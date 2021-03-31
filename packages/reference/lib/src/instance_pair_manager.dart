import 'dart:ffi';

import 'dart:io';

import 'package:ffi/ffi.dart';

// final DynamicLibrary _nativeAddLib = Platform.isAndroid
//     ? DynamicLibrary.open('libnative_add.so')
//     : DynamicLibrary.process();
//
// final void Function(Pointer<Void> data) _referenceDartDlInitialize =
//     _nativeAddLib.lookupFunction<Void Function(Pointer<Void> data),
//         void Function(Pointer<Void> data)>('reference_dart_dl_initialize');
//
// final int Function(Pointer<Int8>, Object, int) _dartAddPair =
//     _nativeAddLib.lookupFunction<Int32 Function(Pointer<Int8>, Handle, Int32),
//         int Function(Pointer<Int8>, Object, int)>('dart_add_pair');

// final int Function(Object) _dartIsPaired =
//     _nativeAddLib.lookupFunction<Int32 Function(Handle), int Function(Object)>(
//         'dart_is_paired');

// final Pointer<Int8>? Function(Object) _dartGetInstanceId =
//     _nativeAddLib.lookupFunction<Pointer<Int8> Function(Handle),
//         Pointer<Int8> Function(Object)>('dart_get_instanceId');

// final Object? Function(Pointer<Int8>) _dartGetObject =
//     _nativeAddLib.lookupFunction<Handle Function(Pointer<Int8>),
//         Object Function(Pointer<Int8>)>('dart_get_object');

/// Stores instance pair.
class InstancePairManager {
  // final _pairedInstances = _BiMap<Object, PairedInstance>();
  // final Map<Object, Set<Object>> _owners = <Object, Set<Object>>{};
  InstancePairManager._() {
    _referenceDartDlInitialize(NativeApi.initializeApiDLData);
  }

  static final InstancePairManager instance = InstancePairManager._();

  static final DynamicLibrary _nativeAddLib = Platform.isAndroid
      ? DynamicLibrary.open('libnative_add.so')
      : DynamicLibrary.process();

  static final void Function(Pointer<Void> data) _referenceDartDlInitialize =
      _nativeAddLib.lookupFunction<Void Function(Pointer<Void> data),
          void Function(Pointer<Void> data)>('reference_dart_dl_initialize');

  static final void Function(Pointer<Int8>, Object, int) _dartAddPair =
      _nativeAddLib.lookupFunction<Void Function(Pointer<Int8>, Handle, Int32),
          void Function(Pointer<Int8>, Object, int)>('dart_add_pair');

  static final Object? Function(Pointer<Int8>) _dartGetObject =
      _nativeAddLib.lookupFunction<Handle Function(Pointer<Int8>),
          Object Function(Pointer<Int8>)>('dart_get_object');

  static final int Function(Pointer<Int8>) _dartContainsInstanceId =
      _nativeAddLib.lookupFunction<Int32 Function(Pointer<Int8>),
          int Function(Pointer<Int8>)>('dart_contains_instanceId');

  final Expando _instanceIds = Expando();

  bool addPair(
    Object instance,
    String instanceId, {
    required bool owner,
  }) {
    if (_instanceIds[instance] != null) return false;
    final Pointer<Int8> charArray = instanceId.toNativeUtf8().cast<Int8>();
    assert(_dartContainsInstanceId(charArray) == 0);

    _instanceIds[instance] = instanceId;
    _dartAddPair(charArray, instance, owner ? 1 : 0);
    return true;
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
    return _instanceIds[instance] != null;
    //return getPairedPairedInstance(instance) != null;
  }

  /// Retrieve the [PairedInstance] paired with [object].
  ///
  /// Returns null if this [object] is not paired.
  String? getInstanceId(Object instance) {
    return _instanceIds[instance] as String?;
    //return _pairedInstances[object];
  }

  // TODO: `getInstance`
  /// Retrieve the [Object] paired with [pairedInstance].
  ///
  /// Returns null if this [pairedInstance] is not paired.
  Object? getObject(String instanceId) {
    final Pointer<Int8> charArray = instanceId.toNativeUtf8().cast<Int8>();
    if (_dartContainsInstanceId(charArray) == 0) return null;
    return _dartGetObject(charArray);
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
