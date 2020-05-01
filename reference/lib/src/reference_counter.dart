import 'package:flutter/foundation.dart';

import '../reference.dart';

// TODO: find some better names?
//typedef OwnerCounterLifecycleCallback = void Function(
//  LocalReference localReference,
//  RemoteReference remoteReference,
//);

class OwnerCounterLifecycleListener {
  const OwnerCounterLifecycleListener({
    @required this.onCreate,
    @required this.onDispose,
  })  : assert(onCreate != null),
        assert(onDispose != null);

  final void Function(LocalReference localReference) onCreate;
  final void Function(
    LocalReference localReference,
    RemoteReference remoteReference,
  ) onDispose;
}

class ReferencePairOwnerCounter {
  ReferencePairOwnerCounter(
    this.lifecycleListener, [
    int initialOwnerCount = 0,
  ])  : assert(initialOwnerCount == null || initialOwnerCount >= 0),
        _ownerCount = initialOwnerCount ?? 0;

  final OwnerCounterLifecycleListener lifecycleListener;

  int _ownerCount;
  int get ownerCount => _ownerCount;

  void increment(LocalReference localReference) {
    _ownerCount++;
    if (ownerCount == 1) {
      lifecycleListener?.onCreate(localReference);
    }
  }

  void decrement(
    LocalReference localReference,
    RemoteReference remoteReference,
  ) {
    assert(ownerCount > 0,
        '`release()` was called without calling `retain()` first. In other words, `release()` was called while `referenceCount == 0`. Reference count = $_ownerCount.');

    _ownerCount--;
    if (ownerCount == 0) {
      lifecycleListener?.onDispose(localReference, remoteReference);
    }
  }
}
