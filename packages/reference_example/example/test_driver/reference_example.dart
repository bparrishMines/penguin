import 'dart:async';

import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reference_example/channels.dart';

import 'package:reference_example/reference_example.dart';

Future<void> main() async {
  final Completer<String> completer = Completer<String>();
  enableFlutterDriverExtension(handler: (_) => completer.future);
  tearDownAll(() => completer.complete('lul'));

  group('reference_example', () {
    test('methodTemplate', () {
      final $$class_name$$ classTemplate = $$class_name$$(44);

      expect(
        classTemplate.$$method_name$$('Hello,'),
        completion('Hello, World!'),
      );
    });

    test('staticMethodTemplate', () {
      expect(
        $$class_name$$.$__staticMethod_name__('howmanycharacters'),
        completion(17),
      );
    });

    test('ACallback', () async {
      String? returnValue;
      final $$function_name$$ callback = (String value) {
        returnValue = value;
      };
      ChannelRegistrar.instance.implementations.channel__function_name__
          .$$create(
        callback,
        $owner: true,
      );
      final $$class_name$$ classTemplate = $$class_name$$(44);
      ChannelRegistrar.instance.implementations.channel__class_name__
          .sendInvokeMethod(
        classTemplate,
        'callbackTest',
        <Object?>[callback],
      );
      await Future.delayed(Duration(seconds: 1));
      expect(returnValue, 'Eureka!');
    });
  });
}
