import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:quiver/collection.dart';
import 'package:uuid/uuid.dart';

import 'reference.dart';

/// Handles communication with [RemoteReference]s for a [ReferencePairManager].
///
/// This class communicates with other [ReferencePairManager]s to create,
/// dispose, or execute methods on [RemoteReference]s.
mixin RemoteReferenceCommunicationHandler {
  /// Retrieves arguments to instantiate an object that is created with [createRemoteReference].
  List<Object> creationArgumentsFor(LocalReference localReference);

  /// Instantiate and store an object on a different thread/process.
  ///
  /// The remote instantiated object will be represented as [remoteReference].
  ///
  /// The LOCAL [ReferencePairManager] stores the paired [LocalReference] and
  /// [remoteReference] and facilitates communication between the instances they
  /// represent.
  ///
  /// The REMOTE [ReferencePairManager] will represent [localReference] as a
  /// [RemoteReference], instantiate a new [LocalReference], and also store them
  /// as a pair.
  ///
  /// This method should make the instantiated remote object accessible until
  /// [disposeRemoteReference] is called with [remoteReference].
  Future<void> createRemoteReference(
    RemoteReference remoteReference,
    int typeId,
    List<Object> arguments,
  );

  /// Execute a method on the object instance that [remoteReference] represents.
  ///
  /// For any [RemoteReference], this method should only be called after
  /// [createRemoteReference] and should never be called after
  /// [disposeRemoteReference].
  Future<Object> executeRemoteMethod(
    RemoteReference remoteReference,
    String methodName,
    List<Object> arguments,
  );

  /// Dispose [remoteReference] on a remote thread/process.
  ///
  /// This method should also stop the local and remote [ReferencePairManager]
  /// from maintaining the connection between its paired [LocalReference] and
  /// should allow for either object instance to connect to new references.
  Future<void> disposeRemoteReference(RemoteReference remoteReference);
}

/// Handles communication with [LocalReference]s for a [ReferencePairManager].
///
/// This class handles communication from other [ReferencePairManager]s to
/// create, dispose, or execute methods for a [LocalReference].
mixin LocalReferenceCommunicationHandler {
  /// Instantiates and stores an object on the same thread/process.
  ///
  /// This will be called when a message to instantiate and store an object on
  /// the same thread/process is received.
  ///
  /// The remote instantiated object will be represented as [remoteReference].
  ///
  /// The LOCAL [ReferencePairManager] stores the returned [LocalReference] and
  /// and a generated [RemoteReference] as a pair and will facilitate
  /// communication between their object instances they represent.
  ///
  /// The REMOTE [ReferencePairManager] will represent the returned value as a
  /// [RemoteReference] and represent the generated [RemoteReference] as a
  /// [LocalReference]. It will also store both references as a pair.
  LocalReference createLocalReference(
    ReferencePairManager referencePairManager,
    Type referenceType,
    List<Object> arguments,
  );

  /// Execute a method to be executed on the object instance represented by [localReference].
  ///
  /// For any [LocalReference] this method should only be called after
  /// [createLocalReference] and should never be called after
  /// [disposeLocalReference].
  Object executeLocalMethod(
    ReferencePairManager referencePairManager,
    LocalReference localReference,
    String methodName,
    List<Object> arguments,
  );

  /// Dispose [localReference] and the value it represents.
  ///
  /// This also stops the [ReferencePairManager] from maintaining the connection
  /// with its paired [RemoteReference] and will allow for either value to be
  /// attached to new references.
  void disposeLocalReference(
    ReferencePairManager referencePairManager,
    LocalReference localReference,
  ) {}
}

