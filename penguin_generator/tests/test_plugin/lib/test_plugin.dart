import 'dart:async';
import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:penguin_plugin/penguin_plugin.dart';

import 'src/android.dart';
import 'src/test_plugin_interface.dart';
import 'src/ios.dart';

void initialize() {
  PenguinPlugin.globalMethodChannel = MethodChannel('test_plugin');
  PenguinPlugin.globalMethodChannel.setMethodCallHandler(
    PenguinPlugin.methodCallHandler,
  );
}

class TestClass1Controller with TestClass1 {
  TestClass1Controller()
      : testClass1 = io.Platform.isAndroid
            ? AndroidTestClass1()
            : (IosTestClass1() as TestClass1);

  TestClass1Controller.namedConstructor() : testClass1 = io.Platform.isAndroid
      ? AndroidTestClass1.namedConstructor()
      : (IosTestClass1.initNamedConstructor() as TestClass1);

  final TestClass1 testClass1;

  @override
  FutureOr<double> get mutableField => testClass1.mutableField;

  @override
  set mutableField(FutureOr<double> value) => testClass1.mutableField = value;

  @override
  Future<bool> get boolField => testClass1.boolField;

  @override
  Future<double> get doubleField => testClass1.doubleField;

  @override
  FutureOr<int> get intField => testClass1.intField;

  @override
  Future<double> get notAField => testClass1.notAField;

  @override
  Future<String> get stringField => testClass1.stringField;

  @override
  Future<bool> returnBool() => testClass1.returnBool();

  @override
  Future<double> returnDouble() => testClass1.returnDouble();

  @override
  Future returnDynamic() => testClass1.returnDynamic();

  @override
  Future<int> returnInt() => testClass1.returnInt();
  @override
  Future<List<double>> returnList() => testClass1.returnList();

  @override
  Future<Map<String, int>> returnMap() => testClass1.returnMap();

  @override
  Future<Object> returnObject() => testClass1.returnObject();

  @override
  Future<String> returnString() => testClass1.returnString();

  @override
  Future<void> returnVoid() => testClass1.returnVoid();
}

class TestClass2Controller {
  TestClass2Controller()
      : testClass2 = io.Platform.isAndroid
            ? AndroidTestClass2()
            : (IosTestClass2() as TestClass2);

  final TestClass2 testClass2;
}

class GenericClassController<T> with GenericClass<T> {
  GenericClassController()
      : genericClass = io.Platform.isAndroid
            ? AndroidGenericClass<T>()
            : (IosGenericClass<T>() as GenericClass<T>);

  final GenericClass<T> genericClass;

  @override
  Future<void> add(T object) => genericClass.add(object);

  @override
  Future<T> get(String identifier) => genericClass.get(identifier);
}

class TextViewWidget extends StatefulWidget {
  TextViewWidget(this.text);

  final String text;

  @override
  State<StatefulWidget> createState() {
    if (io.Platform.isAndroid) return AndroidTextViewState();
    //if (io.Platform.isIOS) return ios.IosTextViewState();
    throw UnsupportedError('Not Android or iOS');
  }
}
