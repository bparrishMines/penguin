import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';
import 'package:reference/reference.dart';
import 'package:test_plugin_platform_interface/test_plugin_platform_interface.dart'
    as plugin_interface;

part 'implementation.g.dart';

mixin _MethodChannelUser {
  final MethodChannel _channel = _initializeReferenceMethodChannel(
    'test_plugin',
  );
}

typedef TestCallback = void Function(TestClass testParameter);

@MethodChannelImplementation()
class TestClass extends _TestClass
    with _MethodChannelUser
    implements plugin_interface.TestClass {
  TestClass(this.testField, TestCallback onTestCallback)
      : _onTestCallback = onTestCallback;

  final String testField;

  TestCallback _onTestCallback;
  plugin_interface.TestCallback get onTestCallback =>
      (plugin_interface.TestClass testParameter) =>
          _onTestCallback(testParameter as TestClass);

  Future<String> testMethod(String testParameter) {
    reference.retain();
    reference.autoReleasePool();

    final MethodCall call = _testMethod(testParameter);
    return _channel.invokeMethod<String>(call.method, call.arguments);
  }
}
