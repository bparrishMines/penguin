import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';
import 'package:penguin_plugin/penguin_plugin.dart';
import 'package:test_plugin/test_plugin.dart';

part 'ios.ios.penguin.g.dart';

//class IosTextViewState extends State<TextViewWidget> {
//  TextView get _asTextView => widget.textView as TextView;
//
//  @override
//  void initState() {
//    super.initState();
//    callbackHandler.addWrapper(_asTextView);
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//    invoke<void>(channel, [_asTextView.deallocate()]);
//    callbackHandler.removeWrapper(_asTextView);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    if (_asTextView._isCreated) {
//      invoke<void>(channel, _asTextView.methodCallStorageHelper.methodCalls);
//      _asTextView.methodCallStorageHelper.clearMethodCalls();
//    }
//    return UiKitView(
//      viewType: '${channel.name}/view',
//      creationParams: _asTextView.uniqueId,
//      creationParamsCodec: const StandardMessageCodec(),
//    );
//  }
//}
//
//@Class(IosPlatform(IosType('UITextView')))
//class TextView extends $TextView with PlatformTextView {
//  @Constructor()
//  TextView.initWithFrame([CGRect frame]) : super(randomId());
//
//  bool _isCreated = false;
//
//  @Field()
//  set text(String text) => methodCallStorageHelper.replace($text(text: text));
//
//  @override
//  FutureOr<Iterable<MethodCall>> onCreateView(CGRect frame) {
//    final List<MethodCall> methodCalls = methodCallStorageHelper.methodCalls;
//    methodCallStorageHelper.clearMethodCalls();
//
//    _isCreated = true;
//    return <MethodCall>[
//      $TextViewinitWithFrame(frame),
//      ...methodCalls,
//      allocate(),
//    ];
//  }
//
//  static FutureOr onAllocated($TextView wrapper) => throw UnimplementedError();
//}

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
      invoke<int>(PenguinPlugin.globalMethodChannel, [$intField()]);
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

@Class(IosPlatform(
  IosType('TestClass1', import: '"TestPlugin.h"'),
))
class IosTestClass1 extends $IosTestClass1 with TestClass1 {
  @Constructor()
  IosTestClass1() : super.$Default();

  @Constructor()
  IosTestClass1.initNamedConstructor(
    String supported,
    @int32 int primitive,
    IosTestClass2 wrapper,
  ) : super.initNamedConstructor(supported, primitive, wrapper);

  IosTestClass1.fromUniqueId(String uniqueId) : super.fromUniqueId(uniqueId);

  @Field()
  static Future<List<bool>> get staticField => invokeList<bool>(
      PenguinPlugin.globalMethodChannel, [$IosTestClass1.$staticField()]);

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
      PenguinPlugin.globalMethodChannel, [$mutableField(mutableField: value)]);

  @override
  FutureOr<double> get mutableField =>
      invoke<double>(PenguinPlugin.globalMethodChannel, [$mutableField()]);

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
      PenguinPlugin.globalMethodChannel, [$returnWrapper()]);

  @override
  FutureOr<int> get intField =>
      invoke<int>(PenguinPlugin.globalMethodChannel, [$intField()]);

  @override
  Future<String> get stringField =>
      invoke<String>(PenguinPlugin.globalMethodChannel, [$stringField()]);

  @override
  Future<double> get doubleField =>
      invoke<double>(PenguinPlugin.globalMethodChannel, [$doubleField()]);

  @override
  Future<bool> get boolField =>
      invoke<bool>(PenguinPlugin.globalMethodChannel, [$boolField()]);

  @override
  Future<double> get notAField =>
      invoke<double>(PenguinPlugin.globalMethodChannel, [$nameOverrideField()]);
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
//    if (isTypeOf<T, Wrapper>()) {
//      return invoke<void>(
//        channel,
//        (object as Wrapper).methodCallStorageHelper.methodCalls
//          ..add($add(object)),
//      );
//    }
//
//    return invoke<void>(channel, [$add(object)]);
  }

  @override
  Future<T> get(String identifier) async {
//    if (isTypeOf<T, Wrapper>()) {
//      final Wrapper wrapper = _GenericHelper.getWrapperForType<T>(randomId());
//      invoke<void>(
//        channel,
//        [$get(identifier, wrapper.uniqueId), wrapper.allocate()],
//      );
//      return _GenericHelper.onAllocated(wrapper);
//    }
//
//    return invoke<T>(channel, [$get(identifier)]);
  }
}
