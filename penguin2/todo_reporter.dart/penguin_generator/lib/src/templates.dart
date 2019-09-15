class _Template {
  const _Template._(this.value);

  final String value;

  static const _Template methodChannel = _Template._(r'''
import 'package:flutter/services.dart';

// CLASSES
// CLASS
class $__className__ {
  $__className__(this.$uniqueId);

  final String $uniqueId;

  // CONSTRUCTORS
  // CONSTRUCTOR
  MethodCall $__className__Default() {
    return MethodCall(
      '__platformClassName__()',
      <String, String>{'uniqueId': $uniqueId},
    );
  }
  // end CONSTRUCTOR
  // end CONSTRUCTORS

  // METHODS
  // METHOD
  MethodCall $__methodName__(
  // PARAMETERS
  // PARAMETER
  __parameterType__ __parameterName__
  // end PARAMETER
  // end PARAMETERS
  ) {
    return MethodCall(
      '__platformClassName__#__methodName__',
       <String, String>{'uniqueId': $uniqueId},
    );
  }
  // end METHOD
  // end METHODS
  
  MethodCall $allocate() {
    return MethodCall(
      '__platformClassName__#allocate',
       <String, String>{'uniqueId': $uniqueId},
    );
  }
  
  MethodCall $deallocate() {
    return MethodCall(
      '__platformClassName__#deallocate',
       <String, String>{'uniqueId': $uniqueId},
    );
  }
}
// end CLASS
// end CLASSES

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
''');

  static const _Template android = _Template._(r'''
package __package__;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
// IMPORTS
// IMPORT
import __classPackage__.__platformClassName__;
// end IMPORT
// end IMPORTS

public class ChannelGenerated implements MethodCallHandler {
  private abstract class FlutterWrapper {
    private final String uniqueId;
    
    FlutterWrapper(String uniqueId) {
      this.uniqueId = uniqueId;
    }

    abstract Object onMethodCall(MethodCall call) throws NotImplementedException;

    void allocate() {
      if (isAllocated(uniqueId)) return;
      addWrapper(uniqueId, this, allocatedWrappers);
    }

    void deallocate() {
      removeWrapper(uniqueId);
    }
  }

  private class NotImplementedException extends Exception {
    NotImplementedException(String method) {
      super(String.format(Locale.getDefault(),"No implementation for %s.", method));
    }
  }

  private class NoUniqueIdException extends Exception {
    NoUniqueIdException(String method) {
      super(String.format("MethodCall was made without a unique handle for %s.", method));
    }
  }

  private class WrapperNotFoundException extends Exception {
    WrapperNotFoundException(String uniqueId) {
      super(String.format("Could not find FlutterWrapper with uniqueId %s.", uniqueId));
    }
  }

  private final HashMap<String, FlutterWrapper> allocatedWrappers = new HashMap<>();
  private final HashMap<String, FlutterWrapper> tempWrappers = new HashMap<>();

  private void addWrapper(
      final String uniqueId, final FlutterWrapper wrapper, HashMap<String, FlutterWrapper> wrapperMap) {
    if (wrapperMap.get(uniqueId) != null) {
      final String message = String.format("Object for uniqueId already exists: %s", uniqueId);
      throw new IllegalArgumentException(message);
    }
    wrapperMap.put(uniqueId, wrapper);
  }

  private void removeWrapper(String uniqueId) {
    allocatedWrappers.remove(uniqueId);
  }

  private Boolean isAllocated(final String uniqueId) {
    return allocatedWrappers.containsKey(uniqueId);
  }

  private FlutterWrapper getWrapper(String uniqueId) {
    final FlutterWrapper wrapper = allocatedWrappers.get(uniqueId);
    if (wrapper != null) return wrapper;
    return tempWrappers.get(uniqueId);
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    try {
      final Object value = onMethodCall(call);
      result.success(value);
    } catch (WrapperNotFoundException exception) {
      result.error(exception.getClass().getSimpleName(), exception.getMessage(), null);
    } catch (NoUniqueIdException exception) {
      result.error(exception.getClass().getSimpleName(), exception.getMessage(), null);
    } catch (NotImplementedException exception) {
      result.notImplemented();
    } finally {
      tempWrappers.clear();
    }
  }

  private Object onMethodCall(MethodCall call) throws NoUniqueIdException, WrapperNotFoundException, NotImplementedException {
    switch(call.method) {
      case "MultiInvoke":
        final ArrayList<HashMap<String, Object>> allMethodCallData = (ArrayList<HashMap<String, Object>>) call.arguments;
        final ArrayList<Object> resultData = new ArrayList<>(allMethodCallData.size());
        for(HashMap<String, Object> methodCallData : allMethodCallData) {
          final String method = (String) methodCallData.get("method");;
          final HashMap<String, Object> arguments = (HashMap<String, Object>) methodCallData.get("arguments");
          final MethodCall methodCall = new MethodCall(method, arguments);
          resultData.add(onMethodCall(methodCall));
        }
        return resultData;
      // STATICMETHODCALLS
      // STATICMETHODCALL
      case "__platformClassName__()": {
          new __platformClassName__Wrapper((String) call.argument("uniqueId"));
          return null;
        }
      // end STATICMETHODCALL
      // end STATICMETHODCALLS
      default:
        final String uniqueId = call.argument("uniqueId");
        if (uniqueId == null) throw new NoUniqueIdException(call.method);

        final FlutterWrapper wrapper = getWrapper(uniqueId);
        if (wrapper == null) throw new WrapperNotFoundException(uniqueId);

        return wrapper.onMethodCall(call);
    }
  }

  // CLASSES
  // CLASS
  private class __platformClassName__Wrapper extends FlutterWrapper {
    private final __platformClassName__ __variableName__;

    __platformClassName__Wrapper(String uniqueId, __platformClassName__ __variableName__) {
      super(uniqueId);
      this.__variableName__ = __variableName__;
      addWrapper(uniqueId, this, tempWrappers);
    }

    // CONSTRUCTORS
    // CONSTRUCTOR
    private __platformClassName__Wrapper(final String uniqueId) {
      super(uniqueId);
      this.__variableName__ = new __platformClassName__();
      addWrapper(uniqueId, this, tempWrappers);
    }
    // end CONSTRUCTOR
    // end CONSTRUCTORS

    @Override
    public Object onMethodCall(MethodCall call) throws NotImplementedException {
      switch(call.method) {
        case "__platformClassName__#allocate":
          allocate();
          return null;
        case "__platformClassName__#deallocate":
          deallocate();
          return null;
        // METHODCALLS
        // METHODCALL
        case "__platformClassName__#__methodName__":
          return __methodName__();
        // end METHODCALL
        // end METHODCALLS
        default:
          throw new NotImplementedException(call.method);
      }
    }

    // METHODS
    // METHOD returns:void
    Object __methodName__() {
      __variableName__.__methodName__();
      return null;
    }
    // end METHOD returns:void
    // METHOD returns:supported
    Object __methodName__() {
      return __variableName__.__methodName__();
    }
    // end METHOD returns:supported
    // end METHODS
  }
  // end CLASS
  // end CLASSES
}
''');
}

