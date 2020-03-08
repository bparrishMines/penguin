import 'package:penguin/penguin.dart';
import 'package:test_plugin/src/platform.dart';

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