/// Manages communication between [LocalReference]s and [RemoteReference]s.
///
/// This class works by facilitating communication between a [LocalReference]
/// and a [RemoteReference] pair. When a [LocalReference] is added to a
/// [ReferencePairManager] on the same thread/process, it is expected that an
/// equivalent object is created and added to a [ReferencePairManager] on a
/// different thread/process.
///
/// For example, assume that there is a [ReferencePairManager] in a process
/// running Dart code and a [ReferencePairManager] in a process running Java
/// code. Next, an object of a Dart class named `Apple` is instantiated and is
/// added to the Dart [ReferencePairManager], then
///
/// 1. The Dart [ReferencePairManager] will send a message to the Java
/// [ReferencePairManager] to instantiate a Java object of a class named
/// `Apple`.
///
/// 2. The Dart `Apple` would then be stored as a [LocalReference] and paired
/// with a [RemoteReference] that represents the `Apple` instantiated in Java.
///
/// 3. The [ReferencePairManager]s would then handle sending and receiving
/// methods to be executed between the Dart `Apple` and the Java `Apple` until
/// the objects are disposed and removed.
///
/// 4. Disposing of the Dart `Apple` would lead to a message sent to the remote
/// [ReferencePairManager] to dispose the Java `Apple`.
abstract class ReferencePairManager {
  ReferencePairManager(List<Type> supportedTypes)
      : assert(supportedTypes != null),
        supportedTypes = List<Type>.unmodifiable(supportedTypes),
        _typeIds = BiMap()..addAll(supportedTypes.toList().asMap());

  static final Uuid _uuid = Uuid();

  bool _isInitialized = false;
  final _referencePairs = BiMap<LocalReference, RemoteReference>();
  final BiMap<int, Type> _typeIds;

  final List<Type> supportedTypes;

  /// Handles communication with [RemoteReference]s.
  RemoteReferenceCommunicationHandler get remoteHandler;

  /// Handles communication with [LocalReference]s.
  LocalReferenceCommunicationHandler get localHandler;

  /// Finish setup to start facilitating communication between [LocalReference]s and [RemoteReference].
  @mustCallSuper
  void initialize() => _isInitialized = true;

  /// Retrieve the [RemoteReference] paired with [localReference].
  ///
  /// Returns null if this [localReference] is not paired.
  RemoteReference remoteReferenceFor(LocalReference localReference) {
    _assertIsInitialized();
    return _referencePairs[localReference];
  }

  /// Retrieve the [LocalReference] paired with [remoteReference].
  ///
  /// Returns null if this [remoteReference] is not paired.
  LocalReference localReferenceFor(RemoteReference remoteReference) {
    _assertIsInitialized();
    return _referencePairs.inverse[remoteReference];
  }

  /// Call when a [ReferencePairManager] on a different thread/process wants to create a [RemoteReference].
  ///
  /// This will instantiate a [LocalReference] and add it and [remoteReference]
  /// as a pair.
  ///
  /// All [RemoteReference]s and [UnpairedRemoteReference]s in `arguments` will
  /// be replaced by a [LocalReference].
  ///
  /// Also, all [List]s will also be converted into `List<Object>` and all
  /// [Map]s will be converted into `Map<Object, Object>`.
  LocalReference createLocalReferenceFor(
    RemoteReference remoteReference,
    int typeId, [
    List<Object> arguments,
  ]) {
    _assertIsInitialized();
    final LocalReference localReference = localHandler.createLocalReference(
      this,
      _typeIds[typeId],
      _replaceRemoteReferences(arguments ?? <Object>[]),
    );
    _referencePairs[localReference] = remoteReference;
    return localReference;
  }

  /// Call when a remote [ReferencePairManager] wants to dispose their [RemoteReference].
  ///
  /// This will remove [remoteReference] and its paired [LocalReference] from
  /// this [ReferencePairManager].
  void disposeLocalReferenceFor(RemoteReference remoteReference) {
    _assertIsInitialized();

    final LocalReference localReference = localReferenceFor(remoteReference);
    if (localReference == null) return;

    _referencePairs.remove(localReference);
    localHandler.disposeLocalReference(this, localReference);
  }

