import 'package:reference/reference.dart';

class TestMessenger extends TypeChannelMessenger {
  TestMessenger() {
    registerHandler('test_channel', testHandler);
  }

  late final TestHandler testHandler = TestHandler();

  @override
  final TestMessageDispatcher messageDispatcher = TestMessageDispatcher();

  @override
  final TestInstanceManager instanceManager = TestInstanceManager();
}

class TestHandler with TypeChannelHandler<TestClass> {
  final TestClass testClassInstance = TestClass();

  @override
  TestClass createInstance(
    TypeChannelMessenger manager,
    List<Object?> arguments,
  ) {
    return testClassInstance;
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger manager,
    TestClass instance,
    String methodName,
    List<Object?> arguments,
  ) {
    return 'return_value';
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger manager,
    String methodName,
    List<Object?> arguments,
  ) {
    return 'return_value';
  }
}

class TestMessageDispatcher with TypeChannelMessageDispatcher {
  @override
  Future<void> sendCreateNewInstancePair(
    String handlerChannel,
    PairedInstance remoteReference,
    List<Object?> arguments, {
    required bool owner,
  }) {
    return Future<void>.value();
  }

  @override
  Future<Object?> sendInvokeMethod(
    String handlerChannel,
    PairedInstance remoteReference,
    String methodName,
    List<Object?> arguments,
  ) {
    return Future<String>.value('return_value');
  }

  @override
  Future<Object?> sendInvokeStaticMethod(
    String handlerChannel,
    String methodName,
    List<Object?> arguments,
  ) {
    return Future<String>.value('return_value');
  }

  @override
  Future<void> sendDisposeInstancePair(PairedInstance pairedInstance) {
    return Future<void>.value();
  }
}

class TestClass {}

class TestInstanceManager implements InstanceManager {
  final Map<Object, String> instanceToInstanceId = <Object, String>{};
  final Map<String, Object> instanceIdToInstance = <String, Object>{};

  @override
  Object? getInstance(String instanceId) {
    return instanceIdToInstance[instanceId];
  }

  @override
  String? getInstanceId(Object instance) {
    return instanceToInstanceId[instance];
  }

  @override
  bool containsInstance(Object instance) {
    return instanceToInstanceId.containsKey(instance);
  }

  @override
  void removeInstance(String instanceId) {
    final Object? instance = instanceIdToInstance.remove(instanceId);
    instanceToInstanceId.remove(instance);
  }

  @override
  bool addStrongReference({required Object instance, String? instanceId}) {
    if (containsInstance(true)) return false;

    final String newId = instanceId ?? generateUniqueInstanceId(instance);
    instanceToInstanceId[instance] = newId;
    instanceIdToInstance[newId] = instance;
    return true;
  }

  @override
  bool addWeakReference({
    required Object instance,
    String? instanceId,
    required void Function(String instanceId) onFinalize,
  }) {
    if (containsInstance(true)) return false;
    final String newId = instanceId ?? generateUniqueInstanceId(instance);
    return addStrongReference(instance: instance, instanceId: newId);
  }

  @override
  String generateUniqueInstanceId(Object instance) {
    return 'test_reference_id';
  }
}
