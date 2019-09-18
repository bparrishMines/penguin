// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// PenguinGenerator
// **************************************************************************
import 'package:flutter/services.dart';

class $Usage1 extends $Wrapper {
  $Usage1(String $uniqueId) : super($uniqueId);

  MethodCall $Usage1Default() {
    return MethodCall(
      'TestClass()',
      <String, String>{'uniqueId': $uniqueId},
    );
  }

  MethodCall $aMethod() {
    return MethodCall(
      'TestClass#aMethod',
      <String, dynamic>{
        'uniqueId': $uniqueId,
      },
    );
  }

  MethodCall $getStringMethod() {
    return MethodCall(
      'TestClass#getStringMethod',
      <String, dynamic>{
        'uniqueId': $uniqueId,
      },
    );
  }

  MethodCall $addTwo(int value) {
    return MethodCall(
      'TestClass#addTwo',
      <String, dynamic>{
        'uniqueId': $uniqueId,
        'value': value,
      },
    );
  }

  MethodCall $divide(int one, int two) {
    return MethodCall(
      'TestClass#divide',
      <String, dynamic>{
        'uniqueId': $uniqueId,
        'one': one,
        'two': two,
      },
    );
  }

  MethodCall $getList(Map<int, int> addThese) {
    return MethodCall(
      'TestClass#getList',
      <String, dynamic>{
        'uniqueId': $uniqueId,
        'addThese': addThese,
      },
    );
  }

  MethodCall $giveUsage2($Usage2 usage2) {
    return MethodCall(
      'TestClass#giveUsage2',
      <String, dynamic>{
        'uniqueId': $uniqueId,
        'usage2': usage2.$uniqueId,
      },
    );
  }

  MethodCall $getUsage2(
    String $newUniqueId,
  ) {
    return MethodCall(
      'TestClass#getUsage2',
      <String, dynamic>{
        'uniqueId': $uniqueId,
        r'$newUniqueId': $newUniqueId,
      },
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

class $Usage2 extends $Wrapper {
  $Usage2(String $uniqueId) : super($uniqueId);

  MethodCall $Usage2Default() {
    return MethodCall(
      'TestClassTwo()',
      <String, String>{'uniqueId': $uniqueId},
    );
  }

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

class $GenericUsage extends $Wrapper {
  $GenericUsage(String $uniqueId) : super($uniqueId);

  MethodCall $GenericUsageDefault() {
    return MethodCall(
      'TestGenericClass()',
      <String, String>{'uniqueId': $uniqueId},
    );
  }

  MethodCall $setValue(dynamic value) {
    return MethodCall(
      'TestGenericClass#setValue',
      <String, dynamic>{
        'uniqueId': $uniqueId,
        if (value is $Wrapper) 'value': value.$uniqueId,
        if (value is! $Wrapper) 'value': value,
      },
    );
  }

  MethodCall $get(String $newUniqueId) {
    return MethodCall(
      'TestGenericClass#get',
      <String, dynamic>{
        'uniqueId': $uniqueId,
        r'$newUniqueId': $newUniqueId,
      },
    );
  }

  MethodCall $allocate() {
    return MethodCall(
      'TestGenericClass#allocate',
      <String, String>{'uniqueId': $uniqueId},
    );
  }

  MethodCall $deallocate() {
    return MethodCall(
      'TestGenericClass#deallocate',
      <String, String>{'uniqueId': $uniqueId},
    );
  }
}

class $Wrapper {
  $Wrapper(this.$uniqueId);

  final String $uniqueId;

  MethodCall $allocate() {
    return MethodCall(
      '${this.runtimeType}#allocate',
      <String, String>{'uniqueId': $uniqueId},
    );
  }

  MethodCall $deallocate() {
    return MethodCall(
      '${this.runtimeType}#deallocate',
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
