class DartTemplateCreator extends _TemplateCreator {
  String createMethod({String className, String methodName}) {
    return _replaceMethod(<Pattern, String>{
      _Replacement.className.name: className,
      _Replacement.methodName.name: methodName,
    });
  }

  String createFile({
    Iterable<String> methods,
    String libraryName,
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
    String methodName,
    String variableName,
  }) {
    return _replaceMethod(<Pattern, String>{
      _Replacement.methodName.name: methodName,
      _Replacement.variableName.name: variableName,
    });
  }

//  String createFile({
//    Iterable<String> methods,
//    String className,
//    String package,
//    String variableName,
//  }) {
//    return _replace(
//      template.value,
//      <Pattern, String>{
//        _TemplateCreator._methodBlocks: methods.join('\n'),
//        _Replacement.className.name: className,
//        _Replacement.package.name: package,
//        _Replacement.variableName.name: variableName,
//      },
//    );
//  }

  String createClass({
    Iterable<String> methods,
    String className,
    String variableName,
  }) {
    return _replaceClass(<Pattern, String>{
      _Block.methods.exp: methods.join('\n'),
      _Replacement.className.name: className,
      _Replacement.variableName.name: variableName,
    });
  }

  String createImport({String classPackage, String className}) {
    return _replaceImport(<Pattern, String>{
      _Replacement.classPackage.name: classPackage,
      _Replacement.className.name: className,
    });
  }

  String createFile({
    Iterable<String> imports,
    Iterable<String> classes,
    String package,
    String libraryName,
  }) {
    return _replace(template.value, <Pattern, String>{
      _Block.imports.exp: imports.join('\n'),
      _Block.classes.exp: classes.join('\n'),
      _Replacement.package.name: package,
      _Replacement.libraryName.name: libraryName,
    });
  }

//  String createLibrary({
//    Iterable<String> classes,
//    Iterable<String> imports,
//    String className,
//    String package,
//    String variableName,
//  }) {
//    return _replace(
//      template.value,
//      <Pattern, String>{
//        _TemplateCreator._methodBlocks: methods.join('\n'),
//        _Replacement.className.name: className,
//        _Replacement.package.name: package,
//        _Replacement.variableName.name: variableName,
//      },
//    );
//  }

//  String createCentral({String package}) {
//    return _replace(
//      _Template.javaWrapper.value,
//      <Pattern, String>{_Replacement.package.name: package},
//    );
//  }

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
    print('_getMethod');
    return _methodBlock.firstMatch(input).group(1);
  }

  String _getImport(String input) {
    print('_getImport');
    return _Block.import.exp.firstMatch(input).group(1);
  }

//  String _getImports(String input) {
//    print('_getImports');
//    return _Block.imports.exp.firstMatch(input).group(1);
//  }

  String _getClass(String input) {
    print('_getClass');
    return _Block.aClass.exp.firstMatch(input).group(1);
  }
//
//  String _getClasses(String input) {
//    print('_getClasses');
//    return _Block.classes.exp.firstMatch(input).group(1);
//  }
//
//  String _getMethods(String input) {
//    print('_getMethods');
//    return _Block.methods.exp.firstMatch(input).group(1);
//  }

  // TODO: Speedup with replaceAllMapped
  String _replace(String value, Map<Pattern, String> replacements) {
    for (MapEntry<Pattern, String> entry in replacements.entries) {
      value = value.replaceAll(entry.key, entry.value);
    }
    return value;
  }

  String _replaceClass(Map<Pattern, String> replacements) {
    return _replace(_getClass(template.value), replacements);
  }

  String _replaceMethod(Map<Pattern, String> replacements) {
    return _replace(_getMethod(template.value), replacements);
  }

  String _replaceImport(Map<Pattern, String> replacements) {
    return _replace(_getImport(template.value), replacements);
  }
}

class _Block {
  _Block(this.exp);

  final RegExp exp;

  static final _Block methods = _Block(RegExp(
    r'// METHODS$(.*)// end METHODS',
    multiLine: true,
    dotAll: true,
  ));

  static final _Block method = _Block(RegExp(
    r'// METHOD$(.*)// end METHOD$',
    multiLine: true,
    dotAll: true,
  ));

  static final _Block imports = _Block(RegExp(
    r'// IMPORTS$(.*)// end IMPORTS',
    multiLine: true,
    dotAll: true,
  ));

  static final _Block import = _Block(RegExp(
    r'// IMPORT$(.*)// end IMPORT$',
    multiLine: true,
    dotAll: true,
  ));

  static final _Block classes = _Block(RegExp(
    r'// CLASSES$(.*)// end CLASSES',
    multiLine: true,
    dotAll: true,
  ));

  static final _Block aClass = _Block(RegExp(
    r'// CLASS$(.*)// end CLASS$',
    multiLine: true,
    dotAll: true,
  ));
}

class _Replacement {
  const _Replacement(this.name);

  final String name;

  static final _Replacement methodName = _Replacement('__methodName__');
  static final _Replacement className = _Replacement('__className__');
  static final _Replacement channelName = _Replacement('__channelName__');
  static final _Replacement variableName = _Replacement('__variableName__');
  static final _Replacement package = _Replacement('__package__');
  static final _Replacement classPackage = _Replacement('__classPackage__');
  static final _Replacement libraryName = _Replacement('__libraryName__');
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

//  static const _Template java = _Template._(r'''
//package __package__;
//
//import io.flutter.plugin.common.MethodCall;
//
//// CLASS
//class Flutter__className__ implements FlutterWrapper {
//  private final String handle;
//  public final __className__ __variableName__;
//
//  // METHODS
//  // METHOD
//  Object __methodName__() {
//    return __variableName__.__methodName__();
//  }
//  // end METHOD
//  // end METHODS
//}
//// end CLASS
//''');

  static const _Template java = _Template._(r'''
package __package__;

import io.flutter.plugin.common.MethodCall;
// IMPORTS
// IMPORT
import __classPackage__.__className__;
// end IMPORT
// end IMPORTS

public class __libraryName__ {
  // CLASSES
  // CLASS
  static class __className__ {
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
  // end CLASSES
}
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
