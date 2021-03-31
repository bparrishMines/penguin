import 'instance.dart';
import 'instance_converter.dart';
import 'instance_pair_manager.dart';

/// A named channel used to handle communication between platform types.
class TypeChannel<T extends Object> {
  /// Default constructor for [TypeChannel].
  TypeChannel(this.messenger, this.name);

  /// Manages instances created and disposed by this [TypeChannel].
  ///
  /// Also handles communication with other platform [TypeChannelMessenger]s.
  final TypeChannelMessenger messenger;

  /// The channel used to handle communication.
  final String name;

  /// Register a [TypeChannelHandler] for channel [name] in a [messenger].
  ///
  /// See [TypeChannelMessenger.registerHandler].
  void setHandler(TypeChannelHandler<T> handler) {
    messenger.registerHandler(name, handler);
  }

  /// Unregister a [TypeChannelHandler] for channel [name] in a [messenger].
  ///
  /// See [TypeChannelMessenger.registerHandler].
  void removeHandler() {
    messenger.unregisterHandler(name);
  }

  // /// Create a [NewUnpairedInstance] with a registered [TypeChannelHandler].
  // NewUnpairedInstance? createUnpairedInstance(T instance) {
  //   return messenger.createUnpairedInstance(name, instance);
  // }

  /// Creates a new [PairedInstance] to be paired with [instance].
  ///
  /// Sends a message to another [TypeChannelMessenger] to instantiate an
  /// object for [TypeChannel] with name: [name].
  ///
  /// Returns `null` if a pair with [instance] has already been added to
  /// messenger. Otherwise, it returns the paired [PairedInstance].
  ///
  /// Sends a message to another [TypeChannelMessenger] with
  /// [TypeChannelMessenger.messenger].
  Future<PairedInstance?> createNewInstancePair(
    T instance, {
    required bool owner,
  }) async {
    return messenger.sendCreateNewInstancePair(name, instance, owner: owner);
  }

  /// Invoke static method [methodName] on type channel of [name].
  ///
  /// Sends a message to another [TypeChannelMessenger] to invoke a static
  /// method on the [TypeChannelHandler] registered to [TypeChannel]
  /// with name: [name]. See [TypeChannelMessenger.registerHandler].
  ///
  /// Sends a message to another [TypeChannelMessenger] with
  /// [TypeChannelMessenger.messenger].
  Future<Object?> sendInvokeStaticMethod(
    String methodName,
    List<Object?> arguments,
  ) async {
    return messenger.sendInvokeStaticMethod(name, methodName, arguments);
  }

  /// Attempt to invoke a method on [PairedInstance] paired with [instance].
  ///
  /// If [instance] isn't paired, the method will be invoked on a
  /// [NewUnpairedInstance].
  ///
  /// Sends a message to another [TypeChannelMessenger] with
  /// [TypeChannelMessenger.messenger].
  Future<Object?> sendInvokeMethod(
    T instance,
    String methodName,
    List<Object?> arguments,
  ) async {
    return messenger.sendInvokeMethod(name, instance, methodName, arguments);
  }

  // /// Dispose the instance pair containing [instance].
  // ///
  // /// Sends a message to another [TypeChannelMessenger] with
  // /// [TypeChannelMessenger.messenger].
  // Future<void> disposeInstancePair(T instance, {Object? owner}) async {
  //   return messenger.disposeInstancePair(name, instance, owner: owner);
  // }
}

/// Handles sending messages for a [TypeChannelMessenger].
///
/// This class handles sending messages to other [TypeChannelMessenger]s to
/// create, dispose, or invoke methods across type channels.
mixin TypeChannelMessageDispatcher {
  /// Instantiate a new object instance for type channel of [channelName].
  Future<void> sendCreateNewInstancePair(
    String channelName,
    PairedInstance pairedInstance,
    List<Object?> arguments, {
    required bool owner,
  });

  /// Invoke a static method for type channel of [channelName].
  Future<Object?> sendInvokeStaticMethod(
    String channelName,
    String methodName,
    List<Object?> arguments,
  );

  /// Invoke a method on the object instance that [pairedInstance] represents.
  Future<Object?> sendInvokeMethod(
    String channelName,
    PairedInstance pairedInstance,
    String methodName,
    List<Object?> arguments,
  );

  // /// Instantiate [unpairedInstance] and invoke a method on the instance.
  // Future<Object?> sendInvokeMethodOnUnpairedInstance(
  //   NewUnpairedInstance unpairedInstance,
  //   String methodName,
  //   List<Object?> arguments,
  // );

  // /// Dispose the pair that contains [pairedInstance].
  // Future<void> sendDisposePair(
  //   String channelName,
  //   PairedInstance pairedInstance,
  // );
}

