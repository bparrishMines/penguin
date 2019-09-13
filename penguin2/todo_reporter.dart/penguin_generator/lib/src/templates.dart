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
      '__className__()', 
      <String, String>{'uniqueId': $uniqueId},
    );
  }
  // end CONSTRUCTOR
  // end CONSTRUCTORS

  // METHODS
  // METHOD
  MethodCall $__methodName__() {
    return MethodCall(
      '__className__#__methodName__',
       <String, String>{'uniqueId': $uniqueId},
    );
  }
  // end METHOD
  // end METHODS
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

  return channel.invokeListMethod('Invoke', calls);
}
  ''');

  static const _Template android = _Template._(r'''
package __package__;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
// IMPORTS
// IMPORT
import __classPackage__;
// end IMPORT
// end IMPORTS

public class ChannelGenerated implements MethodCallHandler {
  private abstract class FlutterWrapper {
    private final String uniqueId;
    
    FlutterWrapper(String uniqueId) {
      this.uniqueId = uniqueId;
    }

    abstract Object onMethodCall(MethodCall call);

    private void allocate() {
      addWrapper(uniqueId, this, allocatedWrappers);
    }

    private void deallocate() {
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
    } finally {
      tempWrappers.clear();
    }
  }
  
  private Object onMethodCall(MethodCall call) throws NoUniqueIdException, WrapperNotFoundException {
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
  private class __className__ extends FlutterWrapper {
    private final __className__ __variableName__;

    __className__(String uniqueId, __className__ __variableName__) {
      super(uniqueId);
      this.__variableName__ = __variableName__;
      addWrapper(uniqueId, this, tempWrappers);
    }
    
    @Override
    public Object onMethodCall(MethodCall call) {
      return null;
    }

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
}

class MethodChannelTemplateCreator extends _TemplateCreator {
  @override
  _Template get template => _Template.methodChannel;

  String createMethod({String className, String methodName}) {
    return _replaceMethod(<Pattern, String>{
      _Replacement.className.name: className,
      _Replacement.methodName.name: methodName,
    });
  }

  String createClass({
    Iterable<String> constructors,
    Iterable<String> methods,
    String className,
  }) {
    return _replaceClass(
      <Pattern, String>{
        _Block.constructors.exp: constructors.join(),
        _Block.methods.exp: methods.join(),
        _Replacement.className.name: className,
      },
    );
  }

  String createFile({Iterable<String> classes}) {
    return _replace(
      template.value,
      <Pattern, String>{_Block.classes.exp: classes.join()},
    );
  }

  String createConstructor({String className}) {
    return _replaceConstructor(
      <Pattern, String>{_Replacement.className.name: className},
    );
  }
}

class AndroidTemplateCreator extends _TemplateCreator {
  @override
  _Template get template => _Template.android;

  String createMethod({
    String methodName,
    String variableName,
  }) {
    return _replaceMethod(<Pattern, String>{
      _Replacement.methodName.name: methodName,
      _Replacement.variableName.name: variableName,
    });
  }

  String createClass({
    Iterable<String> methods,
    String className,
    String variableName,
  }) {
    return _replaceClass(<Pattern, String>{
      _Block.methods.exp: methods.join(),
      _Replacement.className.name: className,
      _Replacement.variableName.name: variableName,
    });
  }

  String createImport({String classPackage}) {
    return _replaceImport(<Pattern, String>{
      _Replacement.classPackage.name: classPackage,
    });
  }

  String createFile({
    Iterable<String> imports,
    Iterable<String> classes,
    String package,
  }) {
    return _replace(template.value, <Pattern, String>{
      _Block.imports.exp: imports.join(),
      _Block.classes.exp: classes.join(),
      _Replacement.package.name: package,
    });
  }
}

abstract class _TemplateCreator {
  _Template get template;

  String _getMethod(String input) {
    return _Block.method.exp.firstMatch(input).group(1);
  }

  String _getImport(String input) {
    return _Block.import.exp.firstMatch(input).group(1);
  }

  String _getClass(String input) {
    return _Block.aClass.exp.firstMatch(input).group(1);
  }

  String _getConstructor(String input) {
    return _Block.constructor.exp.firstMatch(input).group(1);
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

  String _replaceMethod(Map<Pattern, String> replacements) {
    return _replace(_getMethod(template.value), replacements);
  }

  String _replaceImport(Map<Pattern, String> replacements) {
    return _replace(_getImport(template.value), replacements);
  }

  String _replaceConstructor(Map<Pattern, String> replacements) {
    return _replace(_getConstructor(template.value), replacements);
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
}
