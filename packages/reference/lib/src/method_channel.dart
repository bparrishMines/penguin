import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'instance.dart';
import 'type_channel.dart';

/// Implementation of a [TypeChannelMessenger] using a [MethodChannel].
class MethodChannelMessenger extends TypeChannelMessenger {
  /// Default constructor for [MethodChannelMessenger].
  ///
  /// `channelName` is the name used for [channel].
  MethodChannelMessenger(String channelName)
      : channel = MethodChannel(
          channelName,
          const StandardMethodCodec(ReferenceMessageCodec()),
        ) {
    channel.setMethodCallHandler(_handleMethodCall);
  }

  static const String _methodCreate = 'REFERENCE_CREATE';
  static const String _methodStaticMethod = 'REFERENCE_STATIC_METHOD';
  static const String _methodMethod = 'REFERENCE_METHOD';
  static const String _methodUnpairedMethod = 'REFERENCE_UNPAIRED_METHOD';
  static const String _methodDispose = 'REFERENCE_DISPOSE';

  /// Global manager maintained by reference plugin.
  ///
  /// A plugin should use this instance when it allows other plugins to access
  /// their instance pairs.
  static final MethodChannelMessenger instance =
      MethodChannelMessenger('github.penguin/reference');

  /// [MethodChannel] used to communicate with the platform [TypeChannelMessenger].
  final MethodChannel channel;

  @override
  MethodChannelDispatcher get messageDispatcher =>
      MethodChannelDispatcher(channel);

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    try {
      if (call.method == MethodChannelMessenger._methodCreate) {
        onReceiveCreateNewInstancePair(
          call.arguments[0] as String,
          call.arguments[1] as PairedInstance,
          call.arguments[2] as List<Object?>,
        );
        return null;
      } else if (call.method == MethodChannelMessenger._methodStaticMethod) {
        return onReceiveInvokeStaticMethod(
          call.arguments[0] as String,
          call.arguments[1] as String,
          call.arguments[2] as List<Object?>,
        );
      } else if (call.method == MethodChannelMessenger._methodMethod) {
        return onReceiveInvokeMethod(
          call.arguments[0] as String,
          call.arguments[1] as PairedInstance,
          call.arguments[2] as String,
          call.arguments[3] as List<Object?>,
        );
      } else if (call.method == MethodChannelMessenger._methodUnpairedMethod) {
        return onReceiveInvokeMethodOnUnpairedInstance(
          call.arguments[0] as NewUnpairedInstance,
          call.arguments[1] as String,
          call.arguments[2] as List<Object?>,
        );
      } else if (call.method == MethodChannelMessenger._methodDispose) {
        onReceiveDisposeInstancePair(
          call.arguments[0] as String,
          call.arguments[1] as PairedInstance,
        );
        return null;
      }

      throw StateError(call.method);
    } catch (error, stacktrace) {
      debugPrint('Error: $error\nStackTrace: $stacktrace');
      rethrow;
    }
  }
}

/// Implementation of [TypeChannelMessageDispatcher] using a [MethodChannel].
class MethodChannelDispatcher with TypeChannelMessageDispatcher {
  MethodChannelDispatcher(this.channel);

  /// [MethodChannel] used to communicate with a platform [TypeChannelMessenger].
  final MethodChannel channel;

  @override
  Future<void> sendCreateNewInstancePair(
    String channelName,
    PairedInstance remoteReference,
    List<Object?> arguments,
  ) {
    return channel.invokeMethod<void>(
      MethodChannelMessenger._methodCreate,
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
      MethodChannelMessenger._methodStaticMethod,
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
      MethodChannelMessenger._methodMethod,
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
      MethodChannelMessenger._methodUnpairedMethod,
      <Object>[unpairedReference, methodName, arguments],
    );
  }

  @override
  Future<void> sendDisposePair(
    String channelName,
    PairedInstance remoteReference,
  ) {
    return channel.invokeMethod<void>(
      MethodChannelMessenger._methodDispose,
      <Object>[channelName, remoteReference],
    );
  }
}

/// Implementation of [StandardMessageCodec] for reference plugin.
///
/// Adds support for serialization of [PairedInstance]s and
/// [NewUnpairedInstance]s.
///
/// When extending, no `int` below 130 should be used as a key. See
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
        return PairedInstance(
          readValueOfType(buffer.getUint8(), buffer) as String,
        );
      case _valueNewUnpairedInstance:
        return NewUnpairedInstance(
          readValueOfType(buffer.getUint8(), buffer) as String,
          readValueOfType(buffer.getUint8(), buffer) as List<Object?>,
        );
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}
