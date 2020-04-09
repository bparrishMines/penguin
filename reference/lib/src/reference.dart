import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:quiver/collection.dart';
import 'package:uuid/uuid.dart';

class Reference {
  const Reference(this.referenceId);

  final String referenceId;

  @override
  bool operator ==(other) => hashCode == other.hashCode;

  @override
  int get hashCode => referenceId.hashCode;
}

mixin ReferenceHolder {}

mixin ReferenceFactory {
  void createRemoteReference(String referenceId, ReferenceHolder holder);
  void disposeRemoteReference(String referenceId, ReferenceHolder holder);
}

mixin ReferenceMethodHandler {
  FutureOr<dynamic> sendRemoteMethodCall(
    Reference reference,
    String methodName,
    List<dynamic> arguments,
  );

  FutureOr<dynamic> receiveLocalMethodCall(
    ReferenceHolder holder,
    String methodName,
    List<dynamic> arguments,
  );
}

typedef ReferenceCounterCallback = void Function(
  String referenceId,
  ReferenceHolder holder,
);

class ReferenceCounter {
  ReferenceCounter({
    @required this.onCreate,
    @required this.onDispose,
    int initialReferenceCount = 0,
  })  : assert(onCreate != null),
        assert(onDispose != null),
        assert(initialReferenceCount == null || initialReferenceCount >= 0),
        _referenceCount = initialReferenceCount ?? 0;

  final ReferenceCounterCallback onCreate;
  final ReferenceCounterCallback onDispose;

  int _referenceCount;
  int get referenceCount => _referenceCount;

  @mustCallSuper
  void retain(String referenceId, ReferenceHolder holder) {
    _referenceCount++;
    if (referenceCount == 1) onCreate(referenceId, holder);
  }

  @mustCallSuper
  void release(String referenceId, ReferenceHolder holder) {
    assert(referenceCount > 0,
        '`release()` was called without calling `retain()` first. In other words, `release()` was called while `referenceCount == 0`. Reference count = $_referenceCount.');

    _referenceCount--;
    if (referenceCount == 0) onDispose(referenceId, holder);
  }
}

abstract class ReferenceManager {
  static final Uuid _uuid = Uuid();

  final BiMap<ReferenceHolder, String> _valueToReferenceId =
      BiMap<ReferenceHolder, String>();
  final Map<String, ReferenceCounter> _referenceIdToReferenceCounter =
      <String, ReferenceCounter>{};

  final List<ReferenceHolder> _autoReleasePool = <ReferenceHolder>[];

  ReferenceFactory get factory;
  ReferenceMethodHandler get methodHandler;
  void initialize();

  void addLocalReference(String referenceId, ReferenceHolder holder) {
    _valueToReferenceId[holder] = referenceId;
  }

  void removeLocalReference(ReferenceHolder holder) {
    _valueToReferenceId.remove(holder);
  }

  String getReferenceId(ReferenceHolder holder) => _valueToReferenceId[holder];

  dynamic getHolder(String referenceId) =>
      _valueToReferenceId.inverse[referenceId];

  void retain(ReferenceHolder holder) {
    String referenceId = _valueToReferenceId[holder];
    if (referenceId == null) {
      _add(holder);
      referenceId = getReferenceId(holder);
    }
    _referenceIdToReferenceCounter[referenceId].retain(referenceId, holder);
  }

  FutureOr<dynamic> sendMethodCall(
    ReferenceHolder holder,
    String methodName,
    List<dynamic> arguments,
  ) {
    return methodHandler.sendRemoteMethodCall(
      Reference(getReferenceId(holder)),
      methodName,
      arguments.map<dynamic>((dynamic argument) {
        if (argument is ReferenceHolder && getReferenceId(argument) != null) {
          return Reference(getReferenceId(argument));
        }
        return argument;
      }).toList(),
    );
  }

  FutureOr<dynamic> receiveMethodCall(
    Reference reference,
    String methodName,
    List<dynamic> arguments,
  ) {
    return methodHandler.receiveLocalMethodCall(
      getHolder(reference.referenceId),
      methodName,
      arguments.map<dynamic>((dynamic argument) {
        if (argument is Reference) return getHolder(reference.referenceId);
        return argument;
      }).toList(),
    );
  }

  void release(ReferenceHolder holder) {
    final String referenceId = getReferenceId(holder);
    if (referenceId == null) return;

    final ReferenceCounter counter =
        _referenceIdToReferenceCounter[referenceId];
    counter.release(referenceId, holder);
  }

  void addToAutoReleasePool(ReferenceHolder value) {
    _autoReleasePool.add(value);
    if (_autoReleasePool.length == 1) {
      WidgetsBinding.instance.addPostFrameCallback(_drainAutoreleasePool);
    }
  }

  void _drainAutoreleasePool(Duration duration) {
    for (dynamic value in _autoReleasePool) {
      release(value);
    }
    _autoReleasePool.clear();
  }

  void _add(ReferenceHolder holder) {
    final String referenceId = _uuid.v4();
    _valueToReferenceId[holder] = referenceId;
    _referenceIdToReferenceCounter[referenceId] = ReferenceCounter(
      onCreate: (String referenceId, ReferenceHolder holder) {
        factory.createRemoteReference(referenceId, holder);
      },
      onDispose: (String referenceId, ReferenceHolder holder) {
        factory.disposeRemoteReference(referenceId, holder);
        _remove(holder);
      },
    );
  }

  void _remove(ReferenceHolder holder) {
    final String referenceId = _valueToReferenceId.remove(holder);
    _referenceIdToReferenceCounter.remove(referenceId);
  }
}
