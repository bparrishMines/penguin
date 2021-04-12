import 'dart:ffi';

import 'dart:io';
import 'dart:isolate';

import 'package:ffi/ffi.dart';

final DynamicLibrary _referenceLib = Platform.isAndroid
    ? DynamicLibrary.open('libreference.so')
    : DynamicLibrary.process();

final void Function(Pointer<Void> data) _referenceDartDlInitialize =
    _referenceLib.lookupFunction<Void Function(Pointer<Void> data),
        void Function(Pointer<Void> data)>('reference_dart_dl_initialize');

Pointer<Int8> _stringAsNativeCharArray(String value) {
  return value.toNativeUtf8().cast<Int8>();
}

class NativeWeakMap extends Struct {
  factory NativeWeakMap(int onFinalizePort) {
    return createWeakMap(onFinalizePort);
  }

  @Int64()
  external int onFinalizePort;

  external Pointer<Void> instanceMap;
}

final NativeWeakMap Function(int) createWeakMap = _referenceLib.lookupFunction<
    NativeWeakMap Function(Int64),
    NativeWeakMap Function(int)>('create_weak_map');

class _WeakMap {
  _WeakMap(void Function(String) onFinalize) {
    _onFinalizePort = ReceivePort()
      ..listen((message) {
        final String instanceId = message.toString();
        remove(instanceId);
        onFinalize(instanceId);
      });
    //print('create weak map');
    _nativeWeakMap = NativeWeakMap(_onFinalizePort.sendPort.nativePort);
    //print('create weak ma done');
  }

  static final int Function(NativeWeakMap, Pointer<Int8>, Object) _put =
      _referenceLib.lookupFunction<
          Int32 Function(NativeWeakMap, Pointer<Int8>, Handle),
          int Function(NativeWeakMap, Pointer<Int8>, Object)>('put');

  static final void Function(NativeWeakMap, Pointer<Int8>) _remove =
      _referenceLib.lookupFunction<Void Function(NativeWeakMap, Pointer<Int8>),
          void Function(NativeWeakMap, Pointer<Int8>)>('remove_key');

  static final int Function(NativeWeakMap, Pointer<Int8>) _contains =
      _referenceLib.lookupFunction<Int32 Function(NativeWeakMap, Pointer<Int8>),
          int Function(NativeWeakMap, Pointer<Int8>)>('contains');

  static final Object Function(NativeWeakMap, Pointer<Int8>) _get =
      _referenceLib.lookupFunction<
          Handle Function(NativeWeakMap, Pointer<Int8>),
          Object Function(NativeWeakMap, Pointer<Int8>)>('get');

  late final ReceivePort _onFinalizePort;
  late final NativeWeakMap _nativeWeakMap;

  bool put(String instanceId, Object instance) {
    return _put(
          _nativeWeakMap,
          _stringAsNativeCharArray(instanceId),
          instance,
        ) ==
        1;
  }

  bool containsKey(String instanceId) {
    //print('contains');
    return _contains(_nativeWeakMap, _stringAsNativeCharArray(instanceId)) == 1;
  }

  Object? get(String instanceId) {
    if (containsKey(instanceId)) {
      return _get(_nativeWeakMap, _stringAsNativeCharArray(instanceId));
    }

    return null;
  }

  void remove(String instanceId) {
    if (containsKey(instanceId)) {
      _remove(_nativeWeakMap, _stringAsNativeCharArray(instanceId));
    }
  }
}

/// Stores instance pair.
class InstancePairManager {
  InstancePairManager(void Function(String) onFinalize) {
    if (!_initialized) {
      _referenceDartDlInitialize(NativeApi.initializeApiDLData);
      _initialized = true;
    }
    _weakReferences = _WeakMap(onFinalize);
    //_removePairReceivePort = ReceivePort()..listen(_removePair);
    //_dartRegisterReceivePort(_removePairReceivePort.sendPort.nativePort);
  }

  //static final InstancePairManager instance = InstancePairManager();

  static bool _initialized = false;

  // static final void Function(Pointer<Void> data) _referenceDartDlInitialize =
  //     _referenceLib.lookupFunction<Void Function(Pointer<Void> data),
  //         void Function(Pointer<Void> data)>('reference_dart_dl_initialize');

  // static final void Function(Object, Pointer<Int8>) _dartAddWeakReference =
  //     _referenceLib.lookupFunction<Void Function(Handle, Pointer<Int8>),
  //         void Function(Object, Pointer<Int8>)>('dart_add_weak_reference');
  //
  // static final Object? Function(Pointer<Int8>) _dartGetWeakHandle =
  //     _referenceLib.lookupFunction<Handle Function(Pointer<Int8>),
  //         Object Function(Pointer<Int8>)>('dart_get_weak_handle');
  //
  // static final int Function(Pointer<Int8>) _dartContainsWeakHandleInstanceId =
  //     _referenceLib.lookupFunction<Int32 Function(Pointer<Int8>),
  //         int Function(Pointer<Int8>)>('dart_contains_weak_handle_instanceId');
  //
  // static final void Function(int sendPort) _dartRegisterReceivePort =
  //     _referenceLib.lookupFunction<Void Function(Int64 sendPort),
  //         void Function(int sendPort)>('register_dart_receive_port');

  // static Pointer<Int8> _stringAsNativeCharArray(String value) {
  //   return value.toNativeUtf8().cast<Int8>();
  // }

  final Expando _instanceIds = Expando();
  final Map<String, Object> _strongReferences = <String, Object>{};
  late final _WeakMap _weakReferences;
  //late final ReceivePort _removePairReceivePort;

  void removePair(String instanceId) {
    Object? instance = _strongReferences.remove(instanceId);
    if (instance != null) {
      _instanceIds[instance] = null;
      return;
    }

    instance = _weakReferences.get(instanceId);
    if (instance != null) {
      _instanceIds[instance] = null;
      _weakReferences.remove(instanceId);
    }
  }

  bool addPair(
    Object instance,
    String instanceId, {
    required bool owner,
  }) {
    //print(instance.runtimeType);
    if (isPaired(instance)) return false;
    //final Pointer<Int8> charArray = _stringAsNativeCharArray(instanceId);
    assert(getInstance(instanceId) == null);

    _instanceIds[instance] = instanceId;
    if (owner) {
      return _weakReferences.put(instanceId, instance);
    }

    _strongReferences[instanceId] = instance;
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
    //final Pointer<Int8> charArray = _stringAsNativeCharArray(instanceId);
    // final Object? instance = _strongReferences[instanceId];
    // if (instance != null) return instance;
    // if (_dartContainsWeakHandleInstanceId(charArray) == 1) {
    //   return _dartGetWeakHandle(charArray);
    // }
    // return _strongReferences[instanceId];
    return _strongReferences[instanceId] ?? _weakReferences.get(instanceId);
  }

  // void _removePair(dynamic message) {
  //   final String instanceId = message.toString();
  //
  //   final Object? instance = getInstance(instanceId);
  //   if (instance == null) {
  //     throw StateError(
  //       'The Object with the following instanceId has already been disposed: $instanceId',
  //     );
  //   }
  //
  //   _instanceIds[instance] = null;
  //   _strongReferences.remove(instanceId);
  // }
}
