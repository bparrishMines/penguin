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
      <String, String>{r'$uniqueId': $uniqueId},
    );
  }

  MethodCall $aMethod(
    String $newUniqueId,
  ) {
    return MethodCall(
      'TestClass#aMethod',
      <String, dynamic>{
        r'$uniqueId': $uniqueId,
        r'$newUniqueId': $newUniqueId,
      },
    );
  }

  MethodCall $getStringMethod(
    String $newUniqueId,
  ) {
    return MethodCall(
      'TestClass#getStringMethod',
      <String, dynamic>{
        r'$uniqueId': $uniqueId,
        r'$newUniqueId': $newUniqueId,
      },
    );
  }

  MethodCall $addTwo(String $newUniqueId, int value) {
    return MethodCall(
      'TestClass#addTwo',
      <String, dynamic>{
        r'$uniqueId': $uniqueId,
        r'$newUniqueId': $newUniqueId,
        'value': value,
      },
    );
  }

  MethodCall $divide(String $newUniqueId, int one, int two) {
    return MethodCall(
      'TestClass#divide',
      <String, dynamic>{
        r'$uniqueId': $uniqueId,
        r'$newUniqueId': $newUniqueId,
        'one': one,
        'two': two,
      },
    );
  }

  MethodCall $getList(String $newUniqueId, Map<int, int> addThese) {
    return MethodCall(
      'TestClass#getList',
      <String, dynamic>{
        r'$uniqueId': $uniqueId,
        r'$newUniqueId': $newUniqueId,
        'addThese': addThese,
      },
    );
  }

  MethodCall $giveUsage2(String $newUniqueId, $Usage2 usage2) {
    return MethodCall(
      'TestClass#giveUsage2',
      <String, dynamic>{
        r'$uniqueId': $uniqueId,
        r'$newUniqueId': $newUniqueId,
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
        r'$uniqueId': $uniqueId,
        r'$newUniqueId': $newUniqueId,
      },
    );
  }

  static MethodCall $arePenguinsAwesome(
    String $newUniqueId,
  ) {
    return MethodCall(
      'TestClass#arePenguinsAwesome',
      <String, dynamic>{
        r'$newUniqueId': $newUniqueId,
      },
    );
  }

  @override
  String get $platformClassName => 'TestClass';
}

class $Usage2 extends $Wrapper {
  $Usage2(String $uniqueId) : super($uniqueId);

  MethodCall $Usage2Default() {
    return MethodCall(
      'TestClassTwo()',
      <String, String>{r'$uniqueId': $uniqueId},
    );
  }

  @override
  String get $platformClassName => 'TestClassTwo';
}

class $GenericUsage<T> extends $Wrapper {
  $GenericUsage(String $uniqueId) : super($uniqueId);

  MethodCall $GenericUsageDefault() {
    return MethodCall(
      'TestGenericClass()',
      <String, String>{r'$uniqueId': $uniqueId},
    );
  }

  MethodCall $setValue(String $newUniqueId, T value) {
    return MethodCall(
      'TestGenericClass#setValue',
      <String, dynamic>{
        r'$uniqueId': $uniqueId,
        r'$newUniqueId': $newUniqueId,
        if (value is $Wrapper) 'value': value.$uniqueId,
        if (value is! $Wrapper) 'value': value,
      },
    );
  }

  MethodCall $get(
    String $newUniqueId,
  ) {
    return MethodCall(
      'TestGenericClass#get',
      <String, dynamic>{
        r'$uniqueId': $uniqueId,
        r'$newUniqueId': $newUniqueId,
      },
    );
  }

  @override
  String get $platformClassName => 'TestGenericClass';
}

abstract class $Wrapper {
  $Wrapper(this.$uniqueId);

  final String $uniqueId;

  String get $platformClassName;

  MethodCall $allocate() {
    return MethodCall(
      '${$platformClassName}#allocate',
      <String, String>{r'$uniqueId': $uniqueId},
    );
  }

  MethodCall $deallocate() {
    return MethodCall(
      '${$platformClassName}#deallocate',
      <String, String>{r'$uniqueId': $uniqueId},
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
