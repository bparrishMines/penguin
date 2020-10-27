import 'dart:math';

import 'reference.dart';
import 'reference_converter.dart';
import 'remote_reference_map.dart';

/// Handles communication with [RemoteReference]s for a [ReferencePairManager].
///
/// This class communicates with other [ReferencePairManager]s to create,
/// dispose, or invoke methods on [RemoteReference]s.
mixin ReferenceChannelMessenger {
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
  /// [sendDisposePair] is called with [remoteReference].
  Future<void> sendCreateNewPair(
    String handlerChannel,
    RemoteReference remoteReference,
    List<Object> arguments,
  );

  /// Invoke a static method on the type that is represented by [typeId].
  Future<Object> sendInvokeStaticMethod(
    String handlerChannel,
    String methodName,
    List<Object> arguments,
  );

  /// Invoke a method on the object instance that [remoteReference] represents.
  ///
  /// For any [RemoteReference], this method should only be called after
  /// [sendCreateNewPair] and should never be called after
  /// [sendDisposePair].
  Future<Object> sendInvokeMethod(
    String handlerChannel,
    RemoteReference remoteReference,
    String methodName,
    List<Object> arguments,
  );

  /// Invoke a method on an object instance that [unpairedReference] represents.
  Future<Object> sendInvokeMethodOnUnpairedReference(
    UnpairedReference unpairedReference,
    String methodName,
    List<Object> arguments,
  );

  /// Dispose the object instance that [remoteReference] represents.
  ///
  /// This method should also stop the local and remote [ReferencePairManager]
  /// from maintaining the connection between its paired [LocalReference] and
  /// should allow for either object instance to connect to new references.
  Future<void> sendDisposePair(
    String handlerChannel,
    RemoteReference remoteReference,
  );
}

/// Handles communication with [LocalReference]s for a [ReferencePairManager].
///
/// This class handles communication from other [ReferencePairManager]s to
/// create, dispose, or invoke methods for a [LocalReference].
mixin ReferenceChannelHandler<T> {
  /// Retrieves arguments to instantiate an object that is created with [createInstance].
  List<Object> getCreationArguments(
    ReferenceChannelManager manager,
    T instance,
  );

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
  T createInstance(
    ReferenceChannelManager manager,
    List<Object> arguments,
  );

  /// Invoke a static method on [referenceType].
  Object invokeStaticMethod(
    ReferenceChannelManager manager,
    String methodName,
    List<Object> arguments,
  );

  /// Invoke a method on the object instance represented by [localReference].
  Object invokeMethod(
    ReferenceChannelManager manager,
    T instance,
    String methodName,
    List<Object> arguments,
  );

  /// Dispose [localReference] and the value it represents.
  ///
  /// This also stops the [ReferencePairManager] from maintaining the connection
  /// with its paired [RemoteReference] and will allow for either value to be
  /// attached to new references.
  void onInstanceDisposed(
    ReferenceChannelManager manager,
    T instance,
  ) {}
}

abstract class ReferenceChannelManager {
  static const String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final Random _rnd = Random();

  final Map<String, ReferenceChannelHandler> _channelHandlers =
      <String, ReferenceChannelHandler>{};

  final RemoteReferenceMap referencePairs = RemoteReferenceMap();

  bool _initialized = false;

  ReferenceChannelMessenger get messenger;

  //@mustCallSuper
  void initialize() => _initialized = true;

  void registerHandler(String channelName, ReferenceChannelHandler handler) {
    _channelHandlers[channelName] = handler;
  }

  void unregisterHandler(String channelName) {
    _channelHandlers.remove(channelName);
  }

  ReferenceChannelHandler getChannelHandler(String channelName) {
    return _channelHandlers[channelName];
  }

  /// Converts [Reference]s when passing values to a [ReferenceChannelHandler] or a [MessageSender].
  ReferenceConverter get converter => StandardReferenceConverter();

