import 'dart:async';

import 'package:flutter/foundation.dart';

import 'reference.dart';

/// Contains lifecycle callbacks for [OwnerCounter].
class OwnerCounterLifecycleListener {
  const OwnerCounterLifecycleListener({
    @required this.onCreate,
    @required this.onDispose,
  })  : assert(onCreate != null),
        assert(onDispose != null);

  /// Called when owner count reaches 1 and
  final Future<void> Function(LocalReference localReference) onCreate;
  final Future<void> Function(RemoteReference remoteReference) onDispose;
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

  FutureOr<void> increment(LocalReference localReference) {
    _ownerCount++;
    if (ownerCount == 1) {
      return lifecycleListener?.onCreate(localReference);
    }
  }

  FutureOr<void> decrement(RemoteReference remoteReference) {
    assert(ownerCount > 0,
        '`release()` was called without calling `retain()` first. In other words, `release()` was called while `referenceCount == 0`. Reference count = $_ownerCount.');

    _ownerCount--;
    if (ownerCount == 0) {
      return lifecycleListener?.onDispose(remoteReference);
    }
  }
}
