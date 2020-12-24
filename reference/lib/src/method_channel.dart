import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'reference_channel.dart';
import 'reference.dart';

/// Implementation of a [ReferenceChannelManager] using a [MethodChannel].
class MethodChannelManager extends ReferenceChannelManager {
  /// Default constructor for [MethodChannelManager].
  MethodChannelManager(String channelName)
      : channel = MethodChannel(
          channelName,
          StandardMethodCodec(ReferenceMessageCodec()),
        ) {
    channel.setMethodCallHandler(_handleMethodCall);
  }

  static const String _methodCreate = 'REFERENCE_CREATE';
  static const String _methodStaticMethod = 'REFERENCE_STATIC_METHOD';
  static const String _methodMethod = 'REFERENCE_METHOD';
  static const String _methodUnpairedMethod = 'REFERENCE_UNPAIRED_METHOD';
  static const String _methodDispose = 'REFERENCE_DISPOSE';

  /// Global manager maintained by reference plugin.
  static final MethodChannelManager instance =
      MethodChannelManager('github.penguin/reference');

  /// [MethodChannel] used to communicate with the platform [ReferenceChannelManager].
  final MethodChannel channel;

  @override
  MethodChannelMessenger get messenger => MethodChannelMessenger(channel);

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    try {
      if (call.method == MethodChannelManager._methodCreate) {
        onReceiveCreateNewPair(
          call.arguments[0],
          call.arguments[1],
          call.arguments[2],
        );
        return null;
      } else if (call.method == MethodChannelManager._methodStaticMethod) {
        return onReceiveInvokeStaticMethod(
          call.arguments[0],
          call.arguments[1],
          call.arguments[2],
        );
      } else if (call.method == MethodChannelManager._methodMethod) {
        return onReceiveInvokeMethod(
          call.arguments[0],
          call.arguments[1],
          call.arguments[2],
          call.arguments[3],
        );
      } else if (call.method == MethodChannelManager._methodUnpairedMethod) {
        return onReceiveInvokeMethodOnUnpairedReference(
          call.arguments[0],
          call.arguments[1],
          call.arguments[2],
        );
      } else if (call.method == MethodChannelManager._methodDispose) {
        onReceiveDisposePair(call.arguments[0], call.arguments[1]);
        return null;
      }

      throw StateError(call.method);
    } catch (error, stacktrace) {
      debugPrint('Error: $error\nStackTrace: $stacktrace');
      rethrow;
    }
  }
}

/// Implementation of [ReferenceChannelMessenger] using a [MethodChannel].
class MethodChannelMessenger with ReferenceChannelMessenger {
  MethodChannelMessenger(this.channel);

  /// [MethodChannel] used to communicate with the platform [ReferenceChannelManager].
  final MethodChannel channel;

  @override
  Future<void> sendCreateNewPair(
    String handlerChannel,
    PairedReference remoteReference,
    List<Object?> arguments,
  ) {
    return channel.invokeMethod<void>(
      MethodChannelManager._methodCreate,
      <Object>[handlerChannel, remoteReference, arguments],
    );
  }

  @override
  Future<Object?> sendInvokeStaticMethod(
    String handlerChannel,
    String methodName,
    List<Object?> arguments,
  ) {
    return channel.invokeMethod<Object>(
      MethodChannelManager._methodStaticMethod,
      <Object>[handlerChannel, methodName, arguments],
    );
  }

  @override
  Future<Object?> sendInvokeMethod(
    String handlerChannel,
    PairedReference remoteReference,
    String methodName,
    List<Object?> arguments,
  ) {
    return channel.invokeMethod<Object>(
      MethodChannelManager._methodMethod,
      <Object>[handlerChannel, remoteReference, methodName, arguments],
    );
  }

  @override
  Future<Object?> sendInvokeMethodOnUnpairedReference(
    UnpairedReference unpairedReference,
    String methodName,
    List<Object?> arguments,
  ) {
    return channel.invokeMethod<Object>(
      MethodChannelManager._methodUnpairedMethod,
      <Object>[unpairedReference, methodName, arguments],
    );
  }

  @override
  Future<void> sendDisposePair(
    String handlerChannel,
    PairedReference remoteReference,
  ) {
    return channel.invokeMethod<void>(
      MethodChannelManager._methodDispose,
      <Object>[handlerChannel, remoteReference],
    );
  }
}

/// Implementation of [StandardMessageCodec] supporting serialization of [PairedReference]s and [UnpairedReference]s.
///
/// When extending, no int below 130 should be used as a key. See
/// [StandardMessageCodec] for more info on extending a [StandardMessageCodec].
class ReferenceMessageCodec extends StandardMessageCodec {
  /// Default constructor for [ReferenceMessageCodec].
  const ReferenceMessageCodec();

  static const int _valueRemoteReference = 128;
  static const int _valueUnpairedReference = 129;

  @override
  void writeValue(WriteBuffer buffer, dynamic value) {
    if (value is PairedReference) {
      buffer.putUint8(_valueRemoteReference);
      writeValue(buffer, value.referenceId);
    } else if (value is UnpairedReference) {
      buffer.putUint8(_valueUnpairedReference);
      writeValue(buffer, value.channelName);
      writeValue(buffer, value.creationArguments);
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  dynamic readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case _valueRemoteReference:
        return PairedReference(readValueOfType(buffer.getUint8(), buffer));
      case _valueUnpairedReference:
        return UnpairedReference(
          readValueOfType(buffer.getUint8(), buffer),
          readValueOfType(buffer.getUint8(), buffer),
        );
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}
