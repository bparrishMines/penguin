import 'package:flutter/foundation.dart';

import '../reference.dart';

typedef ReferenceCounterLifecycleCallback = void Function(
  String referenceId,
  ReferenceHolder holder,
);

class ReferenceCounterLifecycleListener {
  const ReferenceCounterLifecycleListener({
    @required this.onCreate,
    @required this.onDispose,
  })  : assert(onCreate != null),
        assert(onDispose != null);

  final ReferenceCounterLifecycleCallback onCreate;
  final ReferenceCounterLifecycleCallback onDispose;
}

class ReferenceCounter {
  ReferenceCounter(
    this.lifecycleListener, [
    int initialReferenceCount = 0,
  ])  : assert(initialReferenceCount == null || initialReferenceCount >= 0),
        _referenceCount = initialReferenceCount ?? 0;

  final ReferenceCounterLifecycleListener lifecycleListener;

  int _referenceCount;
  int get referenceCount => _referenceCount;

  void retain(String referenceId, ReferenceHolder holder) {
    _referenceCount++;
    if (referenceCount == 1) lifecycleListener?.onCreate(referenceId, holder);
  }

  void release(String referenceId, ReferenceHolder holder) {
    assert(referenceCount > 0,
        '`release()` was called without calling `retain()` first. In other words, `release()` was called while `referenceCount == 0`. Reference count = $_referenceCount.');

    _referenceCount--;
    if (referenceCount == 0) lifecycleListener?.onDispose(referenceId, holder);
  }
}
