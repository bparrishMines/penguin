import 'package:flutter_test/flutter_test.dart';
import 'package:reference/reference.dart';

import 'reference_matchers.dart';
import 'test_classes.dart';

void main() {
  group('$StandardInstanceConverter', () {
    const StandardInstanceConverter converter = StandardInstanceConverter();
    late TestMessenger testMessenger;

    setUp(() {
      testMessenger = TestMessenger();
    });

    test('convertForRemoteMessenger handles paired Object', () {
      testMessenger.onReceiveCreateNewInstancePair(
        'test_channel',
        const PairedInstance('test_id'),
        <Object>[],
      );

      expect(
        converter.convertForRemoteMessenger(
          testMessenger,
          testMessenger.testHandler.testClassInstance,
        ),
        const PairedInstance('test_id'),
      );
    });

    test('convertForRemoteMessenger handles unpaired object', () {
      expect(
        converter.convertForRemoteMessenger(
            testMessenger, TestClass(testMessenger)),
        isUnpairedInstance('test_channel', <Object>[]),
      );
    });

    test('convertForRemoteMessenger handles unpaired non-$ReferenceType', () {
      expect(
        converter.convertForRemoteMessenger(testMessenger, 'potato'),
        equals('potato'),
      );
    });

    test('convertForLocalMessenger handles $PairedInstance', () {
      const PairedInstance pairedInstance = PairedInstance('test_id');
      testMessenger.onReceiveCreateNewInstancePair(
        'test_channel',
        pairedInstance,
        <Object>[],
      );

      expect(
        converter.convertForLocalMessenger(testMessenger, pairedInstance),
        testMessenger.testHandler.testClassInstance,
      );
    });

    test('convertForLocalMessenger handles $NewUnpairedInstance', () async {
      expect(
        converter.convertForLocalMessenger(
          testMessenger,
          const NewUnpairedInstance('test_channel', <Object>[]),
        ),
        testMessenger.testHandler.testClassInstance,
      );
    });
  });
}
