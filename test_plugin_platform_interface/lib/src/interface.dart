import 'package:penguin/penguin.dart';

@Interface()
abstract class TestClass {
  const TestClass(this.testField);

  final String testField;

  Future<String> testMethod(String testParameter);
}