/// Handles receiving messages for a type channel.
mixin TypeChannelHandler<T extends Object> {
  /// Retrieves arguments to instantiate an object for a type channel.
  List<Object?> getCreationArguments(
    TypeChannelMessenger messenger,
    T instance,
  );

  /// Instantiates a new object with [arguments].
  T createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  );

  /// Invoke a static method for a type channel.
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  );

  /// Invoke a method on [instance] for a type channel.
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    T instance,
    String methodName,
    List<Object?> arguments,
  );

  // /// Called when an object and a new [PairedInstance] is added to a [TypeChannelMessenger].
  // void onInstanceAdded(TypeChannelMessenger messenger, T instance) {}
  //
  // /// Called when an object and its paired [PairedInstance] is removed from a [TypeChannelMessenger].
  // void onInstanceRemoved(
  //   TypeChannelMessenger messenger,
  //   T instance,
  // ) {}
}

/// Stores instance pairs and handles communication for [TypeChannel]s.
///
/// Type channels allow for types/classes of different languages to communicate
/// (e.g. a `Camera` class in Dart may want to communicate with a `Camera` class
/// in Java). The `Camera` class in Dart may want to control when the Java
/// `Camera` class should call a static method, instantiate a new instance, or
/// call methods on that instance.
///
/// To control specific instances for a type channel, this class pairs Dart
/// instances to instances in another language (e.g. Java/Obj-c). A paired
/// object then acts as the key to communicate with it's paired object in
/// another language and can be used to represent its paired instance when
/// passed as an argument.
///
/// TypeChannelManager 1           TypeChannelManager 2
/// |------------------|           |------------------|
/// |  Dart Instances  |<--------->|  Java Instances  |
/// |------------------|           |------------------|
///
/// - A visual representation of communicating [TypeChannelMessenger]s.
abstract class TypeChannelMessenger {
  final Map<String, TypeChannelHandler> _channelHandlers =
      <String, TypeChannelHandler>{};
  final InstancePairManager _instancePairManager = InstancePairManager.instance;

  bool _addPair(
    Object instance,
    PairedInstance pairedInstance, {
    required bool owner,
  }) {
    return _instancePairManager.addPair(
      instance,
      pairedInstance.instanceId,
      owner: owner,
    );
  }

  // bool _addInstancePair({
  //   required String channelName,
  //   required Object instance,
  //   required PairedInstance pairedInstance,
  //   required Object owner,
  // }) {
  //   if (_instancePairManager.addPair(instance, pairedInstance, owner: owner)) {
  //     getChannelHandler(channelName)?.onInstanceAdded(this, instance);
  //     return true;
  //   }
  //   return false;
  // }
  //
  // bool _removeInstancePair({
  //   required String channelName,
  //   required Object instance,
  //   required Object owner,
  //   bool force = false,
  // }) {
  //   if (_instancePairManager.removePairWithObject(
  //     instance,
  //     owner: owner,
  //     force: force,
  //   )) {
  //     getChannelHandler(channelName)?.onInstanceRemoved(this, instance);
  //     return true;
  //   }
  //
  //   return false;
  // }

  /// Dispatches send messages to other [TypeChannelMessenger]s.
  TypeChannelMessageDispatcher get messageDispatcher;

  /// Attempts to convert objects to [PairedInstance]s or [NewUnpairedInstance]s and vice-versa.
  InstanceConverter get converter => const StandardInstanceConverter();

  /// Whether [instance] is paired with a [PairedInstance].
  bool isPaired(Object instance) {
    return _instancePairManager.isPaired(instance);
  }

  /// Retrieve the [PairedInstanced] paired to [instance].
  ///
  /// Returns `null` if [instance] is not paired.
  PairedInstance? getPairedPairedInstance(Object instance) {
    final String? instanceId = _instancePairManager.getInstanceId(instance);
    return instanceId == null ? null : PairedInstance(instanceId);
  }

  /// Retrieve the `Object` paired to [pairedInstance].
  ///
  /// Returns `null` is [pairedInstance] is not paired.
  Object? getPairedObject(PairedInstance pairedInstance) {
    return _instancePairManager.getObject(pairedInstance.instanceId);
  }

