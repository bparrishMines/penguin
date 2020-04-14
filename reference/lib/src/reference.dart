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

class ResultListener {
  const ResultListener({@required this.onSuccess, this.onError});

  final void Function([dynamic result]) onSuccess;
  final void Function(dynamic error, [StackTrace stackTrace]) onError;
}

mixin ReferenceHolder {}

mixin LocalReferenceFactory {
  ReferenceHolder createLocalReference(String referenceId, dynamic arguments);
}

mixin RemoteReferenceFactory {
  void createRemoteReference(String referenceId, ReferenceHolder holder);
  void disposeRemoteReference(String referenceId, ReferenceHolder holder);
}

mixin MethodReceiver {
  void receiveLocalMethodCall(
    ReferenceHolder holder,
    String methodName,
    List<dynamic> arguments, [
    ResultListener resultListener,
  ]);
}

mixin MethodSender {
  void sendRemoteMethodCall(
    Reference reference,
    String methodName,
    List<dynamic> arguments, [
    ResultListener resultListener,
  ]);
}

abstract class ReferenceManager {
  static final Uuid _uuid = Uuid();

  final BiMap<ReferenceHolder, String> _holderToReferenceId =
      BiMap<ReferenceHolder, String>();
  final Map<String, ReferenceCounter> _referenceIdToReferenceCounter =
      <String, ReferenceCounter>{};

  final List<ReferenceHolder> _autoReleasePool = <ReferenceHolder>[];

  LocalReferenceFactory get localFactory;
  RemoteReferenceFactory get remoteFactory;
  MethodReceiver get methodReceiver;
  MethodSender get methodSender;
  void initialize();

  void createAndAddLocalReference(String referenceId, dynamic arguments) {
    final ReferenceHolder holder = localFactory.createLocalReference(
      referenceId,
      arguments,
    );
    _holderToReferenceId[holder] = referenceId;
  }

  void disposeLocalReference(String referenceId) {
    _holderToReferenceId.inverse.remove(referenceId);
  }

  String getReferenceId(ReferenceHolder holder) => _holderToReferenceId[holder];

  ReferenceHolder getHolder(String referenceId) =>
      _holderToReferenceId.inverse[referenceId];

  void retain(ReferenceHolder holder) {
    String referenceId = _holderToReferenceId[holder];
    if (referenceId == null) {
      _add(holder);
      referenceId = getReferenceId(holder);
    }
    _referenceIdToReferenceCounter[referenceId].retain(referenceId, holder);
  }

  void sendMethodCall(
    ReferenceHolder holder,
    String methodName,
    List<dynamic> arguments, [
    ResultListener resultListener,
  ]) {
    methodSender.sendRemoteMethodCall(
      Reference(getReferenceId(holder)),
      methodName,
      arguments.map<dynamic>((dynamic argument) {
        if (argument is ReferenceHolder && getReferenceId(argument) != null) {
          return Reference(getReferenceId(argument));
        }
        return argument;
      }).toList(),
      resultListener,
    );
  }

  void receiveMethodCall(
    Reference reference,
    String methodName,
    List<dynamic> arguments, [
    ResultListener resultListener,
  ]) {
    methodReceiver.receiveLocalMethodCall(
      getHolder(reference.referenceId),
      methodName,
      arguments.map<dynamic>((dynamic argument) {
        if (argument is Reference) return getHolder(reference.referenceId);
        return argument;
      }).toList(),
      resultListener,
    );
  }

  void release(ReferenceHolder holder) {
    final String referenceId = getReferenceId(holder);
    if (referenceId == null) return;

    final ReferenceCounter counter =
        _referenceIdToReferenceCounter[referenceId];
    counter.release(referenceId, holder);
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
          remoteFactory.createRemoteReference(referenceId, holder);
        },
        onDispose: (String referenceId, ReferenceHolder holder) {
          remoteFactory.disposeRemoteReference(referenceId, holder);
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
