import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';
import 'package:reference/reference.dart';
import 'package:test_plugin_platform_interface/test_plugin_platform_interface.dart'
    as plugin_interface;

part 'implementation.g.dart';

mixin MethodChannelUser {
  MethodChannel get _channel => MethodChannel(
        'test_plugin',
        StandardMethodCodec(TestPluginMessageCodec()),
      );
}

@MethodChannelImplementation()
class TestClass extends _MethodChannelTestClass
    with MethodChannelUser
    implements plugin_interface.TestClass {
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
