import 'dart:io';

import 'package:test/test.dart';

void main() {
  group('penguin_generator', () {
    setUp(() {
      Process.runSync('flutter', <String>[
        'create',
        '--project-name="test_plugin"',
        '--no-with-driver-test',
        '--template=plugin',
        '--androidx',
        'test_plugin',
      ]);
    });

    test('android', () {
      // Move files
      // Run test driver tests flutter drive
    });
  });
}
