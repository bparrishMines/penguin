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
        final LocalReference localReference = manager.getPairedLocalReference(remoteReference);
        if (localReference != null) return localReference;
      }
    }

    return null;
  }

  @SuppressWarnings({"unchecked", "ConstantConditions"})
  @Override
  Object replaceRemoteReferences(Object argument) throws Exception {
    if (!(argument instanceof RemoteReference) && !(argument instanceof UnpairedReference)) {
      return super.replaceRemoteReferences(argument);
    }

    final boolean argumentIsRemoteReference = argument instanceof RemoteReference;
    if (argumentIsRemoteReference && getPairedLocalReference((RemoteReference) argument) != null) {
      return getPairedLocalReference((RemoteReference) argument);
    } else if (argumentIsRemoteReference && getPairedLocalReference((RemoteReference) argument) == null) {
      return localRefFromRemoteRef((RemoteReference) argument);
    }

    final UnpairedReference unpairedReference = (UnpairedReference) argument;
    final PoolableReferencePairManager manager =
        poolId.equals(unpairedReference.managerPoolId)
            ? this
            : managerFromPoolId(unpairedReference.managerPoolId);
    return manager.getLocalHandler()
        .create(
            manager,
            manager.classIds.get(((UnpairedReference) argument).classId),
            (List<Object>) replaceRemoteReferences(((UnpairedReference) argument).creationArguments));
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

    if (getPairedRemoteReference(localReference) != null) {
      return manager.getPairedRemoteReference(localReference);
    }

    return new UnpairedReference(
        manager.classIds.inverse().get(((LocalReference) argument).getReferenceClass()),
        (List<Object>)
            manager.replaceLocalReferences(manager.getRemoteHandler().getCreationArguments(localReference)), manager.poolId);
  }
}
