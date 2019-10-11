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

  final List<MethodCall> _setters = <MethodCall>[];

  @Field()
  Future<Object> get objectField => $invoke<Object>(
        _channel,
        _testClass.$AndroidTestClass1Default(),
        [..._setters, _testClass.$objectField()],
      );

  @Field()
  set objectField(FutureOr<Object> objectField) {
    _setters.add(_testClass.$objectField(objectField: objectField));
    $invoke<Object>(
      _channel,
      _testClass.$AndroidTestClass1Default(),
      [_testClass.$objectField(objectField: objectField)],
    );
  }

  @Field()
  Future<dynamic> get dynamicField => $invoke<dynamic>(
        _channel,
        _testClass.$AndroidTestClass1Default(),
        [_testClass.$dynamicField()],
      );

  @Field()
  Future<String> get stringField => $invoke<String>(
        _channel,
        _testClass.$AndroidTestClass1Default(),
        [_testClass.$stringField()],
      );

  @Field()
  Future<int> get intField => $invoke<int>(
        _channel,
        _testClass.$AndroidTestClass1Default(),
        [_testClass.$intField()],
      );

  @Field()
  Future<double> get doubleField => $invoke<double>(
        _channel,
        _testClass.$AndroidTestClass1Default(),
        [_testClass.$doubleField()],
      );

  @Field()
  Future<num> get numField => $invoke<num>(
        _channel,
        _testClass.$AndroidTestClass1Default(),
        [_testClass.$numField()],
      );

  @Field()
  Future<bool> get boolField => $invoke<bool>(
    _channel,
    _testClass.$AndroidTestClass1Default(),
    [_testClass.$boolField()],
  );

  @Method()
  Future<void> returnVoid() {
    return $invoke<void>(
      _channel,
      _testClass.$AndroidTestClass1Default(),
      [_testClass.$returnVoid()],
    );
  }

  @Method()
  Future<Object> returnObject() {
    return $invoke<Object>(
      _channel,
      _testClass.$AndroidTestClass1Default(),
      [_testClass.$returnObject()],
    );
  }

  @Method()
  Future<dynamic> returnDynamic() {
    return $invoke<dynamic>(
      _channel,
      _testClass.$AndroidTestClass1Default(),
      [_testClass.$returnDynamic()],
    );
  }

  @Method()
  Future<String> returnString() {
    return $invoke<String>(
      _channel,
      _testClass.$AndroidTestClass1Default(),
      [_testClass.$returnString()],
    );
  }

  @Method()
  Future<int> returnInt() {
    return $invoke<int>(
      _channel,
      _testClass.$AndroidTestClass1Default(),
      [_testClass.$returnInt()],
    );
  }

  @Method()
  Future<double> returnDouble() {
    return $invoke<double>(
      _channel,
      _testClass.$AndroidTestClass1Default(),
      [_testClass.$returnDouble()],
    );
  }

  @Method()
  Future<bool> returnBool() {
    return $invoke<bool>(
      _channel,
      _testClass.$AndroidTestClass1Default(),
      [_testClass.$returnBool()],
    );
  }

  @Method()
  Future<List<double>> returnList() {
    return $invokeList<double>(
      _channel,
      _testClass.$AndroidTestClass1Default(),
      [_testClass.$returnList()],
    );
  }

  @Method()
  Future<Map<String, int>> returnMap() {
    return $invokeMap<String, int>(
      _channel,
      _testClass.$AndroidTestClass1Default(),
      [_testClass.$returnMap()],
    );
  }

  @Method()
  Future<int> noParametersMethod() {
    return $invoke<int>(
      _channel,
      _testClass.$AndroidTestClass1Default(),
      [_testClass.$noParametersMethod()],
    );
  }

  @Method()
  Future<String> singleParameterMethod(String value) {
    return $invoke<String>(
      _channel,
      _testClass.$AndroidTestClass1Default(),
      [_testClass.$singleParameterMethod(value)],
    );
  }
}

@Class(AndroidPlatform(
  AndroidType('com.example.test_plugin.test_library', 'TestClass2'),
))
class AndroidTestClass2 {}
