import 'package:test_plugin_platform_interface/test_plugin_platform_interface.dart' as platform_interface;
import 'implementation.dart';

class TestClass extends platform_interface.TestClass {
  factory TestClass(String testField) {
    return TestClassImpl(testField);
  }

  @override
  Future<String> testMethod(String testParameter) {
    throw UnimplementedError();
  }
}