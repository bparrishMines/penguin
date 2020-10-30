import 'dart:async';

import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:reference/src/template/template.dart';

Future<void> main() async {
  final Completer<String> completer = Completer<String>();
  enableFlutterDriverExtension(handler: (_) => completer.future);
  tearDownAll(() => completer.complete(null));

  group('reference', () {
    setUpAll(() {
      PluginTemplate.initialize();
    });

    test('$ClassTemplate.methodTemplate', () async {
      final ClassTemplate classTemplate = ClassTemplate(44, ClassTemplate2());

      expect(
        classTemplate.methodTemplate('Hello,', ClassTemplate2()),
        completion('Hello, World!'),
      );
    });

    test('$ClassTemplate.staticMethodTemplate', () async {
      expect(
        ClassTemplate.staticMethodTemplate(
          'howmanycharacters',
          ClassTemplate2(),
        ),
        completion(17),
      );
    });
  });
}
