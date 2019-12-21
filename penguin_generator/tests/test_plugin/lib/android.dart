import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';
import 'package:penguin_plugin/penguin_plugin.dart';
import 'package:penguin_plugin/android_wrapper.dart';
import 'package:test_plugin/test_plugin.dart';

part 'android.android.penguin.g.dart';

@Class(AndroidPlatform(
  AndroidType(
    'com.example.test_plugin.test_library',
    <String>['TestClass1', 'NestedTestClass'],
  ),
))
class AndroidNestedClass extends $AndroidNestedClass {
  @Constructor()
  AndroidNestedClass() : super(randomId());
}

@Class(AndroidPlatform(
  AndroidType(
    'com.example.test_plugin.test_library',
    <String>['AbstractTestClass'],
  ),
))
abstract class AndroidAbstractClass extends $AndroidAbstractClass {
  @Constructor()
  AndroidAbstractClass() : super('aRef') {
    invokeAll(channel, <MethodCall>[
      $AndroidAbstractClass$Default(),
      allocate(),
    ]);

    callbackHandler.addWrapper(this);
  }

  @Method(callback: true)
  void callbackMethod() {
    invoke<void>(channel, $callbackMethod());
  }
}

@Class(AndroidPlatform(
  AndroidType('com.example.test_plugin.test_library', <String>['TestClass1']),
))
class AndroidTestClass1 extends $AndroidTestClass1 with TestClass1 {
  @Constructor()
  AndroidTestClass1() : super(randomId()) {
    constructorMethodCalls = [$AndroidTestClass1$Default()];
  }

  @Constructor()
  AndroidTestClass1.namedConstructor(
    String supported,
    @int64 int primitive,
    AndroidTestClass2 wrapper,
    AndroidNestedClass nested,
  ) : super(randomId()) {
    constructorMethodCalls = [
      wrapper.constructorMethodCall,
      nested.$AndroidNestedClass$Default(),
      $AndroidTestClass1namedConstructor(
        supported,
        primitive,
        wrapper,
        nested,
      )
    ];
  }

  @Field()
  static Future<List<bool>> get staticField {
    return invokeList<bool>(channel, $AndroidTestClass1.$staticField());
  }

  @Method()
  static Future<void> staticMethod() {
    return invoke<void>(channel, $AndroidTestClass1.$staticMethod());
  }

  @Method()
  Future<void> parameterMethod(
    String supported,
    @int64 int primitive,
    AndroidTestClass2 wrapper,
    AndroidNestedClass nested,
  ) {
    return invoke<void>(
      channel,
      constructorMethodCalls[0],
      <MethodCall>[
        ...constructorMethodCalls.skip(1).toList(),
        wrapper.constructorMethodCall,
        nested.$AndroidNestedClass$Default(),
        $parameterMethod(
          supported,
          primitive,
          wrapper,
          nested,
        ),
      ],
    );
  }

  @override
  set mutableField(FutureOr<double> value) =>
      invoke<double>(channel, constructorMethodCalls[0], [
        ...constructorMethodCalls.skip(1).toList(),
        allocate(),
        $mutableField(mutableField: value),
      ]);

  @override
  FutureOr<double> get mutableField => invoke<double>(
    channel,
    $mutableField(),
  );

  @override
  Future<void> returnVoid() {
    return invoke<void>(
      channel,
      constructorMethodCalls[0],
      <MethodCall>[
        ...constructorMethodCalls.skip(1).toList(),
        $returnVoid(),
      ],
    );
  }

  @override
  Future<String> returnString() {
    return invoke<String>(
      channel,
      constructorMethodCalls[0],
      <MethodCall>[
        ...constructorMethodCalls.skip(1).toList(),
        $returnString(),
      ],
    );
  }

  @override
  Future<int> returnInt() {
    return invoke<int>(
      channel,
      constructorMethodCalls[0],
      <MethodCall>[
        ...constructorMethodCalls.skip(1).toList(),
        $returnInt(),
      ],
    );
  }

