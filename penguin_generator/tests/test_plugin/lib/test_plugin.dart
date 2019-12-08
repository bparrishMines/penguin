import 'dart:async';
import 'dart:math';
import 'dart:io' as io;

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';

import 'android.penguin.g.dart' as android;
import 'ios.penguin.g.dart' as ios;

final android.CallbackHandler androidCallbackHandler =
    android.CallbackHandler();
final ios.CallbackHandler iosCallbackHandler = ios.CallbackHandler();
final MethodChannel _channel = MethodChannel('test_plugin')
  ..setMethodCallHandler(io.Platform.isAndroid
      ? androidCallbackHandler.methodCallHandler
      : iosCallbackHandler.methodCallHandler);
String _randomId() => Random().nextDouble().toString();

@Class(AndroidPlatform(
  AndroidType(
    'com.example.test_plugin.test_library',
    <String>['TestClass1', 'NestedTestClass'],
  ),
))
class AndroidNestedClass {
  @Constructor()
  AndroidNestedClass();

  final android.$AndroidNestedClass _testClass =
      android.$AndroidNestedClass(_randomId());
}

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

@Class(IosPlatform(
  IosType('UITextView'),
))
class _IosTextViewState extends State<TextView> {
  _IosTextViewState(this.text);

  /// Internal. Only for code gen. DO NOT USE
  @Constructor()
  _IosTextViewState.initWithFrame(CGRect frame);

  @Field()
  String text;

  ios.$_IosTextViewState _textView;

  @override
  void initState() {
    super.initState();
    _textView = ios.$_IosTextViewState(
      _randomId(),
      onCreateView: (ios.$CGRect cgRect) {
        return <MethodCall>[
          _textView.$_IosTextViewStateinitWithFrame(cgRect),
          _textView.$text(text: text),
          _textView.allocate(),
        ];
      },
    );
    iosCallbackHandler.addWrapper(_textView);
  }

  @override
  void dispose() {
    super.dispose();
    iosCallbackHandler.removeWrapper(_textView);
  }

  @override
  Widget build(BuildContext context) {
    return UiKitView(
      viewType: '${_channel.name}/view',
      creationParams: _textView.uniqueId,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}

@Class(AndroidPlatform(
  AndroidType('android.widget', <String>['TextView']),
))
class _AndroidTextViewState extends State<TextView> {
  @Constructor()
  _AndroidTextViewState(Context context);

  android.$_AndroidTextViewState _textView;

  @Method()
  void setText(String text) {}

  @override
  void initState() {
    super.initState();
    _textView = android.$_AndroidTextViewState(
      _randomId(),
      onCreateView: (android.$Context context) {
        return <MethodCall>[
          _textView.$_AndroidTextViewState$Default(context),
          _textView.$setText(widget.text),
        ];
      },
    );
    androidCallbackHandler.addWrapper(_textView);
  }

  @override
  void dispose() {
    super.dispose();
    androidCallbackHandler.removeWrapper(_textView);
  }

  @override
  Widget build(BuildContext context) {
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
  AndroidTestClass1() {
    _constructorMethodCalls = [_android.$AndroidTestClass1$Default()];
  }

  @Constructor()
  AndroidTestClass1.namedConstructor(
    String supported,
    @int64 int primitive,
    AndroidTestClass2 wrapper,
    AndroidNestedClass nested,
  ) {
    _constructorMethodCalls = [
      wrapper._android.$AndroidTestClass2$Default(),
      nested._testClass.$AndroidNestedClass$Default(),
      _android.$AndroidTestClass1namedConstructor(
        supported,
        primitive,
        wrapper._android,
        nested._testClass,
      )
    ];
  }

  @Field()
  static Future<List<bool>> get staticField {
    return android.invokeList<bool>(
      _channel,
      android.$AndroidTestClass1.$staticField(),
    );
  }

  @Method()
  static Future<void> staticMethod() {
    return android.invoke<void>(
      _channel,
      android.$AndroidTestClass1.$staticMethod(),
    );
  }

  @Method()
  Future<void> parameterMethod(
    String supported,
    @int64 int primitive,
    AndroidTestClass2 wrapper,
    AndroidNestedClass nested,
  ) {
    return android.invoke<void>(
      _channel,
      _constructorMethodCalls[0],
      <MethodCall>[
        ..._constructorMethodCalls.skip(1).toList(),
        wrapper._constructorMethodCall,
        nested._testClass.$AndroidNestedClass$Default(),
        _android.$parameterMethod(
          supported,
          primitive,
          wrapper._android,
          nested._testClass,
        ),
      ],
    );
  }
}

@Class(IosPlatform(
  IosType('TestClass1', import: '"TestPlugin.h"'),
))
class IosTestClass1 extends TestClass1 {
  @Constructor()
  IosTestClass1() {
    _constructorMethodCalls = [_ios.$IosTestClass1$Default()];
  }

  @Constructor()
  IosTestClass1.initNamedConstructor(
    String supported,
    @int32 int primitive,
    IosTestClass2 wrapper,
  ) {
    _constructorMethodCalls = [
      wrapper._ios.$IosTestClass2$Default(),
      _ios.$IosTestClass1initNamedConstructor(
        supported,
        primitive,
        wrapper._ios,
      )
    ];
  }

  @Field()
  static Future<List<bool>> get staticField {
    return android.invokeList<bool>(
      _channel,
      ios.$IosTestClass1.$staticField(),
    );
  }

  @Method()
  static Future<void> staticMethod() {
    return android.invoke<void>(
      _channel,
      ios.$IosTestClass1.$staticMethod(),
    );
  }

  @Method()
  Future<void> parameterMethod(
    String supported,
    @int32 int primitive,
    IosTestClass2 wrapper,
    CGRect aStruct,
  ) {
    final ios.$CGRect rect = ios.$CGRect(_randomId());
    return android.invoke<void>(
      _channel,
      _constructorMethodCalls[0],
      <MethodCall>[
        ..._constructorMethodCalls.skip(1).toList(),
        wrapper._constructorMethodCall,
        rect.$CGRect$Default(),
        _ios.$parameterMethod(supported, primitive, wrapper._ios, rect),
      ],
    );
  }

  @Method()
  @int32
  Future<int> returnInt32() {
    return android.invoke<int>(
      _channel,
      _constructorMethodCalls[0],
      <MethodCall>[
        ..._constructorMethodCalls.skip(1).toList(),
        _ios.$returnInt32()
      ],
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

//@Class(AndroidPlatform(
//  AndroidType('com.example.test_plugin.test_library', <String>['TestClass1']),
//))
//class AndroidTestClass1 {
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
