import 'dart:math';

import 'package:reference/reference.dart';

import 'reference.dart';
import 'remote_reference_map.dart';

/// A named channel used to handle communication between platform types.
class ReferenceChannel<T extends Object> {
  /// Default constructor for [ReferenceChannel].
  ReferenceChannel(this.manager, this.name);

  /// Manages instances created and disposed by this [ReferenceChannel].
  final ReferenceChannelManager manager;

  /// The channel used to handle communication.
  final String name;

  /// Register a [ReferenceChannelHandler] for channel [name] in a [ReferenceChannelManager].
  void setHandler(ReferenceChannelHandler<T> handler) {
    manager.registerHandler(name, handler);
  }

  /// Creates a new [PairedReference] to be paired with [instance].
  ///
  /// Sends a message to another [ReferenceChannelManager] to instantiate an
  /// instance for [ReferenceChannel] with name: [name].
  ///
  /// Returns `null` if a pair with [instance] has already been added to
  /// manager. Otherwise, it returns the paired [PairedReference].
  Future<PairedReference?> createNewPair(T instance) async {
    if (manager.isPaired(instance)) return null;

    final PairedReference pairedReference = PairedReference(
      manager.getNewReferenceId(),
    );

    manager._referencePairs.add(instance, pairedReference);

    await manager.messenger.sendCreateNewPair(
      name,
      pairedReference,
      manager.converter.convertForRemoteManager(
        manager,
        manager
            .getChannelHandler(name)!
            .getCreationArguments(manager, instance),
      )! as List<Object?>,
    );

    return pairedReference;
  }

  /// Invoke a static on the on this reference channel.
  ///
  /// Sends a message to another [ReferenceChannelManager] to invoke a static
  /// method on the [ReferenceChannelHandler] registered to [ReferenceChannel]
  /// with name: [name].
  ///
  /// See [ReferenceChannelManager.registerHandler].
  Future<Object?> invokeStaticMethod(
    String methodName,
    List<Object?> arguments,
  ) async {
    final Object? result = await manager.messenger.sendInvokeStaticMethod(
      name,
      methodName,
      manager.converter.convertForRemoteManager(manager, arguments)!
          as List<Object?>,
    );

    return manager.converter.convertForLocalManager(manager, result);
  }

  /// Invoke a method on the [PairedReference] paired with [instance].
  ///
  /// Sends a message to another [ReferenceChannelManager] to invoke a method
  /// on an instance represented by the [PairedReference] paired with
  /// [instance].
  Future<Object?> invokeMethod(
    T instance,
    String methodName,
    List<Object?> arguments,
  ) async {
    if (!manager.isPaired(instance)) {
      return _invokeMethodOnUnpairedReference(instance, methodName, arguments);
    }

    final Object? result = await manager.messenger.sendInvokeMethod(
      name,
      manager._referencePairs.getPairedRemoteReference(instance)!,
      methodName,
      manager.converter.convertForRemoteManager(manager, arguments)!
          as List<Object?>,
    );

    return manager.converter.convertForLocalManager(manager, result);
  }

  Future<Object?> _invokeMethodOnUnpairedReference(
    T object,
    String methodName,
    List<Object?> arguments,
  ) async {
    final Object? result =
        await manager.messenger.sendInvokeMethodOnUnpairedReference(
      manager.createUnpairedReference(name, object)!,
      methodName,
      manager.converter.convertForRemoteManager(manager, arguments)!
          as List<Object?>,
    );

    return manager.converter.convertForLocalManager(manager, result);
  }

  /// Dispose the reference pair containing [instance].
  ///
  /// Sends a message to another [ReferenceChannelManager] to dispose the
  /// [PairedReference] paired to [instance].
  Future<void> disposePair(T instance) async {
    final PairedReference? pairedReference =
        manager._referencePairs.getPairedRemoteReference(instance);

    if (pairedReference != null) {
      manager._referencePairs.removePairWithObject(instance);
      return manager.messenger.sendDisposePair(name, pairedReference);
    }
  }
}

/// Handles sending messages for a [ReferenceChannelManager].
///
/// This class handles sending messages to other [ReferenceChannelManager]s to
/// create, dispose, or invoke methods across reference channels.
mixin ReferenceChannelMessenger {
  /// Instantiate a new object instance for reference channel of [channelName].
  Future<void> sendCreateNewPair(
    String channelName,
    PairedReference pairedReference,
    List<Object?> arguments,
  );

  /// Invoke a static method for reference channel of [channelName].
  Future<Object?> sendInvokeStaticMethod(
    String channelName,
    String methodName,
    List<Object?> arguments,
  );

  /// Invoke a method on the object instance that [pairedReference] represents on reference channel of [channelName].
  Future<Object?> sendInvokeMethod(
    String channelName,
    PairedReference pairedReference,
    String methodName,
    List<Object?> arguments,
  );

  /// Instantiate [unpairedReference] and invoke a method on reference channel of `unpairedReference.channelName`.
  Future<Object?> sendInvokeMethodOnUnpairedReference(
    UnpairedReference unpairedReference,
    String methodName,
    List<Object?> arguments,
  );

  /// Dispose the pair that contains [pairedReference].
  Future<void> sendDisposePair(
    String channelName,
    PairedReference pairedReference,
  );
}

