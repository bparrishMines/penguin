import 'package:flutter/widgets.dart';
import 'package:quiver/collection.dart';

import '../reference.dart';
import 'reference_counter.dart';

/// Handles communication with [RemoteReference]s for a [ReferenceManager].
mixin RemoteReferenceCommunicationHandler {
  /// Sends a message to instantiate and store an object on a remote thread/process.
  ///
  /// The remote instantiated object will be represented as [remoteReference].
  ///
  /// The local [ReferenceManager] stores the [LocalReference] and
  /// [RemoteReference] as a pair and will facilitate communication between
  /// their instances they represent.
  ///
  /// The remote [ReferenceManager] will represent [localReference] as a
  /// [RemoteReference] and it will instantiate a new [LocalReference].
  ///
  /// This method should instantiate a remote object and keep the object
  /// accessible until [disposeRemoteReference] with the same [reference] is
  /// called.
  RemoteReference createRemoteReference(LocalReference localReference);

  /// Sends a message to execute a method on the value that [reference] represents.
  ///
  /// This method should only be called after [createRemoteReference] and should
  /// never be called after [disposeRemoteReference].
  Future<dynamic> sendMethodToExecute(
    RemoteReference reference,
    String methodName,
    List<dynamic> arguments,
  );

  /// Sends a message to dispose [reference] on a remote thread/process.
  ///
  /// This also stops the [ReferenceManager] from maintaining the connection
  /// between its [LocalReference] and will allow for either reference to
  /// connect to new [Reference]s.
  void disposeRemoteReference(RemoteReference reference);
}

/// Handles communication with [LocalReference]s for a [ReferenceManager].
mixin LocalReferenceCommunicationHandler {
  /// Receive a message to instantiate and store an object on the local thread/process.
  ///
  /// The remote instantiated object will be represented as [remoteReference].
  ///
  /// The local [ReferenceManager] stores the [LocalReference] and
  /// [RemoteReference] as a pair and will facilitate communication between
  /// their instances they represent.
  ///
  /// The remote [ReferenceManager] will represent [localReference] as a
  /// [RemoteReference] and it will instantiate a [LocalReference].
  ///
  /// This method should instantiate a remote object and keep the object
  /// accessible until [disposeLocalReference] with the same [reference] is
  /// called.
  ///
  /// This method should instantiate an object and keep the object in memory
  /// until [disposeLocalReference] is called with the same [reference].
  LocalReference createLocalReference(
    RemoteReference remoteReference,
    dynamic arguments,
  );

  /// Receives a method call to be executed on the value represented by [reference].
  ///
  /// This method should only be called after [createLocalReference] and should
  /// never be called after [disposeLocalReference].
  Future<dynamic> receiveMethodToExecute(
    LocalReference localReference,
    String methodName,
    List<dynamic> arguments,
  );

  /// Receive a message to dispose [reference] and the value it represents.
  ///
  /// This also stops the [ReferenceManager] from maintaining the connection
  /// between its [RemoteReference] and will allow for either value to be
  /// attached to new [Reference]s.
  void disposeLocalReference(LocalReference reference) {}
}

/// Manages connections between [LocalReference]s and [RemoteReference]s.
///
/// This class works by facilitating communication between a [LocalReference]
/// and a [RemoteReference]. When an object is added to a local
/// [ReferenceManager], it is expected that an equivalent object is created and
/// added to a remote [ReferenceManager].
///
/// For example, let's assume that we have a Dart [ReferenceManager] and a Java
/// [ReferenceManager]. If one instantiates an object named `Apple` in Dart and
/// adds it to the Dart [ReferenceManager]:
///
/// 1. the Dart [ReferenceManager] will send a message to the Java
/// [ReferenceManager] to instantiate a Java object named `Apple`.
///
/// 2. The Dart `Apple` would then be stored in a map as a [LocalReference] with
/// a [RemoteReference] that represents the `Apple` instantiated in Java.
///
/// 3. The [ReferenceManager] would then handle sending and receiving methods to
/// be executed between the Dart `Apple` and the Java `Apple` until the objects
/// are disposed and removed.
///
/// 4. Disposing of the Dart `Apple` would lead to a message sent to the remote
/// [ReferenceManager] to dispose of the Java `Apple`.
abstract class ReferencePairManager {
  final _localRefToRemoteRefMap = BiMap<LocalReference, RemoteReference>();
  final _localRefToRefCounterMap =
      <LocalReference, ReferencePairOwnerCounter>{};

