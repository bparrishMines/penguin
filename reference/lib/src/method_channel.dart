import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'reference_pair_manager.dart';
import 'reference.dart';

abstract class MethodChannelReferencePairManager extends ReferencePairManager {
  MethodChannelReferencePairManager({
    @required this.channelName,
    @required this.localHandler,
    @required this.remoteHandler,
    this.referenceMessageCodec = const ReferenceMessageCodec(),
  })  : assert(channelName != null),
        assert(localHandler != null),
        assert(remoteHandler != null),
        assert(referenceMessageCodec != null);

  static const String methodCreate = 'REFERENCE_CREATE';
  static const String methodMethod = 'REFERENCE_METHOD';
  static const String methodDispose = 'REFERENCE_DISPOSE';

  final String channelName;
  final ReferenceMessageCodec referenceMessageCodec;
  final LocalReferenceCommunicationHandler localHandler;
  final MethodChannelRemoteReferenceCommunicationHandler remoteHandler;

  MethodChannel get channel => remoteHandler._channel;

  @override
  void initialize() {
    super.initialize();
    remoteHandler._channel = MethodChannel(
      channelName,
      StandardMethodCodec(referenceMessageCodec),
    );
    remoteHandler._channel.setMethodCallHandler((MethodCall call) async {
      if (call.method == MethodChannelReferencePairManager.methodCreate) {
        createLocalReferenceFor(call.arguments[0], call.arguments[1]);
      } else if (call.method ==
          MethodChannelReferencePairManager.methodMethod) {
        return executeLocalMethodFor(
          call.arguments[0],
          call.arguments[1],
          call.arguments[2],
        );
      } else if (call.method ==
          MethodChannelReferencePairManager.methodDispose) {
        disposeLocalReferenceFor(call.arguments);
      }
      return null;
    });
  }
}

abstract class MethodChannelRemoteReferenceCommunicationHandler
    with RemoteReferenceCommunicationHandler {
  MethodChannelRemoteReferenceCommunicationHandler();

  MethodChannel _channel;

  dynamic creationArgumentsFor(LocalReference localReference);

  @override
  Future<void> createRemoteReferenceFor(
    LocalReference localReference,
    RemoteReference remoteReference,
  ) {
    return _channel.invokeMethod<void>(
      MethodChannelReferencePairManager.methodCreate,
      <dynamic>[remoteReference, creationArgumentsFor(localReference)],
    );
  }

  @override
  Future<dynamic> executeRemoteMethod(
    RemoteReference remoteReference,
    String methodName,
    List<dynamic> arguments,
  ) {
    return _channel.invokeMethod<dynamic>(
      MethodChannelReferencePairManager.methodMethod,
      <dynamic>[remoteReference, methodName, arguments],
    );
  }

  @override
  Future<void> disposeRemoteReference(RemoteReference remoteReference) {
    return _channel.invokeMethod<void>(
      MethodChannelReferencePairManager.methodDispose,
      remoteReference,
    );
  }
}

class ReferenceMessageCodec extends StandardMessageCodec {
  const ReferenceMessageCodec();

  static const int _valueRemoteReference = 128;

  @override
  void writeValue(WriteBuffer buffer, dynamic value) {
    if (value is RemoteReference) {
      buffer.putUint8(_valueRemoteReference);
      writeValue(buffer, value.referenceId);
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  dynamic readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case _valueRemoteReference:
        return RemoteReference(readValueOfType(buffer.getUint8(), buffer));
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}
