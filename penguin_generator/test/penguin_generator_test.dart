import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  group('penguin_generator', () {
    test('test_plugin', () async {
      bool success;

      print('Running flutter create...');
      success = _printProcessResult(Process.runSync('flutter', <String>[
        'create',
        '--project-name=test_plugin',
        '--no-with-driver-test',
        '--template=plugin',
        '--androidx',
        '--android-language=java',
        '--ios-language=objc',
        p.join('test', 'test_plugin'),
      ]));
      if (!success) exit(64);

      print('Running build_runner...');
      success = _printProcessResult(Process.runSync(
        'flutter',
        <String>[
          'packages',
          'pub',
          'run',
          'build_runner',
          'build',
        ],
        workingDirectory: p.join('test', 'test_plugin'),
      ));
      if (!success) exit(64);

      print('Moving platform specific files...');
      await Future.wait<File>(<Future<File>>[_moveAndroidGeneratedCode()]);

      print('Running test_driver...');
      success = _printProcessResult(Process.runSync(
        'flutter',
        <String>['drive', p.join('test_driver', 'test_plugin.dart')],
        workingDirectory: p.join('test', 'test_plugin', 'example'),
      ));

      expect(success, isTrue);
    });
  });
}

// Returns whether script runs successfully
bool _printProcessResult(ProcessResult result) {
  final bool success = result.exitCode == 0;

  if (!success) {
    print(result.stdout);
    print(result.stderr);
  }

  return success;
}

Future<File> _moveAndroidGeneratedCode() =>
    File(p.join('test', 'test_plugin', 'lib', 'ChannelGenerated.java')).copy(
      p.joinAll(
        <String>[
          'test',
          'test_plugin',
          'android',
          'src',
          'main',
          'java',
          'com',
          'example',
          'test_plugin',
          'ChannelGenerated.java',
        ],
      ),
    );
