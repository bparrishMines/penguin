import 'dart:async';
import 'dart:math';
import 'dart:io' as io;

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';
import 'package:penguin_plugin/penguin_plugin.dart';
import 'package:penguin_plugin/android_wrapper.dart' as android;
import 'package:penguin_plugin/ios_wrapper.dart' as ios;

import 'android.dart';
import 'ios.dart';

final CallbackHandler callbackHandler = io.Platform.isAndroid
    ? android.AndroidCallbackHandler()
    : ios.IosCallbackHandler();

final MethodChannel channel = MethodChannel('test_plugin')
  ..setMethodCallHandler(callbackHandler.methodCallHandler);
String randomId() => Random().nextDouble().toString();

class TextView extends StatefulWidget {
  TextView(this.text) : assert(text != null);

  final String text;

  @override
  State<StatefulWidget> createState() {
    if (io.Platform.isAndroid) return AndroidTextViewState(null);
    if (io.Platform.isIOS) return IosTextViewState(text);
    throw UnsupportedError('Not Android or iOS');
  }
}

abstract class TestClass1 {
  @Field()
  set mutableField(FutureOr<double> value);

  @Field()
  FutureOr<double> get mutableField;

  @Method()
  Future<void> returnVoid();

  @Method()
  Future<String> returnString();

  @Method()
  Future<int> returnInt();

  @Method()
  Future<double> returnDouble();

  @Method()
  Future<bool> returnBool();

  @Method()
  Future<List<double>> returnList();

  @Method()
  Future<Map<String, int>> returnMap();

  @Method()
  Future<Object> returnObject();

  @Method()
  Future<dynamic> returnDynamic();

  @Field()
  FutureOr<int> get intField;

  @Field()
  Future<String> get stringField;

  @Field()
  Future<double> get doubleField;

  @Field()
  Future<bool> get boolField;
}

abstract class TestClass2 {}

abstract class GenericClass<T> {
  @Method()
  Future<void> add(T object);

  @Method()
  Future<T> get(String identifier);
}