class MethodChannelTemplateCreator extends _TemplateCreator {
  @override
  _Template get template => _Template.methodChannel;

  String createMethod({
    Iterable<String> parameters,
    String platformClassName,
    String methodName,
  }) {
    return _replace(
      _Block.method.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        _Block.parameters.exp: parameters.join(','),
        _Replacement.platformClassName.name: platformClassName,
        _Replacement.methodName.name: methodName,
      },
    );
  }

  String createParameter({String parameterType, String parameterName}) {
    return _replaceParameter(<Pattern, String>{
      _Replacement.parameterType.name: parameterType,
      _Replacement.parameterName.name: parameterName,
    });
  }

  String createClass({
    Iterable<String> constructors,
    Iterable<String> methods,
    String className,
    String platformClassName,
  }) {
    return _replaceClass(
      <Pattern, String>{
        _Block.constructors.exp: constructors.join(),
        _Block.methods.exp: methods.join(),
        _Replacement.className.name: className,
        _Replacement.platformClassName.name: platformClassName,
      },
    );
  }

  String createFile({Iterable<String> classes}) {
    return _replace(
      template.value,
      <Pattern, String>{_Block.classes.exp: classes.join()},
    );
  }

  String createConstructor({String platformClassName, String className}) {
    return _replaceConstructor(
      <Pattern, String>{
        _Replacement.platformClassName.name: platformClassName,
        _Replacement.className.name: className
      },
    );
  }
}

class AndroidTemplateCreator extends _TemplateCreator {
  @override
  _Template get template => _Template.android;

  String createMethod(
    ReturnType returnType, {
    String methodName,
    String variableName,
  }) {
    return _replace(
      _Block.channelMethod(returnType).exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        _Replacement.methodName.name: methodName,
        _Replacement.variableName.name: variableName,
      },
    );
  }

  String createClass({
    Iterable<String> constructors,
    Iterable<String> methods,
    Iterable<String> methodCalls,
    String platformClassName,
    String variableName,
  }) {
    return _replaceClass(<Pattern, String>{
      _Block.constructors.exp: constructors.join(),
      _Block.methods.exp: methods.join(),
      _Block.methodCalls.exp: methodCalls.join(),
      _Replacement.platformClassName.name: platformClassName,
      _Replacement.variableName.name: variableName,
    });
  }

  String createImport({String classPackage, String platformClassName}) {
    return _replaceImport(<Pattern, String>{
      _Replacement.classPackage.name: classPackage,
      _Replacement.platformClassName.name: platformClassName,
    });
  }

  String createFile({
    Iterable<String> imports,
    Iterable<String> classes,
    Iterable<String> staticMethodCalls,
    String package,
  }) {
    return _replace(template.value, <Pattern, String>{
      _Block.imports.exp: imports.join(),
      _Block.classes.exp: classes.join(),
      _Block.staticMethodCalls.exp: staticMethodCalls.join(),
      _Replacement.package.name: package,
    });
  }

  String createConstructor({String platformClassName, String variableName}) {
    return _replaceConstructor(<Pattern, String>{
      _Replacement.platformClassName.name: platformClassName,
      _Replacement.variableName.name: variableName,
    });
  }

  String createMethodCall({String platformClassName, String methodName}) {
    return _replaceMethodCall(<Pattern, String>{
      _Replacement.platformClassName.name: platformClassName,
      _Replacement.methodName.name: methodName,
    });
  }

  String createStaticMethodCall({String platformClassName}) {
    return _replaceStaticMethodCall(<Pattern, String>{
      _Replacement.platformClassName.name: platformClassName,
    });
  }
}

