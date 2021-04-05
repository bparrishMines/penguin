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

    test('convertForRemoteMessenger handles paired Object', () {
      testMessenger.onReceiveCreateNewInstancePair(
        'test_channel',
        const PairedInstance('test_id'),
        <Object>[],
        owner: true,
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
        owner: true,
      );

      expect(
        converter.convertForLocalMessenger(testMessenger, pairedInstance),
        testMessenger.testHandler.testClassInstance,
      );
    });

    test('convertForLocalMessenger handles unpaired object', () async {
      expect(
        converter.convertForLocalMessenger(
          testMessenger,
          'apple',
        ),
        equals('apple'),
      );
    });
  });
}