  /// Set a [TypeChannelHandler] for a type channel with [channelName].
  void registerHandler(String channelName, TypeChannelHandler handler) {
    _channelHandlers[channelName] = handler;
  }

  /// Removes a [TypeChannelHandler] for the type channel of [channelName].
  void unregisterHandler(String channelName) {
    _channelHandlers.remove(channelName);
  }

  /// Retrieve the registered [TypeChannelHandler] for a type channel.
  TypeChannelHandler? getChannelHandler(String channelName) {
    return _channelHandlers[channelName];
  }

  /// Create a new [PairedInstance] to be paired with [instance].
  ///
  /// Also sends a message to another [TypeChannelMessenger] to instantiate an
  /// object for [TypeChannel] with name: [channelName].
  ///
  /// Returns `null` if a pair with [instance] has already been added to
  /// messenger. Otherwise, it returns the paired [PairedInstance].
  ///
  /// Sends a message to another [TypeChannelMessenger] with
  /// [messageDispatcher].
  Future<PairedInstance?> sendCreateNewInstancePair(
    String channelName,
    Object instance, {
    required bool owner,
  }) async {
    final PairedInstance pairedInstance = PairedInstance(
      generateUniqueInstanceId(instance),
    );

    final TypeChannelHandler? handler = getChannelHandler(channelName);
    if (handler == null) {
      throw ArgumentError(
        'A `TypeChannelHandler` must be set for channel of: $channelName.',
      );
    }

    // final bool createdNewInstance = _addInstancePair(
    //   channelName: channelName,
    //   instance: instance,
    //   pairedInstance: pairedInstance,
    //   owner: owner ?? instance,
    // );

    if (!_addPair(instance, pairedInstance, owner: owner)) return null;

    await messageDispatcher.sendCreateNewInstancePair(
      channelName,
      pairedInstance,
      converter.convertForRemoteMessenger(
        this,
        handler.getCreationArguments(this, instance),
      )! as List<Object?>,
      owner: !owner,
    );

    return pairedInstance;
  }

  /// Invoke static method [methodName] on type channel of [channelName].
  ///
  /// Also sends a message to another [TypeChannelMessenger] to invoke a static
  /// method on the [TypeChannelHandler] registered to [TypeChannel]
  /// with name: [name]. See [TypeChannelMessenger.registerHandler].
  ///
  /// Sends a message to another [TypeChannelMessenger] with
  /// [messageDispatcher].
  Future<Object?> sendInvokeStaticMethod(
    String channelName,
    String methodName,
    List<Object?> arguments,
  ) async {
    final Object? result = await messageDispatcher.sendInvokeStaticMethod(
      channelName,
      methodName,
      converter.convertForRemoteMessenger(this, arguments)! as List<Object?>,
    );

    return converter.convertForLocalMessenger(this, result);
  }

  /// Send a message to invoke a method on [PairedInstance] paired with [instance].
  ///
  /// If [instance] isn't paired, the method will be invoked on a
  /// [NewUnpairedInstance].
  ///
  /// Sends a message to another [TypeChannelMessenger] with
  /// [messageDispatcher].
  Future<Object?> sendInvokeMethod(
    String channelName,
    Object instance,
    String methodName,
    List<Object?> arguments,
  ) async {
    // if (!isPaired(instance)) {
    //   return _sendInvokeMethodOnUnpairedInstance(
    //     channelName,
    //     instance,
    //     methodName,
    //     arguments,
    //   );
    // }

    final Object? result = await messageDispatcher.sendInvokeMethod(
      channelName,
      getPairedPairedInstance(instance)!,
      methodName,
      converter.convertForRemoteMessenger(this, arguments)! as List<Object?>,
    );

    return converter.convertForLocalMessenger(this, result);
  }

  // Future<Object?> _sendInvokeMethodOnUnpairedInstance(
  //   String channelName,
  //   Object object,
  //   String methodName,
  //   List<Object?> arguments,
  // ) async {
  //   final Object? result =
  //       await messageDispatcher.sendInvokeMethodOnUnpairedInstance(
  //     createUnpairedInstance(channelName, object)!,
  //     methodName,
  //     converter.convertForRemoteMessenger(this, arguments)! as List<Object?>,
  //   );
  //
  //   return converter.convertForLocalMessenger(this, result);
  // }