  /// Create a new [LocalReference] to be paired with [RemoteReference].
  ///
  /// This is typically called when a remote [RemoteReferenceMap] wants to
  /// create a [RemoteReference].
  ///
  /// This will instantiate a new [LocalReference] and add it and
  /// [remoteReference] as a pair.
  ///
  /// This method uses [ReferenceConverter.convertForLocalManager] to convert
  /// [arguments].
  ///
  /// Returns `null` if a pair with [remoteReference] has already been added.
  /// Otherwise, it returns the paired [LocalReference].
  Object onReceiveCreateNewPair(
    String handlerChannel,
    RemoteReference remoteReference, [
    List<Object> arguments,
  ]) {
    _assertIsInitialized();
    if (referencePairs.getPairedObject(remoteReference) != null) return null;

    final Object object = getChannelHandler(handlerChannel).createInstance(
      this,
      // getReferenceType(typeId),
      converter.convertForLocalManager(this, arguments ?? <Object>[]),
    );

    assert(referencePairs.getPairedRemoteReference(object) == null);

    referencePairs.add(object, remoteReference);
    return object;
  }

  /// Invoke a static method on [referenceType].
  ///
  /// This method uses [ReferenceConverter.convertForLocalManager] to convert
  /// [arguments] and [ReferenceConverter.convertForRemoteManager] to convert
  /// the result.
  Object onReceiveInvokeStaticMethod(
    String handlerChannel,
    String methodName, [
    List<Object> arguments,
  ]) {
    _assertIsInitialized();
    // assert(getTypeId(referenceType) != null);
    final Object result = getChannelHandler(handlerChannel).invokeStaticMethod(
      this,
      // referenceType,
      methodName,
      converter.convertForLocalManager(this, arguments) ?? <Object>[],
    );

    return converter.convertForRemoteManager(this, result);
  }

  UnpairedReference createUnpairedReference(
    String handlerChannel,
    Object object,
  ) {
    return UnpairedReference(
      handlerChannel,
      getChannelHandler(handlerChannel).getCreationArguments(this, object),
    );
  }

  /// Invoke a method on [localReference].
  ///
  /// This method uses [ReferenceConverter.convertForLocalManager] to convert
  /// [arguments] and [ReferenceConverter.convertForRemoteManager] to convert
  /// the result.
  Object onReceiveInvokeMethod(
    String handlerChannel,
    Object instance,
    String methodName,
    List<Object> arguments,
  ) {
    _assertIsInitialized();

    final Object result = getChannelHandler(handlerChannel).invokeMethod(
      this,
      instance,
      methodName,
      converter.convertForLocalManager(this, arguments) ?? <Object>[],
    );

    return converter.convertForRemoteManager(this, result);
  }

  /// Creates a [LocalReference] from [unpairedReference] and invoke a method.
  ///
  /// This method uses [ReferenceConverter.convertForLocalManager] to convert
  /// [arguments] and [ReferenceConverter.convertForRemoteManager] to convert
  /// the result.
  Object onReceiveInvokeMethodOnUnpairedReference(
    UnpairedReference unpairedReference,
    String methodName,
    List<Object> arguments,
  ) {
    _assertIsInitialized();
    return onReceiveInvokeMethod(
      unpairedReference.handlerChannel,
      getChannelHandler(unpairedReference.handlerChannel).createInstance(
        this,
        // getReferenceType(unpairedReference.typeId),
        converter.convertForLocalManager(
          this,
          unpairedReference.creationArguments,
        ),
      ),
      methodName,
      arguments,
    );
  }

  /// Removes the [Reference] pair containing [remoteReference] from this [RemoteReferenceMap].
  ///
  /// Typically called when a remote [RemoteReferenceMap] wants to dispose
  /// their [RemoteReference].
  ///
  /// This will remove [remoteReference] and its paired [LocalReference] from
  /// this [RemoteReferenceMap].
  void onReceiveDisposePair(
    String handlerChannel,
    RemoteReference remoteReference,
  ) {
    _assertIsInitialized();

    final Object instance = referencePairs.getPairedObject(remoteReference);
    if (instance == null) return;

    referencePairs.removePairWithObject(instance);
    getChannelHandler(handlerChannel).onInstanceDisposed(this, instance);
  }

