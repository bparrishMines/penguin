import 'package:penguin/penguin.dart';

import '../test_plugin_platform_interface.dart';

@Interface()
class TestClass {
  const TestClass._(this.testField);

  factory TestClass(String testField) {
    return TestPluginPlatform.instance.createTestClass(TestClass._(testField));
  }

  final String testField;

  Future<void> testMethod(String testParameter) {

  }
}