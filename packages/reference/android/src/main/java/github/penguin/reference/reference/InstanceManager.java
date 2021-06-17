package github.penguin.reference.reference;

import android.annotation.SuppressLint;

import androidx.annotation.Nullable;

import java.lang.ref.PhantomReference;
import java.lang.ref.Reference;
import java.lang.ref.ReferenceQueue;
import java.lang.ref.WeakReference;
import java.util.HashMap;
import java.util.Map;
import java.util.WeakHashMap;

public class InstanceManager {
  public interface OnFinalizeListener {
    void onFinalize(String instanceId);
  }
  
  private final WeakHashMap<Object, String> instanceIds = new WeakHashMap<>();
  private final Map<String, Object> strongReferences = new HashMap<>();
  private final Map<String, Object> temporaryStrongReferences = new HashMap<>();

  private final Map<String, WeakReference<Object>> weakReferences = new HashMap<>();
  private final Map<String, OnFinalizeListener> weakReferenceListeners = new HashMap<>();
  private final ReferenceQueue<Object> referenceQueue = new ReferenceQueue<>();

  public boolean addWeakReference(Object instance, @Nullable String instanceId, OnFinalizeListener onFinalize) {
    if (containsInstance(instance)) return false;

    final String newId = instanceId != null ? instanceId : generateUniqueInstanceId(instance);

    instanceIds.put(instance, newId);
    weakReferences.put(newId, new WeakReference<>(instance));
    weakReferenceListeners.put(newId, onFinalize);
    new PhantomReference<>(instance, referenceQueue);
    return true;
  }

  private void flushPhantomReferences() {
    Reference<?> referenceFromQueue;
    while ((referenceFromQueue = referenceQueue.poll()) != null) {
      final Object instance = referenceFromQueue.get();
      final String instanceId = getInstanceId(instance);

      // TODO: remove
      android.util.Log.d("ReferencePlugin", "Releasing instanceId: " + instanceId);

      final OnFinalizeListener listener = weakReferenceListeners.get(instanceId);
      if (listener == null) {
        throw new IllegalStateException("Unable to find listener for object with instanceId: " + instanceId);
      }
      removeInstance(instanceId);
      listener.onFinalize(instanceId);
      referenceFromQueue.clear();
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
    if (instanceIds.containsKey(instance)) return false;

    final String newId = instanceId != null ? instanceId : generateUniqueInstanceId(instance);

    instanceIds.put(instance, newId);
    temporaryStrongReferences.put(newId, instance);
    weakReferenceListeners.put(newId, onFinalize);
    return true;
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
    weakReferenceListeners.remove(instanceId);
  }

  @Nullable
  public Object getInstance(String instanceId) {
    flushPhantomReferences();
    final Object tempInstance = temporaryStrongReferences.get(instanceId);
    if (tempInstance != null) {
      final OnFinalizeListener onFinalize = weakReferenceListeners.get(instanceId);
      instanceIds.remove(tempInstance);
      temporaryStrongReferences.remove(instanceId);
      addWeakReference(tempInstance, instanceId, onFinalize);
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
