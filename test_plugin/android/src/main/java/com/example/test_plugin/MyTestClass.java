package com.example.test_plugin;

import io.flutter.Log;

public class MyTestClass extends TestPluginPlatform.TestClass {
  public MyTestClass(TestPluginPlatform.TestClass testClass) {
    super(testClass.testField, testClass.referenceId);
  }

  @Override
  public Object testMethod(String testParameter) {
    Log.d(MyTestClass.class.getSimpleName(), "testMethod called");
    return null;
  }
}
