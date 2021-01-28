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
  Future<void> sendCreateNewInstancePair(String handlerChannel,
      PairedInstance remoteReference, List<Object?> arguments) {
    return Future<void>.value();
  }

  @override
  Future<void> sendDisposePair(
      String channelName, PairedInstance remoteReference) {
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
  Future<Object?> sendInvokeMethodOnUnpairedInstance(
    NewUnpairedInstance unpairedReference,
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
}

class TestClass with ReferenceType<TestClass> {
  TestClass(this.manager);

  final TypeChannelMessenger manager;

  @override
  TypeChannel<TestClass> get typeChannel => TypeChannel<TestClass>(
        manager,
        'test_channel',
      );
}
