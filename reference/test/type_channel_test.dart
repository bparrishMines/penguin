import 'package:flutter_test/flutter_test.dart';
import 'package:reference/reference.dart';

import 'test_classes.dart';

void main() {
  group('$TypeChannelMessenger', () {
    late TestMessenger testMessenger;

    setUp(() {
      testMessenger = TestMessenger();
    });

    test('onReceiveCreateNewPair', () {
      expect(
        testMessenger.onReceiveCreateNewInstancePair(
          'test_channel',
          const PairedInstance('test_id'),
          <Object>[],
        ),
        testMessenger.testHandler.testClassInstance,
      );
      expect(
        testMessenger.isPaired(testMessenger.testHandler.testClassInstance),
        isTrue,
      );
      expect(
        testMessenger.onReceiveCreateNewInstancePair(
          '',
          const PairedInstance('test_id'),
          <Object>[],
        ),
        isNull,
      );
    });

    test('onReceiveInvokeStaticMethod', () {
      expect(
        testMessenger.onReceiveInvokeStaticMethod(
          'test_channel',
          'aStaticMethod',
          <Object>[],
        ),
        'return_value',
      );
    });

    test('createUnpairedInstance', () {
      final NewUnpairedInstance unpairedReference =
          testMessenger.createUnpairedInstance(
        'test_channel',
        TestClass(testMessenger),
      )!;
      expect(unpairedReference.channelName, 'test_channel');
      expect(unpairedReference.creationArguments, isEmpty);
    });

    test('onReceiveInvokeMethod', () {
      testMessenger.onReceiveCreateNewInstancePair(
        'test_channel',
        const PairedInstance('test_id'),
        <Object>[],
      );

      expect(
        testMessenger.onReceiveInvokeMethod(
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
        testMessenger.onReceiveInvokeMethodOnUnpairedInstance(
          const NewUnpairedInstance('test_channel', <Object>[]),
          'aMethod',
          <Object>[],
        ),
        'return_value',
      );
    });

    test('onReceiveDisposePair', () {
      testMessenger.onReceiveCreateNewInstancePair(
        'test_channel',
        const PairedInstance('test_id'),
        <Object>[],
      );
      testMessenger.onReceiveDisposePair(
        'test_channel',
        const PairedInstance('test_id'),
      );
      expect(
        testMessenger.isPaired(testMessenger.testHandler.testClassInstance),
        isFalse,
      );
    });
  });

  group('$TypeChannel', () {
    late TestMessenger testMessenger;
    late TypeChannel<TestClass> testChannel;

    setUp(() {
      testMessenger = TestMessenger();
      testChannel = TypeChannel<TestClass>(testMessenger, 'test_channel');
    });

    test('createNewInstancePair', () {
      final TestClass testClass = TestClass(testMessenger);

      expect(
        testChannel.createNewInstancePair(testClass),
        completion(const PairedInstance('test_instance_id')),
      );
      expect(testMessenger.isPaired(testClass), isTrue);

      expect(testChannel.createNewInstancePair(testClass), completion(isNull));
      expect(testMessenger.isPaired(testClass), isTrue);

      expect(
        testChannel.createNewInstancePair(testClass, owner: Object()),
        completion(isNull),
      );
      expect(testMessenger.isPaired(testClass), isTrue);
    });

    test('invokeStaticMethod', () {
      expect(
        testChannel.invokeStaticMethod('aStaticMethod', <Object>[]),
        completion('return_value'),
      );
    });

    test('invokeMethod', () {
      final TestClass testClass = TestClass(testMessenger);

      testChannel.createNewInstancePair(testClass);
      expect(
        testChannel.invokeMethod(testClass, 'aMethod', <Object>[]),
        completion('return_value'),
      );
    });

    test('invokeMethod on unpaired instance', () {
      expect(
        testChannel.invokeMethod(
          TestClass(testMessenger),
          'aMethod',
          <Object>[],
        ),
        completion('return_value'),
      );
    });

    test('disposeInstancePair', () {
      final testClass = TestClass(testMessenger);

      testChannel.createNewInstancePair(testClass);
      expect(testChannel.disposeInstancePair(testClass), completes);
      expect(testMessenger.isPaired(testClass), isFalse);

      expect(testChannel.disposeInstancePair(testClass), completes);

      final Object owner = Object();
      testChannel.createNewInstancePair(testClass, owner: owner);
      expect(testChannel.disposeInstancePair(testClass), completes);
      expect(testMessenger.isPaired(testClass), isTrue);

      expect(
        testChannel.disposeInstancePair(testClass, owner: owner),
        completes,
      );
      expect(testMessenger.isPaired(testClass), isFalse);
    });
  });
}
