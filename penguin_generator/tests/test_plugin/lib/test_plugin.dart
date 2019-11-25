import 'dart:async';
import 'dart:math';
import 'dart:io' as io;

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';

import 'android.penguin.g.dart' as android;
import 'ios.penguin.g.dart' as ios;

final MethodChannel _channel = MethodChannel('test_plugin');
String _randomId() => Random().nextDouble().toString();

@Class(AndroidPlatform(
  AndroidType('android.app', <String>['Activity']),
))
class _AndroidActivity {
  _AndroidActivity();

  final android.$_AndroidActivity _activity =
      android.$_AndroidActivity('activity');
}

@Class(AndroidPlatform(
  AndroidType('com.example.test_plugin.test_library', <String>['TestClass1']),
))
class AndroidTestClass1 extends TestClass1 {
  @Constructor()
  AndroidTestClass1();
}

@Class(IosPlatform(
  IosType('TestClass1', import: '"TestPlugin.h"'),
))
class IosTestClass1 extends TestClass1 {
  @Constructor()
  IosTestClass1();
}

abstract class TestClass1 {
  TestClass1() {
    _constructorMethodCall = io.Platform.isAndroid
        ? _android.$AndroidTestClass1$Default()
        : _ios.$IosTestClass1$Default();
  }
  final android.$AndroidTestClass1 _android =
      android.$AndroidTestClass1(_randomId());
  final ios.$IosTestClass1 _ios = ios.$IosTestClass1(_randomId());

  MethodCall _constructorMethodCall;

  @Method()
  Future<void> returnVoid() {
    return android.invoke<void>(
      _channel,
      _constructorMethodCall,
      <MethodCall>[
        io.Platform.isAndroid ? _android.$returnVoid() : _ios.$returnVoid(),
      ],
    );
  }

  @Method()
  Future<String> returnString() {
    return android.invoke<String>(
      _channel,
      _constructorMethodCall,
      <MethodCall>[
        io.Platform.isAndroid ? _android.$returnString() : _ios.$returnString(),
      ],
    );
  }

  @Method()
  Future<int> returnInt() {
    return android.invoke<int>(
      _channel,
      _constructorMethodCall,
      <MethodCall>[
        io.Platform.isAndroid ? _android.$returnInt() : _ios.$returnInt(),
      ],
    );
  }

  @Method()
  Future<double> returnDouble() {
    return android.invoke<double>(
      _channel,
      _constructorMethodCall,
      <MethodCall>[
        io.Platform.isAndroid ? _android.$returnDouble() : _ios.$returnDouble(),
      ],
    );
  }

  @Method()
  Future<bool> returnBool() {
    return android.invoke<bool>(
      _channel,
      _constructorMethodCall,
      <MethodCall>[
        io.Platform.isAndroid ? _android.$returnBool() : _ios.$returnBool(),
      ],
    );
  }

  @Method()
  Future<List<double>> returnList() {
    return android.invokeList<double>(
      _channel,
      _constructorMethodCall,
      <MethodCall>[
        io.Platform.isAndroid ? _android.$returnList() : _ios.$returnList(),
      ],
    );
  }

  @Method()
  Future<Map<String, int>> returnMap() {
    return android.invokeMap<String, int>(
      _channel,
      _constructorMethodCall,
      <MethodCall>[
        io.Platform.isAndroid ? _android.$returnMap() : _ios.$returnMap(),
      ],
    );
  }
}

