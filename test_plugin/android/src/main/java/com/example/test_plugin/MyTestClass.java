package com.example.test_plugin;

import io.flutter.plugin.common.MethodChannel;

public class MyTestClass extends GeneratedPlatform.TestClass {
  private final MethodChannel channel;

  public MyTestClass(GeneratedPlatform.TestClass testClass, final MethodChannel channel) {
    super(testClass.testField, testClass.referenceId);
    this.channel = channel;
  }

  @Override
  public String testMethod(String testParameter) throws Exception {
    return String.format("Hello, %s and %s!", testField, testParameter);
  }
}
