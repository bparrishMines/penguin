import 'dart:collection';

import 'reference.dart';

class RemoteReferenceMap {
  final _remoteReferences = _BiMap<Object, PairedReference>();

  void add(Object instance, PairedReference remoteReference) {
    _remoteReferences[instance] = remoteReference;
  }

  PairedReference? removePairWithObject(Object object) {
    return _remoteReferences.remove(object);
  }

  Object? removePairWithRemoteReference(PairedReference remoteReference) {
    return _remoteReferences.inverse.remove(remoteReference);
  }

  /// Retrieve the [PairedReference] paired with [instance].
  ///
  /// Returns null if this [instance] is not paired.
  PairedReference? getPairedRemoteReference(Object instance) {
    return _remoteReferences[instance];
  }

  /// Retrieve the [Object] paired with [remoteReference].
  ///
  /// Returns null if this [remoteReference] is not paired.
  Object? getPairedObject(PairedReference remoteReference) {
    return _remoteReferences.inverse[remoteReference];
  }
}

class _BiMap<K, V> extends MapBase<K, V> {
  _BiMap() {
    _inverse = _BiMap<V, K>._inverse(this);
  }

  _BiMap._inverse(this._inverse);

  final Map<K, V> _map = <K, V>{};
  late _BiMap<V, K> _inverse;

  _BiMap get inverse => _inverse;

  @override
  V? operator [](Object? key) => _map[key];

  @override
  void operator []=(K key, V value) {
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
  V? remove(Object? key) {
    if (key == null) return null;
    final V? value = _map[key];
    inverse._map.remove(value);
    return _map.remove(key);
  }
}
