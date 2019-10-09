import 'dart:async';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';

import 'android.penguin.g.dart';

const MethodChannel _channel = const MethodChannel('test_plugin');
String _randomId() => Random().nextDouble().toString();

@Class(AndroidPlatform(
  AndroidType('com.example.test_plugin.test_library', 'TestClass1'),
))
class AndroidTestClass1 {
  @Constructor()
  AndroidTestClass1();

  final $AndroidTestClass1 _testClass = $AndroidTestClass1(_randomId());

  @Method()
  Future<void> noParametersMethod() {
    return $invoke<void>(
      _channel,
      _testClass.$AndroidTestClass1Default(),
      _testClass.$noParametersMethod(),
    );
  }
}

@Class(AndroidPlatform(
  AndroidType('com.example.test_plugin.test_library', 'TestClass2'),
))
class AndroidTestClass2 {}
