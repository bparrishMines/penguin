import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'reference_pair_manager.dart';
import 'reference.dart';

/// Abstract implementation of [ReferencePairManager] for [MethodChannel]s.
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

  static const String _methodCreate = 'REFERENCE_CREATE';
  static const String _methodMethod = 'REFERENCE_METHOD';
  static const String _methodDispose = 'REFERENCE_DISPOSE';

  /// Name used for [channel].
  ///
  /// See [MethodChannel.name].
  final String channelName;

  /// Message codec used for [channel].
  ///
  /// [ReferenceMessageCodec] extends [StandardMessageCodec] to provide support
  /// for passing [RemoteReference].
  ///
  /// See [MethodChannel.codec].
  final ReferenceMessageCodec referenceMessageCodec;

  @override
  final LocalReferenceCommunicationHandler localHandler;

  @override
  final MethodChannelRemoteReferenceCommunicationHandler remoteHandler;

  /// [MethodChannel] used to communicate with a [ReferencePairManager] on another thread/process.
  ///
  /// Null until [initialize] is called.
  MethodChannel get channel => remoteHandler._channel;

  @override
  void initialize() {
    super.initialize();
    remoteHandler._channel = MethodChannel(
      channelName,
      StandardMethodCodec(referenceMessageCodec),
    );
    remoteHandler._channel.setMethodCallHandler((MethodCall call) async {
      if (call.method == MethodChannelReferencePairManager._methodCreate) {
        createLocalReferenceFor(call.arguments[0], call.arguments[1]);
      } else if (call.method ==
          MethodChannelReferencePairManager._methodMethod) {
        return executeLocalMethodFor(
          call.arguments[0],
          call.arguments[1],
          call.arguments[2],
        );
      } else if (call.method ==
          MethodChannelReferencePairManager._methodDispose) {
        disposeLocalReferenceFor(call.arguments);
      }
      return null;
    });
  }
}

/// Implementation of [RemoteReferenceCommunicationHandler] for [MethodChannel]s.
///
/// Used in [MethodChannelReferencePairManager] to handle communication with
/// [RemoteReference]s.
abstract class MethodChannelRemoteReferenceCommunicationHandler
    with RemoteReferenceCommunicationHandler {
  MethodChannelRemoteReferenceCommunicationHandler();

  MethodChannel _channel;

  /// Gets arguments to pass over [MethodChannel] that instantiates a [RemoteReference].
  dynamic creationArgumentsFor(LocalReference localReference);

  @override
  Future<void> createRemoteReferenceFor(
    LocalReference localReference,
    RemoteReference remoteReference,
  ) {
    return _channel.invokeMethod<void>(
      MethodChannelReferencePairManager._methodCreate,
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
      MethodChannelReferencePairManager._methodMethod,
      <dynamic>[remoteReference, methodName, arguments],
    );
  }

  @override
  Future<void> disposeRemoteReference(RemoteReference remoteReference) {
    return _channel.invokeMethod<void>(
      MethodChannelReferencePairManager._methodDispose,
      remoteReference,
    );
  }
}

/// Implementation of [StandardMessageCodec] that supports serializing [RemoteReference]s.
///
/// When extending, no int below 129 should be used as a key. See
/// [StandardMessageCodec] for more info on extending.
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
