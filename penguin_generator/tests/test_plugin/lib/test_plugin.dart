import 'dart:async';
import 'dart:math';
import 'dart:io' as io;

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';
import 'package:penguin_plugin/android_wrapper.dart';
import 'package:penguin_plugin/penguin_plugin.dart';
import 'package:penguin_plugin/android_wrapper.dart' as android;
import 'package:penguin_plugin/ios_wrapper.dart' as ios;

final CallbackHandler callbackHandler = io.Platform.isAndroid ? android.CallbackHandler() : ios.CallbackHandler;

final MethodChannel channel = MethodChannel('test_plugin')
  ..setMethodCallHandler(io.Platform.isAndroid
      ? androidCallbackHandler.methodCallHandler
      : iosCallbackHandler.methodCallHandler);
String randomId() => Random().nextDouble().toString();

class TextView extends StatefulWidget {
  TextView(this.text) : assert(text != null);

  final String text;

  @override
  State<StatefulWidget> createState() {
    if (io.Platform.isAndroid) return _AndroidTextViewState(null);
    if (io.Platform.isIOS) return _IosTextViewState(text);
    throw UnsupportedError('Not Android or iOS');
  }
}

abstract class TestClass1 {
  final android.$AndroidTestClass1 _android =
      android.$AndroidTestClass1(_randomId());
  final ios.$IosTestClass1 _ios = ios.$IosTestClass1(_randomId());

  List<MethodCall> _constructorMethodCalls;

  @Field()
  set mutableField(FutureOr<double> value) =>
      android.invoke<double>(_channel, _constructorMethodCalls[0], [
        ..._constructorMethodCalls.skip(1).toList(),
        io.Platform.isAndroid ? _android.allocate() : _ios.allocate(),
        io.Platform.isAndroid
            ? _android.$mutableField(mutableField: value)
            : _ios.$mutableField(mutableField: value),
      ]);

  @Field()
  FutureOr<double> get mutableField => android.invoke<double>(
        _channel,
        io.Platform.isAndroid ? _android.$mutableField() : _ios.$mutableField(),
      );

  @Method()
  Future<void> returnVoid() {
    return android.invoke<void>(
      _channel,
      _constructorMethodCalls[0],
      <MethodCall>[
        ..._constructorMethodCalls.skip(1).toList(),
        io.Platform.isAndroid ? _android.$returnVoid() : _ios.$returnVoid(),
      ],
    );
  }

  @Method()
  Future<String> returnString() {
    return android.invoke<String>(
      _channel,
      _constructorMethodCalls[0],
      <MethodCall>[
        ..._constructorMethodCalls.skip(1).toList(),
        io.Platform.isAndroid ? _android.$returnString() : _ios.$returnString(),
      ],
    );
  }

  @Method()
  Future<int> returnInt() {
    return android.invoke<int>(
      _channel,
      _constructorMethodCalls[0],
      <MethodCall>[
        ..._constructorMethodCalls.skip(1).toList(),
        io.Platform.isAndroid ? _android.$returnInt() : _ios.$returnInt(),
      ],
    );
  }

  @Method()
  Future<double> returnDouble() {
    return android.invoke<double>(
      _channel,
      _constructorMethodCalls[0],
      <MethodCall>[
        ..._constructorMethodCalls.skip(1).toList(),
        io.Platform.isAndroid ? _android.$returnDouble() : _ios.$returnDouble(),
      ],
    );
  }

  @Method()
  Future<bool> returnBool() {
    return android.invoke<bool>(
      _channel,
      _constructorMethodCalls[0],
      <MethodCall>[
        ..._constructorMethodCalls.skip(1).toList(),
        io.Platform.isAndroid ? _android.$returnBool() : _ios.$returnBool(),
      ],
    );
  }

  @Method()
  Future<List<double>> returnList() {
    return android.invokeList<double>(
      _channel,
      _constructorMethodCalls[0],
      <MethodCall>[
        ..._constructorMethodCalls.skip(1).toList(),
        io.Platform.isAndroid ? _android.$returnList() : _ios.$returnList(),
      ],
    );
  }

  @Method()
  Future<Map<String, int>> returnMap() {
    return android.invokeMap<String, int>(
      _channel,
      _constructorMethodCalls[0],
      <MethodCall>[
        ..._constructorMethodCalls.skip(1).toList(),
        io.Platform.isAndroid ? _android.$returnMap() : _ios.$returnMap(),
      ],
    );
  }

  @Method()
  Future<Object> returnObject() {
    return android.invoke<Object>(
      _channel,
      _constructorMethodCalls[0],
      <MethodCall>[
        ..._constructorMethodCalls.skip(1).toList(),
        io.Platform.isAndroid ? _android.$returnObject() : _ios.$returnObject(),
      ],
    );
  }

  @Method()
  Future<dynamic> returnDynamic() {
    return android.invoke<dynamic>(
      _channel,
      _constructorMethodCalls[0],
      <MethodCall>[
        ..._constructorMethodCalls.skip(1).toList(),
        io.Platform.isAndroid
            ? _android.$returnDynamic()
            : _ios.$returnDynamic(),
      ],
    );
  }

  @Field()
  FutureOr<int> get intField =>
      android.invoke<int>(_channel, _constructorMethodCalls[0], [
        ..._constructorMethodCalls.skip(1).toList(),
        io.Platform.isAndroid ? _android.$intField() : _ios.$intField(),
      ]);

  @Field()
  Future<String> get stringField =>
      android.invoke<String>(_channel, _constructorMethodCalls[0], [
        ..._constructorMethodCalls.skip(1).toList(),
        io.Platform.isAndroid ? _android.$stringField() : _ios.$stringField(),
      ]);

  @Field()
  Future<double> get doubleField =>
      android.invoke<double>(_channel, _constructorMethodCalls[0], [
        ..._constructorMethodCalls.skip(1).toList(),
        io.Platform.isAndroid ? _android.$doubleField() : _ios.$doubleField(),
      ]);

  @Field()
  Future<bool> get boolField =>
      android.invoke<bool>(_channel, _constructorMethodCalls[0], [
        ..._constructorMethodCalls.skip(1).toList(),
        io.Platform.isAndroid ? _android.$boolField() : _ios.$boolField(),
      ]);
}

abstract class TestClass2 {
  TestClass2() {
    _constructorMethodCall = io.Platform.isAndroid
        ? _android.$AndroidTestClass2$Default()
        : _ios.$IosTestClass2$Default();
  }

  final android.$AndroidTestClass2 _android =
      android.$AndroidTestClass2(_randomId());
  final ios.$IosTestClass2 _ios = ios.$IosTestClass2(_randomId());

  MethodCall _constructorMethodCall;
}

abstract class GenericClass<T> {
  @Method()
  Future<void> add(T object) {}

  @Method()
  Future<T> get(String id) {}
}
