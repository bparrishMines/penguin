import 'dart:math';

import 'package:reference/reference.dart';

import 'reference.dart';
import 'remote_reference_map.dart';

class ReferenceChannel<T> {
  ReferenceChannel(this.manager, this.channelName);

  final ReferenceChannelManager manager;
  final String channelName;

  void setHandler(ReferenceChannelHandler<T> handler) {
    manager.registerHandler(channelName, handler);
  }

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
  Future<RemoteReference> createNewPair(T instance) async {
    if (manager.isPaired(instance)) return null;

    final RemoteReference remoteReference = RemoteReference(
      manager.getNewReferenceId(),
    );

    manager._referencePairs.add(instance, remoteReference);

    await manager.messenger.sendCreateNewPair(
      channelName,
      remoteReference,
      manager.converter.convertForRemoteManager(
        manager,
        manager
            .getChannelHandler(channelName)
            .getCreationArguments(manager, instance),
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
    String methodName,
    List<Object> arguments,
  ) async {
    final Object result = await manager.messenger.sendInvokeStaticMethod(
      channelName,
      methodName,
      manager.converter.convertForRemoteManager(manager, arguments),
    );

    return manager.converter.convertForLocalManager(manager, result);
  }

  /// Invoke a method on [remoteReference].
  ///
  /// This method uses [ReferenceConverter.convertForRemoteManager] to convert
  /// [arguments] and [ReferenceConverter.convertForLocalManager] to convert
  /// the result.
  Future<Object> invokeMethod(
    T instance,
    String methodName,
    List<Object> arguments,
  ) async {
    final Object result = await manager.messenger.sendInvokeMethod(
      channelName,
      manager._referencePairs.getPairedRemoteReference(instance),
      methodName,
      manager.converter.convertForRemoteManager(manager, arguments),
    );

    return manager.converter.convertForLocalManager(manager, result);
  }

  /// Creates an [UnpairedReference] from [localReference] and invokes a method on a remote version of the [UnpairedReference].
  ///
  /// This method uses [ReferenceConverter.convertForRemoteManager] to convert
  /// [arguments] and [ReferenceConverter.convertForLocalManager] to convert
  /// the result.
  Future<Object> invokeMethodOnUnpairedReference(
    T object,
    String methodName,
    List<Object> arguments,
  ) async {
    final Object result =
        await manager.messenger.sendInvokeMethodOnUnpairedReference(
      manager.createUnpairedReference(channelName, object),
      methodName,
      manager.converter.convertForRemoteManager(manager, arguments),
    );

    return manager.converter.convertForLocalManager(manager, result);
  }

  /// Removes the [Reference] pair containing [localReference] from this [RemoteReferenceMap].
  ///
  /// This also removes the [Reference] pair from the remote
  /// [RemoteReferenceMap].
  ///
  /// This is typically called when a class no longer needs access to the
  /// [RemoteReference] it is paired with.
  Future<void> disposePair(T instance) async {
    final RemoteReference remoteReference =
        manager._referencePairs.getPairedRemoteReference(instance);

    if (remoteReference != null) {
      manager._referencePairs.removePairWithObject(instance);
      return manager.messenger.sendDisposePair(channelName, remoteReference);
    }
  }
}

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
  /// The LOCAL [ReferencePairManagerr] stores the returned [LocalReference] and
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

  final RemoteReferenceMap _referencePairs = RemoteReferenceMap();

  ReferenceChannelMessenger get messenger;

  /// Converts [Reference]s when passing values to a [ReferenceChannelHandler] or a [MessageSender].
  ReferenceConverter get converter => StandardReferenceConverter();

  bool isPaired(Object instance) {
    return _referencePairs.getPairedRemoteReference(instance) != null;
  }

  void registerHandler(String channelName, ReferenceChannelHandler handler) {
    _channelHandlers[channelName] = handler;
  }

  ReferenceChannelHandler getChannelHandler(String channelName) {
    return _channelHandlers[channelName];
  }

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
    String channelName,
    RemoteReference remoteReference,
    List<Object> arguments,
  ) {
    if (_referencePairs.getPairedObject(remoteReference) != null) return null;

    final Object object = getChannelHandler(channelName).createInstance(
      this,
      converter.convertForLocalManager(this, arguments),
    );

    assert(!isPaired(object));

    _referencePairs.add(object, remoteReference);
    return object;
  }

  /// Invoke a static method on [referenceType].
  ///
  /// This method uses [ReferenceConverter.convertForLocalManager] to convert
  /// [arguments] and [ReferenceConverter.convertForRemoteManager] to convert
  /// the result.
  Object onReceiveInvokeStaticMethod(
    String channelName,
    String methodName,
    List<Object> arguments,
  ) {
    final Object result = getChannelHandler(channelName).invokeStaticMethod(
      this,
      methodName,
      converter.convertForLocalManager(this, arguments),
    );

    return converter.convertForRemoteManager(this, result);
  }

  UnpairedReference createUnpairedReference(
    String channelName,
    Object object,
  ) {
    final ReferenceChannelHandler handler = _channelHandlers[channelName];
    if (handler == null) return null;

    return UnpairedReference(
      channelName,
      handler.getCreationArguments(this, object),
    );
  }

