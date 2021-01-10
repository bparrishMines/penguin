import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'type_channel.dart';
import 'instance.dart';

/// Implementation of a [TypeChannelManager] using a [MethodChannel].
class MethodChannelManager extends TypeChannelManager {
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

  /// [MethodChannel] used to communicate with the platform [TypeChannelManager].
  final MethodChannel channel;

  @override
  MethodChannelMessenger get messenger => MethodChannelMessenger(channel);

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    try {
      if (call.method == MethodChannelManager._methodCreate) {
        onReceiveCreateNewInstancePair(
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
        return onReceiveInvokeMethodOnUnpairedInstance(
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

/// Implementation of [TypeChannelMessenger] using a [MethodChannel].
class MethodChannelMessenger with TypeChannelMessenger {
  MethodChannelMessenger(this.channel);

  /// [MethodChannel] used to communicate with a platform [TypeChannelManager].
  final MethodChannel channel;

  @override
  Future<void> sendCreateNewInstancePair(
    String channelName,
    PairedInstance remoteReference,
    List<Object?> arguments,
  ) {
    return channel.invokeMethod<void>(
      MethodChannelManager._methodCreate,
      <Object>[channelName, remoteReference, arguments],
    );
  }

  @override
  Future<Object?> sendInvokeStaticMethod(
    String channelName,
    String methodName,
    List<Object?> arguments,
  ) {
    return channel.invokeMethod<Object>(
      MethodChannelManager._methodStaticMethod,
      <Object>[channelName, methodName, arguments],
    );
  }

  @override
  Future<Object?> sendInvokeMethod(
    String channelName,
    PairedInstance remoteReference,
    String methodName,
    List<Object?> arguments,
  ) {
    return channel.invokeMethod<Object>(
      MethodChannelManager._methodMethod,
      <Object>[channelName, remoteReference, methodName, arguments],
    );
  }

  @override
  Future<Object?> sendInvokeMethodOnUnpairedInstance(
    NewUnpairedInstance unpairedReference,
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
    String channelName,
    PairedInstance remoteReference,
  ) {
    return channel.invokeMethod<void>(
      MethodChannelManager._methodDispose,
      <Object>[channelName, remoteReference],
    );
  }
}

/// Implementation of [StandardMessageCodec] for reference plugin.
/// 
/// Adds support for serialization of [PairedInstance]s and
/// [NewUnpairedInstance]s.
///
/// When extending, no int below 130 should be used as a key. See
/// [StandardMessageCodec] for more info on extending a [StandardMessageCodec].
class ReferenceMessageCodec extends StandardMessageCodec {
  /// Default constructor for [ReferenceMessageCodec].
  const ReferenceMessageCodec();

  static const int _valuePairedInstance = 128;
  static const int _valueNewUnpairedInstance = 129;

  @override
  void writeValue(WriteBuffer buffer, dynamic value) {
    if (value is PairedInstance) {
      buffer.putUint8(_valuePairedInstance);
      writeValue(buffer, value.instanceId);
    } else if (value is NewUnpairedInstance) {
      buffer.putUint8(_valueNewUnpairedInstance);
      writeValue(buffer, value.channelName);
      writeValue(buffer, value.creationArguments);
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  dynamic readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case _valuePairedInstance:
        return PairedInstance(readValueOfType(buffer.getUint8(), buffer));
      case _valueNewUnpairedInstance:
        return NewUnpairedInstance(
          readValueOfType(buffer.getUint8(), buffer),
          readValueOfType(buffer.getUint8(), buffer),
        );
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}
