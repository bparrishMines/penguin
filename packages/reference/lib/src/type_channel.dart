import 'instance.dart';
import 'instance_converter.dart';
import 'instance_manager.dart';

/// A named channel used to handle communication between platform types.
class TypeChannel<T extends Object> {
  /// Default constructor for [TypeChannel].
  TypeChannel(this.messenger, this.name);

  /// Handles communication and manages instances for type channels.
  final TypeChannelMessenger messenger;

  /// The name of the channel.
  final String name;

  /// Register a [TypeChannelHandler] for channel with [name] in [messenger].
  ///
  /// See [TypeChannelMessenger.registerHandler].
  void setHandler(TypeChannelHandler<T> handler) {
    messenger.registerHandler(name, handler);
  }

  /// Unregister a [TypeChannelHandler] for channel with [name] in [messenger].
  ///
  /// See [TypeChannelMessenger.unregisterHandler].
  void removeHandler() {
    messenger.unregisterHandler(name);
  }

  /// Creates a new [PairedInstance] to be paired with [instance].
  ///
  /// Sends a message to another [TypeChannelMessenger] to instantiate an
  /// object for [TypeChannel] with named with [name].
  ///
  /// Returns `null` if a pair with [instance] has already been added to
  /// [messenger]. Otherwise, it returns the paired [PairedInstance].
  Future<PairedInstance?> createNewInstancePair(
    T instance,
    List<Object?> arguments, {
    required bool owner,
  }) {
    return messenger.createNewInstancePair(
      name,
      instance,
      arguments,
      owner: owner,
    );
  }

  /// Invoke static method [methodName] on type channel of [name].
  ///
  /// Sends a message to another [TypeChannelMessenger] to invoke a static
  /// method on the [TypeChannelHandler] registered to [TypeChannel]
  /// of [name]. See [TypeChannelMessenger.registerHandler].
  Future<Object?> sendInvokeStaticMethod(
    String methodName,
    List<Object?> arguments,
  ) {
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
  ) {
    return messenger.sendInvokeMethod(name, instance, methodName, arguments);
  }

  /// Removes an instance pair containing [instance] from [messenger].
  Future<void> disposeInstancePair(T instance) {
    return messenger.disposeInstancePair(instance);
  }
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

  /// Communicate to another [TypeChannelMessenger] to dispose the instance pair containing [pairedInstance].
  Future<void> sendDisposeInstancePair(PairedInstance pairedInstance);
}

