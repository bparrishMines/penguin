package com.example.test_plugin;

public class MyTestClass extends TestPluginPlatform.TestClass {
  public MyTestClass(TestPluginPlatform.TestClass testClass) {
    super(testClass.testField, testClass.referenceId);
  }

  @Override
  public String testMethod(String testParameter) throws Exception {
    return String.format("Hello, %s and %s!", testField, testParameter);
  }
}
