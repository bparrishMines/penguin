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
      viewType: '${channel.name}/view',
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
  TextView.initWithFrame(CGRect frame)
      : super.initWithFrame(frame, channel: channel);

  TextView.fromUniqueId(String uniqueId)
      : super.fromUniqueId(uniqueId, channel: channel);

  @Field()
  set text(String text) => invoke<void>(channel, [$set$text(text)]);
}

@Class(IosPlatform(
  IosType('TestClass1', import: '"TestPlugin.h"'),
))
class IosTestClass1 extends $IosTestClass1 with TestClass1 {
  @Constructor()
  IosTestClass1() : super.$Default(channel: channel);

  @Constructor()
  IosTestClass1.initNamedConstructor()
      : super.initNamedConstructor(channel: channel);

  IosTestClass1.fromUniqueId(String uniqueId)
      : super.fromUniqueId(uniqueId, channel: channel);

  @Field()
  static Future<List<bool>> get staticField =>
      invokeList<bool>(channel, [$IosTestClass1.$get$staticField()]);

  @Method()
  static Future<void> staticMethod() =>
      invoke<void>(channel, [$IosTestClass1.$staticMethod()]);

  @Method()
  Future<void> parameterMethod(
    String supported,
    @int32 int primitive,
    IosTestClass2 wrapper,
  ) =>
      invoke<void>(channel, [$parameterMethod(supported, primitive, wrapper)]);

  @Method()
  @int32
  Future<int> returnInt32() => invoke<int>(channel, [$returnInt32()]);

  @override
  set mutableField(FutureOr<double> value) =>
      invoke<double>(channel, [$set$mutableField(value)]);

  @override
  FutureOr<double> get mutableField =>
      invoke<double>(channel, [$get$mutableField()]);

  @override
  Future<void> returnVoid() => invoke<void>(channel, [$returnVoid()]);

  @override
  Future<String> returnString() => invoke<String>(channel, [$returnString()]);

  @override
  Future<int> returnInt() => invoke<int>(channel, [$returnInt()]);

  @override
  Future<double> returnDouble() => invoke<double>(channel, [$returnDouble()]);

  @override
  Future<bool> returnBool() => invoke<bool>(channel, [$returnBool()]);

  @override
  Future<List<double>> returnList() =>
      invokeList<double>(channel, [$returnList()]);

  @override
  Future<Map<String, int>> returnMap() =>
      invokeMap<String, int>(channel, [$returnMap()]);

  @override
  Future<Object> returnObject() => invoke<Object>(channel, [$returnObject()]);

  @override
  Future<dynamic> returnDynamic() =>
      invoke<dynamic>(channel, [$returnDynamic()]);

  @Method()
  Future<IosTestClass1> returnWrapper() =>
      invoke<IosTestClass1>(channel, [$returnWrapper()],
          genericHelper: _GenericHelper.instance);

  @override
  FutureOr<int> get intField => invoke<int>(channel, [$get$intField()]);

  @override
  Future<String> get stringField =>
      invoke<String>(channel, [$get$stringField()]);

  @override
  Future<double> get doubleField =>
      invoke<double>(channel, [$get$doubleField()]);

  @override
  Future<bool> get boolField => invoke<bool>(channel, [$get$boolField()]);

  @override
  Future<double> get notAField =>
      invoke<double>(channel, [$get$nameOverrideField()]);
}

@Class(IosPlatform(
  IosType('TestClass2', import: '"TestPlugin.h"'),
))
class IosTestClass2 extends $IosTestClass2 with TestClass2 {
  @Constructor()
  IosTestClass2() : super.$Default(channel: channel);

  IosTestClass2.fromUniqueId(String uniqueId)
      : super.fromUniqueId(uniqueId, channel: channel);
}

@Class(IosPlatform(IosType('GenericClass', import: '"TestPlugin.h"')))
class IosGenericClass<T> extends $IosGenericClass<T> with GenericClass<T> {
  @Constructor()
  IosGenericClass() : super.$Default(channel: channel);

  IosGenericClass.fromUniqueId(String uniqueId)
      : super.fromUniqueId(uniqueId, channel: channel);

  @override
  Future<void> add(T object) {
    if (isTypeOf<T, Wrapper>()) {
      return invoke<void>(
        channel,
        [$add(object)],
      );
    }

    return invoke<void>(channel, [$add(object)]);
  }

  @override
  Future<T> get(String identifier) async {
    if (isTypeOf<T, Wrapper>()) {
      return invoke<T>(
        channel,
        [$get(identifier)],
        genericHelper: _GenericHelper.instance,
      );
    }

    return invoke<T>(channel, [$get(identifier)]);
  }
}

@Class(IosPlatform(
  IosType('TestStruct', isStruct: true, import: '"TestPlugin.h"'),
))
class TestStruct extends $TestStruct {
  @Constructor()
  TestStruct() : super.$Default(channel: channel);

  TestStruct.fromUniqueId(String uniqueId)
      : super.fromUniqueId(uniqueId, channel: channel);

  @Field()
  @int32
  Future<int> get intField => invoke<int>(channel, [$get$intField()]);
}

@Class(IosPlatform(IosType('TestProtocol', import: '"TestPlugin.h"')))
class IosProtocol extends $IosProtocol {
  @Constructor()
  IosProtocol() : super.$Default(channel: channel);

  IosProtocol.fromUniqueId(String uniqueId)
      : super.fromUniqueId(uniqueId, channel: channel);

  @Method(callback: true)
  Future<void> callbackMethod() => invoke<void>(channel, [$callbackMethod()]);
}
