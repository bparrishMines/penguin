import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';
import 'package:penguin_plugin/penguin_plugin.dart';
import 'interface.dart';

part 'implementation.g.dart';

@Implementation()
class TestClassImpl extends _MethodChannelTestClass implements TestClass {
  TestClassImpl(this.testField);

  final String testField;

  @override
  Future<String> testMethod(String testParameter) {
    final MethodCall methodCall = _testMethod(testParameter);
    return channel.invokeMethod(methodCall.method, methodCall.arguments);
  }

  @override
  MethodChannel get channel => MethodChannel(
        'test_plugin',
        StandardMethodCodec(TestPluginMessageCodec()),
      );
}
