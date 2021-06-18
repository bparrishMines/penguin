package github.penguin.reference.reference;

import android.annotation.SuppressLint;

import androidx.annotation.Nullable;

import java.lang.ref.ReferenceQueue;
import java.lang.ref.WeakReference;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.WeakHashMap;

public class InstanceManager {
  public interface OnFinalizeListener {
    void onFinalize(String instanceId);
  }
  
  private final WeakHashMap<Object, String> instanceIds = new WeakHashMap<>();
  private final Map<String, Object> strongReferences = new HashMap<>();
  private final Map<String, Object> temporaryStrongReferences = new HashMap<>();

  private final Map<String, WeakReference<Object>> weakReferences = new HashMap<>();
  private final Map<WeakReference<Object>, String> weakReferenceIds = new HashMap<>();
  private final Map<WeakReference<Object>, OnFinalizeListener> weakReferenceListeners = new HashMap<>();
  private final ReferenceQueue<Object> referenceQueue = new ReferenceQueue<>();

  public boolean addWeakReference(Object instance, @Nullable String instanceId, OnFinalizeListener onFinalize) {
    if (containsInstance(instance)) return false;

    final String newId = instanceId != null ? instanceId : generateUniqueInstanceId(instance);

    instanceIds.put(instance, newId);

    final WeakReference<Object> reference = new WeakReference<>(instance, referenceQueue);
    weakReferences.put(newId, reference);
    weakReferenceIds.put(reference, newId);
    weakReferenceListeners.put(reference, onFinalize);
    return true;
  }

  @SuppressWarnings("unchecked")
  private void flushWeakReferences() {
    WeakReference<Object> referenceFromQueue;

    while ((referenceFromQueue = (WeakReference<Object>) referenceQueue.poll()) != null) {
      final String instanceId = weakReferenceIds.remove(referenceFromQueue);
      final OnFinalizeListener listener = weakReferenceListeners.remove(referenceFromQueue);

      // TODO: remove
      android.util.Log.d("ReferencePlugin", "Releasing instanceId: " + instanceId);

      removeInstance(instanceId);
      Objects.requireNonNull(listener).onFinalize(instanceId);
    }
  }

  public boolean addStrongReference(Object instance, @Nullable String instanceId) {
    if (instanceIds.containsKey(instance)) return false;

    final String newId = instanceId != null ? instanceId : generateUniqueInstanceId(instance);

    instanceIds.put(instance, newId);
    strongReferences.put(newId, instance);
    return true;
  }

  public boolean addTemporaryStrongReference(Object instance, @Nullable String instanceId, OnFinalizeListener onFinalize) {
    final String newId = instanceId != null ? instanceId : generateUniqueInstanceId(instance);

    if (addWeakReference(instance, newId, onFinalize)) {
      temporaryStrongReferences.put(newId, instance);
      return true;
    }

    return false;
  }

  public boolean containsInstance(Object instance) {
    return instanceIds.containsKey(instance);
  }

  @Nullable
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

  @Nullable
  public Object getInstance(String instanceId) {
    flushWeakReferences();

    final Object tempInstance = temporaryStrongReferences.get(instanceId);
    if (tempInstance != null) {
      temporaryStrongReferences.remove(instanceId);
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
