// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:path/path.dart' as path;
import "package:test/test.dart";

void main() {
  group('Penguin Tests', () {
    final String testPluginPath = 'test/tmp';
    final String testYamlPath = 'test/test_yamls';
    final String correctOutputPath = 'test/correct_output';
    final List<String> pluginFiles = const <String>[
      'lib/src/channel.dart',
      'lib/src/firebase_performance.dart',
      'lib/src/hello_world.dart',
      'lib/src/http_metric.dart',
      'lib/src/trace.dart',
      'lib/test_plugin.dart',
      'pubspec.yaml',
    ];

    test('file compare', () {
      final ProcessResult result = Process.runSync(
        'pub',
        <String>[
          'run',
          'penguin',
          '-d',
          testPluginPath,
          '-p',
          testYamlPath,
        ],
      );

      print(result.stdout);
      print(result.stderr);

      for (String str in pluginFiles) {
        final File file = File(path.join(testPluginPath, str));
        expect(file.existsSync(), isTrue);

        final File correctFile = File(path.join(correctOutputPath, str));
        expect(file.readAsStringSync(), equals(correctFile.readAsStringSync()));
      }
    });
  });
}