//final a.CallbackHandler callbackHandler = a.CallbackHandler();
//final MethodChannel _channel = MethodChannel('test_plugin')
//  ..setMethodCallHandler(callbackHandler.methodCallHandler);
//String _randomId() => Random().nextDouble().toString();
//
//@Class(
//  AndroidPlatform(
//    AndroidType(
//      'com.example.test_plugin.test_library',
//      <String>['AbstractTestClass'],
//    ),
//  ),
//)
//class AndroidAbstractClass {}
//
//@Class(
//  AndroidPlatform(
//    AndroidType(
//      'com.example.test_plugin.test_library.TestClass1',
//      <String>['TestEnum'],
//    ),
//  ),
//)
//class AndroidTestEnum {
//  AndroidTestEnum._(this._testEnum);
//
//  final a.$AndroidTestEnum _testEnum;
//
//  @Field()
//  static final AndroidTestEnum ONE =
//      AndroidTestEnum._(a.$AndroidTestEnum(_randomId()));
//
//  @Field()
//  static final AndroidTestEnum TWO =
//      AndroidTestEnum._(a.$AndroidTestEnum(_randomId()));
//
//  @Method()
//  Future<int> enumMethod() {
//    return a.invoke<int>(
//      _channel,
//      a.$AndroidTestEnum.$ONE($newUniqueId: _testEnum.uniqueId),
//      <MethodCall>[_testEnum.$enumMethod()],
//    );
//  }
//}
//
//@Class(AndroidPlatform(
//  AndroidType('android.app', <String>['Activity']),
//))
//class _AndroidActivity {
//  _AndroidActivity() : activity = a.$_AndroidActivity('activity');
//
//  final a.$_AndroidActivity activity;
//}
//
//class AndroidTextView extends StatefulWidget {
//  AndroidTextView(this.text);
//
//  final String text;
//
//  @override
//  State<StatefulWidget> createState() =>
//      _AndroidTextViewState(_AndroidActivity());
//}
//
//@Class(AndroidPlatform(
//  AndroidType('android.widget', <String>['TextView']),
//))
//class _AndroidTextViewState extends State<AndroidTextView> {
//  @Constructor()
//  _AndroidTextViewState(this._activity);
//
//  final _AndroidActivity _activity;
//  a.$_AndroidTextViewState _textView;
//
//  @Method()
//  void setText(String text) {}
//
//  @override
//  void initState() {
//    super.initState();
//    _textView = a.$_AndroidTextViewState(_randomId());
//    a.invokeAll(_channel, [
//      _textView.$_AndroidTextViewState$Default(_activity.activity),
//      _textView.allocate(),
//    ]);
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//    a.invoke<void>(_channel, _textView.deallocate());
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    a.invoke<void>(_channel, _textView.$setText(widget.text));
//    return AndroidView(
//      viewType: '${_channel.name}/view',
//      creationParams: _textView.uniqueId,
//      creationParamsCodec: const StandardMessageCodec(),
//    );
//  }
//}
//
//@Class(AndroidPlatform(
//  AndroidType('com.example.test_plugin.test_library', <String>['TestClass1']),
//))
//class AndroidTestClass1 {
//  @Constructor()
//  AndroidTestClass1() {
//    _testClass = a.$AndroidTestClass1(
//      _randomId(),
//      $callbackMethod$Callback:
//          (a.$AndroidTestClass3 wrapper, String supported) {
//        assert(wrapper != null);
//        assert(wrapper.uniqueId != null);
//        callbackMethod(AndroidTestClass3._(wrapper), supported);
//        return <MethodCall>[wrapper.allocate(), wrapper.deallocate()];
//      },
//    );
//  }
//
//  @Constructor()
//  AndroidTestClass1.namedConstructor(String constructorValue)
//      : _constructorValue = constructorValue {
//    _testClass = a.$AndroidTestClass1(
//      _randomId(),
//      $callbackMethod$Callback:
//          (a.$AndroidTestClass3 wrapper, String supported) {
//        assert(wrapper != null);
//        assert(wrapper.uniqueId != null);
//        callbackMethod(AndroidTestClass3._(wrapper), supported);
//        return <MethodCall>[wrapper.allocate(), wrapper.deallocate()];
//      },
//    );
//  }
//
//  String _constructorValue;
//
//  @Field()
//  Future<String> get constructorValue => a.invoke<String>(
//        _channel,
//        _testClass.$AndroidTestClass1namedConstructor(_constructorValue),
//        [_testClass.$constructorValue()],
//      );
//
//  a.$AndroidTestClass1 _testClass;
//
//  final List<MethodCall> _setters = <MethodCall>[];
//
//  @Method()
//  static Future<int> staticMethod() {
//    return a.invoke<int>(_channel, a.$AndroidTestClass1.$staticMethod());
//  }
//
//  @Field()
//  static Future<int> get staticField => a.invoke<int>(
//        _channel,
//        a.$AndroidTestClass1.$staticField(),
//      );
//
//  @Field()
//  Future<Object> get objectField => a.invoke<Object>(
//        _channel,
//        _testClass.$AndroidTestClass1$Default(),
//        [..._setters, _testClass.$objectField()],
//      );
//
//  @Field()
//  set objectField(FutureOr<Object> objectField) {
//    _setters.add(_testClass.$objectField(objectField: objectField));
//    a.invoke<Object>(
//      _channel,
//      _testClass.$AndroidTestClass1$Default(),
//      [_testClass.$objectField(objectField: objectField)],
//    );
//  }
//
//  @Field()
//  Future<dynamic> get dynamicField => a.invoke<dynamic>(
//        _channel,
//        _testClass.$AndroidTestClass1$Default(),
//        [_testClass.$dynamicField()],
//      );
//
//  @Field()
//  Future<String> get stringField => a.invoke<String>(
//        _channel,
//        _testClass.$AndroidTestClass1$Default(),
//        [_testClass.$stringField()],
//      );
//
//  @Field()
//  Future<int> get intField => a.invoke<int>(
//        _channel,
//        _testClass.$AndroidTestClass1$Default(),
//        [_testClass.$intField()],
//      );
//
//  @Field()
//  Future<double> get doubleField => a.invoke<double>(
//        _channel,
//        _testClass.$AndroidTestClass1$Default(),
//        [_testClass.$doubleField()],
//      );
//
//  @Field()
//  Future<num> get numField => a.invoke<num>(
//        _channel,
//        _testClass.$AndroidTestClass1$Default(),
//        [_testClass.$numField()],
//      );
//
//  @Field()
//  Future<bool> get boolField => a.invoke<bool>(
//        _channel,
//        _testClass.$AndroidTestClass1$Default(),
//        [_testClass.$boolField()],
//      );
//
//  @Field()
//  Future<List<bool>> get listField => a.invokeList<bool>(
//        _channel,
//        _testClass.$AndroidTestClass1$Default(),
//        [_testClass.$listField()],
//      );
//
//  @Field()
//  Future<Map<String, double>> get mapField => a.invokeMap<String, double>(
//        _channel,
//        _testClass.$AndroidTestClass1$Default(),
//        [_testClass.$mapField()],
//      );
//
//  @Method(callback: true)
//  Future<void> callbackMethod(
//      AndroidTestClass3 wrapper, String supported) async {
//    print(supported);
//    callbackHandler.removeWrapper(_testClass);
//  }
//
//  @Method()
//  Future<void> callCallbackMethod() {
//    callbackHandler.addWrapper(_testClass);
//    return a.invoke<void>(
//      _channel,
//      _testClass.$AndroidTestClass1$Default(),
//      [_testClass.$callCallbackMethod()],
//    );
//  }
//
//  @Method()
//  Future<void> returnVoid() {
//    return a.invoke<void>(
//      _channel,
//      _testClass.$AndroidTestClass1$Default(),
//      [_testClass.$returnVoid()],
//    );
//  }
//
//  @Method()
//  Future<Object> returnObject() {
//    return a.invoke<Object>(
//      _channel,
//      _testClass.$AndroidTestClass1$Default(),
//      [_testClass.$returnObject()],
//    );
//  }
//
//  @Method()
//  Future<dynamic> returnDynamic() {
//    return a.invoke<dynamic>(
//      _channel,
//      _testClass.$AndroidTestClass1$Default(),
//      [_testClass.$returnDynamic()],
//    );
//  }
//
//  @Method()
//  Future<String> returnString() {
//    return a.invoke<String>(
//      _channel,
//      _testClass.$AndroidTestClass1$Default(),
//      [_testClass.$returnString()],
//    );
//  }
//
//  @Method()
//  Future<int> returnInt() {
//    return a.invoke<int>(
//      _channel,
//      _testClass.$AndroidTestClass1$Default(),
//      [_testClass.$returnInt()],
//    );
//  }
//
//  @Method()
//  Future<double> returnDouble() {
//    return a.invoke<double>(
//      _channel,
//      _testClass.$AndroidTestClass1$Default(),
//      [_testClass.$returnDouble()],
//    );
//  }
//
//  @Method()
//  Future<bool> returnBool() {
//    return a.invoke<bool>(
//      _channel,
//      _testClass.$AndroidTestClass1$Default(),
//      [_testClass.$returnBool()],
//    );
//  }
//
//  @Method()
//  Future<List<double>> returnList() {
//    return a.invokeList<double>(
//      _channel,
//      _testClass.$AndroidTestClass1$Default(),
//      [_testClass.$returnList()],
//    );
//  }
//
//  @Method()
//  Future<Map<String, int>> returnMap() {
//    return a.invokeMap<String, int>(
//      _channel,
//      _testClass.$AndroidTestClass1$Default(),
//      [_testClass.$returnMap()],
//    );
//  }
//
//  @Method()
//  Future<int> noParametersMethod() {
//    return a.invoke<int>(
//      _channel,
//      _testClass.$AndroidTestClass1$Default(),
//      [_testClass.$noParametersMethod()],
//    );
//  }
//
//  @Method()
//  Future<String> singleParameterMethod(String value) {
//    return a.invoke<String>(
//      _channel,
//      _testClass.$AndroidTestClass1$Default(),
//      [_testClass.$singleParameterMethod(value)],
//    );
//  }
//
//  @Method()
//  Future<void> passParameters(
//    int primitive,
//    AndroidTestClass3 wrapper,
//    AndroidNestedClass nested,
//    AndroidAbstractClass abstractClass,
//  ) {
//    return a.invoke<void>(
//      _channel,
//      wrapper._androidTestClass3.$AndroidTestClass3$Default(),
//      <MethodCall>[
//        (abstractClass as AndroidTestClass3)
//            ._androidTestClass3
//            .$AndroidTestClass3$Default(),
//        nested._testClass.$AndroidNestedClass$Default(),
//        _testClass.$AndroidTestClass1$Default(),
//        _testClass.$passParameters(
//          primitive,
//          wrapper._androidTestClass3,
//          nested._testClass,
//          a.$AndroidAbstractClass(
//            (abstractClass as AndroidTestClass3)._androidTestClass3.uniqueId,
//          ),
//        ),
//      ],
//    );
//  }
//}
//
//@Class(AndroidPlatform(
//  AndroidType(
//    'com.example.test_plugin.test_library',
//    <String>['TestClass1', 'NestedTestClass'],
//  ),
//))
//class AndroidNestedClass {
//  @Constructor()
//  AndroidNestedClass();
//
//  final a.$AndroidNestedClass _testClass = a.$AndroidNestedClass(_randomId());
//
//  @Field()
//  Future<int> get nestedClassField => a.invoke<int>(
//        _channel,
//        _testClass.$AndroidNestedClass$Default(),
//        [_testClass.$nestedClassField()],
//      );
//
//  @Method()
//  Future<int> nestedClassMethod() => a.invoke<int>(
//        _channel,
//        _testClass.$AndroidNestedClass$Default(),
//        [_testClass.$nestedClassMethod()],
//      );
//}
//
//@Class(
//  AndroidPlatform(
//    AndroidType('com.example.test_plugin.test_library', <String>['TestClass2']),
//  ),
//  androidApi: AndroidApi(21),
//)
//class AndroidTestClass2 {
//  @Constructor()
//  AndroidTestClass2();
//}
//
//@Class(
//  AndroidPlatform(
//    AndroidType('com.example.test_plugin.test_library', <String>['TestClass3']),
//  ),
//)
//class AndroidTestClass3 extends AndroidAbstractClass {
//  @Constructor()
//  AndroidTestClass3() : _androidTestClass3 = a.$AndroidTestClass3(_randomId());
//
//  AndroidTestClass3._(this._androidTestClass3);
//
//  final a.$AndroidTestClass3 _androidTestClass3;
//}

