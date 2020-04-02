import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class ReferenceManager {
  static final ReferenceManager globalInstance = ReferenceManager();

  final Map<String, Reference> _references = <String, Reference>{};
  final List<Reference> _autoReleasePool = <Reference>[];

  void addReference(Reference reference) {
    assert(
      !_references.containsKey(reference),
      'A reference with id ${reference.referenceId} already exists.',
    );
    _references[reference.referenceId] = reference;
  }

  Reference removeReference(Reference reference) {
    return _references.remove(reference.referenceId);
  }

  Reference getReference(String referenceId) {
    return _references[referenceId];
  }

  void drainAutoreleasePool(Duration duration) {
    for (Reference reference in _autoReleasePool) {
      reference.release();
    }
    _autoReleasePool.clear();
  }

  void addReferenceToAutoReleasePool(Reference reference) {
    _autoReleasePool.add(reference);
    if (_autoReleasePool.length == 1) {
      WidgetsBinding.instance.addPostFrameCallback(drainAutoreleasePool);
    }
  }
}

abstract class Reference {
  Reference({
    String referenceId,
    bool useGlobalReferenceManager,
    int initialReferenceCount,
    this.onRetain,
    this.onRelease,
  })  : assert(initialReferenceCount == null || initialReferenceCount >= 0),
        referenceId = referenceId ?? _uuid.v4(),
        useGlobalReferenceManager = useGlobalReferenceManager ?? true,
        _referenceCount = math.max(initialReferenceCount ?? 0, 0);

  static final Uuid _uuid = Uuid();

  int _referenceCount;

  final String referenceId;
  final bool useGlobalReferenceManager;
  final VoidCallback onRetain;
  final VoidCallback onRelease;

  int get referenceCount => _referenceCount;

  void retain() {
    _referenceCount++;
    if (referenceCount != 1) return;
    if (onRetain != null) onRetain();
    if (useGlobalReferenceManager) {
      ReferenceManager.globalInstance.addReference(this);
    }
  }

  void release() {
    assert(_referenceCount > 0,
        '`release()` was called without calling `retain()` first. In other words, `release()` was called while `referenceCount == 0`. Reference count = $_referenceCount.');
    if (referenceCount == 0) return;

    _referenceCount--;
    if (_referenceCount > 0) return;
    if (onRelease != null) onRelease();
    if (useGlobalReferenceManager) {
      ReferenceManager.globalInstance.removeReference(this);
    }
  }

  void autoReleasePool() {
    if (useGlobalReferenceManager) {
      ReferenceManager.globalInstance.addReferenceToAutoReleasePool(this);
    }
  }

  @override
  int get hashCode => referenceId.hashCode;

  @override
  bool operator ==(other) {
    return super.hashCode == hashCode;
  }
}

class MethodChannelReference extends Reference {
  MethodChannelReference._({
    @required MethodChannel channel,
    String referenceId,
    bool useGlobalReferenceManager,
    this.creationParameters,
    int initialReferenceCount,
  })  : channel = channel,
        assert(referenceId != null),
        super(
          referenceId: referenceId,
          useGlobalReferenceManager: useGlobalReferenceManager,
          initialReferenceCount: initialReferenceCount,
          onRetain: () => channel.invokeMethod<void>(
            methodRetain,
            creationParameters,
          ),
          onRelease: () => channel.invokeMethod<void>(
            methodRelease,
            referenceId,
          ),
        );

  factory MethodChannelReference({
    @required MethodChannel channel,
    String referenceId,
    bool useGlobalReferenceManager = true,
    dynamic creationParameters,
    int initialReferenceCount,
  }) {
    referenceId ??= Reference._uuid.v4();
    return MethodChannelReference._(
      channel: channel,
      referenceId: referenceId,
      useGlobalReferenceManager: useGlobalReferenceManager,
      creationParameters: creationParameters,
      initialReferenceCount: initialReferenceCount,
    );
  }

  static const String methodRetain = 'REFERENCE_RETAIN';
  static const String methodMethodCall = 'REFERENCE_METHODCALL';
  static const String methodRelease = 'REFERENCE_RELEASE';

  final MethodChannel channel;
  final dynamic creationParameters;

  MethodCall createMethodCall(
    String methodName, [
    List<dynamic> arguments,
  ]) {
    return MethodCall(
      MethodChannelReference.methodMethodCall,
      <dynamic>[referenceId, methodName, ...arguments],
    );
  }
}
