package github.penguin.reference.reference;

import androidx.annotation.NonNull;
import androidx.annotation.VisibleForTesting;

import java.util.WeakHashMap;

public class InstancePairManager {
  private static InstancePairManager instance;

  private final WeakHashMap<Object, String> instanceIds = new WeakHashMap<>();

  @VisibleForTesting
  public InstancePairManager() { }

  private static native void passJvm();

  @NonNull
  public static InstancePairManager getInstance() {
    if (instance == null) {
      System.loadLibrary("native_add");
      passJvm();
      instance = new InstancePairManager();
    }
    return instance;
  }

  public boolean addPair(Object instance, String instanceId, boolean owner) {
    if (instanceIds.containsKey(instance)) return false;
    if (getInstance(instanceId) != null) throw new AssertionError();

    instanceIds.put(instance, instanceId);
    nativeAddPair(instance, instanceId, owner);
    return true;
  }

  public boolean isPaired(Object instance) {
    return instanceIds.containsKey(instance);
  }

  public String getInstanceId(Object instance) {
    return instanceIds.get(instance);
  }

  public void releaseDartHandle(Object instance) {
    if (!isPaired(instance)) throw new AssertionError();
    final String instanceId = instanceIds.remove(instance);
    nativeReleaseDartHandle(instanceId);
  }

  public native Object getInstance(String instanceId);

  private native void nativeAddPair(Object instance, String instanceId, boolean owner);

  private native void nativeReleaseDartHandle(String instanceId);
}
