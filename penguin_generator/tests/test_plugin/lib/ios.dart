import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';
import 'package:penguin_plugin/ios_wrapper.dart';
import 'package:penguin_plugin/penguin_plugin.dart';
import 'package:test_plugin/test_plugin.dart';

part 'ios.ios.penguin.g.dart';

@Class(IosPlatform(
  IosType('UITextView'),
))
class IosTextViewState extends State<TextView> {
  IosTextViewState(this.text);

  /// Internal. Only for code gen. DO NOT USE
  @Constructor()
  IosTextViewState.initWithFrame(CGRect frame);

  @Field()
  String text;

  $IosTextViewState _textView;

  @override
  void initState() {
    super.initState();
    _textView = $IosTextViewState(
      randomId(),
      onCreateView: (CGRect cgRect) {
        return <MethodCall>[
          _textView.$IosTextViewStateinitWithFrame(cgRect),
          _textView.$text(text: text),
          _textView.allocate(),
        ];
      },
    );
    callbackHandler.addWrapper(_textView);
  }

  @override
  void dispose() {
    super.dispose();
    invoke<void>(channel, _textView.deallocate());
    callbackHandler.removeWrapper(_textView);
  }

  @override
  Widget build(BuildContext context) {
    return UiKitView(
      viewType: '${channel.name}/view',
      creationParams: _textView.uniqueId,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}

@Class(IosPlatform(
  IosType('TestStruct', isStruct: true, import: '"TestPlugin.h"'),
))
class TestStruct extends $TestStruct {
  @Constructor()
  TestStruct() : super(randomId());

  @Field()
  @int32
  Future<int> get intField {
    return invoke<int>(channel, $TestStruct$Default(), [$intField()]);
  }
}

@Class(IosPlatform(IosType('TestProtocol', import: '"TestPlugin.h"')))
abstract class IosProtocol extends $IosProtocol {
  @Constructor()
  IosProtocol() : super(randomId()) {
    invokeAll(channel, <MethodCall>[
      $IosProtocol$Default(),
      allocate(),
    ]);

    callbackHandler.addWrapper(this);
  }

  @Method(callback: true)
  void callbackMethod() {
    invoke<void>(channel, $callbackMethod());
  }
}

@Class(IosPlatform(
  IosType('TestClass1', import: '"TestPlugin.h"'),
))
class IosTestClass1 extends $IosTestClass1 with TestClass1 {
  @Constructor()
  IosTestClass1() : super(randomId()) {
    constructorMethodCalls = [$IosTestClass1$Default()];
  }

  @Constructor()
  IosTestClass1.initNamedConstructor(
    String supported,
    @int32 int primitive,
    IosTestClass2 wrapper,
  ) : super(randomId()) {
    constructorMethodCalls = [
      wrapper.$IosTestClass2$Default(),
      $IosTestClass1initNamedConstructor(
        supported,
        primitive,
        wrapper,
      )
    ];
  }

  @Field()
  static Future<List<bool>> get staticField {
    return invokeList<bool>(
      channel,
      $IosTestClass1.$staticField(),
    );
  }

  @Method()
  static Future<void> staticMethod() {
    return invoke<void>(
      channel,
      $IosTestClass1.$staticMethod(),
    );
  }

  @Method()
  Future<void> parameterMethod(
    String supported,
    @int32 int primitive,
    IosTestClass2 wrapper,
  ) {
    return invoke<void>(
      channel,
      constructorMethodCalls[0],
      <MethodCall>[
        ...constructorMethodCalls.skip(1).toList(),
        wrapper.constructorMethodCall,
        $parameterMethod(supported, primitive, wrapper),
      ],
    );
  }

  @Method()
  @int32
  Future<int> returnInt32() {
    return invoke<int>(
      channel,
      constructorMethodCalls[0],
      <MethodCall>[...constructorMethodCalls.skip(1).toList(), $returnInt32()],
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

@Class(IosPlatform(
  IosType('TestClass2', import: '"TestPlugin.h"'),
))
class IosTestClass2 extends $IosTestClass2 with TestClass2 {
  @Constructor()
  IosTestClass2() : super(randomId()) {
    constructorMethodCall = $IosTestClass2$Default();
  }
}

@Class(IosPlatform(IosType('GenericClass', import: '"TestPlugin.h"')))
class IosGenericClass<T> extends GenericClass<T> {
  @Constructor()
  IosGenericClass();
}
