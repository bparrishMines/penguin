import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class AutoReleasePool {
  AutoReleasePool._();

  AutoReleasePool get instance => AutoReleasePool._();

  final List<OwnerCounter> _autoReleasePool = <OwnerCounter>[];

  /// Adds a [localReference] to an auto release pool.
  ///
  /// After each frame, [decrementOwnerCount] is called on all [LocalReference]s
  /// in the auto release pool and then the pool is cleared.
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

  /// Called when owner count reaches 1 and
  final Future<void> Function() onCreate;

  final Future<void> Function() onDispose;
}

class OwnerCounter {
  OwnerCounter(
    this.lifecycleListener, [
    int initialOwnerCount = 0,
  ])  : assert(initialOwnerCount == null || initialOwnerCount >= 0),
        _ownerCount = initialOwnerCount ?? 0;

  final OwnerCounterLifecycleListener lifecycleListener;

  int _ownerCount;
  int get ownerCount => _ownerCount;

  FutureOr<void> increment() {
    _ownerCount++;
    if (ownerCount == 1) {
      return lifecycleListener.onCreate();
    }
  }

  FutureOr<void> decrement() {
    assert(ownerCount > 0,
        '`release()` was called without calling `retain()` first. In other words, `release()` was called while `referenceCount == 0`. Reference count = $_ownerCount.');

    _ownerCount--;
    if (ownerCount == 0) {
      return lifecycleListener.onDispose();
    }
  }
}
