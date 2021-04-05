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
          owner: true,
        ),
        testMessenger.testHandler.testClassInstance,
      );
      expect(
        testMessenger.isPaired(testMessenger.testHandler.testClassInstance),
        isTrue,
      );
      expect(
        () => testMessenger.onReceiveCreateNewInstancePair(
          '',
          const PairedInstance('test_id'),
          <Object>[],
          owner: true,
        ),
        throwsAssertionError,
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

    test('onReceiveInvokeMethod', () {
      testMessenger.onReceiveCreateNewInstancePair(
        'test_channel',
        const PairedInstance('test_id'),
        <Object>[],
        owner: true,
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
        testChannel.createNewInstancePair(
          testClass,
          owner: true,
        ),
        completion(const PairedInstance('test_instance_id')),
      );
      expect(testMessenger.isPaired(testClass), isTrue);

      expect(
        testChannel.createNewInstancePair(testClass, owner: true),
        completion(isNull),
      );
      expect(testMessenger.isPaired(testClass), isTrue);

      expect(
        testChannel.createNewInstancePair(testClass, owner: true),
        completion(isNull),
      );
      expect(testMessenger.isPaired(testClass), isTrue);
    });

    test('invokeStaticMethod', () {
      expect(
        testChannel.sendInvokeStaticMethod('aStaticMethod', <Object>[]),
        completion('return_value'),
      );
    });

    test('invokeMethod', () {
      final TestClass testClass = TestClass(testMessenger);

      testChannel.createNewInstancePair(testClass, owner: true);
      expect(
        testChannel.sendInvokeMethod(testClass, 'aMethod', <Object>[]),
        completion('return_value'),
      );
    });
  });
}
