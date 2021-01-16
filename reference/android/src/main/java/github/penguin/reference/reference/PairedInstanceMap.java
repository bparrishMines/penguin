package github.penguin.reference.reference;

public class PairedInstanceMap {
  private final BiMap<Object, PairedInstance> pairedInstances = new BiMap<>();

  void add(Object instance, PairedInstance pairedInstance) {
    pairedInstances.put(instance, pairedInstance);
  }

  PairedInstance removePairWithObject(Object object) {
    return pairedInstances.remove(object);
  }

  Object removePairWithPairedInstance(PairedInstance pairedInstance) {
    return pairedInstances.inverse.remove(pairedInstance);
  }

  PairedInstance getPairedPairedInstance(Object instance) {
    return pairedInstances.get(instance);
  }

  Object getPairedObject(PairedInstance pairedInstance) {
    return pairedInstances.inverse.get(pairedInstance);
  }
}