  // TODO(bparrishMines): Don't change state if failure to create
  /// Creates and maintains access of an equivalent object to [localReference] on a remote thread/process.
  ///
  /// This will also store [localReference] and a [RemoteReference] as a pair.
  FutureOr<RemoteReference> createRemoteReferenceFor(
    LocalReference localReference, [
    Type referenceType,
  ]) {
    _assertIsInitialized();
    if (remoteReferenceFor(localReference) != null) return null;

    final RemoteReference remoteReference = RemoteReference(_uuid.v4());
    _referencePairs[localReference] = remoteReference;

    final Completer<RemoteReference> completer = Completer<RemoteReference>();

    remoteHandler
        .createRemoteReference(
          remoteReference,
          referenceType ?? _typeIds.inverse[localReference.referenceType],
          _replaceLocalReferences(
            remoteHandler.creationArgumentsFor(localReference),
          ),
        )
        .then((_) => completer.complete(remoteReference));

    return completer.future;
  }

  /// Call when it is no longer needed to access the [RemoteReference] paired with [localReference].
  FutureOr<void> disposeRemoteReferenceFor(LocalReference localReference) {
    _assertIsInitialized();

    final RemoteReference remoteReference = remoteReferenceFor(localReference);
    if (remoteReference == null) return null;

    _referencePairs.remove(localReference);
    return remoteHandler.disposeRemoteReference(remoteReference);
  }

  // TODO(bparrishMines): This should be able to use UnpairedRemoteReference for the RemoteReference
  /// Execute a method on the [RemoteReference] paired to [localReference].
  ///
  /// The [LocalReference]s in `arguments` will be replaced by a
  /// [RemoteReference] or a [UnpairedRemoteReference].
  ///
  /// All [List]s will also be converted into `List<Object>` and all [Map]s
  /// will be converted into `Map<Object, Object>`.
  Future<Object> executeRemoteMethodFor(
    LocalReference localReference,
    String methodName, [
    List<Object> arguments,
  ]) {
    _assertIsInitialized();
    assert(remoteReferenceFor(localReference) != null);
    final Completer<Object> resultCompleter = Completer<Object>();
    remoteHandler
        .executeRemoteMethod(
          remoteReferenceFor(localReference),
          methodName,
          _replaceLocalReferences(arguments) ?? <Object>[],
        )
        .then(
          (Object value) =>
              resultCompleter.complete(_replaceRemoteReferences(value)),
        );
    return resultCompleter.future;
  }

  /// Execute a method on the [LocalReference] paired to [remoteReference].
  ///
  /// All [RemoteReference]s and [UnpairedRemoteReference]s in `arguments` will
  /// be replaced by a [LocalReference].
  ///
  /// Also, all [List]s will also be converted into `List<Object>` and all
  /// [Map]s will be converted into `Map<Object, Object>`.
  Object executeLocalMethodFor(
    RemoteReference remoteReference,
    String methodName, [
    List<Object> arguments,
  ]) {
    _assertIsInitialized();
    assert(localReferenceFor(remoteReference) != null);

    final LocalReference localReference = localReferenceFor(remoteReference);
    final Object result = localHandler.executeLocalMethod(
      this,
      localReference,
      methodName,
      _replaceRemoteReferences(arguments) ?? <Object>[],
    );
    return _replaceLocalReferences(result);
  }

  void _assertIsInitialized() {
    assert(_isInitialized, 'Initialize has not been called.');
  }

  Object _replaceRemoteReferences(Object argument) {
    if (argument is RemoteReference) {
      return localReferenceFor(argument);
    } else if (argument is UnpairedRemoteReference) {
      return localHandler.createLocalReference(
        this,
        _typeIds[argument.typeId],
        argument.creationArguments.map(_replaceRemoteReferences).toList(),
      );
    } else if (argument is List) {
      return argument.map(_replaceRemoteReferences).toList();
    } else if (argument is Map) {
      return Map<Object, Object>.fromIterables(
        argument.keys.map<Object>(_replaceRemoteReferences),
        argument.values.map<Object>(_replaceRemoteReferences),
      );
    }

    return argument;
  }

