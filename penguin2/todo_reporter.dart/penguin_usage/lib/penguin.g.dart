import 'package:flutter/services.dart';


class $Usage1 {
  $Usage1(this.$uniqueId);
  
  final String $uniqueId;
  
  
  MethodCall $method() {
    return MethodCall(
      'Usage1#method',
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
  