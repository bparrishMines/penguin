class _Template {
  const _Template._(this.value);

  final String value;

  static const _Template methodChannel = _Template._(r'''
import 'package:flutter/services.dart';

%%CLASSES%%
%%CLASS%%
class $__className__ {
  $__className__(this.$uniqueId);

  final String $uniqueId;

  %%CONSTRUCTORS%%
  %%CONSTRUCTOR%%
  MethodCall $__className__Default() {
    return MethodCall(
      '__platformClassName__()',
      <String, String>{'uniqueId': $uniqueId},
    );
  }
  %%CONSTRUCTOR%%
  %%CONSTRUCTORS%%

  %%METHODS%%
  %%METHOD%%
  MethodCall $__methodName__(
  %%PARAMETERS%%
  %%PARAMETER type:supported%%
  __parameterType__ __parameterName__
  %%PARAMETER type:supported%%
  %%PARAMETER type:wrapper%%
  $__parameterType__ __parameterName__
  %%PARAMETER type:wrapper%%
  %%PARAMETERS%%
  ) {
    return MethodCall(
      '__platformClassName__#__methodName__',
       <String, dynamic>{'uniqueId': $uniqueId,
       %%METHODCALLPARAMS%%
       %%METHODCALLPARAM%%
       '__parameterName__': __parameterName__,
       %%METHODCALLPARAM%%
       %%METHODCALLPARAMS%%
       },
    );
  }
  %%METHOD%%
  %%METHODS%%
  
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
%%CLASS%%
%%CLASSES%%

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
%%IMPORTS%%
%%IMPORT%%
import __classPackage__.__platformClassName__;
%%IMPORT%%
%%IMPORTS%%

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
      result.error(exception.getClass().getSimpleName(), exception.getMessage(), null);
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
          final String method = (String) methodCallData.get("method");
          final HashMap<String, Object> arguments = (HashMap<String, Object>) methodCallData.get("arguments");
          final MethodCall methodCall = new MethodCall(method, arguments);
          resultData.add(onMethodCall(methodCall));
        }
        return resultData;
      %%STATICMETHODCALLS%%
      %%STATICMETHODCALL%%
      case "__platformClassName__()": {
          new __platformClassName__Wrapper((String) call.argument("uniqueId"));
          return null;
        }
      %%STATICMETHODCALL%%
      %%STATICMETHODCALLS%%
      default:
        final String uniqueId = call.argument("uniqueId");
        if (uniqueId == null) throw new NoUniqueIdException(call.method);

        final FlutterWrapper wrapper = getWrapper(uniqueId);
        if (wrapper == null) throw new WrapperNotFoundException(uniqueId);

        return wrapper.onMethodCall(call);
    }
  }

  %%CLASSES%%
  %%CLASS%%
  private class __platformClassName__Wrapper extends FlutterWrapper {
    private final __platformClassName__ __variableName__;

    __platformClassName__Wrapper(String uniqueId, __platformClassName__ __variableName__) {
      super(uniqueId);
      this.__variableName__ = __variableName__;
      addWrapper(uniqueId, this, tempWrappers);
    }

    %%CONSTRUCTORS%%
    %%CONSTRUCTOR%%
    private __platformClassName__Wrapper(final String uniqueId) {
      super(uniqueId);
      this.__variableName__ = new __platformClassName__();
      addWrapper(uniqueId, this, tempWrappers);
    }
    %%CONSTRUCTOR%%
    %%CONSTRUCTORS%%

    @Override
    public Object onMethodCall(MethodCall call) throws NotImplementedException {
      switch(call.method) {
        case "__platformClassName__#allocate":
          allocate();
          return null;
        case "__platformClassName__#deallocate":
          deallocate();
          return null;
        %%METHODCALLS%%
        %%METHODCALL%%
        case "__platformClassName__#__methodName__":
          return __methodName__(call);
        %%METHODCALL%%
        %%METHODCALLS%%
        default:
          throw new NotImplementedException(call.method);
      }
    }

    %%METHODS%%
    %%METHOD returns:void%%
    Object __methodName__(MethodCall call) {
      __variableName__.__methodName__(
      %%PARAMETERS%%
      %%PARAMETER type:supported%%
      call.argument("__parameterName__") == null ? null : (__parameterType__) call.argument("__parameterName__")
      %%PARAMETER type:supported%%
      %%PARAMETER type:wrapper%%
      ((__parameterType__Wrapper) getWrapper((String) call.argument("__parameterName__"))).__variableName__
      %%PARAMETER type:wrapper%%
      %%PARAMETERS%%
      );
      return null;
    }
    %%METHOD returns:void%%
    %%METHOD returns:supported%%
    Object __methodName__(MethodCall call) {
      return __variableName__.__methodName__(
      %%PARAMETERS%%
      %%PARAMETER type:supported%%
      call.argument("__parameterName__") == null ? null : (__parameterType__) call.argument("__parameterName__")
      %%PARAMETER type:supported%%
      %%PARAMETER type:wrapper%%
      ((__parameterType__Wrapper) getWrapper((String) call.argument("__parameterName__"))).__variableName__
      %%PARAMETER type:wrapper%%
      %%PARAMETERS%%
      );
    }
    %%METHOD returns:supported%%
    %%METHODS%%
  }
  %%CLASS%%
  %%CLASSES%%
}
''');
}

