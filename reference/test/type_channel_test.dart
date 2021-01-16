import 'package:flutter_test/flutter_test.dart';
import 'package:reference/reference.dart';

void main() {
  group('$TypeChannelManager', () {
    late TestManager testManager;

    setUp(() {
      testManager = TestManager();
    });

    test('onReceiveCreateNewPair', () {
      expect(
        testManager.onReceiveCreateNewInstancePair(
          'test_channel',
          const PairedInstance('test_id'),
          <Object>[],
        ),
        testManager.testHandler.testClassInstance,
      );
      expect(
        testManager.isPaired(testManager.testHandler.testClassInstance),
        isTrue,
      );
      expect(
        testManager.onReceiveCreateNewInstancePair(
          '',
          const PairedInstance('test_id'),
          <Object>[],
        ),
        isNull,
      );
    });

    test('onReceiveInvokeStaticMethod', () {
      expect(
        testManager.onReceiveInvokeStaticMethod(
          'test_channel',
          'aStaticMethod',
          <Object>[],
        ),
        'return_value',
      );
    });

    test('createUnpairedInstance', () {
      final NewUnpairedInstance unpairedReference =
          testManager.createUnpairedInstance(
        'test_channel',
        TestClass(testManager),
      )!;
      expect(unpairedReference.channelName, 'test_channel');
      expect(unpairedReference.creationArguments, isEmpty);
    });

    test('onReceiveInvokeMethod', () {
      testManager.onReceiveCreateNewInstancePair(
        'test_channel',
        const PairedInstance('test_id'),
        <Object>[],
      );

      expect(
        testManager.onReceiveInvokeMethod(
          'test_channel',
          const PairedInstance('test_id'),
          'aMethod',
          <Object>[],
        ),
        'return_value',
      );
    });

    test('onReceiveInvokeMethodOnUnpairedInstance', () {
      expect(
        testManager.onReceiveInvokeMethodOnUnpairedInstance(
          const NewUnpairedInstance('test_channel', <Object>[]),
          'aMethod',
          <Object>[],
        ),
        'return_value',
      );
    });

    test('onReceiveDisposePair', () {
      testManager.onReceiveCreateNewInstancePair(
        'test_channel',
        const PairedInstance('test_id'),
        <Object>[],
      );
      testManager.onReceiveDisposePair(
        'test_channel',
        const PairedInstance('test_id'),
      );
      expect(
        testManager.isPaired(testManager.testHandler.testClassInstance),
        isFalse,
      );
    });
  });

  group('$TypeChannel', () {
    late TestManager testManager;
    late TypeChannel<TestClass> testChannel;

    setUp(() {
      testManager = TestManager();
      testChannel = TypeChannel<TestClass>(testManager, 'test_channel');
    });

    test('createNewPair', () {
      final TestClass testClass = TestClass(testManager);

      expect(
        testChannel.createNewInstancePair(testClass),
        completion(const PairedInstance('test_instance_id')),
      );
      expect(testChannel.createNewInstancePair(testClass), completion(isNull));
    });

    test('invokeStaticMethod', () {
      expect(
        testChannel.invokeStaticMethod('aStaticMethod', <Object>[]),
        completion('return_value'),
      );
    });

    test('invokeMethod', () {
      final TestClass testClass = TestClass(testManager);

      testChannel.createNewInstancePair(testClass);
      expect(
        testChannel.invokeMethod(testClass, 'aMethod', <Object>[]),
        completion('return_value'),
      );
    });

    test('invokeMethod on unpaired instance', () {
      expect(
        testChannel.invokeMethod(
          TestClass(testManager),
          'aMethod',
          <Object>[],
        ),
        completion('return_value'),
      );
    });

    test('disposePair', () {
      final testClass = TestClass(testManager);

      testChannel.createNewInstancePair(testClass);
      expect(testChannel.disposePair(testClass), completion(null));
      expect(testManager.isPaired(testClass), isFalse);
      // Test that this completes with second call.
      expect(testChannel.disposePair(testClass), completion(null));
    });
  });
}

class TestManager extends TypeChannelManager {
  TestManager() {
    testHandler = TestHandler(this);
    registerHandler('test_channel', testHandler);
  }

  late final TestHandler testHandler;

  @override
  final TestMessenger messenger = TestMessenger();

  @override
  String generateUniqueInstanceId() {
    return 'test_instance_id';
  }
}

class TestHandler with TypeChannelHandler<TestClass> {
  TestHandler(TestManager manager) : testClassInstance = TestClass(manager);

  final TestClass testClassInstance;

  @override
  TestClass createInstance(
    TypeChannelManager manager,
    List<Object?> arguments,
  ) {
    return testClassInstance;
  }

  @override
  List<Object?> getCreationArguments(
    TypeChannelManager manager,
    TestClass instance,
  ) {
    return <Object?>[];
  }

  @override
  Object? invokeMethod(
    TypeChannelManager manager,
    TestClass instance,
    String methodName,
    List<Object?> arguments,
  ) {
    return 'return_value';
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelManager manager,
    String methodName,
    List<Object?> arguments,
  ) {
    return 'return_value';
  }
}

class TestMessenger with TypeChannelMessenger {
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

class TestClass with PairableInstance<TestClass> {
  TestClass(this.manager);

  final TypeChannelManager manager;

  @override
  TypeChannel<TestClass> get typeChannel => TypeChannel<TestClass>(
        manager,
        'test_channel',
      );
}
