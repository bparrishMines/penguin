import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';

import 'reference.dart';
import 'reference_converter.dart';

/// Handles communication with [RemoteReference]s for a [ReferencePairManager].
///
/// This class communicates with other [ReferencePairManager]s to create,
/// dispose, or invoke methods on [RemoteReference]s.
mixin RemoteReferenceCommunicationHandler {
  /// Retrieves arguments to instantiate an object that is created with [create].
  List<Object> getCreationArguments(LocalReference localReference);

  /// Instantiate and store an instance of an object that is remotely accessible.
  ///
  /// The remote instantiated object will be represented as [remoteReference].
  ///
  /// The LOCAL [ReferencePairManager] stores the paired [LocalReference] and
  /// [remoteReference] and facilitates communication between the instances they
  /// represent.
  ///
  /// The REMOTE [ReferencePairManager] will represent the paired
  /// [localReference] as a [RemoteReference], instantiate a new
  /// [LocalReference], and also store them as a pair.
  ///
  /// This method should make the instantiated remote object accessible until
  /// [dispose] is called with [remoteReference].
  Future<void> create(
    RemoteReference remoteReference,
    int typeId,
    List<Object> arguments,
  );

  /// Invoke a method on the object instance that [remoteReference] represents.
  ///
  /// For any [RemoteReference], this method should only be called after
  /// [create] and should never be called after
  /// [dispose].
  Future<Object> invokeMethod(
    RemoteReference remoteReference,
    String methodName,
    List<Object> arguments,
  );

  /// Invoke a method on an object instance that [unpairedReference] represents.
  Future<Object> invokeMethodOnUnpairedReference(
    UnpairedReference unpairedReference,
    String methodName,
    List<Object> arguments,
  );

  /// Dispose the object instance that [remoteReference] represents.
  ///
  /// This method should also stop the local and remote [ReferencePairManager]
  /// from maintaining the connection between its paired [LocalReference] and
  /// should allow for either object instance to connect to new references.
  Future<void> dispose(RemoteReference remoteReference);
}

