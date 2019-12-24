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
  AndroidNestedClass() : super(randomId()) {
    methodCallStorageHelper.store($AndroidNestedClass$Default());
  }

  static FutureOr<Wrapper> fromUniqueId(String uniqueId) =>
      throw UnimplementedError();
}

@Class(AndroidPlatform(
  AndroidType(
    'com.example.test_plugin.test_library',
    <String>['AbstractTestClass'],
  ),
))
abstract class AndroidAbstractClass extends $AndroidAbstractClass {
  @Constructor()
  AndroidAbstractClass() : super(randomId()) {
    invoke(channel, <MethodCall>[
      $AndroidAbstractClass$Default(),
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

@Class(AndroidPlatform(
  AndroidType('com.example.test_plugin.test_library', <String>['TestClass1']),
))
class AndroidTestClass1 extends $AndroidTestClass1 with TestClass1 {
  @Constructor()
  AndroidTestClass1() : super(randomId()) {
    methodCallStorageHelper.store($AndroidTestClass1$Default());
  }

  @Constructor()
  AndroidTestClass1.namedConstructor(
    String supported,
    @int64 int primitive,
    AndroidTestClass2 wrapper,
    AndroidNestedClass nested,
  ) : super(randomId()) {
    methodCallStorageHelper.storeAll(
      wrapper.methodCallStorageHelper.methodCalls,
    );
    methodCallStorageHelper.storeAll(
      nested.methodCallStorageHelper.methodCalls,
    );
    methodCallStorageHelper.store($AndroidTestClass1namedConstructor(
      supported,
      primitive,
      wrapper,
      nested,
    ));
  }

  @Field()
  static Future<List<bool>> get staticField {
    return invokeList<bool>(channel, [$AndroidTestClass1.$staticField()]);
  }

  @Method()
  static Future<void> staticMethod() {
    return invoke<void>(channel, [$AndroidTestClass1.$staticMethod()]);
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
      methodCallStorageHelper.methodCalls
        ..addAll(wrapper.methodCallStorageHelper.methodCalls)
        ..addAll(nested.methodCallStorageHelper.methodCalls)
        ..add($parameterMethod(
          supported,
          primitive,
          wrapper,
          nested,
        )),
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
      methodCallStorageHelper.methodCalls..add($returnObject()),
    );
  }

  @override
  Future<dynamic> returnDynamic() {
    return invoke<dynamic>(
      channel,
      methodCallStorageHelper.methodCalls..add($returnDynamic()),
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

  static FutureOr<Wrapper> fromUniqueId(String uniqueId) =>
      throw UnimplementedError();
}

@Class(
  AndroidPlatform(
    AndroidType('com.example.test_plugin.test_library', <String>['TestClass2']),
  ),
  androidApi: AndroidApi(21),
)
class AndroidTestClass2 extends $AndroidTestClass2 with TestClass2 {
  AndroidTestClass2._(String uniqueId) : super(uniqueId);

  @Constructor()
  AndroidTestClass2() : super(randomId()) {
    methodCallStorageHelper.store($AndroidTestClass2$Default());
  }

  static FutureOr<Wrapper> fromUniqueId(String uniqueId) =>
      AndroidTestClass2._(uniqueId);
}

@Class(AndroidPlatform(AndroidType(
  'com.example.test_plugin.test_library',
  <String>['GenericClass'],
)))
class AndroidGenericClass<T> extends $AndroidGenericClass<T>
    with GenericClass<T> {
  @Constructor()
  AndroidGenericClass() : super(randomId()) {
    invoke<void>(
      channel,
      <MethodCall>[$AndroidGenericClass$Default(), allocate()],
    );
  }

  @override
  Future<void> add(T object) {
    if (isTypeOf<T, Wrapper>()) {
      return invoke<void>(
        channel,
        (object as Wrapper).methodCallStorageHelper.methodCalls.toList()
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