class MethodChannelTemplateCreator extends _TemplateCreator {
  @override
  _Template get template => _Template.methodChannel;

  String createMethod({
    Iterable<String> parameters,
    Iterable<String> methodCallParams,
    String platformClassName,
    String methodName,
  }) {
    return _replace(
      _Block.method.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        _Block.parameters.exp: parameters.join(','),
        _Block.methodCallParams.exp: methodCallParams.join(),
        _Replacement.platformClassName.name: platformClassName,
        _Replacement.methodName.name: methodName,
      },
    );
  }

  String createParameter(
    MethodChannelType channelType, {
    String parameterType,
    String parameterName,
  }) {
    return _replace(
      _Block.channelParameter(channelType)
          .exp
          .firstMatch(template.value)
          .group(1),
      <Pattern, String>{
        _Replacement.parameterType.name: parameterType,
        _Replacement.parameterName.name: parameterName,
      },
    );
  }

  String createMethodCallParam({String parameterName}) {
    return _replace(
      _Block.methodCallParam.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        _Replacement.parameterName.name: parameterName,
      },
    );
  }

  String createClass({
    Iterable<String> constructors,
    Iterable<String> methods,
    String className,
    String platformClassName,
  }) {
    return _replace(
      _Block.aClass.exp.firstMatch(template.value).group(1),
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
    return _replace(
      _Block.constructor.exp.firstMatch(template.value).group(1),
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
    MethodChannelType returnType, {
    Iterable<String> parameters,
    String methodName,
    String variableName,
  }) {
    return _replace(
      _Block.channelMethod(returnType).exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        _Block.parameters.exp: parameters.join(','),
        _Replacement.methodName.name: methodName,
        _Replacement.variableName.name: variableName,
      },
    );
  }

  String createParameter(
    MethodChannelType channelType, {
    String variableName,
    String parameterType,
    String parameterName,
  }) {
    return _replace(
      _Block.channelParameter(channelType)
          .exp
          .firstMatch(template.value)
          .group(1),
      <Pattern, String>{
        _Replacement.variableName.name: variableName,
        _Replacement.parameterType.name: parameterType,
        _Replacement.parameterName.name: parameterName,
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
    return _replace(
      _Block.aClass.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        _Block.constructors.exp: constructors.join(),
        _Block.methods.exp: methods.join(),
        _Block.methodCalls.exp: methodCalls.join(),
        _Replacement.platformClassName.name: platformClassName,
        _Replacement.variableName.name: variableName,
      },
    );
  }

  String createImport({String classPackage, String platformClassName}) {
    return _replace(
      _Block.import.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        _Replacement.classPackage.name: classPackage,
        _Replacement.platformClassName.name: platformClassName,
      },
    );
  }

  String createFile({
    Iterable<String> imports,
    Iterable<String> classes,
    Iterable<String> staticMethodCalls,
    String package,
  }) {
    return _replace(
      template.value,
      <Pattern, String>{
        _Block.imports.exp: imports.join(),
        _Block.classes.exp: classes.join(),
        _Block.staticMethodCalls.exp: staticMethodCalls.join(),
        _Replacement.package.name: package,
      },
    );
  }

  String createConstructor({String platformClassName, String variableName}) {
    return _replace(
      _Block.constructor.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        _Replacement.platformClassName.name: platformClassName,
        _Replacement.variableName.name: variableName,
      },
    );
  }

  String createMethodCall({String platformClassName, String methodName}) {
    return _replace(
      _Block.methodCall.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        _Replacement.platformClassName.name: platformClassName,
        _Replacement.methodName.name: methodName,
      },
    );
  }

  String createStaticMethodCall({String platformClassName}) {
    return _replace(
      _Block.staticMethodCall.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        _Replacement.platformClassName.name: platformClassName,
      },
    );
  }
}

