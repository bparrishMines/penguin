package github.penguin.reference.reference;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

public abstract class PoolableReferencePairManager extends ReferencePairManager {
  public static class PoolableReferenceConverter extends ReferenceConverter.StandardReferenceConverter {
    final String poolId;
    final Set<ReferencePairManagerPool> pools;

    public PoolableReferenceConverter(String poolId, Set<ReferencePairManagerPool> pools) {
      this.poolId = poolId;
      this.pools = pools;
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

    @Override
    public Object convertAllLocalReferences(ReferencePairManager manager, Object object) {
      if (!(object instanceof LocalReference)) {
        return super.convertAllLocalReferences(manager, object);
      }

      final LocalReference localReference = (LocalReference) object;

      final boolean isCorrectManager = manager.getClassId(localReference.getReferenceClass()) != null;
      final PoolableReferencePairManager correctManager = isCorrectManager
          ? (PoolableReferencePairManager) manager
          : managerFromClass(localReference.getReferenceClass());

      if (manager.getPairedRemoteReference(localReference) != null) {
        return manager.getPairedRemoteReference(localReference);
      }

      return new UnpairedReference(
          correctManager.classIds.inverse().get(((LocalReference) object).getReferenceClass()),
          (List<Object>)
              correctManager.getConverter().convertAllLocalReferences(correctManager, correctManager.getRemoteHandler().getCreationArguments(localReference)), correctManager.poolId);
    }

    @Override
    public Object convertAllRemoteReferences(ReferencePairManager manager, Object object) throws Exception {
      if (!(object instanceof RemoteReference) && !(object instanceof UnpairedReference)) {
        return super.convertAllRemoteReferences(manager, object);
      }

      final boolean argumentIsRemoteReference = object instanceof RemoteReference;
      if (argumentIsRemoteReference && manager.getPairedLocalReference((RemoteReference) object) != null) {
        return manager.getPairedLocalReference((RemoteReference) object);
      } else if (argumentIsRemoteReference && manager.getPairedLocalReference((RemoteReference) object) == null) {
        return localRefFromRemoteRef((RemoteReference) object);
      }

      final UnpairedReference unpairedReference = (UnpairedReference) object;
      final PoolableReferencePairManager correctManager = (PoolableReferencePairManager)
          (poolId.equals(unpairedReference.managerPoolId)
              ? manager
              : managerFromPoolId(unpairedReference.managerPoolId));
      return correctManager.getLocalHandler()
          .create(
              correctManager,
              correctManager.classIds.get(((UnpairedReference) object).classId),
              (List<Object>) convertAllRemoteReferences(manager, ((UnpairedReference) object).creationArguments));
    }
  }

  public final String poolId;

  Set<ReferencePairManagerPool> pools = new HashSet<>();

  public PoolableReferencePairManager(List<Class<? extends LocalReference>> supportedClasses, String poolId) {
    super(supportedClasses);
    if (poolId == null) throw new AssertionError("`poolId` cannot be null.");
    this.poolId = poolId;
  }

  @Override
  public ReferenceConverter getConverter() {
    return new PoolableReferenceConverter(poolId, getPools());
  }

  public Set<ReferencePairManagerPool> getPools() {
    return new HashSet<>(pools);
  }
}
