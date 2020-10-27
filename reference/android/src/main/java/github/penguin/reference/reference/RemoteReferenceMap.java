package github.penguin.reference.reference;

public class RemoteReferenceMap {
  private final BiMap<Object, RemoteReference> remoteReferences = new BiMap<>();

  void add(Object instance, RemoteReference remoteReference) {
    remoteReferences.put(instance, remoteReference);
  }

  RemoteReference removePairWithObject(Object object) {
    return remoteReferences.remove(object);
  }

  Object removePairWithRemoteReference(RemoteReference remoteReference) {
    return remoteReferences.inverse.remove(remoteReference);
  }

  RemoteReference getPairedRemoteReference(Object instance) {
    return remoteReferences.get(instance);
  }

  Object getPairedObject(RemoteReference remoteReference) {
    return remoteReferences.inverse.get(remoteReference);
  }
}