/// Handles communication with [LocalReference]s for a [ReferencePairManager].
///
/// This class handles communication from other [ReferencePairManager]s to
/// create, dispose, or invoke methods for a [LocalReference].
mixin ReferenceChannelHandler<T extends Object> {
  /// Retrieves arguments to instantiate an object that is created with [createInstance].
  List<Object?> getCreationArguments(
    ReferenceChannelManager manager,
    T instance,
  );

  /// Instantiates a new [LocalReference].
  ///
  /// When a remote [ReferencePairManager] would like to create a new pair, this
  /// method is called to instantiate a [LocalReference] to be stored in a local
  /// [ReferencePairManager] and paired with a [PairedReference]. This method is
  /// also called to convert an [UnpairedReference] into a [LocalReference].
  ///
  /// Assuming [LocalReference] is being created to be paired with a
  /// [RemoteReference]:
  ///
  /// The LOCAL [ReferencePairManagerr] stores the returned [LocalReference] and
  /// a [PairedReference] with a generated `referenceId` are stored as a pair
  /// and the LOCAL [ReferencePairManager] will facilitate communication between
  /// their object instances they represent.
  ///
  /// The REMOTE [ReferencePairManager] will represent the returned value as a
  /// [PairedReference] and represent the generated [PairedReference] as a
  /// [LocalReference]. It will also store both references as a pair.
  T createInstance(
    ReferenceChannelManager manager,
    List<Object?> arguments,
  );

  /// Invoke a static method on [referenceType].
  Object? invokeStaticMethod(
    ReferenceChannelManager manager,
    String methodName,
    List<Object?> arguments,
  );

  /// Invoke a method on the object instance represented by [localReference].
  Object? invokeMethod(
    ReferenceChannelManager manager,
    T instance,
    String methodName,
    List<Object?> arguments,
  );

  /// Dispose [localReference] and the value it represents.
  ///
  /// This also stops the [ReferencePairManager] from maintaining the connection
  /// with its paired [PairedReference] and will allow for either value to be
  /// attached to new references.
  void onInstanceDisposed(
    ReferenceChannelManager manager,
    T instance,
  ) {}
}