  // TODO(bparrishMines): Undo state change if failure to create?
  /// Creates a new [RemoteReference] to be paired with [localReference].
  ///
  /// This is typically called when a class wants a remote
  /// [RemoteReferenceMap] wants to pair itself with a [RemoteReference].
  ///
  /// This will instantiate a new [RemoteReference] and add it and
  /// [localReference] as a pair.
  ///
  /// This method uses [ReferenceConverter.convertForRemoteManager] to convert
  /// arguments retrieved from
  /// [MessageSender.getCreationArguments].
  ///
  /// Returns `null` if a pair with [localReference] has already been added.
  /// Otherwise, it returns the paired [RemoteReference].
  Future<RemoteReference> createNewPair(
    String handlerChannel,
    Object instance,
  ) async {
    _assertIsInitialized();
    if (referencePairs.getPairedRemoteReference(instance) != null) {
      return null;
    }

    final RemoteReference remoteReference =
        RemoteReference(getNewReferenceId());

    referencePairs.add(instance, remoteReference);

    await messenger.sendCreateNewPair(
      handlerChannel,
      remoteReference,
      // getTypeId(localReference.referenceType),
      converter.convertForRemoteManager(
        this,
        getChannelHandler(handlerChannel).getCreationArguments(this, instance),
      ),
    );

    return remoteReference;
  }

  /// Invoke a static method on [referenceType].
  ///
  /// This method uses [ReferenceConverter.convertForRemoteManager] to convert
  /// [arguments] and [ReferenceConverter.convertForLocalManager] to convert
  /// the result.
  Future<Object> invokeStaticMethod(
    String handlerChannel,
    // Type referenceType,
    String methodName,
    List<Object> arguments,
  ) async {
    _assertIsInitialized();
    // assert(getTypeId(referenceType) != null);
    final Object result = await messenger.sendInvokeStaticMethod(
      handlerChannel,
      // getTypeId(referenceType),
      methodName,
      converter.convertForRemoteManager(this, arguments) ?? <Object>[],
    );

    return converter.convertForLocalManager(this, result);
  }

  /// Invoke a method on [remoteReference].
  ///
  /// This method uses [ReferenceConverter.convertForRemoteManager] to convert
  /// [arguments] and [ReferenceConverter.convertForLocalManager] to convert
  /// the result.
  Future<Object> invokeMethod(
    String handlerChannel,
    RemoteReference remoteReference,
    String methodName,
    List<Object> arguments,
  ) async {
    _assertIsInitialized();

    final Object result = await messenger.sendInvokeMethod(
      handlerChannel,
      remoteReference,
      methodName,
      converter.convertForRemoteManager(this, arguments) ?? <Object>[],
    );

    return converter.convertForLocalManager(this, result);
  }

  /// Creates an [UnpairedReference] from [localReference] and invokes a method on a remote version of the [UnpairedReference].
  ///
  /// This method uses [ReferenceConverter.convertForRemoteManager] to convert
  /// [arguments] and [ReferenceConverter.convertForLocalManager] to convert
  /// the result.
  Future<Object> invokeMethodOnUnpairedReference(
    String handlerChannel,
    Object object,
    String methodName,
    List<Object> arguments,
  ) async {
    _assertIsInitialized();

    final Object result = await messenger.sendInvokeMethodOnUnpairedReference(
      createUnpairedReference(handlerChannel, object),
      methodName,
      converter.convertForRemoteManager(this, arguments) ?? <Object>[],
    );

    return converter.convertForLocalManager(this, result);
  }

  /// Removes the [Reference] pair containing [localReference] from this [RemoteReferenceMap].
  ///
  /// This also removes the [Reference] pair from the remote
  /// [RemoteReferenceMap].
  ///
  /// This is typically called when a class no longer needs access to the
  /// [RemoteReference] it is paired with.
  Future<void> disposePair(String handlerChannel, Object instance) async {
    _assertIsInitialized();

    final RemoteReference remoteReference =
        referencePairs.getPairedRemoteReference(instance);
    if (remoteReference == null) return null;

    referencePairs.removePairWithObject(instance);
    return messenger.sendDisposePair(handlerChannel, remoteReference);
  }

  void _assertIsInitialized() {
    assert(_initialized, 'Initialize has not been called.');
  }

  String getNewReferenceId() {
    return String.fromCharCodes(Iterable.generate(
      10,
      (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)),
    ));
  }
}
