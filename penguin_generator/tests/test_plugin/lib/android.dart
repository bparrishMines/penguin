import 'dart:async';

import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';
import 'package:penguin_plugin/penguin_plugin.dart';
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
  void callbackMethod(
    String supported,
    @int64 int primitive,
    AndroidTestClass2 wrapper,
    AndroidNestedClass nested,
  ) =>
      $callbackMethod(supported, primitive, wrapper, nested);
}

@Class(AndroidPlatform(
  AndroidType('com.example.test_plugin.test_library', <String>['TestClass1']),
))
class AndroidTestClass1 extends $AndroidTestClass1 with TestClass1 {
  @Constructor()
  AndroidTestClass1() : super.$Default();

  AndroidTestClass1.fromUniqueId(String uniqueId) : super.fromUniqueId(uniqueId);

  @Constructor()
  AndroidTestClass1.namedConstructor(
    String supported,
    @int64 int primitive,
    AndroidTestClass2 wrapper,
    AndroidNestedClass nested,
  ) : super.namedConstructor(supported, primitive, wrapper, nested);

  @Field()
  static Future<List<bool>> get staticField =>
      $AndroidTestClass1.$staticField();

  @Method()
  static Future<void> staticMethod() => $AndroidTestClass1.$staticMethod();

  @Method()
  Future<void> parameterMethod(
    String supported,
    @int64 int primitive,
    AndroidTestClass2 wrapper,
    AndroidNestedClass nested,
  ) =>
      $parameterMethod(supported, primitive, wrapper, nested);

  @override
  set mutableField(FutureOr<double> value) =>
      $mutableField(mutableField: mutableField);

  @override
  FutureOr<double> get mutableField => $mutableField();

  @override
  Future<void> returnVoid() => returnVoid();

  @override
  Future<String> returnString() => $returnString();

  @override
  Future<int> returnInt() => $returnInt();

  @override
  Future<double> returnDouble() => $returnDouble();

  @override
  Future<bool> returnBool() => $returnBool();

  @override
  Future<List<double>> returnList() => $returnList();

  @override
  Future<Map<String, int>> returnMap() => $returnMap();

  @override
  Future<Object> returnObject() => $returnObject();

  @override
  Future<dynamic> returnDynamic() => $returnDynamic();

  @Method()
  Future<AndroidTestClass1> returnWrapper() => $returnWrapper();

  @override
  FutureOr<int> get intField => $intField();

  @override
  Future<String> get stringField => $stringField();

  @override
  Future<double> get doubleField => $doubleField();

  @override
  Future<bool> get boolField => $boolField();

  @override
  Future<double> get notAField => $nameOverrideField();
}

//class AndroidTextViewState extends State<TextViewWidget> {
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
//
//    return AndroidView(
//      viewType: '${channel.name}/view',
//      creationParams: _asTextView.uniqueId,
//      creationParamsCodec: const StandardMessageCodec(),
//    );
//  }
//}
//
//@Class(AndroidPlatform(
//  AndroidType('android.widget', <String>['TextView']),
//))
//class TextView extends $TextView with PlatformTextView {
//  @Constructor()
//  TextView([Context context]) : super(randomId());
//
//  bool _isCreated = false;
//
//  @Method()
//  void setText(String text) {
//    methodCallStorageHelper.replace($setText(text));
//  }
//
//  @override
//  FutureOr<Iterable<MethodCall>> onCreateView(Context context) {
//    final List<MethodCall> methodCalls = methodCallStorageHelper.methodCalls;
//    methodCallStorageHelper.clearMethodCalls();
//
//    _isCreated = true;
//    return <MethodCall>[
//      $TextView$Default(context),
//      ...methodCalls,
//      allocate(),
//    ];
//  }
//
//  static FutureOr onAllocated($TextView wrapper) => throw UnimplementedError();
//}

@Class(
  AndroidPlatform(
    AndroidType('com.example.test_plugin.test_library', <String>['TestClass2']),
  ),
  androidApi: AndroidApi(21),
)
class AndroidTestClass2 extends $AndroidTestClass2 with TestClass2 {
  @Constructor()
  AndroidTestClass2() : super.$Default();

  AndroidTestClass2.fromUniqueId(String uniqueId) : super.fromUniqueId(uniqueId);
}

@Class(AndroidPlatform(AndroidType(
  'com.example.test_plugin.test_library',
  <String>['GenericClass'],
)))
class AndroidGenericClass<T> extends $AndroidGenericClass<T>
    with GenericClass<T> {
  @Constructor()
  AndroidGenericClass() : super.$Default();

  AndroidGenericClass.fromUniqueId(String uniqueId) : super.fromUniqueId(uniqueId);

  @override
  Future<void> add(T object) {
//    if (isTypeOf<T, Wrapper>()) {
//      return invoke<void>(
//        channel,
//        (object as Wrapper).methodCallStorageHelper.methodCalls.toList()
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
