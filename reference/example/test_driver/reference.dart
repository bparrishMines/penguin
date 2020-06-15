import 'dart:async';

import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:reference/src/template/template.dart';

Future<void> main() async {
  final Completer<String> completer = Completer<String>();
  enableFlutterDriverExtension(handler: (_) => completer.future);
  tearDownAll(() => completer.complete(null));

  group('reference', () {
    test('$ClassTemplate', () async {
      final ClassTemplate classTemplate = ClassTemplate(44);

      expect(
        classTemplate.methodTemplate('Hello,'),
        completion('Hello, World!'),
      );
    });
  });
}
