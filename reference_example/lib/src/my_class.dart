import 'dart:async';

import 'package:reference/reference.dart';
import 'package:reference/annotations.dart';
import 'package:reference_example/src/my_class.g.dart';

import 'reference_pair_manager.dart';

// final MyReferencePairManager referencePairManager = MyReferencePairManager()
//   ..initialize();

@Channel('a_channel_my_dude')
class MyClass with $MyClass {
  MyClass(this.stringField) {
    //referencePairManager.pairWithNewRemoteReference(this);
  }

  final $MyClassChannel _channel = $MyClassChannel(
    MethodChannelReferenceChannelManager.instance,
  )..registerHandler(
      $MyClassHandler(
        onCreate: (_, args) {
          return MyClass(args.stringField);
        },
      ),
    );

  final String stringField;

  Future<String> myMethod(
    double value,
    covariant MyOtherClass myOtherClass,
  ) async {
    return await _channel.$invokeMyMethod(this, value, myOtherClass);
  }
}

@Channel('my_channel')
class MyOtherClass with $MyOtherClass {
  MyOtherClass(this.intField);

  final int intField;

  Future<String> myMethod() {

  }

  static Future<int> myStaticMethod(String value) async {
    return null;
  }

  static Future<String> noParams() {

  }
}