  @override
  Future<double> returnDouble() {
    return invoke<double>(
      channel,
      constructorMethodCalls[0],
      <MethodCall>[
        ...constructorMethodCalls.skip(1).toList(),
        $returnDouble(),
      ],
    );
  }

  @override
  Future<bool> returnBool() {
    return invoke<bool>(
      channel,
      constructorMethodCalls[0],
      <MethodCall>[
        ...constructorMethodCalls.skip(1).toList(),
        $returnBool(),
      ],
    );
  }

  @override
  Future<List<double>> returnList() {
    return invokeList<double>(
      channel,
      constructorMethodCalls[0],
      <MethodCall>[
        ...constructorMethodCalls.skip(1).toList(),
        $returnList(),
      ],
    );
  }

  @override
  Future<Map<String, int>> returnMap() {
    return invokeMap<String, int>(
      channel,
      constructorMethodCalls[0],
      <MethodCall>[
        ...constructorMethodCalls.skip(1).toList(),
        $returnMap(),
      ],
    );
  }

  @override
  Future<Object> returnObject() {
    return invoke<Object>(
      channel,
      constructorMethodCalls[0],
      <MethodCall>[
        ...constructorMethodCalls.skip(1).toList(),
        $returnObject(),
      ],
    );
  }

  @override
  Future<dynamic> returnDynamic() {
    return invoke<dynamic>(
      channel,
      constructorMethodCalls[0],
      <MethodCall>[
        ...constructorMethodCalls.skip(1).toList(),
        $returnDynamic(),
      ],
    );
  }

  @override
  FutureOr<int> get intField =>
      invoke<int>(channel, constructorMethodCalls[0], [
        ...constructorMethodCalls.skip(1).toList(),
        $intField(),
      ]);

  @override
  Future<String> get stringField =>
      invoke<String>(channel, constructorMethodCalls[0], [
        ...constructorMethodCalls.skip(1).toList(),
        $stringField(),
      ]);

  @override
  Future<double> get doubleField =>
      invoke<double>(channel, constructorMethodCalls[0], [
        ...constructorMethodCalls.skip(1).toList(),
        $doubleField(),
      ]);

  @override
  Future<bool> get boolField =>
      invoke<bool>(channel, constructorMethodCalls[0], [
        ...constructorMethodCalls.skip(1).toList(),
        $boolField(),
      ]);
}

@Class(AndroidPlatform(
  AndroidType('android.widget', <String>['TextView']),
))
class AndroidTextViewState extends State<TextView> {
  @Constructor()
  AndroidTextViewState(Context context);

  $AndroidTextViewState _textView;

  @Method()
  void setText(String text) {}

  @override
  void initState() {
    super.initState();
    _textView = $AndroidTextViewState(
      randomId(),
      onCreateView: (Context context) {
        return <MethodCall>[
          _textView.$AndroidTextViewState$Default(context),
          _textView.$setText(widget.text),
        ];
      },
    );
    callbackHandler.addWrapper(_textView);
  }

  @override
  void dispose() {
    super.dispose();
    callbackHandler.removeWrapper(_textView);
  }

  @override
  Widget build(BuildContext context) {
    return AndroidView(
      viewType: '${channel.name}/view',
      creationParams: _textView.uniqueId,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}

@Class(
  AndroidPlatform(
    AndroidType('com.example.test_plugin.test_library', <String>['TestClass2']),
  ),
  androidApi: AndroidApi(21),
)
class AndroidTestClass2 extends $AndroidTestClass2 with TestClass2 {
  @Constructor()
  AndroidTestClass2() : super(randomId()) {
    constructorMethodCall = $AndroidTestClass2$Default();
  }
}

//@Class(AndroidPlatform(AndroidType(
//  'com.example.test_plugin.test_library',
//  <String>['GenericClass'],
//)))
//class AndroidGenericClass<T> extends GenericClass<T> {
//  @Constructor()
//  AndroidGenericClass();
//}
