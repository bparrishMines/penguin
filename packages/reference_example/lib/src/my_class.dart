import 'dart:async';

import 'package:reference/reference.dart';
import 'package:reference/annotations.dart';
//import 'package:reference_example/src/my_class.g.dart';

import 'reference_pair_manager.dart';

// final MyReferencePairManager referencePairManager = MyReferencePairManager()
//   ..initialize();

@Reference('a_channel_my_dude')
class MyClass {
  MyClass(this.stringField) {
    //referencePairManager.pairWithNewRemoteReference(this);
  }

  // final $MyClassChannel _channel = $MyClassChannel(
  //   MethodChannelReferenceChannelManager.instance,
  // )..registerHandler(
  //     $MyClassHandler(
  //       onCreate: (_, args) {
  //         return MyClass(args.stringField);
  //       },
  //     ),
  //   );

  final String stringField;

  Future<String> myMethod(
    double value,
    covariant MyOtherClass myOtherClass,
  ) async {
    //return await _channel.$invokeMyMethod(this, value, myOtherClass);
  }
}

@Reference('my_channel')
class MyOtherClass {
  MyOtherClass(this.intField);

  final int intField;

  // final $MyOtherClassChannel _channel = $MyOtherClassChannel(
  //   MethodChannelReferenceChannelManager.instance,
  // )..registerHandler(
  //     $MyOtherClassHandler(
  //       onCreate: (_, args) {
  //         return MyOtherClass(args.intField);
  //       },
  //       $onMyStaticMethod: null,
  //       $onNoParams: (_) async => 'woefj',
  //     ),
  //   );

  void myMethod() {}

  static Future<int> myStaticMethod(String value) async {
    return null;
  }

  static Future<String> noParams() {}

  // @override
  // String get referenceChannelName => 'my_channel';
}