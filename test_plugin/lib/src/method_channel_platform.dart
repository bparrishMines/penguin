import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';
import 'package:penguin_plugin/penguin_plugin.dart';
import 'package:test_plugin_platform_interface/test_plugin_platform_interface.dart';

part 'method_channel_platform.g.dart';

class MethodChannelPlatform extends TestPluginPlatform {
  @override
  TestClass createTestClass(TestClass testClass) {
    return super.createTestClass(testClass);
  }
}

@Implementation()
class MethodChannelTestClass extends _MethodChannelTestClass
    implements TestClass {
  MethodChannelTestClass(this.testField);

  final String testField;

  @override
  Future<void> testMethod(String testParameter) {
    final MethodCall methodCall = _testMethod(testParameter);
    return channel.invokeMethod(methodCall.method, methodCall.arguments);
  }

  @override
  MethodChannel get channel => MethodChannel(
        'test_plugin',
        StandardMethodCodec(TestPluginMessageCodec()),
      );
}
