import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'reference_channel_manager.dart';
import 'reference.dart';

/// Abstract implementation of [RemoteReferenceMap] using [MethodChannel]s.
class MethodChannelReferenceChannelManager extends ReferenceChannelManager {
  /// Default constructor for [MethodChannelReferenceChannelManager].
  ///
  /// If [poolId] is passed as `null`, it will be set to [channelName].
  /// If [messageCodec] is passed as `null`, it will be set to
  /// [ReferenceMessageCodec].
  // @visibleForTesting
  MethodChannelReferenceChannelManager(String channelName)
      : channel = MethodChannel(
          channelName,
          StandardMethodCodec(ReferenceMessageCodec()),
        );

  static const String _methodCreate = 'REFERENCE_CREATE';
  static const String _methodStaticMethod = 'REFERENCE_STATIC_METHOD';
  static const String _methodMethod = 'REFERENCE_METHOD';
  static const String _methodUnpairedMethod = 'REFERENCE_UNPAIRED_METHOD';
  static const String _methodDispose = 'REFERENCE_DISPOSE';

  static final MethodChannelReferenceChannelManager instance =
      MethodChannelReferenceChannelManager('github.penguin/reference')
        ..initialize();

  /// [MethodChannel] used to communicate with a remote [RemoteReferenceMap].
  final MethodChannel channel;

  @override
  MethodChannelReferenceChannelMessenger get messenger =>
      MethodChannelReferenceChannelMessenger(channel.name);

  @override
  void initialize() {
    super.initialize();
    channel.setMethodCallHandler((MethodCall call) async {
      try {
        if (call.method == MethodChannelReferenceChannelManager._methodCreate) {
          onReceiveCreateNewPair(
            call.arguments[0],
            call.arguments[1],
            call.arguments[2],
          );
          return null;
        } else if (call.method ==
            MethodChannelReferenceChannelManager._methodStaticMethod) {
          return onReceiveInvokeStaticMethod(
            call.arguments[0],
            call.arguments[1],
            call.arguments[2],
          );
        } else if (call.method ==
            MethodChannelReferenceChannelManager._methodMethod) {
          return onReceiveInvokeMethod(
            call.arguments[0],
            referencePairs.getPairedObject(call.arguments[1]),
            call.arguments[2],
            call.arguments[3],
          );
        } else if (call.method ==
            MethodChannelReferenceChannelManager._methodUnpairedMethod) {
          return onReceiveInvokeMethodOnUnpairedReference(
            call.arguments[0],
            call.arguments[1],
            call.arguments[2],
          );
        } else if (call.method ==
            MethodChannelReferenceChannelManager._methodDispose) {
          onReceiveDisposePair(call.arguments[0], call.arguments[1]);
          return null;
        }

        throw StateError(call.method);
      } catch (error, stacktrace) {
        debugPrint('Error: $error\nStackTrace: $stacktrace');
        rethrow;
      }
    });
  }
}

/// Implementation of [MessageSender] for [MethodChannel]s.
///
/// Used in [MethodChannelReferenceChannelManager] to handle communication with
/// [RemoteReference]s.
class MethodChannelReferenceChannelMessenger with ReferenceChannelMessenger {
  MethodChannelReferenceChannelMessenger(String channelName)
      : channel = MethodChannel(
          channelName,
          StandardMethodCodec(ReferenceMessageCodec()),
        );

  /// [MethodChannel] used to communicate with a remote [RemoteReferenceMap].
  final MethodChannel channel;

  @override
  Future<void> sendCreateNewPair(
    String handlerChannel,
    RemoteReference remoteReference,
    List<Object> arguments,
  ) {
    return channel.invokeMethod<void>(
      MethodChannelReferenceChannelManager._methodCreate,
      <Object>[handlerChannel, remoteReference, arguments],
    );
  }

  @override
  Future<Object> sendInvokeStaticMethod(
    String handlerChannel,
    String methodName,
    List<Object> arguments,
  ) {
    return channel.invokeMethod<Object>(
      MethodChannelReferenceChannelManager._methodStaticMethod,
      <Object>[handlerChannel, methodName, arguments],
    );
  }

  @override
  Future<Object> sendInvokeMethod(
    String handlerChannel,
    RemoteReference remoteReference,
    String methodName,
    List<Object> arguments,
  ) {
    return channel.invokeMethod<Object>(
      MethodChannelReferenceChannelManager._methodMethod,
      <Object>[handlerChannel, remoteReference, methodName, arguments],
    );
  }

  @override
  Future<Object> sendInvokeMethodOnUnpairedReference(
    UnpairedReference unpairedReference,
    String methodName,
    List<Object> arguments,
  ) {
    return channel.invokeMethod<Object>(
      MethodChannelReferenceChannelManager._methodUnpairedMethod,
      <Object>[unpairedReference, methodName, arguments],
    );
  }

  @override
  Future<void> sendDisposePair(
    String handlerChannel,
    RemoteReference remoteReference,
  ) {
    return channel.invokeMethod<void>(
      MethodChannelReferenceChannelManager._methodDispose,
      <Object>[handlerChannel, remoteReference],
    );
  }
}

/// Implementation of [StandardMessageCodec] that supports serializing [RemoteReference]s and [UnpairedReference]s.
///
/// When extending, no int below 130 should be used as a key. See
/// [StandardMessageCodec] for more info on extending a [StandardMessageCodec].
class ReferenceMessageCodec extends StandardMessageCodec {
  const ReferenceMessageCodec();

  static const int _valueRemoteReference = 128;
  static const int _valueUnpairedReference = 129;

  @override
  void writeValue(WriteBuffer buffer, dynamic value) {
    if (value is RemoteReference) {
      buffer.putUint8(_valueRemoteReference);
      writeValue(buffer, value.referenceId);
    } else if (value is UnpairedReference) {
      buffer.putUint8(_valueUnpairedReference);
      writeValue(buffer, value.handlerChannel);
      writeValue(buffer, value.creationArguments);
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  dynamic readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case _valueRemoteReference:
        return RemoteReference(readValueOfType(buffer.getUint8(), buffer));
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
