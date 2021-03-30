import 'dart:ffi';

import 'dart:io';

import 'package:ffi/ffi.dart';

final DynamicLibrary _nativeAddLib = Platform.isAndroid
    ? DynamicLibrary.open("libnative_add.so")
    : DynamicLibrary.process();

final void Function(Pointer<Void> data) _referenceDartDlInitialize =
    _nativeAddLib.lookupFunction<Void Function(Pointer<Void> data),
        void Function(Pointer<Void> data)>("reference_dart_dl_initialize");

final int Function(Pointer<Int8>, Object, int) _dartAddPair =
    _nativeAddLib.lookupFunction<Int32 Function(Pointer<Int8>, Handle, Int32),
        int Function(Pointer<Int8>, Object, int)>("dart_add_pair");

final int Function(Object) _dartIsPaired =
    _nativeAddLib.lookupFunction<Int32 Function(Handle), int Function(Object)>(
        "dart_is_paired");

final Pointer<Int8>? Function(Object) _dartGetInstanceId =
    _nativeAddLib.lookupFunction<Pointer<Int8> Function(Handle),
        Pointer<Int8> Function(Object)>("dart_get_instanceId");

final Object? Function(Pointer<Int8>) _dartGetObject =
    _nativeAddLib.lookupFunction<Handle Function(Pointer<Int8>),
        Object Function(Pointer<Int8>)>("dart_get_object");

/// Stores instance pair.
class InstancePairManager {
  // final _pairedInstances = _BiMap<Object, PairedInstance>();
  // final Map<Object, Set<Object>> _owners = <Object, Set<Object>>{};
  InstancePairManager() {
    _referenceDartDlInitialize(NativeApi.initializeApiDLData);
  }

  bool addPair(
    Object instance,
    String instanceId, {
    required bool owner,
  }) {
    return 1 ==
        _dartAddPair(
          instanceId.toNativeUtf8().cast<Int8>(),
          instance,
          owner ? 1 : 0,
        );
  }
  // /// Adds an instance pair.
  // ///
  // /// Duplicate keys or values will throw an [AssertionError].
  // bool addPair(
  //   Object object,
  //   PairedInstance pairedInstance, {
  //   required Object owner,
  // }) {
  //   final bool containsObject = _pairedInstances.containsKey(object);
  //
  //   if (!containsObject) {
  //     assert(!_pairedInstances.containsValue(pairedInstance));
  //     _pairedInstances[object] = pairedInstance;
  //     _owners[object] = <Object>{};
  //   }
  //
  //   _owners[object]!.add(owner);
  //   return !containsObject;
  // }
  //
  // /// Remove an instance pair containing [object].
  // bool removePairWithObject(
  //   Object object, {
  //   required Object owner,
  //   bool force = false,
  // }) {
  //   if (!_pairedInstances.containsKey(object)) return false;
  //
  //   final Set<Object> owners = _owners[object]!;
  //   owners.remove(owner);
  //
  //   if (!force && owners.isNotEmpty) return false;
  //
  //   _pairedInstances.remove(object);
  //   _owners.remove(object);
  //   return true;
  // }

  bool isPaired(Object instance) {
    return _dartIsPaired(instance) == 1;
    //return getPairedPairedInstance(instance) != null;
  }

  /// Retrieve the [PairedInstance] paired with [object].
  ///
  /// Returns null if this [object] is not paired.
  String? getInstanceId(Object instance) {
    return _dartGetInstanceId(instance)?.cast<Utf8>().toDartString();
    //return _pairedInstances[object];
  }

  /// Retrieve the [Object] paired with [pairedInstance].
  ///
  /// Returns null if this [pairedInstance] is not paired.
  Object? getObject(String instanceId) {
    return _dartGetObject(instanceId.toNativeUtf8().cast<Int8>());
    //return _pairedInstances.inverse[pairedInstance];
  }
}

// class _BiMap<K extends Object, V extends Object> extends MapBase<K, V> {
//   _BiMap() {
//     _inverse = _BiMap<V, K>._inverse(this);
//   }
//
//   _BiMap._inverse(this._inverse);
//
//   final Map<K, V> _map = <K, V>{};
//   late _BiMap<V, K> _inverse;
//
//   _BiMap get inverse => _inverse;
//
//   @override
//   V? operator [](Object? key) => _map[key];
//
//   @override
//   void operator []=(K key, V value) {
//     assert(!_map.containsKey(key));
//     assert(!inverse.containsKey(value));
//     _map[key] = value;
//     inverse._map[value] = key;
//   }
//
//   @override
//   void clear() {
//     _map.clear();
//     inverse._map.clear();
//   }
//
//   @override
//   Iterable<K> get keys => _map.keys;
//
//   @override
//   V? remove(Object? key) {
//     if (key == null) return null;
//     final V? value = _map[key];
//     inverse._map.remove(value);
//     return _map.remove(key);
//   }
// }
