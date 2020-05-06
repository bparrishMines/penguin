import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:quiver/collection.dart';
import 'package:uuid/uuid.dart';

import 'reference.dart';

/// Handles communication with [RemoteReference]s for a [ReferencePairManager].
mixin RemoteReferenceCommunicationHandler {
  List<dynamic> creationArgumentsFor(LocalReference localReference);

  /// Instantiate and store an object on a remote thread/process.
  ///
  /// The remote instantiated object will be represented as [remoteReference].
  ///
  /// The LOCAL [ReferencePairManager] stores [localReference] and
  /// [remoteReference] as a pair and will facilitate communication between
  /// their instances they represent.
  ///
  /// The REMOTE [ReferencePairManager] will represent [localReference] as a
  /// [RemoteReference], instantiate a new [LocalReference], and also store them
  /// as a pair.
  ///
  /// This method should make the instantiated remote object accessible until
  /// [disposeRemoteReference] is called with [remoteReference].
  Future<void> createRemoteReference(
    RemoteReference remoteReference,
    TypeReference typeReference,
    List<dynamic> arguments,
  );

  /// Execute a method on the object instance that [remoteReference] represents.
  ///
  /// This method should only be called after [createRemoteReferenceFor] and
  /// should never be called after [disposeRemoteReference].
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
  /// The LOCAL [ReferencePairManager] stores the returned [LocalReference] and
  /// [remoteReference] as a pair and will facilitate communication between
  /// their object instances they represent.
  ///
  /// The REMOTE [ReferencePairManager] will represent the returned value as a
  /// [RemoteReference] and [remoteReference] as a [LocalReference]. It will
  /// also store both references as a pair.
  LocalReference createLocalReferenceFor(
    RemoteReference remoteReference,
    TypeReference typeReference,
    List<dynamic> arguments,
  );

  /// Execute a method to be executed on the object instance represented by [localReference].
  ///
  /// This method should only be called after [createLocalReferenceFor] and should
  /// never be called after [disposeLocalReference].
  Future<dynamic> executeLocalMethod(
    LocalReference localReference,
    String methodName,
    List<dynamic> arguments,
  );

  /// Dispose [localReference] and the value it represents.
  ///
  /// This also stops the [ReferencePairManager] from maintaining the connection
  /// with its paired [RemoteReference] and will allow for either value to be
  /// attached to new references.
  void disposeLocalReference(LocalReference localReference) {}
}

/// Manages connections between [LocalReference]s and [RemoteReference]s.
///
/// This class works by facilitating communication between a [LocalReference]
/// and a [RemoteReference] pair. When a [LocalReference] is added to a LOCAL
/// [ReferencePairManager], it is expected that an equivalent object is created
/// and added to a REMOTE [ReferencePairManager].
///
/// For example, assume that there is a Dart [ReferencePairManager] and a
/// Java [ReferencePairManager]. Next, an object of a Dart class named `Apple`
/// is instantiated and is added to the Dart [ReferencePairManager],
///
/// 1. The Dart [ReferencePairManager] will send a message to the Java
/// [ReferencePairManager] to instantiate a Java object of a class named
/// `Apple`.
///
/// 2. The Dart `Apple` would then be stored in a map as a [LocalReference] with
/// a [RemoteReference] that represents the `Apple` instantiated in Java.
///
/// 3. The [ReferencePairManager]s would then handle sending and receiving
/// methods to be executed between the Dart `Apple` and the Java `Apple` until
/// the objects are disposed and removed.
///
/// 4. Disposing of the Dart `Apple` would lead to a message sent to the remote
/// [ReferencePairManager] to dispose the Java `Apple`.
// TODO: handle null values?
abstract class ReferencePairManager {
  static final Uuid _uuid = Uuid();

  bool _isInitialized = false;
  final _localRefToRemoteRefMap = BiMap<LocalReference, RemoteReference>();

  /// Handles communication with [RemoteReference]s.
  RemoteReferenceCommunicationHandler get remoteHandler;

  /// Handles communication with [LocalReference]s.
  LocalReferenceCommunicationHandler get localHandler;

  /// Finish setup to start facilitating communication between [LocalReference]s and [RemoteReference].
  @mustCallSuper
  void initialize() => _isInitialized = true;

  /// Retrieve the [RemoteReference] paired with [localReference].
  RemoteReference remoteReferenceFor(LocalReference localReference) {
    _assertIsInitialized();
    return _localRefToRemoteRefMap[localReference];
  }

