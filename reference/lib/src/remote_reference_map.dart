import 'dart:collection';

import 'reference.dart';

/// Manages communication between [LocalReference]s and [RemoteReference]s.
///
/// This class works by facilitating communication between a [LocalReference]
/// and a [RemoteReference] pair. When a [LocalReference] is added to a
/// locally accessible [RemoteReferenceMap], it is expected that an
/// equivalent object is created and added to a remotely accessible
/// [RemoteReferenceMap].
///
/// For example, assume that there is a [RemoteReferenceMap] on a thread
/// running Dart code and a [RemoteReferenceMap] on a thread running Java
/// code. When an object of a Dart class named `Apple` is instantiated and is
/// added to the Dart [RemoteReferenceMap], then
///
/// 1. The Dart [RemoteReferenceMap] will send a message to the Java
/// [RemoteReferenceMap] to instantiate a Java object of a class named
/// `Apple`.
///
/// 2. The Dart `Apple` would then be stored as a [LocalReference] and paired
/// with a [RemoteReference] that represents the `Apple` instantiated in Java.
///
/// 3. The [RemoteReferenceMap]s would then handle sending and receiving
/// methods to be invoked between the Dart `Apple` and the Java `Apple` until
/// the objects are disposed and removed.
///
/// 4. Disposing of the Dart `Apple` would lead to a message sent to the remote
/// [RemoteReferenceMap] to dispose the Java `Apple`.
///
///
/// --------------------------------------------------------
///
/// [RemoteReferenceMap.remoteHandler] and [RemoteReferenceMap.localHandler]
/// must be overriden to return a value. See [MethodChannelReferencePairManager]
/// for an implementation using [MethodChannel]s.
class RemoteReferenceMap {
  // /// Default constructor for [ReferencePairManager].
  // ///
  // /// [ReferencePairManager.supportedTypes] must not be `null`.
  // ReferencePairManager();
  //
  // bool _isInitialized = false;

  void add(Object instance, RemoteReference remoteReference) {
    _remoteReferences[instance] = remoteReference;
  }

  RemoteReference removePairWithObject(Object object) {
    return _remoteReferences.remove(object);
  }

  Object removePairWithRemoteReference(RemoteReference remoteReference) {
    return _remoteReferences.inverse.remove(remoteReference);
  }

  final _remoteReferences = _BiMap<Object, RemoteReference>();

  // final _BiMap<int, Type> _typeIds;

  // final Map<String, ReferenceChannelHandler> _localReferenceHandlers =
  //     <String, ReferenceChannelHandler>{};

  // final List<Type> supportedTypes;

  // /// Handles communication with [RemoteReference]s.
  // RemoteReferenceCommunicationHandler get remoteHandler;
  //
  // /// Handles communication with [LocalReference]s.
  // LocalReferenceCommunicationHandler get localHandler;

  // /// Finish setup to start facilitating communication between [LocalReference] and [RemoteReference] pairs.
  // @mustCallSuper
  // void initialize() => _isInitialized = true;

  // /// Get the unique type identifier for a type in [ReferencePairManager.supportedTypes].
  // ///
  // /// If this [referenceType] is not in [ReferencePairManager.supportedTypes],
  // /// this will return `null`.
  // int getTypeId(Type referenceType) => _typeIds.inverse[referenceType];
  //
  // /// Get the type represented by [typeId].
  // ///
  // /// [typeId] should be greater than or equal to zero and less than
  // /// [ReferencePairManager.supportedTypes].length;
  // Type getReferenceType(int typeId) => _typeIds[typeId];

  /// Retrieve the [RemoteReference] paired with [instance].
  ///
  /// Returns null if this [instance] is not paired.
  RemoteReference getPairedRemoteReference(Object instance) {
    return _remoteReferences[instance];
  }

  /// Retrieve the [Object] paired with [remoteReference].
  ///
  /// Returns null if this [remoteReference] is not paired.
  Object getPairedObject(RemoteReference remoteReference) {
    return _remoteReferences.inverse[remoteReference];
  }
}

class _BiMap<K, V> extends MapBase<K, V> {
  _BiMap() {
    _inverse = _BiMap<V, K>._inverse(this);
  }

  _BiMap._inverse(this._inverse);

  final Map<K, V> _map = <K, V>{};
  _BiMap<V, K> _inverse;

  _BiMap get inverse => _inverse;

  @override
  operator [](Object key) {
    return _map[key];
  }

  @override
  void operator []=(key, value) {
    assert(key != null);
    assert(value != null);
    assert(!_map.containsKey(key));
    assert(!inverse.containsKey(value));
    _map[key] = value;
    inverse._map[value] = key;
  }

  @override
  void clear() {
    _map.clear();
    inverse._map.clear();
  }

  @override
  Iterable<K> get keys => _map.keys;

  @override
  V remove(Object key) {
    if (key == null) return null;
    final V value = _map[key];
    inverse._map.remove(value);
    return _map.remove(key);
  }
}
