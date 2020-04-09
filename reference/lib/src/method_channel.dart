import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../reference.dart';

class MethodChannelReferenceManager extends ReferenceManager {
  MethodChannelReferenceManager({
    @required String channelName,
    @required MethodHandleCallback onReceiveMethodCall,
    @required CreateLocalReferenceCallback onCreateLocalReference,
    ReferenceMessageCodec messageCodec = const ReferenceMessageCodec(),
  }) : _onCreateLocalReference = onCreateLocalReference {
    final MethodChannel channel = MethodChannel(
      channelName,
      StandardMethodCodec(messageCodec),
    );
    _factory = MethodChannelReferenceFactory(channel);
    _methodHandler = MethodChannelReferenceMethodHandler(
      channel,
      onReceiveMethodCall,
    );
  }

  static const String methodCreate = 'REFERENCE_CREATE';
  static const String methodMethod = 'REFERENCE_METHOD';
  static const String methodDispose = 'REFERENCE_DISPOSE';

  MethodChannelReferenceFactory _factory;
  MethodChannelReferenceMethodHandler _methodHandler;
  CreateLocalReferenceCallback _onCreateLocalReference;

  @override
  ReferenceFactory get factory => _factory;

  @override
  ReferenceMethodHandler get methodHandler => _methodHandler;

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    if (call.method == MethodChannelReferenceManager.methodCreate) {
      addLocalReference(
        call.arguments[0],
        _onCreateLocalReference(call.arguments[1]),
      );
    } else if (call.method == MethodChannelReferenceManager.methodMethod) {
      return receiveMethodCall(
        call.arguments[0],
        call.arguments[1],
        call.arguments.length > 2 ? call.arguments.sublist(2) : <dynamic>[],
      );
    } else if (call.method == MethodChannelReferenceManager.methodDispose) {
      removeLocalReference(getHolder(call.arguments.referenceId));
    }
    return null;
  }

  @override
  void initialize() {
    _factory.channel.setMethodCallHandler(_handleMethodCall);
  }

  @visibleForTesting
  MethodChannel initializeMock(
    Future<dynamic> Function(MethodCall call) mockMethodCallHandler,
  ) {
    return _factory.channel..setMockMethodCallHandler(mockMethodCallHandler);
  }
}

typedef MethodHandleCallback = Future<dynamic> Function(
  ReferenceHolder holder,
  String methodName,
  List<dynamic> arguments,
);

typedef CreateLocalReferenceCallback = ReferenceHolder Function(
  dynamic arguments,
);

class MethodChannelReferenceMethodHandler with ReferenceMethodHandler {
  const MethodChannelReferenceMethodHandler(
    this.channel,
    this.onReceiveMethodCall,
  );

  final MethodChannel channel;
  final MethodHandleCallback onReceiveMethodCall;

  @override
  FutureOr<dynamic> sendRemoteMethodCall(
    Reference reference,
    String methodName,
    List<dynamic> arguments,
  ) {
    return channel.invokeMethod<dynamic>(
      MethodChannelReferenceManager.methodMethod,
      <dynamic>[reference, methodName, arguments],
    );
  }

  @override
  FutureOr<dynamic> receiveLocalMethodCall(
    ReferenceHolder holder,
    String methodName,
    List<dynamic> arguments,
  ) {
    return onReceiveMethodCall(holder, methodName, arguments);
  }
}

class MethodChannelReferenceFactory with ReferenceFactory {
  const MethodChannelReferenceFactory(this.channel);

  final MethodChannel channel;

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

class ReferenceMessageCodec extends StandardMessageCodec {
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
