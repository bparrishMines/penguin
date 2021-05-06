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

    test('convertInstances handles paired Object', () {
      testMessenger.onReceiveCreateNewInstancePair(
        'test_channel',
        const PairedInstance('test_id'),
        <Object>[],
        owner: true,
      );

      expect(
        converter.convertInstances(
          testMessenger.instanceManager,
          testMessenger.testHandler.testClassInstance,
        ),
        const PairedInstance('test_id'),
      );
    });

    test('convertInstances handles unpaired object', () {
      expect(
        converter.convertInstances(testMessenger.instanceManager, 'potato'),
        equals('potato'),
      );
    });

    test('convertPairedInstances handles $PairedInstance', () {
      const PairedInstance pairedInstance = PairedInstance('test_id');
      testMessenger.onReceiveCreateNewInstancePair(
        'test_channel',
        pairedInstance,
        <Object>[],
        owner: true,
      );

      expect(
        converter.convertPairedInstances(
          testMessenger.instanceManager,
          pairedInstance,
        ),
        testMessenger.testHandler.testClassInstance,
      );
    });

    test('convertPairedInstances handles unpaired object', () async {
      expect(
        converter.convertPairedInstances(
          testMessenger.instanceManager,
          'apple',
        ),
        equals('apple'),
      );
    });
  });
}