//@Class(IosPlatform(
//  IosType('TestClass1', import: '"TestPlugin.h"'),
//))
//class IosTestClass1 {
//  @Constructor()
//  IosTestClass1();
//
//  final i.$IosTestClass1 _testClass = i.$IosTestClass1(_randomId());
//  final List<MethodCall> _setters = <MethodCall>[];
//
//  @Method()
//  Future<void> returnVoid() {
//    return a.invoke<void>(
//      _channel,
//      _testClass.$IosTestClass1$Default(),
//      [_testClass.$returnVoid()],
//    );
//  }
//
//  @Method()
//  Future<Object> returnObject() {
//    return a.invoke<Object>(
//      _channel,
//      _testClass.$IosTestClass1$Default(),
//      [_testClass.$returnObject()],
//    );
//  }
//
//  @Method()
//  Future<dynamic> returnDynamic() {
//    return a.invoke<dynamic>(
//      _channel,
//      _testClass.$IosTestClass1$Default(),
//      [_testClass.$returnDynamic()],
//    );
//  }
//
//  @Method()
//  Future<String> returnString() {
//    return a.invoke<String>(
//      _channel,
//      _testClass.$IosTestClass1$Default(),
//      [_testClass.$returnString()],
//    );
//  }
//
//  @Method()
//  Future<int> returnInt() {
//    return a.invoke<int>(
//      _channel,
//      _testClass.$IosTestClass1$Default(),
//      [_testClass.$returnInt()],
//    );
//  }
//
//  @int32
//  @Method()
//  Future<int> returnInt32() {
//    return a.invoke<int>(
//      _channel,
//      _testClass.$IosTestClass1$Default(),
//      [_testClass.$returnInt32()],
//    );
//  }
//
//  @Method()
//  Future<double> returnDouble() {
//    return a.invoke<double>(
//      _channel,
//      _testClass.$IosTestClass1$Default(),
//      [_testClass.$returnDouble()],
//    );
//  }
//
//  @Method()
//  Future<bool> returnBool() {
//    return a.invoke<bool>(
//      _channel,
//      _testClass.$IosTestClass1$Default(),
//      [_testClass.$returnBool()],
//    );
//  }
//
//  @Method()
//  Future<List<double>> returnList() {
//    return a.invokeList<double>(
//      _channel,
//      _testClass.$IosTestClass1$Default(),
//      [_testClass.$returnList()],
//    );
//  }
//
//  @Method()
//  Future<Map<String, int>> returnMap() {
//    return a.invokeMap<String, int>(
//      _channel,
//      _testClass.$IosTestClass1$Default(),
//      [_testClass.$returnMap()],
//    );
//  }
//
//  @Method()
//  Future<int> noParametersMethod() {
//    return a.invoke<int>(
//      _channel,
//      _testClass.$IosTestClass1$Default(),
//      [_testClass.$noParametersMethod()],
//    );
//  }
//
//  @Method()
//  Future<String> singleParameterMethod(String value) {
//    return a.invoke<String>(
//      _channel,
//      _testClass.$IosTestClass1$Default(),
//      [_testClass.$singleParameterMethod(value)],
//    );
//  }
//
//  @Method()
//  Future<String> allParameterTypesMethod(@int32 int intValue) {
//    return a.invoke<String>(
//      _channel,
//      _testClass.$IosTestClass1$Default(),
//      [_testClass.$allParameterTypesMethod(intValue)],
//    );
//  }
//}
