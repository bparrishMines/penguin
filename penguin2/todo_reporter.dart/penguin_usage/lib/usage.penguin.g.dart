// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// PenguinGenerator
// **************************************************************************
part of 'usage.dart';


class _$Usage1 {
  _$Usage1(this.$uniqueId);
  
  final String $uniqueId;
  
  
  MethodCall _$method() {
    return MethodCall(
      'Usage1#method',
       <String, String>{'uniqueId': $uniqueId},
    );
  }
  
  
  Future<List<dynamic>> _$invoke(MethodChannel channel, List<MethodCall> methodCalls) {
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
}

class _$Usage2 {
  _$Usage2(this.$uniqueId);
  
  final String $uniqueId;
  
  
  
  Future<List<dynamic>> _$invoke(MethodChannel channel, List<MethodCall> methodCalls) {
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
}

  