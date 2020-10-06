import 'dart:async';

import 'package:reference/reference.dart';
import 'package:reference_example/src/my_class.g.dart';

import 'reference_pair_manager.dart';

final MyReferencePairManager referencePairManager = MyReferencePairManager()
  ..initialize();

@Reference()
class MyClass extends $MyClass {
  MyClass(this.stringField) {
    referencePairManager.pairWithNewRemoteReference(this);
  }

  static Future<Object> myStaticMethod(String table, MyOtherClass chair) {
    return $MyClassMethods.$myStaticMethod(null, null, null);
  }

  static Future<Object> anotherStaticMethod(String table, List<MyClass> chair) {
    return $MyClassMethods.$anotherStaticMethod(null, table, chair);
  }

  final String stringField;

  @override
  Future<String> myMethod(
      double value, covariant MyOtherClass myOtherClass) async {
    return (await $myMethod(null, value, myOtherClass)) as String;
  }
}

@Reference()
class MyOtherClass extends $MyOtherClass {
  MyOtherClass(this.intField, this.doubleField);

  final int intField;
  final double doubleField;
}