/// Handles communication with [LocalReference]s for a [ReferencePairManager].
///
/// This class handles communication from other [ReferencePairManager]s to
/// create, dispose, or invoke methods for a [LocalReference].
mixin LocalReferenceCommunicationHandler {
  /// Instantiates a new [LocalReference].
  ///
  /// When a remote [ReferencePairManager] would like to create a new pair, this
  /// method is called to instantiate a [LocalReference] to be stored in a local
  /// [ReferencePairManager] and paired with a [RemoteReference]. This method is
  /// also called to convert an [UnpairedReference] into a [LocalReference].
  ///
  /// Assuming [LocalReference] is being created to be paired with a
  /// [RemoteReference]:
  ///
  /// The LOCAL [ReferencePairManager] stores the returned [LocalReference] and
  /// a [RemoteReference] with a generated `referenceId` are stored as a pair
  /// and the LOCAL [ReferencePairManager] will facilitate communication between
  /// their object instances they represent.
  ///
  /// The REMOTE [ReferencePairManager] will represent the returned value as a
  /// [RemoteReference] and represent the generated [RemoteReference] as a
  /// [LocalReference]. It will also store both references as a pair.
  LocalReference create(
    ReferencePairManager referencePairManager,
    Type referenceType,
    List<Object> arguments,
  );

  /// Invoke a method to be executed on the object instance represented by [localReference].
  Object invokeMethod(
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
  void dispose(
    ReferencePairManager referencePairManager,
    LocalReference localReference,
  ) {}
}

/// Manages communication between [LocalReference]s and [RemoteReference]s.
///
/// This class works by facilitating communication between a [LocalReference]
/// and a [RemoteReference] pair. When a [LocalReference] is added to a
/// locally accessible [ReferencePairManager], it is expected that an
/// equivalent object is created and added to a remotely accessible
/// [ReferencePairManager].
///
/// For example, assume that there is a [ReferencePairManager] on a thread
/// running Dart code and a [ReferencePairManager] on a thread running Java
/// code. When an object of a Dart class named `Apple` is instantiated and is
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
/// methods to be invoked between the Dart `Apple` and the Java `Apple` until
/// the objects are disposed and removed.
///
/// 4. Disposing of the Dart `Apple` would lead to a message sent to the remote
/// [ReferencePairManager] to dispose the Java `Apple`.
///
///
/// --------------------------------------------------------
///
/// [ReferencePairManager.remoteHandler] and [ReferencePairManager.localHandler]
/// must be overriden to return a value. See [MethodChannelReferencePairManager]
/// for an implementation using [MethodChannel]s.
abstract class ReferencePairManager {
  /// Default constructor for [ReferencePairManager].
  ///
  /// [ReferencePairManager.supportedTypes] must not be `null`.
  ReferencePairManager(List<Type> supportedTypes)
      : assert(supportedTypes != null && supportedTypes.isNotEmpty),
        supportedTypes = List<Type>.unmodifiable(supportedTypes),
        _typeIds = _BiMap()..addAll(supportedTypes.toList().asMap());

  bool _isInitialized = false;
  final _referencePairs = _BiMap<LocalReference, RemoteReference>();
  final _BiMap<int, Type> _typeIds;
  final String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  final List<Type> supportedTypes;

  /// Handles communication with [RemoteReference]s.
  RemoteReferenceCommunicationHandler get remoteHandler;

  /// Handles communication with [LocalReference]s.
  LocalReferenceCommunicationHandler get localHandler;

  /// Finish setup to start facilitating communication between [LocalReference] and [RemoteReference] pairs.
  @mustCallSuper
  void initialize() => _isInitialized = true;

  /// Get the unique type identifier for a type in [ReferencePairManager.supportedTypes].
  ///
  /// If this [referenceType] is not in [ReferencePairManager.supportedTypes],
  /// this will return `null`.
  int getTypeId(Type referenceType) => _typeIds.inverse[referenceType];

  /// Get the type represented by [typeId].
  ///
  /// [typeId] should be greater than or equal to zero and less than
  /// [ReferencePairManager.supportedTypes].length;
  Type getReferenceType(int typeId) => _typeIds[typeId];

  /// Retrieve the [RemoteReference] paired with [localReference].
  ///
  /// Returns null if this [localReference] is not paired.
  RemoteReference getPairedRemoteReference(LocalReference localReference) {
    return _referencePairs[localReference];
  }

  /// Retrieve the [LocalReference] paired with [remoteReference].
  ///
  /// Returns null if this [remoteReference] is not paired.
  LocalReference getPairedLocalReference(RemoteReference remoteReference) {
    return _referencePairs.inverse[remoteReference];
  }

  /// Converts [Reference]s when passing values to a [LocalReferenceCommunicationHandler] or a [RemoteReferenceCommunicationHandler].
  ReferenceConverter get converter => StandardReferenceConverter();

  /// Create a new [LocalReference] to be paired with [RemoteReference].
  ///
  /// This is typically called when a remote [ReferencePairManager] wants to
  /// create a [RemoteReference].
  ///
  /// This will instantiate a new [LocalReference] and add it and
  /// [remoteReference] as a pair.
  ///
  /// This method uses [ReferenceConverter.convertForLocalManager] to convert
  /// [arguments].
  LocalReference pairWithNewLocalReference(
    RemoteReference remoteReference,
    int typeId, [
    List<Object> arguments,
  ]) {
    _assertIsInitialized();
    // TODO(bparrishMines): Verify this localReference doesn't already exists
    final LocalReference localReference = localHandler.create(
      this,
      getReferenceType(typeId),
      converter.convertForLocalManager(this, arguments ?? <Object>[]),
    );

    _referencePairs[localReference] = remoteReference;
    return localReference;
  }

  /// Invoke a method on [localReference].
  ///
  /// This method uses [ReferenceConverter.convertForLocalManager] to convert
  /// [arguments].
  Object invokeLocalMethod(
    LocalReference localReference,
    String methodName, [
    List<Object> arguments,
  ]) {
    _assertIsInitialized();

    final Object result = localHandler.invokeMethod(
      this,
      localReference,
      methodName,
      converter.convertForLocalManager(this, arguments) ?? <Object>[],
    );

    return converter.convertForRemoteManager(this, result);
  }

  /// Creates a [LocalReference] from [unpairedReference] and invoke a method.
  ///
  /// This method uses [ReferenceConverter.convertForLocalManager] to convert
  /// [arguments].
  Object invokeLocalMethodOnUnpairedReference(
    UnpairedReference unpairedReference,
    String methodName, [
    List<Object> arguments,
  ]) {
    _assertIsInitialized();
    return invokeLocalMethod(
      localHandler.create(
        this,
        getReferenceType(unpairedReference.typeId),
        converter.convertForLocalManager(
            this, unpairedReference.creationArguments),
      ),
      methodName,
      arguments,
    );
  }

  /// Removes the [Reference] pair containing [remoteReference] from this [ReferencePairManager].
  ///
  /// Typically called when a remote [ReferencePairManager] wants to dispose
  /// their [RemoteReference].
  ///
  /// This will remove [remoteReference] and its paired [LocalReference] from
  /// this [ReferencePairManager].
  void disposePairWithRemoteReference(RemoteReference remoteReference) {
    _assertIsInitialized();

    final LocalReference localReference =
        getPairedLocalReference(remoteReference);
    if (localReference == null) return;

    _referencePairs.remove(localReference);
    localHandler.dispose(this, localReference);
  }

  // TODO(bparrishMines): Undo state change if failure to create?
  // TODO: return reference if it already exists
  /// Creates a new [RemoteReference] to be paired with [localReference].
  ///
  /// This is typically called when a class wants a remote
  /// [ReferencePairManager] wants to pair itself with a [RemoteReference].
  ///
  /// This will instantiate a new [RemoteReference] and add it and
  /// [localReference] as a pair.
  ///
  /// This method uses [ReferenceConverter.convertForRemoteManager] to convert
  /// arguments retrieved from
  /// [RemoteReferenceCommunicationHandler.getCreationArguments].
  Future<RemoteReference> pairWithNewRemoteReference(
    LocalReference localReference,
  ) async {
    _assertIsInitialized();
    if (getPairedRemoteReference(localReference) != null) return null;

    final RemoteReference remoteReference = RemoteReference(
      getRandomReferenceId(),
    );
    _referencePairs[localReference] = remoteReference;

    await remoteHandler.create(
      remoteReference,
      getTypeId(localReference.referenceType),
      converter.convertForRemoteManager(
        this,
        remoteHandler.getCreationArguments(localReference),
      ),
    );

    return remoteReference;
  }

  /// Invoke a method on [remoteReference].
  ///
  /// This method uses [ReferenceConverter.convertForRemoteManager] to convert
  /// [arguments].
  Future<Object> invokeRemoteMethod(
    RemoteReference remoteReference,
    String methodName, [
    List<Object> arguments,
  ]) async {
    _assertIsInitialized();

    final Object result = await remoteHandler.invokeMethod(
      remoteReference,
      methodName,
      converter.convertForRemoteManager(this, arguments) ?? <Object>[],
    );

    return converter.convertForLocalManager(this, result);
  }

  /// Creates an [UnpairedReference] from [localReference] and invokes a method on a remote version of the [UnpairedReference].
  ///
  /// This method uses [ReferenceConverter.convertForRemoteManager] to convert
  /// [arguments].
  Future<Object> invokeRemoteMethodOnUnpairedReference(
    LocalReference localReference,
    String methodName, [
    List<Object> arguments,
  ]) async {
    _assertIsInitialized();

    final Object result = await remoteHandler.invokeMethodOnUnpairedReference(
      UnpairedReference(
        getTypeId(localReference.referenceType),
        converter.convertForRemoteManager(
          this,
          remoteHandler.getCreationArguments(localReference),
        ),
      ),
      methodName,
      converter.convertForRemoteManager(this, arguments) ?? <Object>[],
    );

    return converter.convertForLocalManager(this, result);
  }

  /// Removes the [Reference] pair containing [localReference] from this [ReferencePairManager].
  ///
  /// This also removes the [Reference] pair from the remote
  /// [ReferencePairManager].
  ///
  /// This is typically called when a class no longer needs access to the
  /// [RemoteReference] it is paired with.
  FutureOr<void> disposePairWithLocalReference(LocalReference localReference) {
    _assertIsInitialized();

    final RemoteReference remoteReference =
        getPairedRemoteReference(localReference);
    if (remoteReference == null) return null;

    _referencePairs.remove(localReference);
    return remoteHandler.dispose(remoteReference);
  }

  void _assertIsInitialized() {
    assert(_isInitialized, 'Initialize has not been called.');
  }

  String getRandomReferenceId() {
    return String.fromCharCodes(Iterable.generate(
      10,
      (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)),
    ));
  }
}

