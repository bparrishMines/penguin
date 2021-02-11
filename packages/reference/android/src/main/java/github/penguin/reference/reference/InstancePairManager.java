package github.penguin.reference.reference;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public class InstancePairManager {
  private final BiMap<Object, PairedInstance> pairedInstances = new BiMap<>();
  private final Map<Object, Set<Object>> owners = new HashMap<>();

  boolean addPair(Object object, PairedInstance pairedInstance, Object owner) {
    final boolean wasPaired = isPaired(object);

    if (!wasPaired) {
      if (pairedInstances.containsValue(pairedInstance)) throw new IllegalStateException();
      pairedInstances.put(object, pairedInstance);
      owners.put(object, new HashSet<>());
    }

    owners.get(object).add(owner);
    return !wasPaired;
  }

  boolean removePairWithObject(Object object, Object owner, boolean force) {
    if (!isPaired(object)) return false;

    final Set<Object> objectOwners = owners.get(object);
    objectOwners.remove(owner);

    if (!force && objectOwners.size() > 0) return false;

    pairedInstances.remove(object);
    objectOwners.remove(object);
    return true;
  }

  boolean isPaired(Object instance) {
    return getPairedPairedInstance(instance) != null;
  }

  PairedInstance getPairedPairedInstance(Object instance) {
    return pairedInstances.get(instance);
  }

  Object getPairedObject(PairedInstance pairedInstance) {
    return pairedInstances.inverse.get(pairedInstance);
  }
}