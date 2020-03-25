import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class ReferenceManager {
  static final ReferenceManager globalInstance = ReferenceManager();

  final Map<Reference, dynamic> _references = <Reference, dynamic>{};
  final List<Reference> _autoReleasePool = <Reference>[];

  void addReference(Reference reference, dynamic object) {
    assert(
      !_references.containsKey(reference),
      'A reference for $object already exists.',
    );
    _references[reference] = object;
  }

  Reference removeReference(Reference reference) {
    return _references.remove(reference);
  }

  void drainAutoreleasePool(Duration duration) {
    for (Reference reference in _autoReleasePool) {
      reference.release();
    }
    _autoReleasePool.clear();
  }

  void addReferenceToAutoReleasePool(Reference holder) {
    _autoReleasePool.add(holder);
    if (_autoReleasePool.length == 1) {
      WidgetsBinding.instance.addPostFrameCallback(drainAutoreleasePool);
    }
  }
}

abstract class Reference {
  Reference(
    this.object, {
    bool useGlobalReferenceManager = true,
  })  : _useGlobalReferenceManager = useGlobalReferenceManager,
        assert(object != null),
        assert(useGlobalReferenceManager != null);

  static final Uuid _uuid = Uuid();

  int _referenceCount = 0;
  String _referenceId = _uuid.v4();
  bool _useGlobalReferenceManager;

  final dynamic object;

  int get referenceCount => _referenceCount;
  String get referenceId => _referenceId;
  bool get useGlobalReferenceManager => _useGlobalReferenceManager;

  @mustCallSuper
  void retain() {
    _referenceCount++;

    if (referenceCount == 1 && useGlobalReferenceManager) {
      ReferenceManager.globalInstance.addReference(this, object);
    }
  }

  @mustCallSuper
  void release() {
    _referenceCount--;

    if (referenceCount == 0 && useGlobalReferenceManager) {
      ReferenceManager.globalInstance.removeReference(this);
    } else if (referenceCount < 0) {
      _referenceCount = 0;
    }
  }

  @mustCallSuper
  void autoReleasePool() {
    if (useGlobalReferenceManager) {
      ReferenceManager.globalInstance.addReferenceToAutoReleasePool(this);
    }
  }

  void reassign(
    String referenceId, {
    int referenceCount = 0,
    bool useGlobalReferenceManager = true,
  }) {
    assert(referenceId != null);

    _referenceId = referenceId;
    _referenceCount = math.max(referenceCount ?? 0, 0);
    _useGlobalReferenceManager = useGlobalReferenceManager ?? true;
  }

  @override
  int get hashCode => referenceId.hashCode;

  @override
  bool operator ==(other) {
    return super.hashCode == hashCode;
  }
}

class MethodChannelReference extends Reference {
  MethodChannelReference({
    @required dynamic object,
    @required this.channel,
  })  : assert(channel != null),
        super(object);

  static const String methodCreate = 'REFERENCE_CREATE';
  static const String methodMethodCall = 'REFERENCE_METHODCALL';
  static const String methodDestroy = 'REFERENCE_DESTROY';

  final MethodChannel channel;

  MethodCall createMethodCall(
    String methodName, [
    List<dynamic> arguments,
  ]) {
    return MethodCall(
      MethodChannelReference.methodMethodCall,
      <dynamic>[referenceId, methodName, ...arguments],
    );
  }

  @override
  void retain() {
    super.retain();
    if (referenceCount == 1) channel.invokeMethod<void>(methodCreate, object);
  }

  @override
  void release() {
    super.release();
    if (referenceCount == 0) {
      channel.invokeMethod<void>(methodDestroy, referenceId);
    }
  }
}
