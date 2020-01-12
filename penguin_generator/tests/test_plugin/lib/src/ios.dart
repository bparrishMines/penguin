import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';
import 'package:penguin_plugin/penguin_plugin.dart';

import '../test_plugin.dart';
import 'test_plugin_interface.dart';

part 'ios.ios.penguin.g.dart';

class IosTextViewState extends State<TextViewWidget> with IosViewCreator {
  IosTextViewState() {
    PenguinPlugin.iosCreator = this;
  }

  static final String identifier = 'aoeifjaiefoawe';

  @override
  Widget build(BuildContext context) {
    return UiKitView(
      viewType: '${PenguinPlugin.globalMethodChannel.name}/view',
      creationParams: identifier,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }

  @override
  Future<String> onCreateView(CGRect frame, String viewId) {
    final TextView textView = TextView.initWithFrame(frame);
    textView.text = widget.text;
    return Future<String>.value(textView.autoReleasePool().uniqueId);
  }
}

@Class(IosPlatform(IosType('UITextView')))
class TextView extends $TextView {
  @Constructor()
  TextView.initWithFrame(CGRect frame) : super.initWithFrame(frame);

  TextView.fromUniqueId(String uniqueId) : super.fromUniqueId(uniqueId);

  @Field()
  set text(String text) => invoke<void>(PenguinPlugin.globalMethodChannel, [$set$text(text)]);
}

@Class(IosPlatform(
  IosType('TestClass1', import: '"TestPlugin.h"'),
))
class IosTestClass1 extends $IosTestClass1 with TestClass1 {
  @Constructor()
  IosTestClass1() : super.$Default();

  @Constructor()
  IosTestClass1.initNamedConstructor() : super.initNamedConstructor();

  IosTestClass1.fromUniqueId(String uniqueId) : super.fromUniqueId(uniqueId);

  @Field()
  static Future<List<bool>> get staticField => invokeList<bool>(
      PenguinPlugin.globalMethodChannel, [$IosTestClass1.$get$staticField()]);

  @Method()
  static Future<void> staticMethod() => invoke<void>(
      PenguinPlugin.globalMethodChannel, [$IosTestClass1.$staticMethod()]);

  @Method()
  Future<void> parameterMethod(
    String supported,
    @int32 int primitive,
    IosTestClass2 wrapper,
  ) =>
      invoke<void>(PenguinPlugin.globalMethodChannel,
          [$parameterMethod(supported, primitive, wrapper)]);

  @Method()
  @int32
  Future<int> returnInt32() =>
      invoke<int>(PenguinPlugin.globalMethodChannel, [$returnInt32()]);

  @override
  set mutableField(FutureOr<double> value) => invoke<double>(
      PenguinPlugin.globalMethodChannel, [$set$mutableField(value)]);

  @override
  FutureOr<double> get mutableField =>
      invoke<double>(PenguinPlugin.globalMethodChannel, [$get$mutableField()]);

  @override
  Future<void> returnVoid() =>
      invoke<void>(PenguinPlugin.globalMethodChannel, [$returnVoid()]);

  @override
  Future<String> returnString() =>
      invoke<String>(PenguinPlugin.globalMethodChannel, [$returnString()]);

  @override
  Future<int> returnInt() =>
      invoke<int>(PenguinPlugin.globalMethodChannel, [$returnInt()]);

  @override
  Future<double> returnDouble() =>
      invoke<double>(PenguinPlugin.globalMethodChannel, [$returnDouble()]);

  @override
  Future<bool> returnBool() =>
      invoke<bool>(PenguinPlugin.globalMethodChannel, [$returnBool()]);

  @override
  Future<List<double>> returnList() =>
      invokeList<double>(PenguinPlugin.globalMethodChannel, [$returnList()]);

  @override
  Future<Map<String, int>> returnMap() =>
      invokeMap<String, int>(PenguinPlugin.globalMethodChannel, [$returnMap()]);

  @override
  Future<Object> returnObject() =>
      invoke<Object>(PenguinPlugin.globalMethodChannel, [$returnObject()]);

  @override
  Future<dynamic> returnDynamic() =>
      invoke<dynamic>(PenguinPlugin.globalMethodChannel, [$returnDynamic()]);

  @Method()
  Future<IosTestClass1> returnWrapper() => invoke<IosTestClass1>(
      PenguinPlugin.globalMethodChannel, [$returnWrapper()], genericHelper: _GenericHelper.instance);

  @override
  FutureOr<int> get intField =>
      invoke<int>(PenguinPlugin.globalMethodChannel, [$get$intField()]);

  @override
  Future<String> get stringField =>
      invoke<String>(PenguinPlugin.globalMethodChannel, [$get$stringField()]);

  @override
  Future<double> get doubleField =>
      invoke<double>(PenguinPlugin.globalMethodChannel, [$get$doubleField()]);

  @override
  Future<bool> get boolField =>
      invoke<bool>(PenguinPlugin.globalMethodChannel, [$get$boolField()]);

  @override
  Future<double> get notAField =>
      invoke<double>(PenguinPlugin.globalMethodChannel, [$get$nameOverrideField()]);
}

@Class(IosPlatform(
  IosType('TestClass2', import: '"TestPlugin.h"'),
))
class IosTestClass2 extends $IosTestClass2 with TestClass2 {
  @Constructor()
  IosTestClass2() : super.$Default();

  IosTestClass2.fromUniqueId(String uniqueId) : super.fromUniqueId(uniqueId);
}

@Class(IosPlatform(IosType('GenericClass', import: '"TestPlugin.h"')))
class IosGenericClass<T> extends $IosGenericClass<T> with GenericClass<T> {
  @Constructor()
  IosGenericClass() : super.$Default();

  IosGenericClass.fromUniqueId(String uniqueId) : super.fromUniqueId(uniqueId);

  @override
  Future<void> add(T object) {
    if (isTypeOf<T, Wrapper>()) {
      return invoke<void>(
        PenguinPlugin.globalMethodChannel,
        [$add(object)],
      );
    }

    return invoke<void>(PenguinPlugin.globalMethodChannel, [$add(object)]);
  }

  @override
  Future<T> get(String identifier) async {
    if (isTypeOf<T, Wrapper>()) {
      return invoke<T>(
        PenguinPlugin.globalMethodChannel,
        [$get(identifier)],
        genericHelper: _GenericHelper.instance,
      );
    }

    return invoke<T>(PenguinPlugin.globalMethodChannel, [$get(identifier)]);
  }
}

@Class(IosPlatform(
  IosType('TestStruct', isStruct: true, import: '"TestPlugin.h"'),
))
class TestStruct extends $TestStruct {
  @Constructor()
  TestStruct() : super.$Default();

  TestStruct.fromUniqueId(String uniqueId) : super.fromUniqueId(uniqueId);

  @Field()
  @int32
  Future<int> get intField =>
      invoke<int>(PenguinPlugin.globalMethodChannel, [$get$intField()]);
}

@Class(IosPlatform(IosType('TestProtocol', import: '"TestPlugin.h"')))
class IosProtocol extends $IosProtocol {
  @Constructor()
  IosProtocol() : super.$Default();

  IosProtocol.fromUniqueId(String uniqueId) : super.fromUniqueId(uniqueId);

  @Method(callback: true)
  Future<void> callbackMethod() =>
      invoke<void>(PenguinPlugin.globalMethodChannel, [$callbackMethod()]);
}
