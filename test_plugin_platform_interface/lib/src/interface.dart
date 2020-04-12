import 'dart:async';

import 'package:penguin/penguin.dart';

typedef TestCallback = void Function(TestClass testParameter);

@Interface()
class TestClass {
  const TestClass(this.testField, this.onTestCallback);

  final String testField;
  final TestCallback onTestCallback;

  FutureOr<int> testMethod(String testParameter) {
    throw UnimplementedError();
  }
}
