import 'dart:math';

import 'package:reference/reference.dart';

import 'instance.dart';
import 'paired_instance_map.dart';

/// A named channel used to handle communication between platform types.
class TypeChannel<T extends Object> {
  /// Default constructor for [TypeChannel].
  TypeChannel(this.manager, this.name);

  /// Manages instances created and disposed by this [TypeChannel].
  final TypeChannelManager manager;

  /// The channel used to handle communication.
  final String name;

  /// Register a [TypeChannelHandler] for channel [name] in a [manager].
  ///
  /// See [TypeChannelManager.registerHandler].
  void setHandler(TypeChannelHandler<T> handler) {
    manager.registerHandler(name, handler);
  }

  NewUnpairedInstance? createUnpairedInstance(T instance) {
    return manager.createUnpairedInstance(name, instance);
  }

  /// Creates a new [PairedInstance] to be paired with [instance].
  ///
  /// Sends a message to another [TypeChannelManager] to instantiate an
  /// object for [TypeChannel] with name: [name].
  ///
  /// Returns `null` if a pair with [instance] has already been added to
  /// manager. Otherwise, it returns the paired [PairedInstance].
  ///
  /// Sends a message to another [TypeChannelManager] with
  /// [TypeChannelManager.messenger].
  Future<PairedInstance?> createNewInstancePair(T instance) async {
    if (manager.isPaired(instance)) return null;

    final PairedInstance pairedInstance = PairedInstance(
      manager.generateUniqueInstanceId(),
    );

    manager._instancePairs.add(instance, pairedInstance);

    final TypeChannelHandler handler = manager.getChannelHandler(name)!;

    await manager.messenger.sendCreateNewInstancePair(
      name,
      pairedInstance,
      manager.converter.convertForRemoteManager(
        manager,
        handler.getCreationArguments(manager, instance),
      )! as List<Object?>,
    );

    return pairedInstance;
  }

  /// Invoke static method [methodName] on type channel of [name].
  ///
  /// Sends a message to another [TypeChannelManager] to invoke a static
  /// method on the [TypeChannelHandler] registered to [TypeChannel]
  /// with name: [name]. See [TypeChannelManager.registerHandler].
  ///
  /// Sends a message to another [TypeChannelManager] with
  /// [TypeChannelManager.messenger].
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

  /// Attempt to invoke a method on [PairedInstance] paired with [instance].
  ///
  /// If [instance] isn't paired, the method will be invoked on a
  /// [NewUnpairedInstance].
  ///
  /// Sends a message to another [TypeChannelManager] with
  /// [TypeChannelManager.messenger].
  Future<Object?> invokeMethod(
    T instance,
    String methodName,
    List<Object?> arguments,
  ) async {
    if (!manager.isPaired(instance)) {
      return _invokeMethodOnUnpairedInstance(instance, methodName, arguments);
    }

    final Object? result = await manager.messenger.sendInvokeMethod(
      name,
      manager._instancePairs.getPairedPairedInstance(instance)!,
      methodName,
      manager.converter.convertForRemoteManager(manager, arguments)!
          as List<Object?>,
    );

    return manager.converter.convertForLocalManager(manager, result);
  }

  Future<Object?> _invokeMethodOnUnpairedInstance(
    T object,
    String methodName,
    List<Object?> arguments,
  ) async {
    final Object? result =
        await manager.messenger.sendInvokeMethodOnUnpairedInstance(
      createUnpairedInstance(object)!,
      methodName,
      manager.converter.convertForRemoteManager(manager, arguments)!
          as List<Object?>,
    );

    return manager.converter.convertForLocalManager(manager, result);
  }

  /// Dispose the instance pair containing [instance].
  ///
  /// Sends a message to another [TypeChannelManager] with
  /// [TypeChannelManager.messenger].
  Future<void> disposePair(T instance) async {
    final PairedInstance? pairedInstance =
        manager._instancePairs.getPairedPairedInstance(instance);

    if (pairedInstance != null) {
      manager._instancePairs.removePairWithObject(instance);
      return manager.messenger.sendDisposePair(name, pairedInstance);
    }
  }
}