  final List<LocalReference> _autoReleasePool = <LocalReference>[];

  /// Handles communication with [RemoteReference]s.
  RemoteReferenceCommunicationHandler get remoteHandler;

  /// Handles communication with [LocalReference]s.
  LocalReferenceCommunicationHandler get localHandler;

  /// Finish setup to facilitate communication between [Reference]s.
  void initialize();

  void receivedCreateReferencePairMessage(
    RemoteReference remoteReference,
    dynamic arguments,
  ) {
    final LocalReference localReference = localHandler.createLocalReference(
      remoteReference,
      arguments,
    );
    _localRefToRemoteRefMap[localReference] = remoteReference;
  }

  void receivedDisposeReferencePairMessage(RemoteReference remoteReference) {
    localHandler.disposeLocalReference(_localReferenceFor(remoteReference));
    _remove(remoteReference);
  }

  void incrementReferencePairOwnerCount(LocalReference localReference) {
    if (_remoteReferenceFor(localReference) == null) {
      _addCounterFor(localReference);
    }

    _localRefToRefCounterMap[localReference].increment(localReference);
  }

  Future<dynamic> sendMethodToExecute(
    LocalReference localReference,
    String methodName,
    List<dynamic> arguments,
  ) {
    return remoteHandler.sendMethodToExecute(
      _remoteReferenceFor(localReference),
      methodName,
      arguments.map<dynamic>((dynamic argument) {
        if (argument is LocalReference &&
            _remoteReferenceFor(localReference) != null) {
          return _remoteReferenceFor(localReference);
        }
        return argument;
      }).toList(),
    );
  }

  Future<dynamic> receiveMethodToExecute(
    RemoteReference remoteReference,
    String methodName,
    List<dynamic> arguments,
  ) {
    return localHandler.receiveMethodToExecute(
      _localReferenceFor(remoteReference),
      methodName,
      arguments.map<dynamic>((dynamic argument) {
        if (argument is RemoteReference) return _localReferenceFor(argument);
        return argument;
      }).toList(),
    );
  }

  void decrementReferencePairOwnerCount(LocalReference localReference) {
    final RemoteReference remoteReference = _remoteReferenceFor(localReference);
    if (remoteReference != null) {
      final ReferencePairOwnerCounter counter =
          _ownerCounterFor(localReference);
      counter.decrement(localReference, remoteReference);
    }
  }

  void addToAutoReleasePool(LocalReference localReference) {
    _autoReleasePool.add(localReference);
    if (_autoReleasePool.length == 1) {
      WidgetsBinding.instance.addPostFrameCallback(_drainAutoreleasePool);
    }
  }

  void _drainAutoreleasePool(Duration duration) {
    for (final LocalReference localReference in _autoReleasePool) {
      decrementReferencePairOwnerCount(localReference);
    }
    _autoReleasePool.clear();
  }

  void _addCounterFor(LocalReference localReference) {
    _localRefToRefCounterMap[localReference] = ReferencePairOwnerCounter(
      OwnerCounterLifecycleListener(
        onCreate: (LocalReference localReference) {
          _localRefToRemoteRefMap[localReference] =
              remoteHandler.createRemoteReference(localReference);
        },
        onDispose: (
          LocalReference localReference,
          RemoteReference remoteReference,
        ) {
          remoteHandler.disposeRemoteReference(remoteReference);
          _remove(remoteReference);
        },
      ),
    );
  }

  void _remove(RemoteReference remoteReference) {
    final LocalReference localReference =
        _localRefToRemoteRefMap.inverse.remove(remoteReference);
    _localRefToRemoteRefMap.remove(localReference);
  }

  RemoteReference _remoteReferenceFor(LocalReference localReference) =>
      _localRefToRemoteRefMap[localReference];

  LocalReference _localReferenceFor(RemoteReference remoteReference) =>
      _localRefToRemoteRefMap.inverse[remoteReference];

  ReferencePairOwnerCounter _ownerCounterFor(dynamic reference) {
    assert(reference is LocalReference || reference is RemoteReference);

    if (reference is LocalReference) {
      return _localRefToRefCounterMap[reference];
    } else if (reference is RemoteReference) {
      return _localRefToRefCounterMap[
          _localRefToRemoteRefMap.inverse[reference]];
    }

    return null;
  }
}
