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
      'Banana()',
      <String, String>{'uniqueId': $uniqueId},
    );
  }
  

  
  MethodCall $method() {
    return MethodCall(
      'Banana#method',
       <String, String>{'uniqueId': $uniqueId},
    );
  }
  
}

class $Usage2 {
  $Usage2(this.$uniqueId);

  final String $uniqueId;

  

  
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

  return channel.invokeListMethod('Invoke', calls);
}
