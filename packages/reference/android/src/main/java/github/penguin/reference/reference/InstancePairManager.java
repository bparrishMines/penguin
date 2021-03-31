package github.penguin.reference.reference;

import java.util.WeakHashMap;

public class InstancePairManager {
  //  private final BiMap<Object, PairedInstance> pairedInstances = new BiMap<>();
//  private final Map<Object, Set<Object>> owners = new HashMap<>();

  public static final InstancePairManager instance;

  static {
    System.loadLibrary("native_add");
    instance = new InstancePairManager();
  }

  private final WeakHashMap<Object, String> instanceIds = new WeakHashMap<>();

  private InstancePairManager() {
    passJvm();
  }

  public static native void passJvm();

  public boolean addPair(Object instance, String instanceId, boolean owner) {
    if (instanceIds.containsKey(instance)) return false;
    if (getObject(instanceId) != null) throw new AssertionError();

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

  private native void nativeAddPair(Object instance, String instanceId, boolean owner);
//    final boolean wasPaired = isPaired(object);
//
//    if (!wasPaired) {
//      if (pairedInstances.containsValue(pairedInstance)) throw new IllegalStateException();
//      pairedInstances.put(object, pairedInstance);
//      owners.put(object, new HashSet<>());
//    }
//
//    owners.get(object).add(owner);
//    return !wasPaired;


//  boolean removePairWithObject(Object object, Object owner, boolean force) {
//    if (!isPaired(object)) return false;
//
//    final Set<Object> objectOwners = owners.get(object);
//    objectOwners.remove(owner);
//
//    if (!force && objectOwners.size() > 0) return false;
//
//    pairedInstances.remove(object);
//    objectOwners.remove(object);
//    return true;
//  }

  //return getPairedPairedInstance(instance) != null;

  //return pairedInstances.get(instance);


  public native Object getObject(String instanceId);
  //return pairedInstances.inverse.get(pairedInstance);
}
