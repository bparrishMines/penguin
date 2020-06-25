import 'reference.dart';
import 'reference_converter.dart';
import 'reference_pair_manager.dart';

class PoolableReferenceConverter extends StandardReferenceConverter {
  PoolableReferencePairManager _managerFromType(
    Set<ReferencePairManagerPool> pools,
    Type type,
  ) {
    for (ReferencePairManagerPool pool in pools) {
      final PoolableReferencePairManager manager = pool._typesToManagers[type];
      if (manager != null) return manager;
    }

    return null;
  }

  PoolableReferencePairManager _managerFromPoolId(
    Set<ReferencePairManagerPool> pools,
    String poolId,
  ) {
    for (ReferencePairManagerPool pool in pools) {
      final PoolableReferencePairManager manager = pool._managers[poolId];
      if (manager != null) return manager;
    }

    return null;
  }

  LocalReference _localRefFromRemoteRef(
    Set<ReferencePairManagerPool> pools,
    RemoteReference remoteReference,
  ) {
    for (ReferencePairManagerPool pool in pools) {
      for (ReferencePairManager manager in pool._managers.values) {
        final LocalReference localReference =
            manager.getPairedLocalReference(remoteReference);
        if (localReference != null) return localReference;
      }
    }

    return null;
  }

  @override
  Object convertForRemoteManager(
    ReferencePairManager manager,
    Object object,
  ) {
    if (object is! LocalReference) {
      return super.convertForRemoteManager(manager, object);
    }

    final LocalReference localReference = object;

    final bool isCorrectManager =
        manager.getTypeId(localReference.referenceType) != null;
    final PoolableReferencePairManager correctManager = isCorrectManager
        ? manager
        : _managerFromType((manager as PoolableReferencePairManager)._pools,
            localReference.referenceType);

    if (correctManager.getPairedRemoteReference(localReference) != null) {
      return correctManager.getPairedRemoteReference(localReference);
    }

    return UnpairedReference(
      correctManager.getTypeId(localReference.referenceType),
      correctManager.remoteHandler
          .getCreationArguments(localReference)
          .map((_) => convertForRemoteManager(manager, _))
          .toList(),
      correctManager.poolId,
    );
  }

  @override
  Object convertForLocalManager(
    ReferencePairManager manager,
    Object object,
  ) {
    if (object is! RemoteReference && object is! UnpairedReference) {
      return super.convertForLocalManager(manager, object);
    }

    if (object is RemoteReference &&
        manager.getPairedLocalReference(object) != null) {
      return manager.getPairedLocalReference(object);
    } else if (object is RemoteReference &&
        manager.getPairedLocalReference(object) == null) {
      return _localRefFromRemoteRef(
          (manager as PoolableReferencePairManager)._pools, object);
    }

    final UnpairedReference unpairedRemoteReference = object;
    final PoolableReferencePairManager correctManager =
        (manager as PoolableReferencePairManager).poolId ==
                unpairedRemoteReference.managerPoolId
            ? manager
            : _managerFromPoolId(
                (manager as PoolableReferencePairManager)._pools,
                unpairedRemoteReference.managerPoolId);

    return correctManager.localHandler.create(
      correctManager,
      correctManager.getReferenceType(unpairedRemoteReference.typeId),
      unpairedRemoteReference.creationArguments
          .map((_) => convertForLocalManager(manager, _))
          .toList(),
    );
  }
}

abstract class PoolableReferencePairManager extends ReferencePairManager {
  PoolableReferencePairManager(List<Type> supportedTypes, this.poolId)
      : assert(poolId != null),
        super(supportedTypes);

  final String poolId;

  Set<ReferencePairManagerPool> _pools = <ReferencePairManagerPool>{};

  @override
  PoolableReferenceConverter get converter => PoolableReferenceConverter();
}

class ReferencePairManagerPool {
  static final ReferencePairManagerPool globalInstance =
      ReferencePairManagerPool();

  final Map<String, PoolableReferencePairManager> _managers =
      <String, PoolableReferencePairManager>{};
  final Map<Type, PoolableReferencePairManager> _typesToManagers =
      <Type, PoolableReferencePairManager>{};

  bool add(PoolableReferencePairManager manager) {
    if (_managers.containsValue(manager)) return true;
    if (_managers.containsKey(manager.poolId)) return false;

    if (manager.supportedTypes
        .any((Type type) => _typesToManagers[type] != null)) {
      return false;
    }

    for (Type type in manager.supportedTypes) _typesToManagers[type] = manager;
    manager._pools.add(this);
    _managers[manager.poolId] = manager;

    return true;
  }

  void remove(PoolableReferencePairManager manager) {
    if (_managers[manager.poolId] == null) return;

    for (Type type in manager.supportedTypes) _typesToManagers.remove(type);
    _managers.remove(manager.poolId);
    manager._pools.remove(this);
  }
}
