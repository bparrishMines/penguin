import 'dart:async';

import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:reference_example/reference_example.dart';

Future<void> main() async {
  final Completer<String> completer = Completer<String>();
  enableFlutterDriverExtension(handler: (_) => completer.future);
  tearDownAll(() => completer.complete('lul'));

  group('reference_example', () {
    test('$ClassTemplate.methodTemplate', () async {
      final ClassTemplate classTemplate = ClassTemplate(44);

      expect(
        classTemplate.methodTemplate('Hello,'),
        completion('Hello, World!'),
      );
    });

    test('$ClassTemplate.staticMethodTemplate', () async {
      expect(
        ClassTemplate.staticMethodTemplate('howmanycharacters'),
        completion(17),
      );
    });
  });
}