class _BiMap<K, V> implements Map<K, V> {
  _BiMap() {
    _inverse = _BiMap<V, K>._inverse(this);
  }

  _BiMap._inverse(this._inverse);

  final Map<K, V> _map = <K, V>{};
  _BiMap<V, K> _inverse;

  _BiMap get inverse => _inverse;

  @override
  operator [](Object key) {
    return _map[key];
  }

  @override
  void operator []=(key, value) {
    assert(key != null);
    assert(value != null);
    assert(!_map.containsKey(key));
    assert(!inverse.containsKey(value));
    _map[key] = value;
    inverse._map[value] = key;
  }

  @override
  void addAll(Map other) {
    addEntries(other.entries);
  }

  @override
  void addEntries(Iterable<MapEntry> newEntries) {
    for (MapEntry entry in newEntries) {
      this[entry.key] = entry.value;
    }
  }

  @override
  Map<RK, RV> cast<RK, RV>() {
    return _BiMap<RK, RV>()..addAll(this);
  }

  @override
  void clear() {
    _map.clear();
    inverse._map.clear();
  }

  @override
  bool containsKey(Object key) {
    return _map.containsKey(key);
  }

  @override
  bool containsValue(Object value) {
    return _map.containsValue(value);
  }

  @override
  Iterable<MapEntry<K, V>> get entries => _map.entries;

  @override
  void forEach(void Function(K key, V value) f) {
    throw UnsupportedError('');
  }

  @override
  bool get isEmpty => _map.isEmpty;

  @override
  bool get isNotEmpty => _map.isNotEmpty;

  @override
  Iterable<K> get keys => _map.keys;

  @override
  int get length => _map.length;

  @override
  Map<K2, V2> map<K2, V2>(MapEntry<K2, V2> Function(K key, V value) f) {
    throw UnsupportedError('');
  }

  @override
  V putIfAbsent(key, Function() ifAbsent) {
    throw UnsupportedError('');
  }

  @override
  V remove(Object key) {
    if (key == null) return null;
    final V value = _map[key];
    inverse._map.remove(value);
    return _map.remove(key);
  }

  @override
  void removeWhere(bool Function(K key, V value) predicate) {
    throw UnsupportedError('');
  }

  @override
  V update(key, Function(V value) update, {Function() ifAbsent}) {
    throw UnsupportedError('');
  }

  @override
  void updateAll(Function(K key, V value) update) {
    throw UnsupportedError('');
  }

  @override
  Iterable<V> get values => _map.values;
}
