import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:quiver/collection.dart';
import 'package:uuid/uuid.dart';

import 'reference.dart';
import 'owner_counter.dart';

/// Handles communication with [RemoteReference]s for a [ReferencePairManager].
mixin RemoteReferenceCommunicationHandler {
  /// Instantiate and store an object on a remote thread/process.
  ///
  /// The remote instantiated object will be represented as [remoteReference].
  ///
  /// The LOCAL [ReferencePairManager] stores the [LocalReference] and
  /// [RemoteReference] as a pair and will facilitate communication between
  /// their instances they represent.
  ///
  /// The REMOTE [ReferencePairManager] will represent [localReference] as a
  /// [RemoteReference], instantiate a new [LocalReference], and also store them
  /// as a pair.
  ///
  /// This method should make the instantiated remote object accessible until
  /// [disposeRemoteReference] is called with the the paired [RemoteReference].
  Future<void> createRemoteReference(
    LocalReference localReference,
    RemoteReference remoteReference,
  );

  /// Execute a method on the object instance that [remoteReference] represents.
  ///
  /// This method should only be called after [createRemoteReference] and should
  /// never be called after [disposeRemoteReference].
  Future<dynamic> executeRemoteMethod(
    RemoteReference remoteReference,
    String methodName,
    List<dynamic> arguments,
  );

  /// Dispose [remoteReference] on a remote thread/process.
  ///
  /// This method should also stop the local and remote [ReferencePairManager]
  /// from maintaining the connection between its [LocalReference] and should
  /// allow for either object instance to connect to new references.
  Future<void> disposeRemoteReference(RemoteReference remoteReference);
}

/// Handles communication with [LocalReference]s for a [ReferencePairManager].
mixin LocalReferenceCommunicationHandler {
  /// Instantiates and stores an object on the local thread/process.
  ///
  /// This will be called when a message to instantiate and store an object on
  /// the local thread/process is received.
  ///
  /// The remote instantiated object will be represented as [remoteReference].
  ///
  /// The LOCAL [ReferencePairManager] stores the [LocalReference] and
  /// [remoteReference] as a pair and will facilitate communication between
  /// their object instances they represent.
  ///
  /// The REMOTE [ReferencePairManager] will represent the returned value as a
  /// [RemoteReference] and also store both references as a pair.
  LocalReference createLocalReference(
    RemoteReference remoteReference,
    dynamic arguments,
  );

  /// Execute a method to be executed on the object instance represented by [reference].
  ///
  /// This method should only be called after [createLocalReference] and should
  /// never be called after [disposeLocalReference].
  Future<dynamic> executeLocalMethod(
    LocalReference localReference,
    String methodName,
    List<dynamic> arguments,
  );

  /// Dispose [reference] and the value it represents.
  ///
  /// This also stops the [ReferencePairManager] from maintaining the connection
  /// with its paired [RemoteReference] and will allow for either value to be
  /// attached to new references.
  void disposeLocalReference(LocalReference reference) {}
}

/// Manages connections between [LocalReference]s and [RemoteReference]s.
///
/// This class works by facilitating communication between a [LocalReference]
/// and a [RemoteReference]. When an object is added to a local
/// [ReferencePairManager], it is expected that an equivalent object is created
/// and added to a remote [ReferencePairManager].
///
/// For example, let's assume that we have a Dart [ReferencePairManager] and a
/// Java [ReferencePairManager]. If one instantiates an object named `Apple` in
/// Dart and adds it to the Dart [ReferencePairManager],
///
/// 1. The Dart [ReferencePairManager] will send a message to the Java
/// [ReferencePairManager] to instantiate a Java object named `Apple`.
///
/// 2. The Dart `Apple` would then be stored in a map as a [LocalReference] with
/// a [RemoteReference] that represents the `Apple` instantiated in Java.
///
/// 3. The [ReferencePairManager]s would then handle sending and receiving
/// methods to be executed between the Dart `Apple` and the Java `Apple` until
/// the objects are disposed and removed.
///
/// 4. Disposing of the Dart `Apple` would lead to a message sent to the remote
/// [ReferencePairManager] to dispose of the Java `Apple`.
abstract class ReferencePairManager {
  static final Uuid _uuid = Uuid();

  bool _isInitialized = false;
  final _localRefToRemoteRefMap = BiMap<LocalReference, RemoteReference>();
  final _localRefToRefCounterMap = <LocalReference, OwnerCounter>{};

  final List<LocalReference> _autoReleasePool = <LocalReference>[];

  /// Handles communication with [RemoteReference]s.
  RemoteReferenceCommunicationHandler get remoteHandler;

  /// Handles communication with [LocalReference]s.
  LocalReferenceCommunicationHandler get localHandler;

  /// Finish setup to facilitate communication between [LocalReference]s and [RemoteReference].
  @mustCallSuper
  void initialize() => _isInitialized = true;

  /// Retrieve the [RemoteReference] paired with [localReference].
  RemoteReference remoteReferenceFor(LocalReference localReference) =>
      _localRefToRemoteRefMap[localReference];

  /// Retrieve the [LocalReference] paired with [remoteReference].
  LocalReference localReferenceFor(RemoteReference remoteReference) =>
      _localRefToRemoteRefMap.inverse[remoteReference];

  /// Call when a remote [ReferencePairManager] wants to create a [RemoteReference].
  ///
  /// This will instantiate a [LocalReference] and add it and [remoteReference]
  /// as a pair.
  void createLocalReference(
    RemoteReference remoteReference,
    dynamic arguments,
  ) {
    _assertIsInitialized();
    final LocalReference localReference = localHandler.createLocalReference(
      remoteReference,
      arguments,
    );
    _localRefToRemoteRefMap[localReference] = remoteReference;
  }

