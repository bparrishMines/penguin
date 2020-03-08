import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class _ReferenceHolderManager {
  static final _ReferenceHolderManager instance = _ReferenceHolderManager();

  final Map<String, MethodChannelReferenceHolder> referenceHolders =
      <String, MethodChannelReferenceHolder>{};
  final List<MethodChannelReferenceHolder> autoReleasePool =
      <MethodChannelReferenceHolder>[];

  void addReferenceHolder(MethodChannelReferenceHolder holder) {
    assert(
      !referenceHolders.containsKey(holder.referenceId),
      holder.referenceId,
    );
    referenceHolders[holder.referenceId] = holder;
  }

  MethodChannelReferenceHolder removeReferenceHolder(
    MethodChannelReferenceHolder holder,
  ) {
    return referenceHolders.remove(holder.referenceId);
  }

  void drainAutoreleasePool(Duration duration) {
    for (MethodChannelReferenceHolder holder in autoReleasePool) {
      holder.release();
    }
    autoReleasePool.clear();
  }

  void addReferenceHolderToAutoReleasePool(
      MethodChannelReferenceHolder holder) {
    autoReleasePool.add(holder);
    if (autoReleasePool.length == 1) {
      WidgetsBinding.instance.addPostFrameCallback(drainAutoreleasePool);
    }
  }
}

mixin MethodChannelReferenceHolder {
  static final Uuid _uuid = Uuid();
  int _refCount = 0;
  String _referenceId = _uuid.v4();

  MethodChannel get channel;

  String get referenceId => _referenceId;

  void retain() {
    _refCount++;

    if (_refCount == 1) {
      _ReferenceHolderManager.instance.addReferenceHolder(this);
      channel.invokeMethod<void>('CREATE', this);
    }
  }

  void release() {
    _refCount--;

    if (_refCount == 0) {
      _ReferenceHolderManager.instance.removeReferenceHolder(this);
      channel.invokeMethod<void>('DESTROY', this);
    } else if (_refCount < 0) {
      _refCount = 0;
    }
  }

  void autoReleasePool() {
    _ReferenceHolderManager.instance.addReferenceHolderToAutoReleasePool(this);
  }

  void setReferenceId(String referenceId) => _referenceId = referenceId;
}