/// Handles receiving messages and retrieving type arguments for a type channel.
mixin TypeChannelHandler<T extends Object> {
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
/// instances to instances in another language (e.g. Java/Obj-c). This API
/// refers to this as an instance pair.
///
/// A paired object then acts as the key to communicate with it's paired object
/// in another language and can be used to represent its paired instance when
/// passed as an argument.
///
/// TypeChannelMessenger 1         TypeChannelMessenger 2
/// |------------------|           |------------------|
/// |  Dart Instances  |<--------->|  Java Instances  |
/// |------------------|           |------------------|
///
/// - A visual representation of communicating [TypeChannelMessenger]s.
abstract class TypeChannelMessenger {
  final Map<String, TypeChannelHandler> _channelHandlers =
      <String, TypeChannelHandler>{};
  late final InstanceManager _instanceManager = InstanceManager();

  /// Dispatches messages to other [TypeChannelMessenger]s.
  TypeChannelMessageDispatcher get messageDispatcher;

  /// Attempts to convert objects to [PairedInstance]s and vice-versa.
  InstanceConverter get converter => const StandardInstanceConverter();

  /// Maintains access to instances.
  InstanceManager get instanceManager => _instanceManager;

  void _addInstancePair({
    required Object instance,
    required String? instanceId,
    required bool owner,
  }) {
    if (owner && instanceId != null) {
      // Receiving weak reference
      instanceManager.addTemporaryStrongReference(
        instance: instance,
        instanceId: instanceId,
        onFinalize: (String instanceId) {
          messageDispatcher.sendDisposeInstancePair(PairedInstance(instanceId));
        },
      );
    } else if (owner && instanceId == null) {
      // Creating weak reference
      instanceManager.addWeakReference(
        instance: instance,
        onFinalize: (String instanceId) {
          messageDispatcher.sendDisposeInstancePair(PairedInstance(instanceId));
        },
      );
    } else {
      instanceManager.addStrongReference(instance: instance);
    }
  }

  /// Whether [instance] is paired with a [PairedInstance].
  bool isPaired(Object instance) {
    return instanceManager.containsInstance(instance);
  }

  /// Retrieve the [PairedInstance] paired to [instance].
  ///
  /// Returns `null` if [instance] is not paired.
  PairedInstance? getPairedPairedInstance(Object instance) {
    final String? instanceId = instanceManager.getInstanceId(instance);
    return instanceId == null ? null : PairedInstance(instanceId);
  }

  /// Retrieve the `Object` paired to [pairedInstance].
  ///
  /// Returns `null` is [pairedInstance] is not paired.
  Object? getPairedObject(PairedInstance pairedInstance) {
    return instanceManager.getInstance(pairedInstance.instanceId);
  }

  /// Sets a [TypeChannelHandler] for a type channel with [channelName].
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
  Future<PairedInstance?> createNewInstancePair(
    String channelName,
    Object instance,
    List<Object?> arguments, {
    required bool owner,
  }) async {
    if (isPaired(instance)) return null;

    _addInstancePair(instance: instance, instanceId: null, owner: owner);
    final PairedInstance pairedInstance = getPairedPairedInstance(instance)!;
    await messageDispatcher.sendCreateNewInstancePair(
      channelName,
      pairedInstance,
      converter.convertInstances(
        instanceManager,
        arguments,
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
  Future<Object?> sendInvokeStaticMethod(
    String channelName,
    String methodName,
    List<Object?> arguments,
  ) async {
    final Object? result = await messageDispatcher.sendInvokeStaticMethod(
      channelName,
      methodName,
      converter.convertInstances(instanceManager, arguments)! as List<Object?>,
    );

    return converter.convertPairedInstances(instanceManager, result);
  }

  /// Send a message to invoke a method on the [PairedInstance] paired with [instance].
  Future<Object?> sendInvokeMethod(
    String channelName,
    Object instance,
    String methodName,
    List<Object?> arguments,
  ) async {
    assert(isPaired(instance));

    final Object? result = await messageDispatcher.sendInvokeMethod(
      channelName,
      getPairedPairedInstance(instance)!,
      methodName,
      converter.convertInstances(instanceManager, arguments)! as List<Object?>,
    );

    return converter.convertPairedInstances(instanceManager, result);
  }

  /// Dispose the instance pair containing [instance].
  ///
  /// Sends a message to another [TypeChannelMessenger] with
  /// [messageDispatcher].
  Future<void> disposeInstancePair(Object instance) async {
    if (!isPaired(instance)) return;

    final PairedInstance pairedInstance = getPairedPairedInstance(instance)!;
    instanceManager.removeInstance(pairedInstance.instanceId);
    return messageDispatcher.sendDisposeInstancePair(pairedInstance);
  }

  /// Create and store a new instance pair for a type channel.
  ///
  /// Throw an assertion error if [pairedInstance] has already been added.
  /// Otherwise, it returns the paired object.
  Object? onReceiveCreateNewInstancePair(
    String channelName,
    PairedInstance pairedInstance,
    List<Object?> arguments, {
    required bool owner,
  }) {
    assert(
      getPairedObject(pairedInstance) == null,
      'An object with `PairedInstance` has already been created.',
    );

    final TypeChannelHandler? handler = getChannelHandler(channelName);
    if (handler == null) {
      throw ArgumentError(
        'A `TypeChannelHandler` must be set for channel of: $channelName.',
      );
    }

    final Object instance = handler.createInstance(
      this,
      converter.convertPairedInstances(instanceManager, arguments)!
          as List<Object?>,
    );

    assert(!isPaired(instance), '`$instance` has already been paired.');

    _addInstancePair(
      instance: instance,
      instanceId: pairedInstance.instanceId,
      owner: owner,
    );
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
      converter.convertPairedInstances(instanceManager, arguments)!
          as List<Object?>,
    );

    return converter.convertInstances(instanceManager, result);
  }

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
      converter.convertPairedInstances(instanceManager, arguments)!
          as List<Object?>,
    );

    return converter.convertInstances(instanceManager, result);
  }

  /// Dispose of the pair containing [pairedInstance].
  void onReceiveDisposeInstancePair(PairedInstance pairedInstance) {
    final Object? instance = getPairedObject(pairedInstance);
    assert(
      instance != null,
      'The Object with the following PairedInstance has already been disposed: $pairedInstance',
    );

    instanceManager.removeInstance(pairedInstance.instanceId);
  }
}
