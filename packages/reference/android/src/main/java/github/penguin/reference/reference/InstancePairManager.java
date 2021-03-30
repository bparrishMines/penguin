package github.penguin.reference.reference;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public class InstancePairManager {
//  private final BiMap<Object, PairedInstance> pairedInstances = new BiMap<>();
//  private final Map<Object, Set<Object>> owners = new HashMap<>();

  static {
    System.loadLibrary("native_add");
  }

  public native boolean addPair(Object instance, String instanceId, boolean owner);
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

  public native boolean isPaired(Object instance);
    //return getPairedPairedInstance(instance) != null;


  public native String getInstanceId(Object instance);
    //return pairedInstances.get(instance);


  public native Object getObject(String instanceId);
    //return pairedInstances.inverse.get(pairedInstance);
}
