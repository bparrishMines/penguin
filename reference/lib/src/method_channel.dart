import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../reference.dart';

abstract class MethodChannelReferenceManager extends ReferenceManager
    with
        RemoteReferenceFactory,
        MethodSender,
        MethodReceiver,
        LocalReferenceFactory {
  MethodChannelReferenceManager(
    String channelName,
    ReferenceMessageCodec messageCodec,
  ) : channel = MethodChannel(
          channelName,
          StandardMethodCodec(messageCodec),
        );

  static const String methodCreate = 'REFERENCE_CREATE';
  static const String methodMethod = 'REFERENCE_METHOD';
  static const String methodDispose = 'REFERENCE_DISPOSE';

  final MethodChannel channel;

  @override
  void initialize() => channel.setMethodCallHandler(_handleMethodCall);

  @override
  RemoteReferenceFactory get remoteFactory => this;

  @override
  MethodSender get methodSender => this;

  @override
  LocalReferenceFactory get localFactory => this;

  @override
  MethodReceiver get methodReceiver => this;

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

  @override
  void sendRemoteMethodCall(
    Reference reference,
    String methodName,
    List<dynamic> arguments, [
    ResultListener resultListener,
  ]) {
    assert(reference != null);
    assert(methodName != null);
    assert(arguments != null);

    channel
        .invokeMethod<dynamic>(
          MethodChannelReferenceManager.methodMethod,
          <dynamic>[reference, methodName, arguments],
        )
        .then((_) => resultListener?.onSuccess(_))
        .catchError(
          (dynamic error, [StackTrace stackTrace]) {
            resultListener?.onError(error, stackTrace);
          },
        );
  }

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    if (call.method == MethodChannelReferenceManager.methodCreate) {
      createAndAddLocalReference(call.arguments[0], call.arguments[1]);
    } else if (call.method == MethodChannelReferenceManager.methodMethod) {
      final Completer<dynamic> completer = Completer<dynamic>();
      receiveMethodCall(
        call.arguments[0],
        call.arguments[1],
        call.arguments[2],
        ResultListener(
          onSuccess: ([_]) => completer.complete(_),
          onError: (dynamic error, [StackTrace stackTrace]) {
            completer.completeError(error, stackTrace);
          },
        ),
      );
      return completer.future;
    } else if (call.method == MethodChannelReferenceManager.methodDispose) {
      disposeLocalReference(call.arguments.referenceId);
    }
    return null;
  }
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