  /// Retrieve the [LocalReference] paired with [remoteReference].
  LocalReference localReferenceFor(RemoteReference remoteReference) {
    _assertIsInitialized();
    return _localRefToRemoteRefMap.inverse[remoteReference];
  }

  /// Call when a remote [ReferencePairManager] wants to create a [RemoteReference].
  ///
  /// This will instantiate a [LocalReference] and add it and [remoteReference]
  /// as a pair.
  LocalReference createLocalReferenceFor(
    RemoteReference remoteReference,
    TypeReference typeReference,
    List<dynamic> arguments,
  ) {
    _assertIsInitialized();
    final LocalReference localReference = localHandler.createLocalReferenceFor(
      remoteReference,
      typeReference,
      _replaceRemoteReferences(arguments),
    );
    _localRefToRemoteRefMap[localReference] = remoteReference;
    return localReference;
  }

  /// Call when a remote [ReferencePairManager] wants to dispose their [RemoteReference].
  ///
  /// This will remove [remoteReference] and its paired [LocalReference] from
  /// this [ReferencePairManager].
  void disposeLocalReferenceFor(RemoteReference remoteReference) {
    _assertIsInitialized();
    localHandler.disposeLocalReference(localReferenceFor(remoteReference));
    _removePairFor(remoteReference);
  }

  /// Creates and maintains access of an equivalent object to [localReference] on a remote thread/process.
  ///
  /// This will also store [localReference] and a [RemoteReference] as a pair.
  FutureOr<RemoteReference> createRemoteReferenceFor(
    LocalReference localReference,
    TypeReference typeReference,
  ) {
    _assertIsInitialized();
    if (remoteReferenceFor(localReference) != null) return null;

    final RemoteReference remoteReference = RemoteReference(_uuid.v4());
    _localRefToRemoteRefMap[localReference] = remoteReference;

    final Completer<RemoteReference> completer = Completer<RemoteReference>();

    remoteHandler
        .createRemoteReference(
          remoteReference,
          typeReference,
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
    if (remoteReference != null) {
      _removePairFor(remoteReference);
      return remoteHandler.disposeRemoteReference(remoteReference);
    }
  }

  /// Execute a method on the [RemoteReference] paired to [localReference].
  Future<dynamic> executeRemoteMethodFor(
    LocalReference localReference,
    String methodName,
    List<dynamic> arguments,
  ) {
    _assertIsInitialized();
    assert(remoteReferenceFor(localReference) != null);
    return remoteHandler.executeRemoteMethod(
      remoteReferenceFor(localReference),
      methodName,
      _replaceLocalReferences(arguments),
    );
  }

  /// Execute a method on the [LocalReference] paired to [remoteReference].
  Future<dynamic> executeLocalMethodFor(
    RemoteReference remoteReference,
    String methodName,
    List<dynamic> arguments,
  ) {
    _assertIsInitialized();
    assert(localReferenceFor(remoteReference) != null);
    return localHandler.executeLocalMethod(
      localReferenceFor(remoteReference),
      methodName,
      _replaceRemoteReferences(arguments),
    );
  }

  void _removePairFor(RemoteReference remoteReference) {
    final LocalReference localReference =
        _localRefToRemoteRefMap.inverse.remove(remoteReference);
    _localRefToRemoteRefMap.remove(localReference);
  }

  void _assertIsInitialized() {
    assert(_isInitialized, 'Initialize has not been called.');
  }

  List<dynamic> _replaceRemoteReferences(Iterable<dynamic> iterable) {
    return iterable
        .replaceWhere(
          (value) => value is RemoteReference,
          (value) => localReferenceFor(value),
        )
        .toList();
  }

  List<dynamic> _replaceLocalReferences(Iterable<dynamic> iterable) {
    return iterable
        .replaceWhere(
          (value) =>
              value is LocalReference && remoteReferenceFor(value) != null,
          (value) => remoteReferenceFor(value),
        )
        .toList();
  }
}

extension ReplaceWhere on Iterable {
  Iterable<dynamic> replaceWhere(
    bool Function(dynamic value) test,
    dynamic Function(dynamic value) replacement,
  ) {
    return map<dynamic>((dynamic value) {
      if (test(value)) return replacement(value);
      return value;
    });
  }
}
