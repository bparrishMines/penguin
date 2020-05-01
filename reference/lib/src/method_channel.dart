import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../reference.dart';

abstract class MethodChannelReferenceManager extends ReferenceManager
    with LocalReferenceCommunicationHandler {
  MethodChannelReferenceManager({
    @required String channelName,
    @required ReferenceMessageCodec messageCodec,
  }) : channel = MethodChannel(channelName, StandardMethodCodec(messageCodec));

  static const String methodCreate = 'REFERENCE_CREATE';
  static const String methodMethod = 'REFERENCE_METHOD';
  static const String methodDispose = 'REFERENCE_DISPOSE';

  final MethodChannel channel;

  @override
  void initialize() => channel.setMethodCallHandler(_handleMethodCall);

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    if (call.method == MethodChannelReferenceManager.methodCreate) {
      createAndAddLocalReference(call.arguments[0], call.arguments[1]);
    } else if (call.method == MethodChannelReferenceManager.methodMethod) {
      return receiveMethodCall(
        call.arguments[0],
        call.arguments[1],
        call.arguments[2],
      );
    } else if (call.method == MethodChannelReferenceManager.methodDispose) {
      disposeLocalReference(call.arguments.referenceId);
    }
    return null;
  }

  @override
  LocalReferenceCommunicationHandler get localHandler => this;

  @override
  RemoteReferenceCommunicationHandler get remoteHandler =>
      _MethodChannelRemoteReferenceHandler(channel);
}

abstract class ReferenceMessageCodec extends StandardMessageCodec {
  const ReferenceMessageCodec();

  static const int _valueReference = 128;

  @override
  void writeValue(WriteBuffer buffer, dynamic value) {
    if (value is Reference) {
      buffer.putUint8(_valueReference);
      writeValue(buffer, value.referenceId);
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  dynamic readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case _valueReference:
        return Reference(readValueOfType(buffer.getUint8(), buffer));
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class _MethodChannelRemoteReferenceHandler with RemoteReferenceCommunicationHandler {
  const _MethodChannelRemoteReferenceHandler(this.channel);

  final MethodChannel channel;

  @override
  Future<dynamic> sendRemoteMethodCall(
    Reference reference,
    String methodName,
    List arguments,
  ) {
    return channel.invokeMethod<dynamic>(
      MethodChannelReferenceManager.methodMethod,
      <dynamic>[reference, methodName, arguments],
    );
  }

  @override
  void createRemoteReference(String referenceId, ReferenceHolder holder) {
    channel.invokeMethod<void>(
      MethodChannelReferenceManager.methodCreate,
      <dynamic>[referenceId, holder],
    );
  }

  @override
  void disposeRemoteReference(String referenceId, ReferenceHolder holder) {
    channel.invokeMethod<void>(
      MethodChannelReferenceManager.methodDispose,
      Reference(referenceId),
    );
  }
}
