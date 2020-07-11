import 'package:reference/reference.dart';

class MyClass with LocalReference {
  String stringField;

  Future<void> myMethod(double value, MyOtherClass myOtherClass) {

  }

  // The unique `Type` used to represent this class in a `ReferencePairManager`.
  @override
  Type get referenceType => runtimeType;
}

class MyOtherClass with LocalReference {
  MyOtherClass(this.intField);

  final int intField;

  // The unique `Type` used to represent this class in a `ReferencePairManager`.
  @override
  Type get referenceType => runtimeType;
}