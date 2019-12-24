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
    invoke<void>(channel, [_textView.deallocate()]);
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

  static FutureOr<Wrapper> fromUniqueId(String uniqueId) =>
      throw UnimplementedError();
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
    return invoke<int>(channel, [$TestStruct$Default(), $intField()]);
  }

  static FutureOr<Wrapper> fromUniqueId(String uniqueId) =>
      throw UnimplementedError();
}

@Class(IosPlatform(IosType('TestProtocol', import: '"TestPlugin.h"')))
abstract class IosProtocol extends $IosProtocol {
  @Constructor()
  IosProtocol() : super(randomId()) {
    invoke<void>(channel, <MethodCall>[
      $IosProtocol$Default(),
      allocate(),
    ]);

    callbackHandler.addWrapper(this);
  }

  @Method(callback: true)
  void callbackMethod() {
    invoke<void>(channel, [$callbackMethod()]);
  }

  static FutureOr<Wrapper> fromUniqueId(String uniqueId) =>
      throw UnimplementedError();
}

@Class(IosPlatform(
  IosType('TestClass1', import: '"TestPlugin.h"'),
))
class IosTestClass1 extends $IosTestClass1 with TestClass1 {
  @Constructor()
  IosTestClass1() : super(randomId()) {
    methodCallStorageHelper.store($IosTestClass1$Default());
  }

  @Constructor()
  IosTestClass1.initNamedConstructor(
    String supported,
    @int32 int primitive,
    IosTestClass2 wrapper,
  ) : super(randomId()) {
    methodCallStorageHelper.storeAll(
      wrapper.methodCallStorageHelper.methodCalls,
    );
    methodCallStorageHelper.store($IosTestClass1initNamedConstructor(
      supported,
      primitive,
      wrapper,
    ));
  }

  @Field()
  static Future<List<bool>> get staticField {
    return invokeList<bool>(
      channel,
      [$IosTestClass1.$staticField()],
    );
  }

  @Method()
  static Future<void> staticMethod() {
    return invoke<void>(
      channel,
      [$IosTestClass1.$staticMethod()],
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
      methodCallStorageHelper.methodCalls
        ..addAll(wrapper.methodCallStorageHelper.methodCalls)
        ..add($parameterMethod(supported, primitive, wrapper)),
    );
  }

  @Method()
  @int32
  Future<int> returnInt32() {
    return invoke<int>(
      channel,
      methodCallStorageHelper.methodCalls..add($returnInt32()),
    );
  }

  @override
  set mutableField(FutureOr<double> value) => invoke<double>(channel, [
        ...methodCallStorageHelper.methodCalls,
        allocate(),
        $mutableField(mutableField: value),
      ]);

  @override
  FutureOr<double> get mutableField => invoke<double>(
        channel,
        [$mutableField()],
      );

  @override
  Future<void> returnVoid() {
    return invoke<void>(
        channel, methodCallStorageHelper.methodCalls..add($returnVoid()));
  }

  @override
  Future<String> returnString() {
    return invoke<String>(
      channel,
      methodCallStorageHelper.methodCalls..add($returnString()),
    );
  }

  @override
  Future<int> returnInt() {
    return invoke<int>(
      channel,
      methodCallStorageHelper.methodCalls..add($returnInt()),
    );
  }

  @override
  Future<double> returnDouble() {
    return invoke<double>(
      channel,
      methodCallStorageHelper.methodCalls..add($returnDouble()),
    );
  }

  @override
  Future<bool> returnBool() {
    return invoke<bool>(
      channel,
      methodCallStorageHelper.methodCalls..add($returnBool()),
    );
  }

  @override
  Future<List<double>> returnList() {
    return invokeList<double>(
      channel,
      methodCallStorageHelper.methodCalls..add($returnList()),
    );
  }

  @override
  Future<Map<String, int>> returnMap() {
    return invokeMap<String, int>(
      channel,
      methodCallStorageHelper.methodCalls..add($returnMap()),
    );
  }

  @override
  Future<Object> returnObject() {
    return invoke<Object>(
      channel,
      methodCallStorageHelper.methodCalls.toList()..add($returnObject()),
    );
  }

  @override
  Future<dynamic> returnDynamic() {
    return invoke<dynamic>(
      channel,
      methodCallStorageHelper.methodCalls.toList()..add($returnDynamic()),
    );
  }

  @override
  FutureOr<int> get intField => invoke<int>(
      channel, methodCallStorageHelper.methodCalls..add($intField()));

  @override
  Future<String> get stringField => invoke<String>(
      channel, methodCallStorageHelper.methodCalls..add($stringField()));

  @override
  Future<double> get doubleField => invoke<double>(
      channel, methodCallStorageHelper.methodCalls..add($doubleField()));

  @override
  Future<bool> get boolField => invoke<bool>(
      channel, methodCallStorageHelper.methodCalls..add($boolField()));

  static FutureOr<Wrapper> fromUniqueId(String uniqueId) =>
      throw UnimplementedError();
}

@Class(IosPlatform(
  IosType('TestClass2', import: '"TestPlugin.h"'),
))
class IosTestClass2 extends $IosTestClass2 with TestClass2 {
  IosTestClass2._(String uniqueId) : super(uniqueId) {
    invoke<void>(channel, <MethodCall>[$IosTestClass2$Default(), allocate()]);
  }

  @Constructor()
  IosTestClass2() : super(randomId()) {
    methodCallStorageHelper.store($IosTestClass2$Default());
  }

  static FutureOr<Wrapper> fromUniqueId(String uniqueId) =>
      IosTestClass2._(uniqueId);
}

@Class(IosPlatform(IosType('GenericClass', import: '"TestPlugin.h"')))
class IosGenericClass<T> extends $IosGenericClass<T> with GenericClass<T> {
  @Constructor()
  IosGenericClass() : super(randomId()) {
    invoke<void>(channel, <MethodCall>[$IosGenericClass$Default(), allocate()]);
  }

  @override
  Future<void> add(T object) {
    if (isTypeOf<T, Wrapper>()) {
      return invoke<void>(
        channel,
        (object as Wrapper).methodCallStorageHelper.methodCalls
          ..add($add(object)),
      );
    }

    return invoke<void>(channel, [$add(object)]);
  }

  @override
  Future<T> get(String identifier) async {
    if (isTypeOf<T, Wrapper>()) {
      final T value = _GenericHelper.fromUniqueId<T>(randomId());
      invoke<void>(channel, [
        $get(identifier, (value as Wrapper).uniqueId),
        (value as Wrapper).allocate(),
      ]);
      return value;
    }

    return invoke<T>(channel, [$get(identifier)]);
  }

  static FutureOr<Wrapper> fromUniqueId(String uniqueId) =>
      throw UnimplementedError();
}