  /// Invoke a method on [localReference].
  ///
  /// This method uses [ReferenceConverter.convertForLocalManager] to convert
  /// [arguments] and [ReferenceConverter.convertForRemoteManager] to convert
  /// the result.
  Object onReceiveInvokeMethod(
    String channelName,
    RemoteReference remoteReference,
    String methodName,
    List<Object> arguments,
  ) {
    final Object result = getChannelHandler(channelName).invokeMethod(
      this,
      _referencePairs.getPairedObject(remoteReference),
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
    final Object result =
        getChannelHandler(unpairedReference.channelName).invokeMethod(
      this,
      getChannelHandler(unpairedReference.channelName).createInstance(
        this,
        converter.convertForLocalManager(
          this,
          unpairedReference.creationArguments,
        ),
      ),
      methodName,
      converter.convertForLocalManager(this, arguments),
    );

    return converter.convertForRemoteManager(this, result);
  }

  /// Removes the [Reference] pair containing [remoteReference] from this [RemoteReferenceMap].
  ///
  /// Typically called when a remote [RemoteReferenceMap] wants to dispose
  /// their [RemoteReference].
  ///
  /// This will remove [remoteReference] and its paired [LocalReference] from
  /// this [RemoteReferenceMap].
  void onReceiveDisposePair(
    String channelName,
    RemoteReference remoteReference,
  ) {
    final Object instance = _referencePairs.getPairedObject(remoteReference);
    if (instance == null) return;

    _referencePairs.removePairWithObject(instance);
    getChannelHandler(channelName).onInstanceDisposed(this, instance);
  }

  String getNewReferenceId() {
    return String.fromCharCodes(Iterable.generate(
      10,
      (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)),
    ));
  }
}

/// Handles converting [Reference]s for a [RemoteReferenceMap].
///
/// When a [RemoteReferenceMap] receives arguments from another
/// [RemoteReferenceMap] or sends arguments to another [RemoteReferenceMap],
/// it converts [Reference]s to their paired [LocalReference]/[RemoteReference]
/// or creates a new [UnpairedReference].
///
/// See [StandardReferenceConverter].
mixin ReferenceConverter {
  /// Converts arguments to be used by a [RemoteReference].
  ///
  /// A [RemoteReferenceMap] should use this when creating or invoking a
  /// method on a [RemoteReference].
  Object convertForRemoteManager(
    ReferenceChannelManager manager,
    Object object,
  );

  /// Converts arguments to be used with a [LocalReference].
  ///
  /// A [RemoteReferenceMap] uses this when creating or invoking a method on
  /// a [LocalReference].
  Object convertForLocalManager(
    ReferenceChannelManager manager,
    Object object,
  );
}

/// Standard implementation of a [ReferenceConverter].
class StandardReferenceConverter implements ReferenceConverter {
  const StandardReferenceConverter();

  /// Converts arguments to be used with a [LocalReference].
  ///
  /// Conversions:
  ///   * Paired [LocalReference]s are converted to their paired [RemoteReference].
  ///   * Unpaired [LocalReference]s are converted into [UnpairedReference].
  ///   * [List]s are converted to `List<dynamic>` and this method is applied to
  ///     each value within the list.
  ///   * [Map]s are converted to `Map<dynamic, dynamic>` and this method is
  ///     applied to each key and each value.
  @override
  Object convertForRemoteManager(
    ReferenceChannelManager manager,
    Object object,
  ) {
    if (manager.isPaired(object)) {
      return manager._referencePairs.getPairedRemoteReference(object);
    } else if (!manager.isPaired(object) && object is Referencable) {
      return manager.createUnpairedReference(
        object.referenceChannel.channelName,
        object,
      );
    } else if (object is List) {
      return object.map((_) => convertForRemoteManager(manager, _)).toList();
    } else if (object is Map) {
      return Map<Object, Object>.fromIterables(
        object.keys.map<Object>((_) => convertForRemoteManager(manager, _)),
        object.values.map<Object>((_) => convertForRemoteManager(manager, _)),
      );
    }

    return object;
  }

  /// Converts arguments to be used with a [LocalReference].
  ///
  /// A [RemoteReferenceMap] uses this when creating or invoking a method on
  /// a [LocalReference].
  ///
  /// Conversions:
  ///   * [RemoteReference]s are converted to their paired [LocalReference].
  ///   * [UnpairedReference]s are converted into unpaired [LocalReference]s.
  ///   * [List]s are converted to `List<dynamic>` and this method is applied to
  ///     each value within the list.
  ///   * [Map]s are converted to `Map<dynamic, dynamic>` and this method is
  ///     applied to each key and each value.
  @override
  Object convertForLocalManager(
    ReferenceChannelManager manager,
    Object object,
  ) {
    if (object is RemoteReference) {
      return manager._referencePairs.getPairedObject(object);
    } else if (object is UnpairedReference) {
      return manager.getChannelHandler(object.channelName).createInstance(
            manager,
            convertForLocalManager(manager, object.creationArguments),
          );
    } else if (object is List) {
      return object.map((_) => convertForLocalManager(manager, _)).toList();
    } else if (object is Map) {
      return Map<Object, Object>.fromIterables(
        object.keys.map<Object>((_) => convertForLocalManager(manager, _)),
        object.values.map<Object>((_) => convertForLocalManager(manager, _)),
      );
    }

    return object;
  }
}
