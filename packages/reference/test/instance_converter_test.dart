import 'package:flutter_test/flutter_test.dart';
import 'package:reference/reference.dart';

import 'test_classes.dart';

void main() {
  group('$StandardInstanceConverter', () {
    const StandardInstanceConverter converter = StandardInstanceConverter();
    late TestMessenger testMessenger;

    setUp(() {
      testMessenger = TestMessenger();
    });

    test('convertInstancesToPairedInstances handles paired Object', () {
      testMessenger.onReceiveCreateNewInstancePair(
        'test_channel',
        const PairedInstance('test_id'),
        <Object>[],
        owner: true,
      );

      expect(
        converter.convertInstancesToPairedInstances(
          testMessenger,
          testMessenger.testHandler.testClassInstance,
        ),
        const PairedInstance('test_id'),
      );
    });

    test('convertInstancesToPairedInstances handles unpaired object', () {
      expect(
        converter.convertInstancesToPairedInstances(testMessenger, 'potato'),
        equals('potato'),
      );
    });

    test('convertPairedInstancesToInstances handles $PairedInstance', () {
      const PairedInstance pairedInstance = PairedInstance('test_id');
      testMessenger.onReceiveCreateNewInstancePair(
        'test_channel',
        pairedInstance,
        <Object>[],
        owner: true,
      );

      expect(
        converter.convertPairedInstancesToInstances(testMessenger, pairedInstance),
        testMessenger.testHandler.testClassInstance,
      );
    });

    test('convertPairedInstancesToInstances handles unpaired object', () async {
      expect(
        converter.convertPairedInstancesToInstances(
          testMessenger,
          'apple',
        ),
        equals('apple'),
      );
    });
  });
}
