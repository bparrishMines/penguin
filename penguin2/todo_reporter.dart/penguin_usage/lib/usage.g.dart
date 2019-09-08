// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usage.dart';

// **************************************************************************
// ClassGenerator
// **************************************************************************

// CLASS
class _$Usage1 {
  _$Usage1(this.$uniqueId);

  final String $uniqueId;

  MethodCall _$method() {
    return MethodCall('Usage1#method');
  }

  Future<List<dynamic>> _$invoke(
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
}
// end CLASS