  // /// Dispose the instance pair containing [instance].
  // ///
  // /// Sends a message to another [TypeChannelMessenger] with
  // /// [messageDispatcher].
  // Future<void> disposeInstancePair(
  //   String channelName,
  //   Object instance, {
  //   Object? owner,
  // }) async {
  //   if (!isPaired(instance)) return;
  //
  //   final PairedInstance pairedInstance = getPairedPairedInstance(instance)!;
  //   if (_removeInstancePair(
  //     channelName: channelName,
  //     instance: instance,
  //     owner: owner ?? instance,
  //   )) {
  //     return messageDispatcher.sendDisposePair(channelName, pairedInstance);
  //   }
  // }

  /// Create and store a new instance pair for a type channel.
  ///
  /// Returns `null` if a pair with [pairedInstance] has already been added.
  /// Otherwise, it returns the paired object.
  Object? onReceiveCreateNewInstancePair(
    String channelName,
    PairedInstance pairedInstance,
    List<Object?> arguments, {
    required bool owner,
  }) {
    if (getPairedObject(pairedInstance) != null) return null;

    final TypeChannelHandler? handler = getChannelHandler(channelName);
    if (handler == null) {
      throw ArgumentError(
        'A `TypeChannelHandler` must be set for channel of: $channelName.',
      );
    }

    final Object instance = handler.createInstance(
      this,
      converter.convertForLocalMessenger(this, arguments)! as List<Object?>,
    );

    assert(!isPaired(instance));

    // _addInstancePair(
    //   channelName: channelName,
    //   instance: instance,
    //   pairedInstance: pairedInstance,
    //   owner: instance,
    // );
    _addPair(instance, pairedInstance, owner: owner);
    return instance;
  }

  /// Invoke a static method for a type channel.
  Object? onReceiveInvokeStaticMethod(
    String channelName,
    String methodName,
    List<Object?> arguments,
  ) {
    final Object? result = getChannelHandler(channelName)!.invokeStaticMethod(
      this,
      methodName,
      converter.convertForLocalMessenger(this, arguments)! as List<Object?>,
    );

    return converter.convertForRemoteMessenger(this, result);
  }

  // /// Create a [NewUnpairedInstance] for a type channel.
  // ///
  // /// Returns `null` if no such handler exists for a type channel of name:
  // /// [channelName].
  // NewUnpairedInstance? createUnpairedInstance(
  //   String channelName,
  //   Object instance,
  // ) {
  //   final TypeChannelHandler? handler = getChannelHandler(channelName);
  //   if (handler == null) return null;
  //
  //   return NewUnpairedInstance(
  //     channelName,
  //     handler.getCreationArguments(this, instance),
  //   );
  // }

  /// Invoke a method on [pairedInstance] for a type channel.
  Object? onReceiveInvokeMethod(
    String channelName,
    PairedInstance pairedInstance,
    String methodName,
    List<Object?> arguments,
  ) {
    final Object? result = getChannelHandler(channelName)!.invokeMethod(
      this,
      getPairedObject(pairedInstance)!,
      methodName,
      converter.convertForLocalMessenger(this, arguments)! as List<Object?>,
    );

    return converter.convertForRemoteMessenger(this, result);
  }

  /// Instantiate an object from [unpairedInstance] and invoke a method.
  Object? onReceiveInvokeMethodOnUnpairedInstance(
    NewUnpairedInstance unpairedInstance,
    String methodName,
    List<Object?> arguments,
  ) {
    final Object? result =
        getChannelHandler(unpairedInstance.channelName)!.invokeMethod(
      this,
      getChannelHandler(unpairedInstance.channelName)!.createInstance(
        this,
        converter.convertForLocalMessenger(
          this,
          unpairedInstance.creationArguments,
        )! as List<Object?>,
      ),
      methodName,
      converter.convertForLocalMessenger(this, arguments)! as List<Object?>,
    );

    return converter.convertForRemoteMessenger(this, result);
  }

  // /// Dispose of the pair containing [pairedInstance].
  // void onReceiveDisposeInstancePair(
  //   String channelName,
  //   PairedInstance pairedInstance,
  // ) {
  //   final Object? instance = getPairedObject(pairedInstance);
  //   if (instance == null) return;
  //
  //   _removeInstancePair(
  //     channelName: channelName,
  //     instance: instance,
  //     owner: instance,
  //     force: true,
  //   );
  // }

  /// Generate a new unique instance id for a [PairedInstance].
  String generateUniqueInstanceId(Object instance) {
    return instance.hashCode.toString();
  }
}
