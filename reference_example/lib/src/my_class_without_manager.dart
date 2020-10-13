import 'package:reference/reference.dart';

class MyClass with LocalReference {
  String stringField;

  Future<String> myMethod(double value, MyOtherClass myOtherClass) {

  }

  // The unique `Type` used to represent this class in a `ReferencePairManager`.
  @override
  Type get referenceType => runtimeType;
}

class MyOtherClass with LocalReference {
  MyOtherClass(this.intField);

  final int intField;

  static Future<int> myStaticMethod() {

  }

  // The unique `Type` used to represent this class in a `ReferencePairManager`.
  @override
  Type get referenceType => runtimeType;
}