import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'instance.dart';
import 'instance_converter.dart';
import 'instance_manager.dart';
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
  late final MethodChannelDispatcher messageDispatcher =
      MethodChannelDispatcher(channel);

  @override
  final StandardMessageCodecConverter converter =
      StandardMessageCodecConverter();

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    try {
      if (call.method == MethodChannelMessenger._methodCreate) {
        onReceiveCreateNewInstancePair(
          call.arguments[0] as String,
          call.arguments[1] as PairedInstance,
          call.arguments[2] as List<Object?>,
          owner: call.arguments[3] as bool,
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
      } else if (call.method == MethodChannelMessenger._methodDispose) {
        onReceiveDisposeInstancePair(call.arguments[0] as PairedInstance);
        return null;
      }

      throw StateError(call.method);
    } catch (error, stacktrace) {
      debugPrint('Error: $error\nStackTrace: $stacktrace');
      rethrow;
    }
  }
}

/// Implementation of [StandardInstanceConverter] for [StandardMessageCodec]s.
///
/// This allows [Uint8List]s, [Int32List]s, [Int64List]s, and [Float64List]s
/// to be passed without being converted to `List<Object?>`.
class StandardMessageCodecConverter extends StandardInstanceConverter {
  @override
  Object? convertPairedInstances(InstanceManager manager, Object? object) {
    if (object is Uint8List ||
        object is Int32List ||
        object is Int64List ||
        object is Float64List) {
      return object;
    }

    return super.convertPairedInstances(manager, object);
  }

  @override
  Object? convertInstances(InstanceManager manager, Object? object) {
    if (object is Uint8List ||
        object is Int32List ||
        object is Int64List ||
        object is Float64List) {
      return object;
    }

    return super.convertInstances(manager, object);
  }
}

/// Implementation of [TypeChannelMessageDispatcher] using a [MethodChannel].
class MethodChannelDispatcher with TypeChannelMessageDispatcher {
  /// Default constructor for [MethodChannelDispatcher].
  MethodChannelDispatcher(this.channel);

  /// [MethodChannel] used to communicate with a platform [TypeChannelMessenger].
  final MethodChannel channel;

  @override
  Future<void> sendCreateNewInstancePair(
    String channelName,
    PairedInstance remoteReference,
    List<Object?> arguments, {
    required bool owner,
  }) {
    return channel.invokeMethod<void>(
      MethodChannelMessenger._methodCreate,
      <Object>[channelName, remoteReference, arguments, owner],
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
    PairedInstance pairedInstance,
    String methodName,
    List<Object?> arguments,
  ) {
    return channel.invokeMethod<Object>(
      MethodChannelMessenger._methodMethod,
      <Object>[channelName, pairedInstance, methodName, arguments],
    );
  }

  @override
  Future<void> sendDisposeInstancePair(PairedInstance pairedInstance) {
    return channel.invokeMethod<void>(
      MethodChannelMessenger._methodDispose,
      <Object>[pairedInstance],
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

  @override
  void writeValue(WriteBuffer buffer, dynamic value) {
    if (value is PairedInstance) {
      buffer.putUint8(_valuePairedInstance);
      writeValue(buffer, value.instanceId);
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
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}
