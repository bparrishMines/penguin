import 'dart:ffi';

import 'dart:io';
import 'dart:isolate';

import 'package:ffi/ffi.dart';

final DynamicLibrary _referenceLib = Platform.isAndroid
    ? DynamicLibrary.open('libreference.so')
    : DynamicLibrary.process();

final int Function(Pointer<Void> data) _referenceDartDlInitialize =
    _referenceLib.lookupFunction<Int32 Function(Pointer<Void> data),
        int Function(Pointer<Void> data)>('reference_dart_dl_initialize');

final _NativeWeakMap Function(int) createWeakMap = _referenceLib.lookupFunction<
    _NativeWeakMap Function(Int64),
    _NativeWeakMap Function(int)>('create_weak_map');

class _NativeWeakMap extends Struct {
  factory _NativeWeakMap(int onFinalizePort) {
    return createWeakMap(onFinalizePort);
  }

  @Int64()
  external int onFinalizePort;

  external Pointer<Void> instanceMap;
}

class _WeakMap {
  _WeakMap(void Function(String) onFinalize) {
    _onFinalizePort = ReceivePort()
      ..listen((message) {
        final String instanceId = message.toString();
        remove(instanceId);
        onFinalize(instanceId);
      });
    _nativeWeakMap = _NativeWeakMap(_onFinalizePort.sendPort.nativePort);
  }

  static final int Function(_NativeWeakMap, Pointer<Int8>, Object) _put =
      _referenceLib.lookupFunction<
          Int32 Function(_NativeWeakMap, Pointer<Int8>, Handle),
          int Function(_NativeWeakMap, Pointer<Int8>, Object)>('put');

  static final void Function(_NativeWeakMap, Pointer<Int8>) _remove =
      _referenceLib.lookupFunction<Void Function(_NativeWeakMap, Pointer<Int8>),
          void Function(_NativeWeakMap, Pointer<Int8>)>('remove_key');

  static final int Function(_NativeWeakMap, Pointer<Int8>) _contains =
      _referenceLib.lookupFunction<
          Int32 Function(_NativeWeakMap, Pointer<Int8>),
          int Function(_NativeWeakMap, Pointer<Int8>)>('contains');

  static final Object Function(_NativeWeakMap, Pointer<Int8>) _get =
      _referenceLib.lookupFunction<
          Handle Function(_NativeWeakMap, Pointer<Int8>),
          Object Function(_NativeWeakMap, Pointer<Int8>)>('get');

  late final ReceivePort _onFinalizePort;
  late final _NativeWeakMap _nativeWeakMap;

  Pointer<Int8> _stringAsNativeCharArray(String value) {
    return value.toNativeUtf8().cast<Int8>();
  }

  bool put(String instanceId, Object instance) {
    return _put(
          _nativeWeakMap,
          _stringAsNativeCharArray(instanceId),
          instance,
        ) ==
        1;
  }

  bool containsKey(String instanceId) {
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
  }

  static bool _initialized = false;

  final Expando _instanceIds = Expando();
  final Map<String, Object> _strongReferences = <String, Object>{};
  late final _WeakMap _weakReferences;

  void removePair(String instanceId) {
    final Object? instance = getInstance(instanceId);
    if (instance != null) {
      _instanceIds[instance] = null;
      _strongReferences.remove(instanceId);
    }

    _weakReferences.remove(instanceId);
  }

  bool addPair(
    Object instance,
    String instanceId, {
    required bool owner,
  }) {
    if (isPaired(instance)) return false;
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
    return _strongReferences[instanceId] ?? _weakReferences.get(instanceId);
  }
}
