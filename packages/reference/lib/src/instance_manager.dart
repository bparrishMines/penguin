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

  /// Add a new instance.
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

/// Manages instances.
///
/// Maintains two types of instances
///   * A strongly typed key mapped to a strongly typed object.
///   * A strongly typed key mapped to a weakly typed object.
///
/// When a strongly referenced object is added, it must be removed manually.
/// When a weakly referenced object is added, it it removed when it is garbage
/// collected.
class InstanceManager {
  /// Default constructor for an [InstanceManager].
  InstanceManager() {
    if (!_initialized) {
      _referenceDartDlInitialize(NativeApi.initializeApiDLData);
      _initialized = true;
    }
    _weakReferences = _WeakMap((String instanceId) {
      final void Function(String)? callback =
          _weakReferenceCallbacks[instanceId];
      if (callback != null) callback(instanceId);
    });
  }

  static bool _initialized = false;

  final Expando _instanceIds = Expando();

  final Map<String, Object> _strongReferences = <String, Object>{};
  late final _WeakMap _weakReferences;

  final Map<String, void Function(String)> _weakReferenceCallbacks =
      <String, void Function(String)>{};

  /// Remove the instance with [instancedId] as key.
  void removeInstance(String instanceId) {
    final Object? instance = getInstance(instanceId);
    if (instance != null) _instanceIds[instance] = null;

    _strongReferences.remove(instanceId);
    _weakReferences.remove(instanceId);
    _weakReferenceCallbacks.remove(instanceId);
  }

  /// Add a new instance with [instanceId] as key and [instance] as the value.
  ///
  /// [instance] is stored as a weak reference and [onFinalize] is called
  /// when [instance] is garbage collected.
  ///
  /// Returns `true` if the instance is successfully added. Returns `false` if
  /// the [instanceId] or [instance] is already contained in the manager or the
  /// [instance] is a [num], [bool], or [String].
  bool addWeakReference({
    required Object instance,
    String? instanceId,
    required void Function(String instanceId) onFinalize,
  }) {
    if (!_isValidInstance(instance)) return false;

    final String newId = instanceId ?? generateUniqueInstanceId(instance);

    _instanceIds[instance] = newId;
    _weakReferenceCallbacks[newId] = onFinalize;
    return _weakReferences.put(newId, instance);
  }

  /// Add a new instance with [instanceId] as key and [instance] as the value.
  ///
  /// [instance] is stored as a strong reference.
  ///
  /// Returns `true` if the pair is successfully added. Returns `false` if
  /// the [instanceId] or [instance] is already contained in the manager or the
  /// [instance] is a [num], [bool], or [String].
  bool addStrongReference({required Object instance, String? instanceId}) {
    if (!_isValidInstance(instance)) return false;

    final String newId = instanceId ?? generateUniqueInstanceId(instance);
    _instanceIds[instance] = newId;
    _strongReferences[newId] = instance;
    return true;
  }

  bool _isValidInstance(Object instance) {
    if (instance is num ||
        instance is bool ||
        instance is String ||
        containsInstance(instance)) {
      return false;
    }
    return true;
  }

  /// Whether [instance] is contained in this manager.
  bool containsInstance(Object instance) {
    if (instance is num || instance is bool || instance is String) return false;
    return _instanceIds[instance] != null;
  }

  /// Retrieve the instanceId paired with [object].
  ///
  /// Returns null if this [instance] is not paired.
  String? getInstanceId(Object instance) {
    if (containsInstance(instance)) return _instanceIds[instance] as String?;
    return null;
  }

  /// Retrieve the [Object] paired with [instanceId].
  ///
  /// Returns null if this [instanceId] is not paired.
  Object? getInstance(String instanceId) {
    return _strongReferences[instanceId] ?? _weakReferences.get(instanceId);
  }

  /// Generate a new unique instance id for instance.
  String generateUniqueInstanceId(Object instance) {
    return '${instance.runtimeType}(${instance.hashCode})';
  }
}
