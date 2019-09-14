// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// PenguinGenerator
// **************************************************************************
import 'package:flutter/services.dart';

class $Usage1 {
  $Usage1(this.$uniqueId);

  final String $uniqueId;

  MethodCall $Usage1Default() {
    return MethodCall(
      'TestClass()',
      <String, String>{'uniqueId': $uniqueId},
    );
  }

  MethodCall $aMethod() {
    return MethodCall(
      'TestClass#aMethod',
      <String, String>{'uniqueId': $uniqueId},
    );
  }

  MethodCall $allocate() {
    return MethodCall(
      'TestClass#allocate',
      <String, String>{'uniqueId': $uniqueId},
    );
  }

  MethodCall $deallocate() {
    return MethodCall(
      'TestClass#deallocate',
      <String, String>{'uniqueId': $uniqueId},
    );
  }
}

class $Usage2 {
  $Usage2(this.$uniqueId);

  final String $uniqueId;

  MethodCall $allocate() {
    return MethodCall(
      'TestClassTwo#allocate',
      <String, String>{'uniqueId': $uniqueId},
    );
  }

  MethodCall $deallocate() {
    return MethodCall(
      'TestClassTwo#deallocate',
      <String, String>{'uniqueId': $uniqueId},
    );
  }
}

Future<List<dynamic>> $invoke(
  MethodChannel channel,
  List<MethodCall> methodCalls,
) {
  final List<Map<String, dynamic>> calls = methodCalls
      .map<Map<String, dynamic>>(
        (MethodCall methodCall) => <String, dynamic>{
          'method': methodCall.method,
          'arguments': methodCall.arguments,
        },
      )
      .toList();

  return channel.invokeListMethod('MultiInvoke', calls);
}