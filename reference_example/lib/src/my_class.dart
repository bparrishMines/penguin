import 'dart:async';

import 'package:reference/reference.dart';

import 'reference_pair_manager.dart';

final MyReferencePairManager referencePairManager = MyReferencePairManager()
  ..initialize();

class MyClass with LocalReference {
  MyClass(this.stringField) {
    referencePairManager.pairWithNewRemoteReference(this);
  }

  final String stringField;

  Future<String> myMethod(double value, MyOtherClass myOtherClass) async {
    return (await referencePairManager.invokeRemoteMethod(
      referencePairManager.getPairedRemoteReference(this),
      'myMethod',
      <dynamic>[value, myOtherClass],
    )) as String;
  }

  // The unique `Type` used to represent this class in a `ReferencePairManager`.
  @override
  Type get referenceType => runtimeType;
}

class MyOtherClass with LocalReference {
  MyOtherClass(this.intField);

  final int intField;

  static Future<int> myStaticMethod() async {
    return (await referencePairManager.invokeRemoteStaticMethod(
      MyOtherClass,
      'myMethod',
    )) as int;
  }

  // The unique `Type` used to represent this class in a `ReferencePairManager`.
  @override
  Type get referenceType => runtimeType;
}
