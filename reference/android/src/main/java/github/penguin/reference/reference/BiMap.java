package github.penguin.reference.reference;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

class BiMap<K, V> implements Map<K, V> {
  private final Map<K, V> map = new HashMap<>();
  final BiMap<V, K> inverse;

  BiMap() {
    this.inverse = new BiMap<>(this);
  }

  private BiMap(BiMap<V, K> inverse) {
    this.inverse = inverse;
  }

  @Override
  public int size() {
    return map.size();
  }

  @Override
  public boolean isEmpty() {
    return map.isEmpty();
  }

  @Override
  public boolean containsKey(@Nullable Object key) {
    return map.containsKey(key);
  }

  @Override
  public boolean containsValue(@Nullable Object value) {
    return map.containsValue(value);
  }

  @Nullable
  @Override
  public V get(@Nullable Object key) {
    return map.get(key);
  }

  @Nullable
  @Override
  public V put(@NonNull K key, @NonNull V value) {
    if (map.containsKey(key) || inverse.containsKey(value)) throw new AssertionError();
    inverse.map.put(value, key);
    return map.put(key, value);
  }

  @Nullable
  @Override
  public V remove(@Nullable Object key) {
    if (key == null) return null;
    inverse.map.remove(get(key));
    return map.remove(key);
  }

  @Override
  public void putAll(@NonNull Map<? extends K, ? extends V> m) {
    for (Map.Entry<? extends K, ? extends V> entry : m.entrySet()) {
      put(entry.getKey(), entry.getValue());
    }
  }

  @Override
  public void clear() {
    map.clear();
    inverse.map.clear();
  }

  @NonNull
  @Override
  public Set<K> keySet() {
    return map.keySet();
  }

  @NonNull
  @Override
  public Collection<V> values() {
    return map.values();
  }

  @NonNull
  @Override
  public Set<Entry<K, V>> entrySet() {
    return map.entrySet();
  }
}
