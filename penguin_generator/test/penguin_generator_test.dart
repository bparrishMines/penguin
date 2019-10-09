import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  group('penguin_generator', () {
    test('test_plugin test_driver tests', () async {
      print('Running flutter create...');
      expect(
        await _printProcess(await Process.start('flutter', <String>[
          'create',
          '--project-name=test_plugin',
          '--no-with-driver-test',
          '--template=plugin',
          '--androidx',
          '--android-language=java',
          '--ios-language=objc',
          p.join('test', 'test_plugin'),
        ])),
        isTrue,
      );

      print('Running build_runner...');
      expect(
        await _printProcess(await Process.start(
          'flutter',
          <String>[
            'packages',
            'pub',
            'run',
            'build_runner',
            'build',
          ],
          workingDirectory: p.join('test', 'test_plugin'),
        )),
        isTrue,
      );

      print('Moving platform specific files...');
      await Future.wait<File>(<Future<File>>[_moveAndroidGeneratedCode()]);

      print('Running test_driver...');
      final Process driverTestProcess = await Process.start(
        'flutter',
        <String>['drive', p.join('test_driver', 'test_plugin.dart')],
        workingDirectory: p.join('test', 'test_plugin', 'example'),
      );

      bool testsPassed = false;
      driverTestProcess.stdout.transform(utf8.decoder).listen((String data) {
        if (data.contains('All tests passed!')) testsPassed = true;
        stdout.write(data);
      });
      stderr.addStream(driverTestProcess.stderr);

      expect(await driverTestProcess.exitCode == 0 && testsPassed, isTrue);
    }, timeout: Timeout(Duration(minutes: 2)));
  });
}

// Returns whether script runs successfully
Future<bool> _printProcess(Process process) async {
  stdout.addStream(process.stdout);
  stderr.addStream(process.stderr);
  return (await process.exitCode) == 0;
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
