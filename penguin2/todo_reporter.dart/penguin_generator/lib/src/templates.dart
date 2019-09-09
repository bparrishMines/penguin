class DartTemplateCreator extends _TemplateCreator {
  String createMethod({String className, String methodName}) {
    return _replaceMethod(<Pattern, String>{
      _Replacement.className.name: className,
      _Replacement.methodName.name: methodName,
    });
  }

  String createFile({
    Iterable<String> methods,
    String className,
    String channelName,
  }) {
    return _replace(
      template.value,
      <Pattern, String>{
        _Replacement.className.name: className,
        _Replacement.channelName.name: channelName,
        _TemplateCreator._methodBlocks: methods.join('\n'),
      },
    );
  }

  @override
  _Template get template => _Template.dart;
}

class JavaTemplateCreator extends _TemplateCreator {
  String createMethod({
    String className,
    String methodName,
    String variableName,
  }) {
    return _replaceMethod(<Pattern, String>{
      _Replacement.className.name: className,
      _Replacement.methodName.name: methodName,
      _Replacement.variableName.name: variableName,
    });
  }

  String createFile({
    Iterable<String> methods,
    String className,
    String package,
    String variableName,
  }) {
    return _replace(
      template.value,
      <Pattern, String>{
        _TemplateCreator._methodBlocks: methods.join('\n'),
        _Replacement.className.name: className,
        _Replacement.package.name: package,
        _Replacement.variableName.name: variableName,
      },
    );
  }

  String createCentral({String package}) {
    return _replace(
      _Template.javaWrapper.value,
      <Pattern, String>{_Replacement.package.name: package},
    );
  }

  @override
  _Template get template => _Template.java;
}

abstract class _TemplateCreator {
  static final RegExp _methodBlocks = RegExp(
    r'// METHODS.*// end METHODS',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp _methodBlock = RegExp(
    r'// METHOD$(.*)// end METHOD$',
    multiLine: true,
    dotAll: true,
  );

  _Template get template;

  String _getMethod(String input) {
    return _methodBlock.firstMatch(input).group(1);
  }

  // TODO: Speedup with replaceAllMapped
  String _replace(String value, Map<Pattern, String> replacements) {
    for (MapEntry<Pattern, String> entry in replacements.entries) {
      value = value.replaceAll(entry.key, entry.value);
    }
    return value;
  }

  String _replaceMethod(Map<Pattern, String> replacements) {
    return _replace(_getMethod(template.value), replacements);
  }
}

class _Replacement {
  const _Replacement._(this.name);

  final String name;

  static final _Replacement methodName = _Replacement._('__methodName__');
  static final _Replacement className = _Replacement._('__className__');
  static final _Replacement channelName = _Replacement._('__channelName__');
  static final _Replacement variableName = _Replacement._('__variableName__');
  static final _Replacement package = _Replacement._('__package__');
}

class _Template {
  const _Template._(this.value);

  final String value;

  static const _Template dart = _Template._(r'''
// CLASS
class _$__className__ {
  _$__className__(this.$uniqueId);
  
  final String $uniqueId;
  
  // METHODS
  // METHOD
  MethodCall _$__methodName__() {
    return MethodCall(
      '__className__#__methodName__',
       <String, String>{'uniqueId': $uniqueId},
    );
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
''');

  static const _Template java = _Template._(r'''
package __package__;

import io.flutter.plugin.common.MethodCall;

// CLASS
class Flutter__className__ implements FlutterWrapper {
  private final String handle;
  public final __className__ __variableName__;
  
  // METHODS
  // METHOD
  Object __methodName__() {
    return __variableName__.__methodName__();
  }
  // end METHOD
  // end METHODS
}
// end CLASS
''');

  static const _Template javaWrapper = _Template._(r''' 
package __package__;

import io.flutter.plugin.common.MethodCall;

public interface FlutterWrapper {
  Object onMethodCall(MethodCall call);
  static class MethodNotImplemented {}
}
''');

  static const _Template javaCentral = _Template._(r'''
  
''');
}
