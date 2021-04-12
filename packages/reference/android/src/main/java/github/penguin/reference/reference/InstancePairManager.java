package github.penguin.reference.reference;

import java.lang.ref.WeakReference;
import java.util.HashMap;
import java.util.Map;
import java.util.WeakHashMap;

public class InstancePairManager {
  private final WeakHashMap<Object, String> instanceIds = new WeakHashMap<>();
  private final Map<String, Object> strongReferences = new HashMap<>();
  private final Map<String, WeakReference<Object>> weakReferences = new HashMap<>();

//  @NonNull
//  public static InstancePairManager getInstance() {
//    if (instance == null) {
//      System.loadLibrary("reference");
//      instance = new InstancePairManager();
//      //instance.initializeLib();
//    }
//    return instance;
//  }

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
    //if (!isPaired(instance)) throw new AssertionError();
    Object instance = getInstance(instanceId);
    if (instance != null) {
      instanceIds.remove(instance);
      strongReferences.remove(instanceId);
    }

    weakReferences.remove(instanceId);
    //nativeReleaseDartHandle(instanceId);
  }

//  public void removePair(String instanceId) {
//    final Object instance = getInstance(instanceId);
//    if (instance == null) {
//      throw new IllegalStateException(
//          "The Object with the following instanceId has already been disposed: " + instanceId
//      );
//    }
//
//    instanceIds.remove(instance);
//    strongReferences.remove(instanceId);
//  }

  public Object getInstance(String instanceId) {
    final Object instance = strongReferences.get(instanceId);
    if (instance != null) return instance;

    final WeakReference<Object> reference = weakReferences.get(instanceId);
    if (reference != null) return reference.get();

    return null;
  }

  //private native void initializeLib();

  //private native void nativeReleaseDartHandle(String instanceId);
}
