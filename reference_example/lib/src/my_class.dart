import 'dart:async';

import 'package:reference/reference.dart';
import 'package:reference/annotations.dart';

import 'reference_pair_manager.dart';

// final MyReferencePairManager referencePairManager = MyReferencePairManager()
//   ..initialize();

@Channel('a_channel_my_dude')
class MyClass {
  MyClass(this.stringField) {
    //referencePairManager.pairWithNewRemoteReference(this);
  }

  final String stringField;

  Future<String> myMethod(double value, MyOtherClass myOtherClass) async {
    return null;
  }
}

@Channel('my_channel')
class MyOtherClass {
  MyOtherClass(this.intField);

  final int intField;

  static Future<int> myStaticMethod() async {
    return null;
  }
}