enum ReturnType { $void, supported }

abstract class _TemplateCreator {
  _Template get template;

//  String _getMethod(String input) {
//    return _Block.method.exp.firstMatch(input).group(1);
//  }

  String _getImport(String input) {
    return _Block.import.exp.firstMatch(input).group(1);
  }

  String _getClass(String input) {
    return _Block.aClass.exp.firstMatch(input).group(1);
  }

  String _getConstructor(String input) {
    return _Block.constructor.exp.firstMatch(input).group(1);
  }

  String _getMethodCall(String input) {
    return _Block.methodCall.exp.firstMatch(input).group(1);
  }

  String _getStaticMethodCall(String input) {
    return _Block.staticMethodCall.exp.firstMatch(input).group(1);
  }

  String _getParameter(String input) {
    return _Block.parameter.exp.firstMatch(input).group(1);
  }

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

//  String _replaceMethod(Map<Pattern, String> replacements) {
//    return _replace(_getMethod(template), replacements);
//  }

  String _replaceImport(Map<Pattern, String> replacements) {
    return _replace(_getImport(template.value), replacements);
  }

  String _replaceConstructor(Map<Pattern, String> replacements) {
    return _replace(_getConstructor(template.value), replacements);
  }

  String _replaceMethodCall(Map<Pattern, String> replacements) {
    return _replace(_getMethodCall(template.value), replacements);
  }

  String _replaceStaticMethodCall(Map<Pattern, String> replacements) {
    return _replace(_getStaticMethodCall(template.value), replacements);
  }

  String _replaceParameter(Map<Pattern, String> replacements) {
    return _replace(_getParameter(template.value), replacements);
  }
}

class _Block {
  _Block(this.exp);

  final RegExp exp;

  static final _Block methods = _Block(RegExp(
    r'// METHODS$.(.*)// end METHODS',
    multiLine: true,
    dotAll: true,
  ));

  static final _Block method = _Block(RegExp(
    r'// METHOD$(.*)// end METHOD$',
    multiLine: true,
    dotAll: true,
  ));

  // For Android and iOS
  static _Block channelMethod(ReturnType type) {
    final List<String> configs = <String>[];
    switch (type) {
      case ReturnType.$void:
        configs.add('returns:void');
        break;
      case ReturnType.supported:
        configs.add('returns:supported');
        break;
    }

    final String joinConfigs = configs.join(' ');

    return _Block(RegExp(
      '// METHOD $joinConfigs\$(.*)// end METHOD $joinConfigs\$',
      multiLine: true,
      dotAll: true,
    ));
  }

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

  static final _Block constructors = _Block(RegExp(
    r'// CONSTRUCTORS$(.*)// end CONSTRUCTORS$',
    multiLine: true,
    dotAll: true,
  ));

  static final _Block constructor = _Block(RegExp(
    r'// CONSTRUCTOR$(.*)// end CONSTRUCTOR$',
    multiLine: true,
    dotAll: true,
  ));

  static final _Block methodCalls = _Block(RegExp(
    r'// METHODCALLS$(.*)// end METHODCALLS$',
    multiLine: true,
    dotAll: true,
  ));

  static final _Block methodCall = _Block(RegExp(
    r'// METHODCALL$(.*)// end METHODCALL$',
    multiLine: true,
    dotAll: true,
  ));

  static final _Block staticMethodCalls = _Block(RegExp(
    r'// STATICMETHODCALLS$(.*)// end STATICMETHODCALLS$',
    multiLine: true,
    dotAll: true,
  ));

  static final _Block staticMethodCall = _Block(RegExp(
    r'// STATICMETHODCALL$(.*)// end STATICMETHODCALL$',
    multiLine: true,
    dotAll: true,
  ));

  static final _Block parameters = _Block(RegExp(
    r'// PARAMETERS$(.*)// end PARAMETERS$',
    multiLine: true,
    dotAll: true,
  ));

  static final _Block parameter = _Block(RegExp(
    r'// PARAMETER$(.*)// end PARAMETER$',
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
  static final _Replacement platformClassName = _Replacement(
    '__platformClassName__',
  );
  static final _Replacement parameterName = _Replacement('__parameterName__');
  static final _Replacement parameterType = _Replacement('__parameterType__');
}
