import 'package:reference/reference.dart';

class TestMessenger extends TypeChannelMessenger {
  TestMessenger() {
    testHandler = TestHandler(this);
    registerHandler('test_channel', testHandler);
  }

  late final TestHandler testHandler;

  @override
  final TestMessageDispatcher messageDispatcher = TestMessageDispatcher();

  @override
  final TestInstancePairManager instancePairManager = TestInstancePairManager();

  @override
  String generateUniqueInstanceId(Object instance) {
    return 'test_instance_id';
  }
}

class TestHandler with TypeChannelHandler<TestClass> {
  TestHandler(TypeChannelMessenger messenger)
      : testClassInstance = TestClass(messenger);

  final TestClass testClassInstance;

  @override
  TestClass createInstance(
    TypeChannelMessenger manager,
    List<Object?> arguments,
  ) {
    return testClassInstance;
  }

  @override
  List<Object?> getCreationArguments(
    TypeChannelMessenger manager,
    TestClass instance,
  ) {
    return <Object?>[];
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

class TestClass {
  TestClass(this.messenger);

  final TypeChannelMessenger messenger;
}

class TestInstancePairManager implements InstancePairManager {
  final Map<Object, String> instanceToInstanceId = <Object,String>{};
  final Map<String, Object> instanceIdToInstance = <String, Object>{};

  @override
  bool addPair(Object instance, String instanceId, {required bool owner}) {
    if (isPaired(true)) return false;
    instanceToInstanceId[instance] = instanceId;
    instanceIdToInstance[instanceId] = instance;
    return true;
  }

  @override
  Object? getInstance(String instanceId) {
    return instanceIdToInstance[instanceId];
  }

  @override
  String? getInstanceId(Object instance) {
    return instanceToInstanceId[instance];
  }

  @override
  bool isPaired(Object instance) {
    return instanceToInstanceId.containsKey(instance);
  }

  @override
  void removePair(String instanceId) {
    final Object? instance = instanceIdToInstance.remove(instanceId);
    instanceToInstanceId.remove(instance);
  }
}
