import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:reference_example/reference_example.dart';

Future<void> main() async {
  final Completer<String> completer = Completer<String>();
  enableFlutterDriverExtension(handler: (_) => completer.future);
  tearDownAll(() => completer.complete(null));

  group('reference', () {
    test('$MyClass', () async {
      final MyClass myClass = MyClass('woeijf');
      print(await myClass.myMethod(123.3, MyOtherClass(23)));
    });
  });
}