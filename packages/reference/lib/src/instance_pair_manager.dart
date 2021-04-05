import 'dart:ffi';

import 'dart:io';
import 'dart:isolate';

import 'package:ffi/ffi.dart';

/// Stores instance pair.
class InstancePairManager {
  InstancePairManager._() {
    _referenceDartDlInitialize(NativeApi.initializeApiDLData);
    _removePairReceivePort = ReceivePort()..listen(_removePair);
    _dartRegisterReceivePort(_removePairReceivePort.sendPort.nativePort);
  }

  static final InstancePairManager instance = InstancePairManager._();

  static final DynamicLibrary _referenceLib = Platform.isAndroid
      ? DynamicLibrary.open('libreference.so')
      : DynamicLibrary.process();

  static final void Function(Pointer<Void> data) _referenceDartDlInitialize =
      _referenceLib.lookupFunction<Void Function(Pointer<Void> data),
          void Function(Pointer<Void> data)>('reference_dart_dl_initialize');

  static final void Function(Pointer<Int8>, Object, int) _dartAddPair =
      _referenceLib.lookupFunction<Void Function(Pointer<Int8>, Handle, Int32),
          void Function(Pointer<Int8>, Object, int)>('dart_add_pair');

  static final Object? Function(Pointer<Int8>) _dartGetObject =
      _referenceLib.lookupFunction<Handle Function(Pointer<Int8>),
          Object Function(Pointer<Int8>)>('dart_get_object');

  static final int Function(Pointer<Int8>) _dartContainsInstanceId =
      _referenceLib.lookupFunction<Int32 Function(Pointer<Int8>),
          int Function(Pointer<Int8>)>('dart_contains_instanceId');

  static final void Function(int sendPort) _dartRegisterReceivePort =
      _referenceLib.lookupFunction<Void Function(Int64 sendPort),
          void Function(int sendPort)>('register_dart_receive_port');

  static final void Function(Pointer<Int8>) _dartRemovePair =
      _referenceLib.lookupFunction<Void Function(Pointer<Int8>),
          void Function(Pointer<Int8>)>('dart_remove_pair');

  static Pointer<Int8> _stringAsNativeCharArray(String value) {
    return value.toNativeUtf8().cast<Int8>();
  }

  final Expando _instanceIds = Expando();
  late final ReceivePort _removePairReceivePort;

  bool addPair(
    Object instance,
    String instanceId, {
    required bool owner,
  }) {
    if (_instanceIds[instance] != null) return false;
    final Pointer<Int8> charArray = _stringAsNativeCharArray(instanceId);
    assert(_dartContainsInstanceId(charArray) == 0);

    _instanceIds[instance] = instanceId;
    _dartAddPair(charArray, instance, owner ? 1 : 0);
    return true;
  }

  bool isPaired(Object instance) {
    if (instance is num || instance is bool || instance is String) return false;
    return _instanceIds[instance] != null;
  }

  /// Retrieve the [PairedInstance] paired with [object].
  ///
  /// Returns null if this [object] is not paired.
  String? getInstanceId(Object instance) {
    return _instanceIds[instance] as String?;
  }

  /// Retrieve the [Object] paired with [pairedInstance].
  ///
  /// Returns null if this [pairedInstance] is not paired.
  Object? getInstance(String instanceId) {
    final Pointer<Int8> charArray = _stringAsNativeCharArray(instanceId);
    if (_dartContainsInstanceId(charArray) == 0) return null;
    return _dartGetObject(charArray);
  }

  void _removePair(dynamic message) {
    final String instanceId = message.toString();

    final Object? instance = getInstance(instanceId);
    if (instance == null) {
      throw StateError(
        'The Object with the following instanceId has already been disposed: $instanceId',
      );
    }

    _instanceIds[instance] = null;
    _dartRemovePair(_stringAsNativeCharArray(instanceId));
  }
}
