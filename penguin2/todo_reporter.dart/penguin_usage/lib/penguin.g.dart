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
  

  
  MethodCall $aMethod(
  
  ) {
    return MethodCall(
      'TestClass#aMethod',
       <String, dynamic>{'uniqueId': $uniqueId,
       
       },
    );
  }
  
  MethodCall $getStringMethod(
  
  ) {
    return MethodCall(
      'TestClass#getStringMethod',
       <String, dynamic>{'uniqueId': $uniqueId,
       
       },
    );
  }
  
  MethodCall $addTwo(
  
  int value
  
  ) {
    return MethodCall(
      'TestClass#addTwo',
       <String, dynamic>{'uniqueId': $uniqueId,
       
       'value': value,
       
       },
    );
  }
  
  MethodCall $divide(
  
  int one
  ,
  int two
  
  ) {
    return MethodCall(
      'TestClass#divide',
       <String, dynamic>{'uniqueId': $uniqueId,
       
       'one': one,
       
       'two': two,
       
       },
    );
  }
  
  MethodCall $getList(
  
  Map<int, int> addThese
  
  ) {
    return MethodCall(
      'TestClass#getList',
       <String, dynamic>{'uniqueId': $uniqueId,
       
       'addThese': addThese,
       
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