  Object _replaceLocalReferences(Object argument) {
    if (argument is LocalReference && remoteReferenceFor(argument) != null) {
      return remoteReferenceFor(argument);
    } else if (argument is LocalReference &&
        remoteReferenceFor(argument) == null) {
      return UnpairedRemoteReference(
        _typeIds.inverse[argument.referenceType],
        remoteHandler
            .creationArgumentsFor(argument)
            .map(_replaceLocalReferences)
            .toList(),
      );
    } else if (argument is List) {
      return argument.map(_replaceLocalReferences).toList();
    } else if (argument is Map) {
      return Map<Object, Object>.fromIterables(
        argument.keys.map<Object>(_replaceLocalReferences),
        argument.values.map<Object>(_replaceLocalReferences),
      );
    }

    return argument;
  }
}

abstract class PoolableReferencePairManager extends ReferencePairManager {
  PoolableReferencePairManager(List<Type> supportedTypes, this.poolId)
      : assert(poolId != null),
        super(supportedTypes);

  final String poolId;

  Set<ReferencePairManagerPool> _pools = <ReferencePairManagerPool>{};

  PoolableReferencePairManager _managerFromType(Type type) {
    for (ReferencePairManagerPool pool in _pools) {
      final PoolableReferencePairManager manager = pool._typesToManagers[type];
      if (manager != null) return manager;
    }

    return null;
  }

  PoolableReferencePairManager _managerFromPoolId(String poolId) {
    for (ReferencePairManagerPool pool in _pools) {
      final PoolableReferencePairManager manager = pool._managers[poolId];
      if (manager != null) return manager;
    }

    return null;
  }

  LocalReference _localRefFromRemoteRef(RemoteReference remoteReference) {
    for (ReferencePairManagerPool pool in _pools) {
      for (ReferencePairManager manager in pool._managers.values) {
        final LocalReference localReference =
            manager.localReferenceFor(remoteReference);
        if (localReference != null) return localReference;
      }
    }

    return null;
  }

  @override
  Object _replaceRemoteReferences(Object argument) {
    if (argument is! RemoteReference && argument is! UnpairedRemoteReference) {
      return super._replaceRemoteReferences(argument);
    }

    if (argument is RemoteReference && localReferenceFor(argument) != null) {
      return localReferenceFor(argument);
    } else if (argument is RemoteReference &&
        localReferenceFor(argument) == null) {
      return _localRefFromRemoteRef(argument);
    }

    final UnpairedRemoteReference unpairedRemoteReference = argument;
    final PoolableReferencePairManager manager =
        poolId == unpairedRemoteReference.managerPoolId
            ? this
            : _managerFromPoolId(unpairedRemoteReference.managerPoolId);

    return manager.localHandler.createLocalReference(
      manager,
      manager._typeIds[unpairedRemoteReference.typeId],
      unpairedRemoteReference.creationArguments
          .map(_replaceRemoteReferences)
          .toList(),
    );
  }

  @override
  Object _replaceLocalReferences(Object argument) {
    if (argument is! LocalReference) {
      return super._replaceLocalReferences(argument);
    }

    final LocalReference localReference = argument;

    final bool isCorrectManager =
        _typeIds.inverse[localReference.referenceType] != null;
    final PoolableReferencePairManager manager = isCorrectManager
        ? this
        : _managerFromType(localReference.referenceType);

    if (remoteReferenceFor(localReference) != null) {
      return manager.remoteReferenceFor(localReference);
    }

    return UnpairedRemoteReference(
      manager._typeIds.inverse[localReference.referenceType],
      manager.remoteHandler
          .creationArgumentsFor(localReference)
          .map(_replaceLocalReferences)
          .toList(),
      manager.poolId,
    );
  }
}

class ReferencePairManagerPool {
  static final ReferencePairManagerPool globalInstance =
      ReferencePairManagerPool();

  final Map<String, PoolableReferencePairManager> _managers =
      <String, PoolableReferencePairManager>{};
  final Map<Type, PoolableReferencePairManager> _typesToManagers =
      <Type, PoolableReferencePairManager>{};

  bool add(PoolableReferencePairManager manager) {
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
