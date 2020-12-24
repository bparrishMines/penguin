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
      manager.generateUniqueReferenceId(),
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

  /// Invoke a method on the object instance that [pairedReference] represents.
  Future<Object?> sendInvokeMethod(
    String channelName,
    PairedReference pairedReference,
    String methodName,
    List<Object?> arguments,
  );

  /// Instantiate [unpairedReference] and invoke a method on the instance.
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

/// Handles receiving messages for a reference channel.
mixin ReferenceChannelHandler<T extends Object> {
  /// Retrieves arguments to instantiate an object for a reference channel.
  List<Object?> getCreationArguments(
    ReferenceChannelManager manager,
    T instance,
  );

  /// Instantiates a object for a reference channel.
  T createInstance(
    ReferenceChannelManager manager,
    List<Object?> arguments,
  );

  /// Invoke a static method for a reference channel.
  Object? invokeStaticMethod(
    ReferenceChannelManager manager,
    String methodName,
    List<Object?> arguments,
  );

  /// Invoke a method an the object instance created by a reference channel.
  Object? invokeMethod(
    ReferenceChannelManager manager,
    T instance,
    String methodName,
    List<Object?> arguments,
  );

  /// Called when an object and its paired [PairedReference] is disposed.
  void onInstanceDisposed(
    ReferenceChannelManager manager,
    T instance,
  ) {}
}

// TODO: define (reference) (reference channel) (reference pair)
/// Stores reference pairs and handles communication for reference channels.
///
/// A reference is an object that represents another.
/// A reference pair are two objects that maintain equivalent states.
/// A reference channel is a channel
abstract class ReferenceChannelManager {
  static const String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final Random _rnd = Random();

  final Map<String, ReferenceChannelHandler> _channelHandlers =
      <String, ReferenceChannelHandler>{};

  final RemoteReferenceMap _referencePairs = RemoteReferenceMap();

  /// Handles sending messages to other [ReferenceChannelManager]s.
  ReferenceChannelMessenger get messenger;

  /// Handles conversion between objects and references.
  ReferenceConverter get converter => StandardReferenceConverter();

  /// Whether [instance] is paired with a [PairedReference].
  bool isPaired(Object? instance) {
    if (instance == null) return false;
    return _referencePairs.getPairedRemoteReference(instance) != null;
  }

  /// Set a [ReferenceChannelHandler] for a reference channel.
  void registerHandler(String channelName, ReferenceChannelHandler handler) {
    _channelHandlers[channelName] = handler;
  }

  /// Retrieve the registered [ReferenceChannelHandler] for a reference channel.
  ReferenceChannelHandler? getChannelHandler(String channelName) {
    return _channelHandlers[channelName];
  }

  /// Create and store a new reference pair for a reference channel.
  ///
  /// Returns `null` if a pair with [pairedReference] has already been added.
  /// Otherwise, it returns the paired object.
  Object? onReceiveCreateNewPair(
    String channelName,
    PairedReference pairedReference,
    List<Object?> arguments,
  ) {
    if (_referencePairs.getPairedObject(pairedReference) != null) return null;

    final Object object = getChannelHandler(channelName)!.createInstance(
      this,
      converter.convertForLocalManager(this, arguments)! as List<Object?>,
    );

    assert(!isPaired(object));

    _referencePairs.add(object, pairedReference);
    return object;
  }

  /// Invoke a static method for a reference channel.
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

  /// Create an [UnpairedReference] for a reference channel.
  /// 
  /// Returns `null` if no such handler exists for a reference channel of name:
  /// [channelName].
  UnpairedReference? createUnpairedReference(
    String channelName,
    Object instance,
  ) {
    final ReferenceChannelHandler? handler = getChannelHandler(channelName);
    if (handler == null) return null;

    return UnpairedReference(
      channelName,
      handler.getCreationArguments(this, instance),
    );
  }

  /// Invoke a method on [pairedReference] for a reference channel.
  Object? onReceiveInvokeMethod(
    String channelName,
    PairedReference pairedReference,
    String methodName,
    List<Object?> arguments,
  ) {
    final Object? result = getChannelHandler(channelName)!.invokeMethod(
      this,
      _referencePairs.getPairedObject(pairedReference)!,
      methodName,
      converter.convertForLocalManager(this, arguments)! as List<Object?>,
    );

    return converter.convertForRemoteManager(this, result);
  }

  /// Instantiate an object from [unpairedReference] and invoke a method.
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

  /// Dispose of the pair containing [pairedReference].
  void onReceiveDisposePair(
    String channelName,
    PairedReference pairedReference,
  ) {
    final Object? instance = _referencePairs.getPairedObject(pairedReference);
    if (instance == null) return;

    _referencePairs.removePairWithObject(instance);
    getChannelHandler(channelName)!.onInstanceDisposed(this, instance);
  }

  /// Generate a new unique reference id for a [PairedReference].
  String generateUniqueReferenceId() {
    return String.fromCharCodes(Iterable.generate(
      10,
      (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)),
    ));
  }
}

/// Handles converting references for a [ReferenceChannelManager].
///
/// See [StandardReferenceConverter].
mixin ReferenceConverter {
  /// Converts arguments to be used by a [PairedReference].
  Object? convertForRemoteManager(
    ReferenceChannelManager manager,
    Object? object,
  );

  /// Converts arguments to be used with a object paired to a [PairedReference].
  Object? convertForLocalManager(
    ReferenceChannelManager manager,
    Object? object,
  );
}

/// Standard implementation of [ReferenceConverter].
class StandardReferenceConverter implements ReferenceConverter {
  const StandardReferenceConverter();

  /// Converts arguments to be used with a remote [ReferenceChannelManager].
  ///
  /// Conversions:
  ///   * Objects paired in a [ReferenceChannelManager] are converted to their
  ///     paired [PairedReference].
  ///   * Unpaired references are converted into [UnpairedReference].
  ///   * [List]s are converted to `List<Object?>` and this method is applied to
  ///     each value within the list.
  ///   * [Map]s are converted to `Map<Object?, Object?>` and this method is
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

  /// Converts arguments to be used by a local [ReferenceChannelManager].
  ///
  /// Conversions:
  ///   * [PairedReference]s are converted to the object instance they're paired
  ///     to.
  ///   * [UnpairedReference]s are converted in to an instantiation using the
  ///     specified channel name.
  ///   * [List]s are converted to `List<Object?>` and this method is applied to
  ///     each value within the list.
  ///   * [Map]s are converted to `Map<Object?, Object?>` and this method is
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
