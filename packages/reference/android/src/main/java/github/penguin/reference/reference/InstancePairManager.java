package github.penguin.reference.reference;

import java.lang.ref.WeakReference;
import java.util.HashMap;
import java.util.Map;
import java.util.WeakHashMap;

public class InstancePairManager {
  private final WeakHashMap<Object, String> instanceIds = new WeakHashMap<>();
  private final Map<String, Object> strongReferences = new HashMap<>();
  private final Map<String, WeakReference<Object>> weakReferences = new HashMap<>();

  public boolean addPair(Object instance, String instanceId, boolean owner) {
    if (instanceIds.containsKey(instance)) return false;
    if (getInstance(instanceId) != null) throw new AssertionError();

    instanceIds.put(instance, instanceId);

    if (owner) {
      weakReferences.put(instanceId, new WeakReference<>(instance));
    } else {
      strongReferences.put(instanceId, instance);
    }
    return true;
  }

  public boolean isPaired(Object instance) {
    return instanceIds.containsKey(instance);
  }

  public String getInstanceId(Object instance) {
    return instanceIds.get(instance);
  }

  public void removePair(String instanceId) {
    Object instance = getInstance(instanceId);
    if (instance != null) {
      instanceIds.remove(instance);
      strongReferences.remove(instanceId);
    }

    weakReferences.remove(instanceId);
  }

  public Object getInstance(String instanceId) {
    final Object instance = strongReferences.get(instanceId);
    if (instance != null) return instance;

    final WeakReference<Object> reference = weakReferences.get(instanceId);
    if (reference != null) return reference.get();

    return null;
  }
}
