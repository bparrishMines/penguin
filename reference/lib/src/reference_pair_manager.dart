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
  List<dynamic> creationArgumentsFor(LocalReference localReference);

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
    TypeReference typeReference,
    List<dynamic> arguments,
  );

  /// Execute a method on the object instance that [remoteReference] represents.
  ///
  /// For any [RemoteReference], this method should only be called after
  /// [createRemoteReference] and should never be called after
  /// [disposeRemoteReference].
  Future<dynamic> executeRemoteMethod(
    RemoteReference remoteReference,
    String methodName,
    List<dynamic> arguments,
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
    TypeReference typeReference,
    List<dynamic> arguments,
  );

  /// Execute a method to be executed on the object instance represented by [localReference].
  ///
  /// For any [LocalReference] this method should only be called after
  /// [createLocalReference] and should never be called after
  /// [disposeLocalReference].
  dynamic executeLocalMethod(
    ReferencePairManager referencePairManager,
    LocalReference localReference,
    String methodName,
    List<dynamic> arguments,
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
  static final Uuid _uuid = Uuid();

  bool _isInitialized = false;
  static final _localRefToRemoteRefMap =
      BiMap<LocalReference, RemoteReference>();

  /// Retrieve the [TypeReference] that represents the type of [localReference].
  ///
  /// This method should be able to return a unique [TypeReference] that this
  /// [ReferencePairManager] should support.
  ///
  /// The local [TypeReference] should also share the same
  /// [TypeReference.typeId], as the equivalent object for the remote
  /// [TypeReference]. For example the `Apple` class in `apple.dart` and
  /// `Apple.java` could both return `TypeReference(0)`.
  TypeReference typeReferenceFor(LocalReference localReference);

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
    return _localRefToRemoteRefMap[localReference];
  }

  /// Retrieve the [LocalReference] paired with [remoteReference].
  ///
  /// Returns null if this [remoteReference] is not paired.
  LocalReference localReferenceFor(RemoteReference remoteReference) {
    _assertIsInitialized();
    return _localRefToRemoteRefMap.inverse[remoteReference];
  }

  /// Call when a [ReferencePairManager] on a different thread/process wants to create a [RemoteReference].
  ///
  /// This will instantiate a [LocalReference] and add it and [remoteReference]
  /// as a pair.
  ///
  /// All [RemoteReference]s and [UnpairedRemoteReference]s in `arguments` will
  /// be replaced by a [LocalReference].
  ///
  /// Also, all [List]s will also be converted into `List<dynamic>` and all
  /// [Map]s will be converted into `Map<dynamic, dynamic>`.
  LocalReference createLocalReferenceFor(
    RemoteReference remoteReference,
    TypeReference typeReference, [
    List<dynamic> arguments,
  ]) {
    _assertIsInitialized();
    final LocalReference localReference = localHandler.createLocalReference(
      this,
      typeReference,
      _replaceRemoteReferences(arguments ?? <dynamic>[]),
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

    final LocalReference localReference = localReferenceFor(remoteReference);
    if (localReference == null) return;

    _localRefToRemoteRefMap.remove(localReference);
    localHandler.disposeLocalReference(this, localReference);
  }

  // TODO(bparrishMines): Don't change state if failure to create
  /// Creates and maintains access of an equivalent object to [localReference] on a remote thread/process.
  ///
  /// This will also store [localReference] and a [RemoteReference] as a pair.
  FutureOr<RemoteReference> createRemoteReferenceFor(
    LocalReference localReference, [
    TypeReference typeReference,
  ]) {
    _assertIsInitialized();
    if (remoteReferenceFor(localReference) != null) return null;

    final RemoteReference remoteReference = RemoteReference(_uuid.v4());
    _localRefToRemoteRefMap[localReference] = remoteReference;

    final Completer<RemoteReference> completer = Completer<RemoteReference>();

    remoteHandler
        .createRemoteReference(
          remoteReference,
          typeReference ?? typeReferenceFor(localReference),
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

    _localRefToRemoteRefMap.remove(localReference);
    return remoteHandler.disposeRemoteReference(remoteReference);
  }

  // TODO(bparrishMines): This should be able to use UnpairedRemoteReference for the RemoteReference
  /// Execute a method on the [RemoteReference] paired to [localReference].
  ///
  /// The [LocalReference]s in `arguments` will be replaced by a
  /// [RemoteReference] or a [UnpairedRemoteReference].
  ///
  /// All [List]s will also be converted into `List<dynamic>` and all [Map]s
  /// will be converted into `Map<dynamic, dynamic>`.
  Future<dynamic> executeRemoteMethodFor(
    LocalReference localReference,
    String methodName, [
    List<dynamic> arguments,
  ]) {
    _assertIsInitialized();
    assert(remoteReferenceFor(localReference) != null);
    final Completer<dynamic> resultCompleter = Completer<dynamic>();
    remoteHandler
        .executeRemoteMethod(
          remoteReferenceFor(localReference),
          methodName,
          _replaceLocalReferences(arguments) ?? <dynamic>[],
        )
        .then(
          (dynamic value) =>
              resultCompleter.complete(_replaceRemoteReferences(value)),
        );
    return resultCompleter.future;
  }

  /// Execute a method on the [LocalReference] paired to [remoteReference].
  ///
  /// All [RemoteReference]s and [UnpairedRemoteReference]s in `arguments` will
  /// be replaced by a [LocalReference].
  ///
  /// Also, all [List]s will also be converted into `List<dynamic>` and all
  /// [Map]s will be converted into `Map<dynamic, dynamic>`.
  dynamic executeLocalMethodFor(
    RemoteReference remoteReference,
    String methodName, [
    List<dynamic> arguments,
  ]) {
    _assertIsInitialized();
    assert(localReferenceFor(remoteReference) != null);

    final LocalReference localReference = localReferenceFor(remoteReference);
    final dynamic result = localHandler.executeLocalMethod(
      this,
      localReference,
      methodName,
      _replaceRemoteReferences(arguments) ?? <dynamic>[],
    );
    return _replaceLocalReferences(result);
  }

  void _assertIsInitialized() {
    assert(_isInitialized, 'Initialize has not been called.');
  }

  dynamic _replaceRemoteReferences(dynamic argument) {
    if (argument is RemoteReference) {
      return localReferenceFor(argument);
    } else if (argument is UnpairedRemoteReference) {
      return localHandler.createLocalReference(
        this,
        argument.typeReference,
        argument.creationArguments.map(_replaceRemoteReferences).toList(),
      );
    } else if (argument is List) {
      return argument.map(_replaceRemoteReferences).toList();
    } else if (argument is Map) {
      return Map<dynamic, dynamic>.fromIterables(
        argument.keys.map<dynamic>(_replaceRemoteReferences),
        argument.values.map<dynamic>(_replaceRemoteReferences),
      );
    }

    return argument;
  }

  dynamic _replaceLocalReferences(dynamic argument) {
    if (argument is LocalReference && remoteReferenceFor(argument) != null) {
      return remoteReferenceFor(argument);
    } else if (argument is LocalReference &&
        remoteReferenceFor(argument) == null) {
      return UnpairedRemoteReference(
        typeReferenceFor(argument),
        remoteHandler
            .creationArgumentsFor(argument)
            .map(_replaceLocalReferences)
            .toList(),
      );
    } else if (argument is List) {
      return argument.map(_replaceLocalReferences).toList();
    } else if (argument is Map) {
      return Map<dynamic, dynamic>.fromIterables(
        argument.keys.map<dynamic>(_replaceLocalReferences),
        argument.values.map<dynamic>(_replaceLocalReferences),
      );
    }

    return argument;
  }
}
