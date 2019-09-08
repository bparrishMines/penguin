class TemplateIdentifiers {
  const TemplateIdentifiers._(this._id);

  final String _id;

  static final String methodName = '__methodName__';
  static final String className = '__className__';
  static final String channelName = '__channelName__';
  static final String variableName = '__variableName__';
  static final String package = '__package__';
}

class Templates {
  const Templates();

  static String getMethod(String input) {
    final RegExp methodRegExp = RegExp(
      r'// METHOD$(.*)// end METHOD$',
      multiLine: true,
      dotAll: true,
    );

    return methodRegExp.firstMatch(input).group(1);
  }

  static const String dart = r'''
// CLASS
class _$__className__ {
  _$__className__(this.$uniqueId);
  
  final String $uniqueId;
  
  // METHODS
  // METHOD
  MethodCall _$__methodName__() {
    return MethodCall('__className__#__methodName__');
  }
  // end METHOD
  // end METHODS
  
  Future<List<dynamic>> _$invoke(List<MethodCall> methodCalls) {
    final List<Map<String, dynamic>> calls = methodCalls
        .map<Map<String, dynamic>>(
          (MethodCall methodCall) => <String, dynamic>{
            'method': methodCall.method,
            'arguments': methodCall.arguments,
          },
        )
        .toList();

    return MethodChannel('__channelName__').invokeListMethod('Invoke', calls);
  }
}
// end CLASS
''';

  static const String java = r'''
package __package__;

import io.flutter.plugin.common.MethodCall;

// CLASS
class Flutter__className__ implements FlutterWrapper {
  private final String handle;

  public final __className__ __variableName__;
}
// end CLASS
''';

  static const String javaWrapper = r''' 
package __package__;

import io.flutter.plugin.common.MethodCall;

public interface FlutterWrapper {
  Object onMethodCall(MethodCall call);
  static class MethodNotImplemented {}
}
''';
}
