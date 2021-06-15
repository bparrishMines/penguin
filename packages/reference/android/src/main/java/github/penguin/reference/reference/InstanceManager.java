package github.penguin.reference.reference;

import android.annotation.SuppressLint;

import androidx.annotation.Nullable;

import java.lang.ref.WeakReference;
import java.util.HashMap;
import java.util.Map;
import java.util.WeakHashMap;

public class InstanceManager {
  private final WeakHashMap<Object, String> instanceIds = new WeakHashMap<>();
  private final Map<String, Object> strongReferences = new HashMap<>();
  private final Map<String, Object> temporaryStrongReferences = new HashMap<>();
  private final Map<String, WeakReference<Object>> weakReferences = new HashMap<>();

  public boolean addWeakReference(Object instance, @Nullable String instanceId) {
    if (containsInstance(instance)) return false;

    final String newId = instanceId != null ? instanceId : generateUniqueInstanceId(instance);

    instanceIds.put(instance, newId);
    weakReferences.put(newId, new WeakReference<>(instance));
    return true;
  }

  public boolean addStrongReference(Object instance, @Nullable String instanceId) {
    if (instanceIds.containsKey(instance)) return false;

    final String newId = instanceId != null ? instanceId : generateUniqueInstanceId(instance);

    instanceIds.put(instance, newId);
    strongReferences.put(newId, instance);
    return true;
  }

  public boolean addTemporaryStrongReference(Object instance, @Nullable String instanceId) {
    if (instanceIds.containsKey(instance)) return false;

    final String newId = instanceId != null ? instanceId : generateUniqueInstanceId(instance);

    instanceIds.put(instance, newId);
    temporaryStrongReferences.put(newId, instance);
    return true;
  }

  public boolean containsInstance(Object instance) {
    return instanceIds.containsKey(instance);
  }

  public String getInstanceId(Object instance) {
    return instanceIds.get(instance);
  }

  public void removeInstance(String instanceId) {
    final Object instance = getInstance(instanceId);
    if (instance != null) instanceIds.remove(instance);

    temporaryStrongReferences.remove(instanceId);
    strongReferences.remove(instanceId);
    weakReferences.remove(instanceId);
  }

  public Object getInstance(String instanceId) {
    final Object tempInstance = temporaryStrongReferences.get(instanceId);
    if (tempInstance != null) {
      removeInstance(instanceId);
      addWeakReference(tempInstance, instanceId);
      return tempInstance;
    }

    final Object instance = strongReferences.get(instanceId);
    if (instance != null) return instance;

    final WeakReference<Object> reference = weakReferences.get(instanceId);
    if (reference != null) return reference.get();

    return null;
  }

  @SuppressLint("DefaultLocale")
  protected String generateUniqueInstanceId(Object instance) {
    return String.format("%s(%d)", instance.getClass().getName(), instance.hashCode());
  }
}