// TODO: define (reference channel) (reference pair)
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

  bool isPaired(Object? instance) {
    if (instance == null) return false;
    return _referencePairs.getPairedRemoteReference(instance) != null;
  }

  void registerHandler(String channelName, ReferenceChannelHandler handler) {
    _channelHandlers[channelName] = handler;
  }

  ReferenceChannelHandler? getChannelHandler(String channelName) {
    return _channelHandlers[channelName];
  }

  /// Create a new [LocalReference] to be paired with [PairedReference].
  ///
  /// This is typically called when a remote [RemoteReferenceMap] wants to
  /// create a [PairedReference].
  ///
  /// This will instantiate a new [LocalReference] and add it and
  /// [remoteReference] as a pair.
  ///
  /// This method uses [ReferenceConverter.convertForLocalManager] to convert
  /// [arguments].
  ///
  /// Returns `null` if a pair with [remoteReference] has already been added.
  /// Otherwise, it returns the paired [LocalReference].
  Object? onReceiveCreateNewPair(
    String channelName,
    PairedReference remoteReference,
    List<Object?> arguments,
  ) {
    if (_referencePairs.getPairedObject(remoteReference) != null) return null;

    final Object object = getChannelHandler(channelName)!.createInstance(
      this,
      converter.convertForLocalManager(this, arguments)! as List<Object?>,
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
  Object? onReceiveInvokeStaticMethod(
    String channelName,
    String methodName,
    List<Object?> arguments,
  ) {
    final Object? result = getChannelHandler(channelName)!.invokeStaticMethod(
      this,
      methodName,
      converter.convertForLocalManager(this, arguments)! as List<Object?>,
    );

    return converter.convertForRemoteManager(this, result);
  }

  UnpairedReference? createUnpairedReference(
    String channelName,
    Object object,
  ) {
    final ReferenceChannelHandler? handler = getChannelHandler(channelName);
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
  Object? onReceiveInvokeMethod(
    String channelName,
    PairedReference remoteReference,
    String methodName,
    List<Object?> arguments,
  ) {
    final Object? result = getChannelHandler(channelName)!.invokeMethod(
      this,
      _referencePairs.getPairedObject(remoteReference)!,
      methodName,
      converter.convertForLocalManager(this, arguments)! as List<Object?>,
    );

    return converter.convertForRemoteManager(this, result);
  }

  /// Creates a [LocalReference] from [unpairedReference] and invoke a method.
  ///
  /// This method uses [ReferenceConverter.convertForLocalManager] to convert
  /// [arguments] and [ReferenceConverter.convertForRemoteManager] to convert
  /// the result.
  Object? onReceiveInvokeMethodOnUnpairedReference(
    UnpairedReference unpairedReference,
    String methodName,
    List<Object?> arguments,
  ) {
    final Object? result =
        getChannelHandler(unpairedReference.channelName)!.invokeMethod(
      this,
      getChannelHandler(unpairedReference.channelName)!.createInstance(
        this,
        converter.convertForLocalManager(
          this,
          unpairedReference.creationArguments,
        )! as List<Object?>,
      ),
      methodName,
      converter.convertForLocalManager(this, arguments)! as List<Object?>,
    );

    return converter.convertForRemoteManager(this, result);
  }

  /// Removes the [Reference] pair containing [remoteReference] from this [RemoteReferenceMap].
  ///
  /// Typically called when a remote [RemoteReferenceMap] wants to dispose
  /// their [PairedReference].
  ///
  /// This will remove [remoteReference] and its paired [LocalReference] from
  /// this [RemoteReferenceMap].
  void onReceiveDisposePair(
    String channelName,
    PairedReference remoteReference,
  ) {
    final Object? instance = _referencePairs.getPairedObject(remoteReference);
    if (instance == null) return;

    _referencePairs.removePairWithObject(instance);
    getChannelHandler(channelName)!.onInstanceDisposed(this, instance);
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
/// it converts [Reference]s to their paired [LocalReference]/[PairedReference]
/// or creates a new [UnpairedReference].
///
/// See [StandardReferenceConverter].
mixin ReferenceConverter {
  /// Converts arguments to be used by a [PairedReference].
  ///
  /// A [RemoteReferenceMap] should use this when creating or invoking a
  /// method on a [PairedReference].
  Object? convertForRemoteManager(
    ReferenceChannelManager manager,
    Object? object,
  );

  /// Converts arguments to be used with a [LocalReference].
  ///
  /// A [RemoteReferenceMap] uses this when creating or invoking a method on
  /// a [LocalReference].
  Object? convertForLocalManager(
    ReferenceChannelManager manager,
    Object? object,
  );
}

/// Standard implementation of a [ReferenceConverter].
class StandardReferenceConverter implements ReferenceConverter {
  const StandardReferenceConverter();

  /// Converts arguments to be used with a [LocalReference].
  ///
  /// Conversions:
  ///   * Paired [LocalReference]s are converted to their paired [PairedReference].
  ///   * Unpaired [LocalReference]s are converted into [UnpairedReference].
  ///   * [List]s are converted to `List<dynamic>` and this method is applied to
  ///     each value within the list.
  ///   * [Map]s are converted to `Map<dynamic, dynamic>` and this method is
  ///     applied to each key and each value.
  @override
  Object? convertForRemoteManager(
    ReferenceChannelManager manager,
    Object? object,
  ) {
    if (manager.isPaired(object)) {
      return manager._referencePairs.getPairedRemoteReference(object!);
    } else if (!manager.isPaired(object) && object is Referencable) {
      return manager.createUnpairedReference(
        object.referenceChannel.name,
        object,
      );
    } else if (object is List) {
      return object
          .map<Object?>((_) => convertForRemoteManager(manager, _))
          .toList();
    } else if (object is Map) {
      return Map<Object?, Object?>.fromIterables(
        object.keys.map<Object?>((_) => convertForRemoteManager(manager, _)),
        object.values.map<Object?>((_) => convertForRemoteManager(manager, _)),
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
  ///   * [PairedReference]s are converted to their paired [LocalReference].
  ///   * [UnpairedReference]s are converted into unpaired [LocalReference]s.
  ///   * [List]s are converted to `List<dynamic>` and this method is applied to
  ///     each value within the list.
  ///   * [Map]s are converted to `Map<dynamic, dynamic>` and this method is
  ///     applied to each key and each value.
  @override
  Object? convertForLocalManager(
    ReferenceChannelManager manager,
    Object? object,
  ) {
    if (object is PairedReference) {
      return manager._referencePairs.getPairedObject(object);
    } else if (object is UnpairedReference) {
      return manager.getChannelHandler(object.channelName)!.createInstance(
            manager,
            convertForLocalManager(manager, object.creationArguments)!
                as List<Object?>,
          );
    } else if (object is List) {
      return object
          .map<Object?>((_) => convertForLocalManager(manager, _))
          .toList();
    } else if (object is Map) {
      return Map<Object?, Object?>.fromIterables(
        object.keys.map<Object?>((_) => convertForLocalManager(manager, _)),
        object.values.map<Object?>((_) => convertForLocalManager(manager, _)),
      );
    }

    return object;
  }
}
