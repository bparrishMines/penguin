import 'dart:async';
import 'dart:math';
import 'dart:io' as io;

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';
import 'package:penguin_plugin/penguin_plugin.dart';
import 'package:penguin_plugin/android_wrapper.dart' as awrapper;
import 'package:penguin_plugin/ios_wrapper.dart' as iwrapper;

import 'android.dart' as android;
import 'ios.dart' as ios;

final CallbackHandler callbackHandler = io.Platform.isAndroid
    ? awrapper.AndroidCallbackHandler()
    : iwrapper.IosCallbackHandler();

final MethodChannel channel = MethodChannel('test_plugin')
  ..setMethodCallHandler(callbackHandler.methodCallHandler);
String randomId() => Random().nextDouble().toString();

abstract class PlatformTextView {
  static PlatformTextView fromText(String text) {
    if (io.Platform.isAndroid) return android.TextView()..setText(text);
    if (io.Platform.isIOS) return ios.TextView.initWithFrame()..text = text;
    throw UnsupportedError('Not Android or iOS');
  }
}

class TextViewWidget extends StatefulWidget {
  TextViewWidget(this.textView);

  final PlatformTextView textView;

  @override
  State<StatefulWidget> createState() {
    if (io.Platform.isAndroid) return android.AndroidTextViewState();
    if (io.Platform.isIOS) return ios.IosTextViewState();
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

  @Field(nameOverride: 'nameOverrideField')
  Future<double> get notAField;
}

abstract class TestClass2 {}

abstract class GenericClass<T> {
  @Method()
  Future<void> add(T object);

  @Method()
  Future<T> get(String identifier);
}
