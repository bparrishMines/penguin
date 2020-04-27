import 'dart:async';

import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reference/src/templates/implementation.dart';

void main() {
  final Completer<String> completer = Completer<String>();
  enableFlutterDriverExtension(handler: (_) => completer.future);
  tearDownAll(() => completer.complete(null));

  group('reference', () {
    test('$ClassTemplate', () async {
      final Completer<double> callbackCompleter = Completer<double>();
      final ClassTemplate template = ClassTemplate(
        54,
        (double value) {
          callbackCompleter.complete(value);
          return Future<String>.value('loco');
        },
      );
      referenceManager = ReferenceManagerTemplate()..initialize();
      referenceManager.retain(template);

      expect(template.methodTemplate('Bees!'), completion('AppleBees!'));
      expect(callbackCompleter.future, completion(15.0));
    });
  });
}
