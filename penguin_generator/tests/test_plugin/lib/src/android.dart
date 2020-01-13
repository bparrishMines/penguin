import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';
import 'package:penguin_plugin/penguin_plugin.dart';

import '../test_plugin.dart';
import 'test_plugin_interface.dart';

part 'android.android.penguin.g.dart';

class AndroidTextViewState extends State<TextViewWidget> {
  final String callbackId = Random().nextDouble().toString();
  
  @override
  void initState() {
    super.initState();
    PenguinPlugin.addAndroidViewCreatorCallback(callbackId, onCreateView);
  }

  @override
  Widget build(BuildContext context) {
    return AndroidView(
      viewType: '${channel.name}/view',
      creationParams: callbackId,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }

  Future<String> onCreateView(Context context) {
    final TextView textView = TextView(context);
    textView.setText(widget.text);
    return Future<String>.value(textView.autoReleasePool().uniqueId);
  }
}

@Class(AndroidPlatform(
  AndroidType('android.widget', <String>['TextView']),
))
class TextView extends $TextView {
  @Constructor()
  TextView(Context context) : super.$Default(context, channel: channel);

  TextView.fromUniqueId(String uniqueId)
      : super.fromUniqueId(uniqueId, channel: channel);

  @Method()
  Future<void> setText(String text) => invoke<void>(channel, [$setText(text)]);
}

@Class(AndroidPlatform(
  AndroidType('com.example.test_plugin.test_library', <String>['TestClass1']),
))
class AndroidTestClass1 extends $AndroidTestClass1 with TestClass1 {
  @Constructor()
  AndroidTestClass1() : super.$Default(channel: channel);

  AndroidTestClass1.fromUniqueId(String uniqueId)
      : super.fromUniqueId(uniqueId, channel: channel);

  @Constructor()
  AndroidTestClass1.namedConstructor()
      : super.namedConstructor(channel: channel);

  @Field()
  static Future<List<bool>> get staticField =>
      invokeList<bool>(channel, [$AndroidTestClass1.$get$staticField()]);

  @Method()
  static Future<void> staticMethod() =>
      invoke<void>(channel, [$AndroidTestClass1.$staticMethod()]);

  @Method()
  Future<void> parameterMethod(
    String supported,
    @int64 int primitive,
    AndroidTestClass2 wrapper,
    AndroidNestedClass nested,
  ) =>
      invoke<void>(
          channel, [$parameterMethod(supported, primitive, wrapper, nested)]);

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
  Future<AndroidTestClass1> returnWrapper() =>
      invoke<AndroidTestClass1>(channel, [$returnWrapper()],
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

@Class(
  AndroidPlatform(
    AndroidType('com.example.test_plugin.test_library', <String>['TestClass2']),
  ),
  androidApi: AndroidApi(21),
)
class AndroidTestClass2 extends $AndroidTestClass2 with TestClass2 {
  @Constructor()
  AndroidTestClass2() : super.$Default(channel: channel);

  AndroidTestClass2.fromUniqueId(String uniqueId)
      : super.fromUniqueId(uniqueId, channel: channel);
}

@Class(AndroidPlatform(AndroidType(
  'com.example.test_plugin.test_library',
  <String>['GenericClass'],
)))
class AndroidGenericClass<T> extends $AndroidGenericClass<T>
    with GenericClass<T> {
  @Constructor()
  AndroidGenericClass() : super.$Default(channel: channel);

  AndroidGenericClass.fromUniqueId(String uniqueId)
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

@Class(AndroidPlatform(
  AndroidType(
    'com.example.test_plugin.test_library',
    <String>['TestClass1', 'NestedTestClass'],
  ),
))
class AndroidNestedClass extends $AndroidNestedClass {
  @Constructor()
  AndroidNestedClass() : super.$Default(channel: channel);

  AndroidNestedClass.fromUniqueId(String uniqueId)
      : super.fromUniqueId(uniqueId, channel: channel);
}

@Class(AndroidPlatform(
  AndroidType(
    'com.example.test_plugin.test_library',
    <String>['AbstractTestClass'],
  ),
))
class AndroidAbstractClass extends $AndroidAbstractClass {
  @Constructor()
  AndroidAbstractClass() : super.$Default(channel: channel);

  AndroidAbstractClass.fromUniqueId(String uniqueId)
      : super.fromUniqueId(uniqueId, channel: channel);

  @Method(callback: true)
  Future<void> callbackMethod(
    String supported,
    @int64 int primitive,
    AndroidTestClass2 wrapper,
    AndroidNestedClass nested,
  ) =>
      invoke<void>(
          channel, [$callbackMethod(supported, primitive, wrapper, nested)]);
}
