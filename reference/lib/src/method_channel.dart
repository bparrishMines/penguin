import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'reference_pair_manager.dart';
import 'reference.dart';

/// Abstract implementation of [ReferencePairManager] for [MethodChannel]s.
abstract class MethodChannelReferencePairManager
    extends PoolableReferencePairManager {
  MethodChannelReferencePairManager(
    List<Type> supportedTypes,
    String channelName, {
    String poolId,
    ReferenceMessageCodec messageCodec,
  })  : channel = MethodChannel(
            channelName,
            StandardMethodCodec(
              messageCodec ?? ReferenceMessageCodec(),
            )),
        super(supportedTypes, poolId ?? channelName);

  static const String _methodCreate = 'REFERENCE_CREATE';
  static const String _methodMethod = 'REFERENCE_METHOD';
  static const String _methodDispose = 'REFERENCE_DISPOSE';

  /// [MethodChannel] used to communicate with a [ReferencePairManager] on a different thread/process.
  ///
  /// Null until [initialize] is called.
  final MethodChannel channel;

  @override
  MethodChannelRemoteHandler get remoteHandler;

  @override
  void initialize() {
    super.initialize();
    channel.setMethodCallHandler((MethodCall call) async {
      try {
        if (call.method == MethodChannelReferencePairManager._methodCreate) {
          pairWithNewLocalReference(
            call.arguments[0],
            call.arguments[1],
            call.arguments[2],
          );
          return null;
        } else if (call.method ==
                MethodChannelReferencePairManager._methodMethod &&
            call.arguments[0] is UnpairedReference) {
          return invokeLocalMethodOnUnpairedReference(
            call.arguments[0],
            call.arguments[1],
            call.arguments[2],
          );
        } else if (call.method ==
                MethodChannelReferencePairManager._methodMethod &&
            call.arguments[0] is RemoteReference) {
          return invokeLocalMethod(
            getPairedLocalReference(call.arguments[0]),
            call.arguments[1],
            call.arguments[2],
          );
        } else if (call.method ==
            MethodChannelReferencePairManager._methodDispose) {
          disposePairWithRemoteReference(call.arguments);
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

/// Implementation of [RemoteReferenceCommunicationHandler] for [MethodChannel]s.
///
/// Used in [MethodChannelReferencePairManager] to handle communication with
/// [RemoteReference]s.
abstract class MethodChannelRemoteHandler
    with RemoteReferenceCommunicationHandler {
  MethodChannelRemoteHandler(
    String channelName, [
    ReferenceMessageCodec messageCodec,
  ]) : channel = MethodChannel(
            channelName,
            StandardMethodCodec(
              messageCodec ?? ReferenceMessageCodec(),
            ));

  final MethodChannel channel;

  @override
  Future<void> create(
    RemoteReference remoteReference,
    int typeId,
    List<Object> arguments,
  ) {
    return channel.invokeMethod<void>(
      MethodChannelReferencePairManager._methodCreate,
      <Object>[remoteReference, typeId, arguments],
    );
  }

  @override
  Future<Object> invokeMethod(
    RemoteReference remoteReference,
    String methodName,
    List<Object> arguments,
  ) {
    return channel.invokeMethod<Object>(
      MethodChannelReferencePairManager._methodMethod,
      <Object>[remoteReference, methodName, arguments],
    );
  }

  @override
  Future<void> dispose(RemoteReference remoteReference) {
    return channel.invokeMethod<void>(
      MethodChannelReferencePairManager._methodDispose,
      remoteReference,
    );
  }

  @override
  Future<Object> invokeMethodOnUnpairedReference(
    UnpairedReference unpairedReference,
    String methodName,
    List<Object> arguments,
  ) {
    return channel.invokeMethod<Object>(
      MethodChannelReferencePairManager._methodMethod,
      <Object>[unpairedReference, methodName, arguments],
    );
  }
}

/// Implementation of [StandardMessageCodec] that supports serializing [TypeReference]s, [RemoteReference]s, and [UnpairedReference]s.
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
      writeValue(buffer, value.typeId);
      writeValue(buffer, value.creationArguments);
      writeValue(buffer, value.managerPoolId);
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
          readValueOfType(buffer.getUint8(), buffer),
        );
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}