/// Handles sending messages for a [TypeChannelManager].
///
/// This class handles sending messages to other [TypeChannelManager]s to
/// create, dispose, or invoke methods across type channels.
mixin TypeChannelMessenger {
  /// Instantiate a new object instance for type channel of [channelName].
  Future<void> sendCreateNewInstancePair(
    String channelName,
    PairedInstance pairedInstance,
    List<Object?> arguments,
  );

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

  /// Instantiate [unpairedInstance] and invoke a method on the instance.
  Future<Object?> sendInvokeMethodOnUnpairedInstance(
    NewUnpairedInstance unpairedInstance,
    String methodName,
    List<Object?> arguments,
  );

  /// Dispose the pair that contains [pairedInstance].
  Future<void> sendDisposePair(
    String channelName,
    PairedInstance pairedInstance,
  );
}

/// Handles receiving messages for a type channel.
mixin TypeChannelHandler<T extends Object> {
  /// Retrieves arguments to instantiate an object for a type channel.
  List<Object?> getCreationArguments(
    TypeChannelManager manager,
    T instance,
  );

  /// Instantiates an object for a new instance pair.
  T createInstance(
    TypeChannelManager manager,
    List<Object?> arguments,
  );

  /// Invoke a static method for a type channel.
  Object? invokeStaticMethod(
    TypeChannelManager manager,
    String methodName,
    List<Object?> arguments,
  );

  /// Invoke a method on [instance] for a type channel.
  Object? invokeMethod(
    TypeChannelManager manager,
    T instance,
    String methodName,
    List<Object?> arguments,
  );

  /// Called when an object and its paired [PairedInstance] is removed from a [TypeChannelManager].
  void onInstanceDisposed(
    TypeChannelManager manager,
    T instance,
  ) {}
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
/// - A visual representation of communicating [TypeChannelManager]s.
abstract class TypeChannelManager {
  static const String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final Random _rnd = Random();

  final Map<String, TypeChannelHandler> _channelHandlers =
      <String, TypeChannelHandler>{};

  final PairedInstanceMap _instancePairs = PairedInstanceMap();

  /// Handles communicating to other [TypeChannelManager]s.
  TypeChannelMessenger get messenger;

  /// Attempts to convert objects to [PairedInstance]s or [NewUnpairedInstance]s and vice-versa.
  InstanceConverter get converter => const StandardInstanceConverter();

  /// Whether [instance] is paired with a [PairedInstance].
  bool isPaired(Object? instance) {
    if (instance == null) return false;
    return _instancePairs.getPairedPairedInstance(instance) != null;
  }

  /// Set a [TypeChannelHandler] for a type channel.
  void registerHandler(String channelName, TypeChannelHandler handler) {
    _channelHandlers[channelName] = handler;
  }

  /// Retrieve the registered [TypeChannelHandler] for a type channel.
  TypeChannelHandler? getChannelHandler(String channelName) {
    return _channelHandlers[channelName];
  }

  /// Create and store a new instance pair for a type channel.
  ///
  /// Returns `null` if a pair with [pairedInstance] has already been added.
  /// Otherwise, it returns the paired object.
  Object? onReceiveCreateNewInstancePair(
    String channelName,
    PairedInstance pairedInstance,
    List<Object?> arguments,
  ) {
    if (_instancePairs.getPairedObject(pairedInstance) != null) return null;

    final Object object = getChannelHandler(channelName)!.createInstance(
      this,
      converter.convertForLocalManager(this, arguments)! as List<Object?>,
    );

    assert(!isPaired(object));

    _instancePairs.add(object, pairedInstance);
    return object;
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
      converter.convertForLocalManager(this, arguments)! as List<Object?>,
    );

    return converter.convertForRemoteManager(this, result);
  }

  /// Create a [NewUnpairedInstance] for a type channel.
  ///
  /// Returns `null` if no such handler exists for a type channel of name:
  /// [channelName].
  NewUnpairedInstance? createUnpairedInstance(
    String channelName,
    Object instance,
  ) {
    final TypeChannelHandler? handler = getChannelHandler(channelName);
    if (handler == null) return null;

    return NewUnpairedInstance(
      channelName,
      handler.getCreationArguments(this, instance),
    );
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
      _instancePairs.getPairedObject(pairedInstance)!,
      methodName,
      converter.convertForLocalManager(this, arguments)! as List<Object?>,
    );

    return converter.convertForRemoteManager(this, result);
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
        converter.convertForLocalManager(
          this,
          unpairedInstance.creationArguments,
        )! as List<Object?>,
      ),
      methodName,
      converter.convertForLocalManager(this, arguments)! as List<Object?>,
    );

    return converter.convertForRemoteManager(this, result);
  }

  /// Dispose of the pair containing [pairedInstance].
  void onReceiveDisposePair(
    String channelName,
    PairedInstance pairedInstance,
  ) {
    final Object? instance = _instancePairs.getPairedObject(pairedInstance);
    if (instance == null) return;

    _instancePairs.removePairWithObject(instance);
    getChannelHandler(channelName)!.onInstanceDisposed(this, instance);
  }

  /// Generate a new unique reference id for a [PairedInstance].
  String generateUniqueInstanceId() {
    return String.fromCharCodes(Iterable.generate(
      10,
      (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)),
    ));
  }
}

