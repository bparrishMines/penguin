package github.penguin.reference.reference;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

public abstract class PoolableReferencePairManager extends ReferencePairManager {
  public final String poolId;

  Set<ReferencePairManagerPool> pools = new HashSet<>();

  public PoolableReferencePairManager(List<Class<? extends LocalReference>> supportedClasses, String poolId) {
    super(supportedClasses);
    this.poolId = poolId;
  }

  private PoolableReferencePairManager managerFromClass(Class<? extends LocalReference> clazz) {
    for (ReferencePairManagerPool pool : pools) {
      final PoolableReferencePairManager manager = pool.classesToManagers.get(clazz);
      if (manager != null) return manager;
    }

    return null;
  }

  private PoolableReferencePairManager managerFromPoolId(String poolId) {
    for (ReferencePairManagerPool pool : pools) {
      final PoolableReferencePairManager manager = pool.managers.get(poolId);
      if (manager != null) return manager;
    }

    return null;
  }

  private LocalReference localRefFromRemoteRef(RemoteReference remoteReference) {
    for (ReferencePairManagerPool pool : pools) {
      for (ReferencePairManager manager : pool.managers.values()) {
        final LocalReference localReference = manager.localReferenceFor(remoteReference);
        if (localReference != null) return localReference;
      }
    }

    return null;
  }

  @SuppressWarnings({"unchecked", "ConstantConditions"})
  @Override
  Object replaceRemoteReferences(Object argument) throws Exception {
    if (!(argument instanceof RemoteReference) && !(argument instanceof UnpairedRemoteReference)) {
      return super.replaceRemoteReferences(argument);
    }

    final boolean argumentIsRemoteReference = argument instanceof RemoteReference;
    if (argumentIsRemoteReference && localReferenceFor((RemoteReference) argument) != null) {
      return localReferenceFor((RemoteReference) argument);
    } else if (argumentIsRemoteReference && localReferenceFor((RemoteReference) argument) == null) {
      return localRefFromRemoteRef((RemoteReference) argument);
    }

    final UnpairedRemoteReference unpairedRemoteReference = (UnpairedRemoteReference) argument;
    final PoolableReferencePairManager manager =
        poolId.equals(unpairedRemoteReference.managerPoolId)
            ? this
            : managerFromPoolId(unpairedRemoteReference.managerPoolId);
    return manager.getLocalHandler()
        .createLocalReference(
            manager,
            manager.classIds.get(((UnpairedRemoteReference) argument).classId),
            (List<Object>) replaceRemoteReferences(((UnpairedRemoteReference) argument).creationArguments));
  }

  @SuppressWarnings({"ConstantConditions", "unchecked"})
  @Override
  Object replaceLocalReferences(Object argument) {
    if (!(argument instanceof LocalReference)) {
      return super.replaceLocalReferences(argument);
    }

    final LocalReference localReference = (LocalReference) argument;

    final boolean isCorrectManager =
        classIds.inverse().get(localReference.getReferenceClass()) != null;
    final PoolableReferencePairManager manager = isCorrectManager
        ? this
        : managerFromClass(localReference.getReferenceClass());

    if (remoteReferenceFor(localReference) != null) {
      return manager.remoteReferenceFor(localReference);
    }

    return new UnpairedRemoteReference(
        manager.classIds.inverse().get(((LocalReference) argument).getReferenceClass()),
        (List<Object>)
            manager.replaceLocalReferences(manager.getRemoteHandler().creationArgumentsFor(localReference)), manager.poolId);
  }
}