enum MethodChannelType { $void, supported, wrapper }

abstract class _TemplateCreator {
  _Template get template;

  // TODO: Speedup with replaceAllMapped
  String _replace(String value, Map<Pattern, String> replacements) {
    for (MapEntry<Pattern, String> entry in replacements.entries) {
      value = value.replaceAll(entry.key, entry.value);
    }
    return value;
  }
}

class _Block {
  _Block(this.identifier, [this.config])
      : exp = config == null
            ? RegExp(
                '%%$identifier%%(.*?)%%$identifier%%',
                multiLine: true,
                dotAll: true,
              )
            : RegExp(
                '%%$identifier $config%%(.*?)%%$identifier $config%%',
                multiLine: true,
                dotAll: true,
              );

  final RegExp exp;
  final String identifier;
  final String config;

  static final _Block methods = _Block('METHODS');
  static final _Block method = _Block('METHOD');

  //  For Android and iOS
  static _Block channelMethod(MethodChannelType type) {
    final List<String> configs = <String>[];
    switch (type) {
      case MethodChannelType.$void:
      case MethodChannelType.wrapper:
        configs.add('returns:void');
        break;
      case MethodChannelType.supported:
        configs.add('returns:supported');
        break;
    }

    final String joinConfigs = configs.join(' ');
    return _Block(method.identifier, joinConfigs);
  }

  // Android and iOS
  static _Block channelParameter(MethodChannelType type) {
    final List<String> configs = <String>[];
    switch (type) {
      case MethodChannelType.wrapper:
        configs.add('type:wrapper');
        break;
      case MethodChannelType.supported:
        configs.add('type:supported');
        break;
      case MethodChannelType.$void:
        throw ArgumentError.value(type, 'type', 'Not supported for parameters');
    }

    final String joinConfigs = configs.join(' ');
    return _Block(parameter.identifier, joinConfigs);
  }

  static final _Block imports = _Block('IMPORTS');
  static final _Block import = _Block('IMPORT');

  static final _Block classes = _Block('CLASSES');
  static final _Block aClass = _Block('CLASS');

  static final _Block constructors = _Block('CONSTRUCTORS');
  static final _Block constructor = _Block('CONSTRUCTOR');

  static final _Block methodCalls = _Block('METHODCALLS');
  static final _Block methodCall = _Block('METHODCALL');

  static final _Block staticMethodCalls = _Block('STATICMETHODCALLS');
  static final _Block staticMethodCall = _Block('STATICMETHODCALL');

  static final _Block parameters = _Block('PARAMETERS');
  static final _Block parameter = _Block('PARAMETER');

  static final _Block methodCallParams = _Block('METHODCALLPARAMS');
  static final _Block methodCallParam = _Block('METHODCALLPARAM');
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
