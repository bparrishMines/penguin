import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class ReferenceManager {
  ReferenceManager._();

  static final ReferenceManager instance = ReferenceManager._();

  final Map<Reference, dynamic> _references = <Reference, dynamic>{};
  final List<Reference> _autoReleasePool = <Reference>[];

  void addReference(Reference reference, dynamic object) {
    assert(
      !_references.containsKey(reference),
      'A reference for $object already exists',
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

  void addReferenceHolderToAutoReleasePool(Reference holder) {
    _autoReleasePool.add(holder);
    if (_autoReleasePool.length == 1) {
      WidgetsBinding.instance.addPostFrameCallback(drainAutoreleasePool);
    }
  }
}

abstract class Reference {
  Reference(this.object) : assert(object != null);

  static final Uuid _uuid = Uuid();

  int _referenceCount = 0;
  String _referenceId = _uuid.v4();

  final dynamic object;

  int get referenceCount => _referenceCount;
  String get referenceId => _referenceId;

  @mustCallSuper
  void retain() {
    _referenceCount++;

    if (referenceCount == 1) {
      ReferenceManager.instance.addReference(this, object);
    }
  }

  @mustCallSuper
  void release() {
    _referenceCount--;

    if (referenceCount == 0) {
      ReferenceManager.instance.removeReference(this);
    } else if (referenceCount < 0) {
      _referenceCount = 0;
    }
  }

  void autoReleasePool() {
    ReferenceManager.instance.addReferenceHolderToAutoReleasePool(this);
  }

  void changeReferenceId(String referenceId) => _referenceId = referenceId;

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

  final MethodChannel channel;

  @override
  void retain() {
    super.retain();
    if (referenceCount == 1) channel.invokeMethod<void>('CREATE', this);
  }

  @override
  void release() {
    super.release();
    if (referenceCount == 0) channel.invokeMethod<void>('DESTROY', this);
  }
}
