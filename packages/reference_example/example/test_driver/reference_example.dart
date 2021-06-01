import 'dart:async';

import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:reference_example/reference_example.dart';

Future<void> main() async {
  final Completer<String> completer = Completer<String>();
  enableFlutterDriverExtension(handler: (_) => completer.future);
  tearDownAll(() => completer.complete('lul'));

  group('reference_example', () {
    test('methodTemplate', () async {
      final $$class_name$$ classTemplate = $$class_name$$(44);

      expect(
        classTemplate.$$method_name$$('Hello,'),
        completion('Hello, World!'),
      );
    });

    test('staticMethodTemplate', () async {
      expect(
        $$class_name$$.$__staticMethod_name__('howmanycharacters'),
        completion(17),
      );
    });
  });
}
