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

@MethodChannelImplementation()
class TestClass extends _TestClass with _MethodChannelUser {
  TestClass(this.testField);

  final String testField;

  @override
  Future<String> testMethod(String testParameter) {
    reference.retain();
    reference.autoReleasePool();

    final MethodCall call = _testMethod(testParameter);
    return _channel.invokeMethod<String>(call.method, call.arguments);
  }
}
