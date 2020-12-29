import 'dart:collection';

import 'instance.dart';

/// Maintains instance pairs.
class PairedInstanceMap {
  final _pairedInstances = _BiMap<Object, PairedInstance>();

  /// Adds an instance pair.
  void add(Object instance, PairedInstance pairedInstance) {
    _pairedInstances[instance] = pairedInstance;
  }

  /// Remove an instance pair containing [object].
  PairedInstance? removePairWithObject(Object object) {
    return _pairedInstances.remove(object);
  }

  /// Remove an instance pair containing [pairedInstance].
  Object? removePairWithPairedInstance(PairedInstance pairedInstance) {
    return _pairedInstances.inverse.remove(pairedInstance);
  }

  /// Retrieve the [PairedInstance] paired with [instance].
  ///
  /// Returns null if this [instance] is not paired.
  PairedInstance? getPairedInstance(Object instance) {
    return _pairedInstances[instance];
  }

  /// Retrieve the [Object] paired with [pairedInstance].
  ///
  /// Returns null if this [pairedInstance] is not paired.
  Object? getPairedObject(PairedInstance pairedInstance) {
    return _pairedInstances.inverse[pairedInstance];
  }
}

class _BiMap<K extends Object, V extends Object> extends MapBase<K, V> {
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
