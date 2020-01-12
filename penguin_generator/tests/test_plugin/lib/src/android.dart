import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';
import 'package:penguin_plugin/penguin_plugin.dart';

import '../test_plugin.dart';
import 'test_plugin_interface.dart';

part 'android.android.penguin.g.dart';

class AndroidTextViewState extends State<TextViewWidget> with AndroidViewCreator {
  AndroidTextViewState() {
    PenguinPlugin.androidCreator = this;
  }

  final String identifier = 'aaoiej;oaijwfe;';

  @override
  Widget build(BuildContext context) {
    return AndroidView(
      viewType: '${PenguinPlugin.globalMethodChannel.name}/view',
      creationParams: identifier,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }

  @override
  Future<String> onCreateView(Context context, String viewId) {
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
  TextView(Context context) : super.$Default(context);

  TextView.fromUniqueId(String uniqueId)
      : super.fromUniqueId(uniqueId);

  @Method()
  Future<void> setText(String text) => invoke<void>(PenguinPlugin.globalMethodChannel, [$setText(text)]);
}

@Class(AndroidPlatform(
  AndroidType('com.example.test_plugin.test_library', <String>['TestClass1']),
))
class AndroidTestClass1 extends $AndroidTestClass1 with TestClass1 {
  @Constructor()
  AndroidTestClass1() : super.$Default();

  AndroidTestClass1.fromUniqueId(String uniqueId)
      : super.fromUniqueId(uniqueId);

  @Constructor()
  AndroidTestClass1.namedConstructor() : super.namedConstructor();

  @Field()
  static Future<List<bool>> get staticField => invokeList<bool>(
      PenguinPlugin.globalMethodChannel, [$AndroidTestClass1.$get$staticField()]);

  @Method()
  static Future<void> staticMethod() => invoke<void>(
      PenguinPlugin.globalMethodChannel, [$AndroidTestClass1.$staticMethod()]);

  @Method()
  Future<void> parameterMethod(
    String supported,
    @int64 int primitive,
    AndroidTestClass2 wrapper,
    AndroidNestedClass nested,
  ) =>
      invoke<void>(PenguinPlugin.globalMethodChannel,
          [$parameterMethod(supported, primitive, wrapper, nested)]);

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
  Future<AndroidTestClass1> returnWrapper() => invoke<AndroidTestClass1>(
      PenguinPlugin.globalMethodChannel, [$returnWrapper()],
      genericHelper: _GenericHelper.instance);

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

@Class(
  AndroidPlatform(
    AndroidType('com.example.test_plugin.test_library', <String>['TestClass2']),
  ),
  androidApi: AndroidApi(21),
)
class AndroidTestClass2 extends $AndroidTestClass2 with TestClass2 {
  @Constructor()
  AndroidTestClass2() : super.$Default();

  AndroidTestClass2.fromUniqueId(String uniqueId)
      : super.fromUniqueId(uniqueId);
}

@Class(AndroidPlatform(AndroidType(
  'com.example.test_plugin.test_library',
  <String>['GenericClass'],
)))
class AndroidGenericClass<T> extends $AndroidGenericClass<T>
    with GenericClass<T> {
  @Constructor()
  AndroidGenericClass() : super.$Default();

  AndroidGenericClass.fromUniqueId(String uniqueId)
      : super.fromUniqueId(uniqueId);

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

@Class(AndroidPlatform(
  AndroidType(
    'com.example.test_plugin.test_library',
    <String>['TestClass1', 'NestedTestClass'],
  ),
))
class AndroidNestedClass extends $AndroidNestedClass {
  @Constructor()
  AndroidNestedClass() : super.$Default();

  AndroidNestedClass.fromUniqueId(String uniqueId)
      : super.fromUniqueId(uniqueId);
}

@Class(AndroidPlatform(
  AndroidType(
    'com.example.test_plugin.test_library',
    <String>['AbstractTestClass'],
  ),
))
class AndroidAbstractClass extends $AndroidAbstractClass {
  @Constructor()
  AndroidAbstractClass() : super.$Default();

  AndroidAbstractClass.fromUniqueId(String uniqueId)
      : super.fromUniqueId(uniqueId);

  @Method(callback: true)
  Future<void> callbackMethod(
    String supported,
    @int64 int primitive,
    AndroidTestClass2 wrapper,
    AndroidNestedClass nested,
  ) =>
      invoke<void>(PenguinPlugin.globalMethodChannel,
          [$callbackMethod(supported, primitive, wrapper, nested)]);
}
