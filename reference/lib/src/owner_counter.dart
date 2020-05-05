import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Automatically decrements [OwnerCounter]s.
///
/// See [instance].
class AutoDecrementPool {
  AutoDecrementPool._();

  /// Singleton [AutoDecrementPool] for all [OwnerCounter]s.
  static AutoDecrementPool get instance => AutoDecrementPool._();

  final List<OwnerCounter> _autoReleasePool = <OwnerCounter>[];

  /// Adds an [OwnerCounter] to the auto decrement pool.
  ///
  /// After each frame, [OwnerCounter.decrement] is called on all
  /// [OwnerCounter]s in the auto decrement pool and then the pool is cleared.
  void addToAutoReleasePool(OwnerCounter counter) {
    assert(counter != null);
    _autoReleasePool.add(counter);
    if (_autoReleasePool.length == 1) {
      WidgetsBinding.instance.addPostFrameCallback(_drainAutoreleasePool);
    }
  }

  void _drainAutoreleasePool(Duration duration) {
    for (final OwnerCounter counter in _autoReleasePool) {
      counter.decrement();
    }
    _autoReleasePool.clear();
  }
}

/// Contains lifecycle callbacks for [OwnerCounter].
class OwnerCounterLifecycleListener {
  const OwnerCounterLifecycleListener({
    @required this.onCreate,
    @required this.onDispose,
  })  : assert(onCreate != null),
        assert(onDispose != null);

  /// Called when there is at least one object that wants to claim ownership.
  ///
  /// In other words, [OwnerCounter.ownerCount] reaches 1.
  final Future<void> Function() onCreate;

  /// Called when there are zero objects that claim ownership.
  ///
  /// In other words, [OwnerCounter.ownerCount] reaches 0.
  final Future<void> Function() onDispose;
}

/// Keeps count of how many objects claim ownership to another.
/// 
/// This is typically used in conjunction with a [LocalReference] so it knows
/// when it can dispose of its paired [RemoteReference] in a
/// [ReferencePairManager].
class OwnerCounter {
  OwnerCounter(
    this.lifecycleListener, [
    int initialOwnerCount = 0,
  ])  : assert(initialOwnerCount == null || initialOwnerCount >= 0),
        _ownerCount = initialOwnerCount ?? 0;
  
  /// Handles lifecycle callbacks for when [ownerCount] reaches 1 or 0.
  final OwnerCounterLifecycleListener lifecycleListener;

  int _ownerCount;
  
  /// Number of objects that claim ownership and wants to keep an object accessible.
  int get ownerCount => _ownerCount;

  /// Increments [ownerCount] by one.
  /// 
  /// If [ownerCount] becomes 1, [OwnerCounterLifecycleListener.onCreate] is
  /// called.
  FutureOr<void> increment() {
    _ownerCount++;
    if (ownerCount == 1) {
      return lifecycleListener.onCreate();
    }
  }

  /// Decrements [ownerCount] by one.
  /// 
  /// If [ownerCount] is already 0, an [AssertionError] will be thrown. If
  /// [ownerCount] becomes 0, [OwnerCounterLifecycleListener.onDispose] is
  /// called.
  FutureOr<void> decrement() {
    assert(ownerCount > 0,
        '`release()` was called without calling `retain()` first. In other words, `release()` was called while `referenceCount == 0`. Reference count = $_ownerCount.');

    _ownerCount--;
    if (ownerCount == 0) {
      return lifecycleListener.onDispose();
    }
  }
}
