import 'reference.dart';
import 'reference_converter.dart';
import 'reference_pair_manager.dart';

/// The [ReferenceConverter] for [PoolableReferencePairManager]s.
///
/// This converter searches through each [PoolableReferencePairManagerPool] that
/// a [PoolableReferencePairManager] is attached to to convert arguments.
///
/// This extends the use cases of [StandardReferenceConverter].
class PoolableReferenceConverter extends StandardReferenceConverter {
  static PoolableReferencePairManager _managerFromType(
    Set<ReferencePairManagerPool> pools,
    Type type,
  ) {
    for (ReferencePairManagerPool pool in pools) {
      final PoolableReferencePairManager manager = pool._typesToManagers[type];
      if (manager != null) return manager;
    }

    return null;
  }

  static PoolableReferencePairManager _managerFromPoolId(
    Set<ReferencePairManagerPool> pools,
    String poolId,
  ) {
    for (ReferencePairManagerPool pool in pools) {
      final PoolableReferencePairManager manager = pool._managers[poolId];
      if (manager != null) return manager;
    }

    return null;
  }

  static LocalReference _localRefFromRemoteRef(
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

/// A [ReferencePairManager] that can access the [LocalReferenceCommunicationHandler]s and [RemoteReferenceCommunicationHandler] of other [ReferencePairManager]s.
///
/// Add this to a [ReferencePairManagerPool] and it will be able to handle
/// the [ReferencePairManager.supportedTypes] of other the other
/// [ReferencePairManagers] within the pool.
abstract class PoolableReferencePairManager extends ReferencePairManager {
  PoolableReferencePairManager(List<Type> supportedTypes, this.poolId)
      : assert(poolId != null),
        super(supportedTypes);

  /// Unique identifier used to identify this manager in a [ReferencePairManagerPool].
  final String poolId;

  Set<ReferencePairManagerPool> _pools = <ReferencePairManagerPool>{};

  @override
  PoolableReferenceConverter get converter => PoolableReferenceConverter();
}

/// Pools [PoolableReferencePairManager]s to allow cross support of [ReferencePairManager.supportedTypes].
///
/// Typically a [ReferencePairManager] can only support types added to its
/// [ReferencePairManager.supportedTypes]. But by creating a shared pool, they
/// can support [Type]s from other [ReferencePairManager]s.
class ReferencePairManagerPool {
  /// A global [ReferencePairManagerPool] that provides a easily accessible pool.
  static final ReferencePairManagerPool globalInstance =
      ReferencePairManagerPool();

  final Map<String, PoolableReferencePairManager> _managers =
      <String, PoolableReferencePairManager>{};
  final Map<Type, PoolableReferencePairManager> _typesToManagers =
      <Type, PoolableReferencePairManager>{};

  /// Add a manager to this pool.
  ///
  /// Successfully adding a manager requires:
  ///   1. Having a unique [PoolableReferencePairManager.poolId].
  ///   2. Having an empty interception of [ReferencePairManager.supportedTypes]
  ///      of all other managers within this pool.
  ///
  /// If both conditions are met, the manager is added and `true` is returned.
  /// Otherwise `false` is returned.
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

  /// Removes a manager from this pool.
  void remove(PoolableReferencePairManager manager) {
    if (_managers[manager.poolId] == null) return;

    for (Type type in manager.supportedTypes) _typesToManagers.remove(type);
    _managers.remove(manager.poolId);
    manager._pools.remove(this);
  }
}