/// Handles converting references for a [TypeChannelManager].
///
/// See [StandardInstanceConverter].
mixin InstanceConverter {
  /// Converts arguments to be used by a [PairedInstance].
  Object? convertForRemoteManager(
    TypeChannelManager manager,
    Object? object,
  );

  /// Converts arguments to be used with a object paired to a [PairedInstance].
  Object? convertForLocalManager(
    TypeChannelManager manager,
    Object? object,
  );
}

/// Standard implementation of [InstanceConverter].
class StandardInstanceConverter implements InstanceConverter {
  const StandardInstanceConverter();

  /// Converts arguments to be used with a remote [TypeChannelManager].
  ///
  /// Conversions:
  ///   * Objects paired in a [TypeChannelManager] are converted to their
  ///     paired [PairedInstance].
  ///   * Unpaired instances are converted into [NewUnpairedInstance].
  ///   * [List]s are converted to `List<Object?>` and this method is applied to
  ///     each value within the list.
  ///   * [Map]s are converted to `Map<Object?, Object?>` and this method is
  ///     applied to each key and each value.
  @override
  Object? convertForRemoteManager(
    TypeChannelManager manager,
    Object? object,
  ) {
    if (manager.isPaired(object)) {
      return manager._instancePairs.getPairedPairedInstance(object!);
    } else if (!manager.isPaired(object) && object is PairableInstance) {
      return manager.createUnpairedInstance(
        object.typeChannel.name,
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

  /// Converts arguments to be used by a local [TypeChannelManager].
  ///
  /// Conversions:
  ///   * [PairedInstance]s are converted to the object instance they're paired
  ///     to.
  ///   * [NewUnpairedInstance]s are converted in to an instantiation using the
  ///     specified channel name.
  ///   * [List]s are converted to `List<Object?>` and this method is applied to
  ///     each value within the list.
  ///   * [Map]s are converted to `Map<Object?, Object?>` and this method is
  ///     applied to each key and each value.
  @override
  Object? convertForLocalManager(
    TypeChannelManager manager,
    Object? object,
  ) {
    if (object is PairedInstance) {
      return manager._instancePairs.getPairedObject(object);
    } else if (object is NewUnpairedInstance) {
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
