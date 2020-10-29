package github.penguin.reference.reference;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

public abstract class PoolableReferencePairManager {
//  public final String poolId;
//  Set<ReferencePairManagerPool> pools = new HashSet<>();
//
//  public static class PoolableReferenceConverter
//      extends ReferenceConverter.StandardReferenceConverter {
//    private static PoolableReferencePairManager managerFromClass(
//        Set<ReferencePairManagerPool> pools, Class<? extends LocalReference> clazz) {
//      for (ReferencePairManagerPool pool : pools) {
//        final PoolableReferencePairManager manager = pool.classesToManagers.get(clazz);
//        if (manager != null) return manager;
//      }
//
//      return null;
//    }
//
//    private static PoolableReferencePairManager managerFromPoolId(
//        Set<ReferencePairManagerPool> pools, String poolId) {
//      for (ReferencePairManagerPool pool : pools) {
//        final PoolableReferencePairManager manager = pool.managers.get(poolId);
//        if (manager != null) return manager;
//      }
//
//      return null;
//    }
//
//    private static LocalReference localRefFromRemoteRef(
//        Set<ReferencePairManagerPool> pools, RemoteReference remoteReference) {
//      for (ReferencePairManagerPool pool : pools) {
//        for (ReferencePairManager manager : pool.managers.values()) {
//          final LocalReference localReference = manager.getPairedLocalReference(remoteReference);
//          if (localReference != null) return localReference;
//        }
//      }
//
//      return null;
//    }
//
//    @Override
//    public Object convertForRemoteManager(ReferencePairManager manager, Object object) {
//      if (!(object instanceof LocalReference)) {
//        return super.convertForRemoteManager(manager, object);
//      }
//
//      final LocalReference localReference = (LocalReference) object;
//
//      final boolean isCorrectManager =
//          manager.getClassId(localReference.getReferenceClass()) != null;
//      final PoolableReferencePairManager correctManager =
//          isCorrectManager
//              ? (PoolableReferencePairManager) manager
//              : managerFromClass(
//                  ((PoolableReferencePairManager) manager).pools,
//                  localReference.getReferenceClass());
//
//      if (correctManager.getPairedRemoteReference(localReference) != null) {
//        return correctManager.getPairedRemoteReference(localReference);
//      }
//
//      return new UnpairedReference(
//          correctManager.getClassId(((LocalReference) object).getReferenceClass()),
//          (List<Object>)
//              correctManager
//                  .getConverter()
//                  .convertForRemoteManager(
//                      correctManager,
//                      correctManager.getRemoteHandler().getCreationArguments(localReference)),
//          correctManager.poolId);
//    }
//
//    @Override
//    public Object convertForLocalManager(ReferencePairManager manager, Object object)
//        throws Exception {
//      if (!(object instanceof RemoteReference) && !(object instanceof UnpairedReference)) {
//        return super.convertForLocalManager(manager, object);
//      }
//
//      final boolean argumentIsRemoteReference = object instanceof RemoteReference;
//      if (argumentIsRemoteReference
//          && manager.getPairedLocalReference((RemoteReference) object) != null) {
//        return manager.getPairedLocalReference((RemoteReference) object);
//      } else if (argumentIsRemoteReference
//          && manager.getPairedLocalReference((RemoteReference) object) == null) {
//        return localRefFromRemoteRef(
//            ((PoolableReferencePairManager) manager).pools, (RemoteReference) object);
//      }
//
//      final UnpairedReference unpairedReference = (UnpairedReference) object;
//      final PoolableReferencePairManager correctManager =
//          ((PoolableReferencePairManager) manager).poolId.equals(unpairedReference.managerPoolId)
//              ? (PoolableReferencePairManager) manager
//              : managerFromPoolId(
//                  ((PoolableReferencePairManager) manager).pools, unpairedReference.managerPoolId);
//      return correctManager
//          .getLocalHandler()
//          .create(
//              correctManager,
//              correctManager.getReferenceClass(((UnpairedReference) object).classId),
//              (List<Object>)
//                  convertForLocalManager(
//                      manager, ((UnpairedReference) object).creationArguments));
//    }
//  }
//
//  public PoolableReferencePairManager(
//      List<Class<? extends LocalReference>> supportedClasses, String poolId) {
//    super(supportedClasses);
//    if (poolId == null) throw new AssertionError("`poolId` cannot be null.");
//    this.poolId = poolId;
//  }
//
//  @Override
//  public ReferenceConverter getConverter() {
//    return new PoolableReferenceConverter();
//  }
}
