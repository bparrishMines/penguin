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
  Future<void> callbackMethod(
    String supported,
    @int64 int primitive,
    AndroidTestClass2 wrapper,
    AndroidNestedClass nested,
  ) =>
      invoke<void>(PenguinPlugin.globalMethodChannel,
          [$callbackMethod(supported, primitive, wrapper, nested)]);
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
  AndroidTestClass1.namedConstructor(
    String supported,
    @int64 int primitive,
    AndroidTestClass2 wrapper,
    AndroidNestedClass nested,
  ) : super.namedConstructor(supported, primitive, wrapper, nested);

  @Field()
  static Future<List<bool>> get staticField => invokeList<bool>(
      PenguinPlugin.globalMethodChannel, [$AndroidTestClass1.$staticField()]);

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
  Future<AndroidTestClass1> returnWrapper() => invoke<AndroidTestClass1>(
      PenguinPlugin.globalMethodChannel, [$returnWrapper()], genericHelper: _GenericHelper.instance);

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
