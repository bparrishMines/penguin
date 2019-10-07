import 'dart:io';

import 'package:test/test.dart';

void main() {
  group('penguin_generator', () {
    setUpAll(() {
      final ProcessResult createResult = Process.runSync('flutter', <String>[
        'create',
        '--project-name=test_plugin',
        '--no-with-driver-test',
        '--template=plugin',
        '--androidx',
        '--android-language=java',
        '--ios-language=objc',
        'test/test_plugin',
      ]);
      print(createResult.stdout);
      print(createResult.stderr);

      if (createResult.exitCode != 0) {
        exit(createResult.exitCode);
      }
    });

    test('android', () {
      // Move files
      // Run test driver tests flutter drive
    });
  });
}
