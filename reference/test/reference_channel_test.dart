import 'package:flutter_test/flutter_test.dart';
import 'package:reference/reference.dart';

void main() {
  group('$ReferenceChannelManager', () {
    late TestManager testManager;

    setUp(() {
      testManager = TestManager();
    });

    test('onReceiveCreateNewPair', () {
      expect(
        testManager.onReceiveCreateNewPair(
          'test_channel',
          PairedReference('test_id'),
          <Object>[],
        ),
        testManager.testHandler.testClassInstance,
      );
      expect(
        testManager.isPaired(testManager.testHandler.testClassInstance),
        isTrue,
      );
      expect(
        testManager.onReceiveCreateNewPair(
          '',
          PairedReference('test_id'),
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

    test('createUnpairedReference', () {
      final UnpairedReference unpairedReference =
          testManager.createUnpairedReference(
        'test_channel',
        TestClass(testManager),
      )!;
      expect(unpairedReference.channelName, 'test_channel');
      expect(unpairedReference.creationArguments, isEmpty);
    });

    test('onReceiveInvokeMethod', () {
      testManager.onReceiveCreateNewPair(
        'test_channel',
        PairedReference('test_id'),
        <Object>[],
      );

      expect(
        testManager.onReceiveInvokeMethod(
          'test_channel',
          PairedReference('test_id'),
          'aMethod',
          <Object>[],
        ),
        'return_value',
      );
    });

    test('onReceiveInvokeMethodOnUnpairedReference', () {
      expect(
        testManager.onReceiveInvokeMethodOnUnpairedReference(
          UnpairedReference('test_channel', <Object>[]),
          'aMethod',
          <Object>[],
        ),
        'return_value',
      );
    });

    test('onReceiveDisposePair', () {
      testManager.onReceiveCreateNewPair(
        'test_channel',
        PairedReference('test_id'),
        <Object>[],
      );
      testManager.onReceiveDisposePair(
        'test_channel',
        PairedReference('test_id'),
      );
      expect(
        testManager.isPaired(testManager.testHandler.testClassInstance),
        isFalse,
      );
    });
  });

  group('$ReferenceChannel', () {
    late TestManager testManager;
    late ReferenceChannel<TestClass> testChannel;

    setUp(() {
      testManager = TestManager();
      testChannel = ReferenceChannel<TestClass>(testManager, 'test_channel');
    });

    test('createNewPair', () {
      final TestClass testClass = TestClass(testManager);

      expect(
        testChannel.createNewPair(testClass),
        completion(PairedReference('test_reference_id')),
      );
      expect(testChannel.createNewPair(testClass), completion(isNull));
    });

    test('invokeStaticMethod', () {
      expect(
        testChannel.invokeStaticMethod('aStaticMethod', <Object>[]),
        completion('return_value'),
      );
    });

    test('invokeMethod', () {
      final TestClass testClass = TestClass(testManager);

      testChannel.createNewPair(testClass);
      expect(
        testChannel.invokeMethod(testClass, 'aMethod', <Object>[]),
        completion('return_value'),
      );
    });

    test('invokeMethod on unpaired reference', () {
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

      testChannel.createNewPair(testClass);
      expect(testChannel.disposePair(testClass), completes);
      expect(testManager.isPaired(testClass), isFalse);
    });
  });
}

class TestManager extends ReferenceChannelManager {
  TestManager() {
    testHandler = TestHandler(this);
    registerHandler('test_channel', testHandler);
  }

  late final TestHandler testHandler;

  @override
  final TestMessenger messenger = TestMessenger();

  @override
  String generateUniqueReferenceId() {
    return 'test_reference_id';
  }
}

class TestHandler with ReferenceChannelHandler<TestClass> {
  TestHandler(TestManager manager) : testClassInstance = TestClass(manager);

  final TestClass testClassInstance;

  @override
  TestClass createInstance(
    ReferenceChannelManager manager,
    List<Object?> arguments,
  ) {
    return testClassInstance;
  }

  @override
  List<Object?> getCreationArguments(
    ReferenceChannelManager manager,
    TestClass instance,
  ) {
    return <Object?>[];
  }

  @override
  Object? invokeMethod(
    ReferenceChannelManager manager,
    TestClass instance,
    String methodName,
    List<Object?> arguments,
  ) {
    return 'return_value';
  }

  @override
  Object? invokeStaticMethod(
    ReferenceChannelManager manager,
    String methodName,
    List<Object?> arguments,
  ) {
    return 'return_value';
  }
}

class TestMessenger with ReferenceChannelMessenger {
  @override
  Future<void> sendCreateNewPair(String handlerChannel,
      PairedReference remoteReference, List<Object?> arguments) {
    return Future<void>.value();
  }

  @override
  Future<void> sendDisposePair(
      String channelName, PairedReference remoteReference) {
    return Future<void>.value();
  }

  @override
  Future<Object?> sendInvokeMethod(
    String handlerChannel,
    PairedReference remoteReference,
    String methodName,
    List<Object?> arguments,
  ) {
    return Future<String>.value('return_value');
  }

  @override
  Future<Object?> sendInvokeMethodOnUnpairedReference(
    UnpairedReference unpairedReference,
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

class TestClass with Referencable<TestClass> {
  TestClass(this.manager);

  final ReferenceChannelManager manager;

  @override
  ReferenceChannel<TestClass> get referenceChannel => ReferenceChannel(
        manager,
        'test_channel',
      );
}
