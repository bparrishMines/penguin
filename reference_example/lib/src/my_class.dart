import 'dart:async';

import 'package:reference/reference.dart';

import 'reference_pair_manager.dart';

final MyReferencePairManager referencePairManager = MyReferencePairManager()
  ..initialize();

@Reference()
class MyClass with LocalReference {
  MyClass(this.stringField) {
    referencePairManager.pairWithNewRemoteReference(this);
  }

  static void aStaticMethodBro(Map<String, MyOtherClass> something) {

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

@Reference()
class MyOtherClass with LocalReference {
  MyOtherClass(this.intField);

  final int intField;

  void noParamMethod() {

  }

  // The unique `Type` used to represent this class in a `ReferencePairManager`.
  @override
  Type get referenceType => runtimeType;
}
