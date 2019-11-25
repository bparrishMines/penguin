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

class AndroidTextView extends StatefulWidget {
  AndroidTextView(this.text) : assert(text != null);

  final String text;

  @override
  State<StatefulWidget> createState() =>
      _AndroidTextViewState(_AndroidActivity());
}

@Class(AndroidPlatform(
  AndroidType('android.widget', <String>['TextView']),
))
class _AndroidTextViewState extends State<AndroidTextView> {
  @Constructor()
  _AndroidTextViewState(this._activity);

  final _AndroidActivity _activity;
  android.$_AndroidTextViewState _textView;

  @Method()
  void setText(String text) {}

  @override
  void initState() {
    super.initState();
    _textView = android.$_AndroidTextViewState(_randomId());
    android.invokeAll(_channel, <MethodCall>[
      _textView.$_AndroidTextViewState$Default(_activity._activity),
      _textView.allocate(),
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    android.invoke<void>(_channel, _textView.deallocate());
  }

  @override
  Widget build(BuildContext context) {
    android.invoke<void>(_channel, _textView.$setText(widget.text));
    return AndroidView(
      viewType: '${_channel.name}/view',
      creationParams: _textView.uniqueId,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}

@Class(AndroidPlatform(
  AndroidType('com.example.test_plugin.test_library', <String>['TestClass1']),
))
class AndroidTestClass1 extends TestClass1 {
  @Constructor()
  AndroidTestClass1();

  @Method()
  static Future<void> staticMethod() {
    return android.invoke<void>(
      _channel,
      io.Platform.isAndroid
          ? android.$AndroidTestClass1.$staticMethod()
          : ios.$IosTestClass1.$staticMethod(),
    );
  }

  @Method()
  Future<void> parameterMethod(
    String supported,
    int primitive,
    AndroidTestClass2 wrapper,
  ) {
    return android.invoke<void>(
      _channel,
      _constructorMethodCall,
      <MethodCall>[
        wrapper._constructorMethodCall,
        _android.$parameterMethod(supported, primitive, wrapper._android),
      ],
    );
  }
}

@Class(IosPlatform(
  IosType('TestClass1', import: '"TestPlugin.h"'),
))
class IosTestClass1 extends TestClass1 {
  @Constructor()
  IosTestClass1();

  @Method()
  static Future<void> staticMethod() {
    return android.invoke<void>(
      _channel,
      io.Platform.isAndroid
          ? android.$AndroidTestClass1.$staticMethod()
          : ios.$IosTestClass1.$staticMethod(),
    );
  }

  @Method()
  Future<void> parameterMethod(
    String supported,
    @int32 int primitive,
    IosTestClass2 wrapper,
  ) {
    return android.invoke<void>(
      _channel,
      _constructorMethodCall,
      <MethodCall>[
        wrapper._constructorMethodCall,
        _ios.$parameterMethod(supported, primitive, wrapper._ios),
      ],
    );
  }

  @Method()
  @int32
  Future<int> returnInt32() {
    return android.invoke<int>(
      _channel,
      _constructorMethodCall,
      <MethodCall>[_ios.$returnInt32()],
    );
  }
}

@Class(
  AndroidPlatform(
    AndroidType('com.example.test_plugin.test_library', <String>['TestClass2']),
  ),
  androidApi: AndroidApi(21),
)
class AndroidTestClass2 extends TestClass2 {
  @Constructor()
  AndroidTestClass2();
}

@Class(IosPlatform(
  IosType('TestClass2', import: '"TestPlugin.h"'),
))
class IosTestClass2 extends TestClass2 {
  @Constructor()
  IosTestClass2();
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

  @Method()
  Future<Object> returnObject() {
    return android.invoke<Object>(
      _channel,
      _constructorMethodCall,
      <MethodCall>[
        io.Platform.isAndroid ? _android.$returnObject() : _ios.$returnObject(),
      ],
    );
  }

  @Method()
  Future<dynamic> returnDynamic() {
    return android.invoke<dynamic>(
      _channel,
      _constructorMethodCall,
      <MethodCall>[
        io.Platform.isAndroid
            ? _android.$returnDynamic()
            : _ios.$returnDynamic(),
      ],
    );
  }
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
