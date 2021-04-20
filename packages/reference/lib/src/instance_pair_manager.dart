import 'dart:ffi';

import 'dart:io';
import 'dart:isolate';

import 'package:ffi/ffi.dart';

/// C library in `ios/Classes/reference.cpp`.
final DynamicLibrary _referenceLib = Platform.isAndroid
    ? DynamicLibrary.open('libreference.so')
    : DynamicLibrary.process();

/// Initializes the dynamic linked reference library in `ios/Classes/reference.cpp`.
final int Function(Pointer<Void> data) _referenceDartDlInitialize =
    _referenceLib.lookupFunction<Int32 Function(Pointer<Void> data),
        int Function(Pointer<Void> data)>('reference_dart_dl_initialize');

/// Create a new weak map.
final _NativeWeakMap Function(int) _createWeakMap =
    _referenceLib.lookupFunction<_NativeWeakMap Function(Int64),
        _NativeWeakMap Function(int)>('create_weak_map');

/// Dart representation of a struct in reference c library.
class _NativeWeakMap extends Struct {
  factory _NativeWeakMap(int onFinalizePort) {
    return _createWeakMap(onFinalizePort);
  }

  @Int64()
  external int onFinalizePort;

  external Pointer<Void> instanceMap;
}

/// Map storing a strongly referenced string key to a weakly referenced Dart object.
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

  /// Callback port for when a Dart_Handle is garbage collected.
  late final ReceivePort _onFinalizePort;
  late final _NativeWeakMap _nativeWeakMap;

  static Pointer<Int8> _stringAsNativeCharArray(String value) {
    return value.toNativeUtf8().cast<Int8>();
  }

  /// Add a new pair.
  bool put(String instanceId, Object instance) {
    return _put(
          _nativeWeakMap,
          _stringAsNativeCharArray(instanceId),
          instance,
        ) ==
        1;
  }

  /// Whether the map contains the [instanceId] as a key.
  bool containsKey(String instanceId) {
    return _contains(_nativeWeakMap, _stringAsNativeCharArray(instanceId)) == 1;
  }

  /// Attempt to retrieve the value of key [instanceId]
  Object? get(String instanceId) {
    if (containsKey(instanceId)) {
      return _get(_nativeWeakMap, _stringAsNativeCharArray(instanceId));
    }

    return null;
  }

  /// Attempt to remove the value of key [instanceId].
  void remove(String instanceId) {
    if (containsKey(instanceId)) {
      _remove(_nativeWeakMap, _stringAsNativeCharArray(instanceId));
    }
  }
}

/// Manages instance pairs.
///
/// Maintains two types of instance pairs
///   * A strongly typed key mapped to a strongly typed object.
///   * A strongly typed key mapped to a weakly typed object.
///
/// When a strongly referenced object is added, it must be removed manually.
/// When a weakly referenced object is added, it it removed when it is garbage
/// collected.
class InstancePairManager {
  /// Constructs an [InstancePairManager].
  ///
  /// When a weakly referenced object is removed from the manager through
  /// by GC, [onFinalize] is called with the instanceId used as its key.
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

  /// Remove the pair with [instancedId] as key.
  void removePair(String instanceId) {
    final Object? instance = getInstance(instanceId);
    if (instance != null) {
      _instanceIds[instance] = null;
      _strongReferences.remove(instanceId);
    }

    _weakReferences.remove(instanceId);
  }

  /// Add a new pair with [instanceId] as key and [instance] as the value.
  ///
  /// [owner] sets whether [instance] is stored as strongly referenced or
  /// weakly referenced.
  ///   * If [owner] == `true`, it is stored as weakly referenced.
  ///   * If [owner] == 'false`, it is stored as strongly referenced.
  ///
  /// Returns `true` if the pair is successfully added. Returns `false` if
  /// the [instanceId] or [instance] is already contained in the manager or the
  /// [instance] is a [num], [bool], or [String].
  bool addPair(
    Object instance,
    String instanceId, {
    required bool owner,
  }) {
    if (instance is num || instance is bool || instance is String) return false;
    if (isPaired(instance)) return false;
    assert(getInstance(instanceId) == null);

    _instanceIds[instance] = instanceId;
    if (owner) {
      return _weakReferences.put(instanceId, instance);
    }

    _strongReferences[instanceId] = instance;
    return true;
  }

  /// Whether [instance] is contained in this manager.
  bool isPaired(Object instance) {
    if (instance is num || instance is bool || instance is String) return false;
    return _instanceIds[instance] != null;
  }

  /// Retrieve the [PairedInstance] paired with [object].
  ///
  /// Returns null if this [object] is not paired.
  String? getInstanceId(Object instance) {
    if (isPaired(instance)) return _instanceIds[instance] as String?;
    return null;
  }

  /// Retrieve the [Object] paired with [pairedInstance].
  ///
  /// Returns null if this [pairedInstance] is not paired.
  Object? getInstance(String instanceId) {
    return _strongReferences[instanceId] ?? _weakReferences.get(instanceId);
  }
}
