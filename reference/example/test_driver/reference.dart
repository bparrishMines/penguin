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
      final ClassTemplate classTemplate1 = ClassTemplate(44, null, null, null);

      final ClassTemplate classTemplate2 = ClassTemplate(
        11,
        ClassTemplate(22, null, null, null),
        <ClassTemplate>[ClassTemplate(33, null, null, null)],
        <String, ClassTemplate>{'hello': classTemplate1},
      );

      referencePairManager.createRemoteReferenceFor(classTemplate1);
      referencePairManager.createRemoteReferenceFor(classTemplate2);

      expect(
        classTemplate2.methodTemplate('hello', null, null, null),
        completion('Reference'),
      );
      expect(classTemplate2.returnsReference(), completes);
    });
  });
}
