import 'dart:async';

import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_plugin/test_plugin.dart';

void main() {
  final Completer<String> completer = Completer<String>();
  enableFlutterDriverExtension(handler: (_) => completer.future);
  tearDownAll(() => completer.complete(null));

  group('$TestClass', () {
    test('testMethod', () {
      final TestClass testClass = TestClass('Bob');
      expect(testClass.testMethod('Bill'), completion('Hello, Bob and Bill!'));
    });
  });
}