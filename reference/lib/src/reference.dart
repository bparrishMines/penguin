import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:quiver/collection.dart';
import 'package:uuid/uuid.dart';

import 'reference_counter.dart';

class Reference {
  const Reference(this.referenceId);

  final String referenceId;

  @override
  bool operator ==(other) => hashCode == other.hashCode;

  @override
  int get hashCode => referenceId.hashCode;
}

mixin ReferenceHolder {}

mixin RemoteReferenceHandler {
  void createRemoteReference(String referenceId, ReferenceHolder holder);
  Future<dynamic> sendRemoteMethodCall(
    Reference reference,
    String methodName,
    List<dynamic> arguments,
  );
  void disposeRemoteReference(String referenceId, ReferenceHolder holder);
}

mixin LocalReferenceHandler {
  ReferenceHolder createLocalReference(String referenceId, dynamic arguments);
  Future<dynamic> receiveLocalMethodCall(
    ReferenceHolder holder,
    String methodName,
    List<dynamic> arguments,
  );
}

abstract class ReferenceManager {
  static final Uuid _uuid = Uuid();

  final BiMap<ReferenceHolder, String> _holderToReferenceId =
      BiMap<ReferenceHolder, String>();
  final Map<String, ReferenceCounter> _referenceIdToReferenceCounter =
      <String, ReferenceCounter>{};

  final List<ReferenceHolder> _autoReleasePool = <ReferenceHolder>[];

  RemoteReferenceHandler get remoteHandler;
  LocalReferenceHandler get localHandler;
  void initialize();

  void createAndAddLocalReference(String referenceId, dynamic arguments) {
    final ReferenceHolder holder = localHandler.createLocalReference(
      referenceId,
      arguments,
    );
    _holderToReferenceId[holder] = referenceId;
  }

  void disposeLocalReference(String referenceId) {
    _holderToReferenceId.inverse.remove(referenceId);
  }

  String referenceIdFor(ReferenceHolder holder) => _holderToReferenceId[holder];

  ReferenceHolder referenceHolderFor(String referenceId) =>
      _holderToReferenceId.inverse[referenceId];

  void retain(ReferenceHolder holder) {
    String referenceId = _holderToReferenceId[holder];
    if (referenceId == null) {
      _add(holder);
      referenceId = referenceIdFor(holder);
    }
    _referenceIdToReferenceCounter[referenceId].retain(referenceId, holder);
  }

  Future<dynamic> sendMethodCall(
    ReferenceHolder holder,
    String methodName,
    List<dynamic> arguments,
  ) {
    return remoteHandler.sendRemoteMethodCall(
      Reference(referenceIdFor(holder)),
      methodName,
      arguments.map<dynamic>((dynamic argument) {
        if (argument is ReferenceHolder && referenceIdFor(argument) != null) {
          return Reference(referenceIdFor(argument));
        }
        return argument;
      }).toList(),
    );
  }

  Future<dynamic> receiveMethodCall(
    Reference reference,
    String methodName,
    List<dynamic> arguments,
  ) {
    return localHandler.receiveLocalMethodCall(
      referenceHolderFor(reference.referenceId),
      methodName,
      arguments.map<dynamic>((dynamic argument) {
        if (argument is Reference)
          return referenceHolderFor(reference.referenceId);
        return argument;
      }).toList(),
    );
  }

  void release(ReferenceHolder holder) {
    final String referenceId = referenceIdFor(holder);
    if (referenceId != null) {
      _referenceIdToReferenceCounter[referenceId].release(referenceId, holder);
    }
  }

  void addToAutoReleasePool(ReferenceHolder holder) {
    _autoReleasePool.add(holder);
    if (_autoReleasePool.length == 1) {
      WidgetsBinding.instance.addPostFrameCallback(_drainAutoreleasePool);
    }
  }

  void _drainAutoreleasePool(Duration duration) {
    for (final ReferenceHolder holder in _autoReleasePool) {
      release(holder);
    }
    _autoReleasePool.clear();
  }

  void _add(ReferenceHolder holder) {
    final String referenceId = _uuid.v4();
    _holderToReferenceId[holder] = referenceId;
    _referenceIdToReferenceCounter[referenceId] = ReferenceCounter(
      ReferenceCounterLifecycleListener(
        onCreate: (String referenceId, ReferenceHolder holder) {
          remoteHandler.createRemoteReference(referenceId, holder);
        },
        onDispose: (String referenceId, ReferenceHolder holder) {
          remoteHandler.disposeRemoteReference(referenceId, holder);
          _remove(holder);
        },
      ),
    );
  }

  void _remove(ReferenceHolder holder) {
    final String referenceId = _holderToReferenceId.remove(holder);
    _referenceIdToReferenceCounter.remove(referenceId);
  }
}