  /// Call when a remote [ReferencePairManager] wants to dispose a [RemoteReference].
  ///
  /// This will remove [remoteReference] and its paired [LocalReference] from
  /// this [ReferencePairManager].
  void disposeLocalReference(RemoteReference remoteReference) {
    _assertIsInitialized();
    localHandler.disposeLocalReference(localReferenceFor(remoteReference));
    _remove(remoteReference);
  }

  FutureOr<void> createRemoteReference(
    LocalReference localReference, [
    bool useOwnerCounter = false,
  ]) {
    _assertIsInitialized();
    if (remoteReferenceFor(localReference) != null) return null;

    final RemoteReference remoteReference = RemoteReference(_uuid.v4());
    _localRefToRemoteRefMap[localReference] = remoteReference;

    if (useOwnerCounter) {
      _addCounterFor(localReference, remoteReference);
      return _localRefToRefCounterMap[localReference].increment(localReference);
    }

    return remoteHandler.createRemoteReference(
      localReference,
      remoteReference,
    );
  }

  FutureOr<void> disposeRemoteReference(LocalReference localReference) {
    _assertIsInitialized();

    final RemoteReference remoteReference = remoteReferenceFor(localReference);
    if (remoteReference != null) {
      _remove(remoteReference);
      return remoteHandler.disposeRemoteReference(remoteReference);
    }
  }

  /// Increment the owner count for a reference pair.
  ///
  /// When the owner count increases to 1 a [RemoteReference] is created to be
  /// paired with [localReference].
  ///
  /// See [OwnerCounter].
  void incrementOwnerCount(LocalReference localReference) {
    _assertIsInitialized();
    _localRefToRefCounterMap[localReference]?.increment(localReference);
  }

  /// Execute a method on the [RemoteReference] paired to [localReference].
  Future<dynamic> executeRemoteMethod(
    LocalReference localReference,
    String methodName,
    List<dynamic> arguments,
  ) {
    _assertIsInitialized();
    assert(remoteReferenceFor(localReference) != null);
    return remoteHandler.executeRemoteMethod(
      remoteReferenceFor(localReference),
      methodName,
      arguments.map<dynamic>((dynamic argument) {
        if (argument is LocalReference &&
            remoteReferenceFor(localReference) != null) {
          return remoteReferenceFor(localReference);
        }
        return argument;
      }).toList(),
    );
  }

  /// Execute a method on the [LocalReference] paired to [remoteReference].
  Future<dynamic> executeLocalMethod(
    RemoteReference remoteReference,
    String methodName,
    List<dynamic> arguments,
  ) {
    _assertIsInitialized();
    assert(localReferenceFor(remoteReference) != null);
    return localHandler.executeLocalMethod(
      localReferenceFor(remoteReference),
      methodName,
      arguments.map<dynamic>((dynamic argument) {
        if (argument is RemoteReference) return localReferenceFor(argument);
        return argument;
      }).toList(),
    );
  }

  /// Decrement the owner count for a reference pair.
  ///
  /// When the owner count decreases to 0, [localReference] and its paired
  /// [RemoteReference] are removed from the [ReferencePairManager].
  ///
  /// See [OwnerCounter].
  void decrementOwnerCount(LocalReference localReference) {
    _assertIsInitialized();
    final OwnerCounter counter = _ownerCounterFor(localReference);
    counter?.decrement(remoteReferenceFor(localReference));
  }

  /// Adds a [localReference] to an auto release pool.
  ///
  /// After each frame, [decrementOwnerCount] is called on all [LocalReference]s
  /// in the auto release pool and then the pool is cleared.
  void addToAutoReleasePool(LocalReference localReference) {
    _assertIsInitialized();
    _autoReleasePool.add(localReference);
    if (_autoReleasePool.length == 1) {
      WidgetsBinding.instance.addPostFrameCallback(_drainAutoreleasePool);
    }
  }

  void _drainAutoreleasePool(Duration duration) {
    for (final LocalReference localReference in _autoReleasePool) {
      decrementOwnerCount(localReference);
    }
    _autoReleasePool.clear();
  }

  void _addCounterFor(
    LocalReference localReference,
    RemoteReference remoteReference,
  ) {
    _localRefToRefCounterMap[localReference] = OwnerCounter(
      OwnerCounterLifecycleListener(
        onCreate: (LocalReference localReference) {
          return remoteHandler.createRemoteReference(
            localReference,
            remoteReference,
          );
        },
        onDispose: (RemoteReference remoteReference) {
          _remove(remoteReference);
          return remoteHandler.disposeRemoteReference(remoteReference);
        },
      ),
    );
  }

  void _remove(RemoteReference remoteReference) {
    final LocalReference localReference =
        _localRefToRemoteRefMap.inverse.remove(remoteReference);
    _localRefToRemoteRefMap.remove(localReference);
  }

  OwnerCounter _ownerCounterFor(dynamic reference) {
    assert(reference is LocalReference || reference is RemoteReference);

    if (reference is LocalReference) {
      return _localRefToRefCounterMap[reference];
    } else if (reference is RemoteReference) {
      return _localRefToRefCounterMap[
          _localRefToRemoteRefMap.inverse[reference]];
    }

    return null;
  }

  void _assertIsInitialized() {
    assert(_isInitialized, 'Initialize has not been called.');
  }
}
