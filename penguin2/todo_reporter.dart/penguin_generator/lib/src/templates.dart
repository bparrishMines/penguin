class _Template {
  const _Template._(this.value);

  final String value;

  static const _Template methodChannel = _Template._(r'''
import 'package:flutter/services.dart';

%%CLASSES%%
%%CLASS%%
class $__className____typeParameters__ extends $Wrapper {
  $__className__(String $uniqueId) : super($uniqueId);

  %%CONSTRUCTORS%%
  %%CONSTRUCTOR%%
  MethodCall $__className__Default() {
    return MethodCall(
      '__platformClassName__()',
      <String, String>{r'$uniqueId': $uniqueId},
    );
  }
  %%CONSTRUCTOR%%
  %%CONSTRUCTORS%%

  %%METHODS%%
  %%METHOD%%
  MethodCall $__methodName__(
  String $newUniqueId,
  %%PARAMETERS%%
  %%PARAMETER type:supported%%
  __parameterType__ __parameterName__
  %%PARAMETER type:supported%%
  %%PARAMETER type:wrapper%%
  $__parameterType__ __parameterName__
  %%PARAMETER type:wrapper%%
  %%PARAMETER type:typeParameter%%
  __parameterType__ __parameterName__
  %%PARAMETER type:typeParameter%%
  %%PARAMETERS%%
  ) {
    return MethodCall(
      '__platformClassName__#__methodName__',
       <String, dynamic>{r'$uniqueId': $uniqueId,
       r'$newUniqueId': $newUniqueId,
       %%METHODCALLPARAMS%%
       %%METHODCALLPARAM type:supported%%
       '__parameterName__': __parameterName__,
       %%METHODCALLPARAM type:supported%%
       %%METHODCALLPARAM type:wrapper%%
       '__parameterName__': __parameterName__.$uniqueId,
       %%METHODCALLPARAM type:wrapper%%
       %%METHODCALLPARAM type:typeParameter%%
       if (__parameterName__ is $Wrapper) '__parameterName__': __parameterName__.$uniqueId,
       if (__parameterName__ is! $Wrapper) '__parameterName__': __parameterName__,
       %%METHODCALLPARAM type:typeParameter%%
       %%METHODCALLPARAMS%%
       },
    );
  }
  %%METHOD%%
  %%METHODS%%
  
  @override
  String get $platformClassName => '__platformClassName__';
}
%%CLASS%%
%%CLASSES%%

abstract class $Wrapper {
  $Wrapper(this.$uniqueId);

  final String $uniqueId;
  
  String get $platformClassName;

  MethodCall $allocate() {
    return MethodCall(
      '${$platformClassName}#allocate',
      <String, String>{r'$uniqueId': $uniqueId},
    );
  }

  MethodCall $deallocate() {
    return MethodCall(
      '${$platformClassName}#deallocate',
      <String, String>{r'$uniqueId': $uniqueId},
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
''');

  static const _Template android = _Template._(r'''
package __package__;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
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
    private final String $uniqueId;
    
    FlutterWrapper(String $uniqueId) {
      this.$uniqueId = $uniqueId;
    }

    abstract Object onMethodCall(MethodCall call) throws NotImplementedException;
    abstract Object $getValue();

    void allocate() {
      if (isAllocated($uniqueId)) return;
      addWrapper($uniqueId, this, allocatedWrappers);
    }

    void deallocate() {
      removeWrapper($uniqueId);
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
          new __platformClassName__Wrapper((String) call.argument("$uniqueId"));
          return null;
        }
      %%STATICMETHODCALL%%
      %%STATICMETHODCALLS%%
      default:
        final String $uniqueId = call.argument("$uniqueId");
        if ($uniqueId == null) throw new NoUniqueIdException(call.method);

        final FlutterWrapper wrapper = getWrapper($uniqueId);
        if (wrapper == null) throw new WrapperNotFoundException($uniqueId);

        return wrapper.onMethodCall(call);
    }
  }

  %%CLASSES%%
  %%CLASS%%
  private class __platformClassName__Wrapper extends FlutterWrapper {
    private final __platformClassName__ $value;

    public __platformClassName__Wrapper(String $uniqueId, __platformClassName__ $value) {
      super($uniqueId);
      this.$value = $value;
      addWrapper($uniqueId, this, tempWrappers);
    }

    %%CONSTRUCTORS%%
    %%CONSTRUCTOR%%
    private __platformClassName__Wrapper(final String $uniqueId) {
      super($uniqueId);
      this.$value = new __platformClassName__();
      addWrapper($uniqueId, this, tempWrappers);
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
    
    @Override
    public Object $getValue() {
      return $value;
    }

    %%METHODS%%
    %%METHOD%%
    Object __methodName__(MethodCall call) {
      %%PREMETHODCALLS%%
      %%PREMETHODCALL returns:void%%
      %%PREMETHODCALL returns:void%%
      %%PREMETHODCALL returns:supported%%
      return
      %%PREMETHODCALL returns:supported%%
      %%PREMETHODCALL returns:wrapper%%
      new __returnType__Wrapper((String) call.argument("$newUniqueId"),
      %%PREMETHODCALL returns:wrapper%%
      %%PREMETHODCALL returns:typeParameter%%
      final Object result = 
      %%PREMETHODCALL returns:typeParameter%%
      %%PREMETHODCALLS%%
      
      $value.__methodName__(
      %%PARAMETERS%%
      %%PARAMETER type:supported%%
      call.argument("__parameterName__") == null ? null : (__parameterType__) call.argument("__parameterName__")
      %%PARAMETER type:supported%%
      %%PARAMETER type:wrapper%%
      ((__parameterType__Wrapper) getWrapper((String) call.argument("__parameterName__"))).$value
      %%PARAMETER type:wrapper%%
      %%PARAMETER type:typeParameter%%
      getWrapper((String) call.argument("value")) == null ? call.argument("value") : getWrapper((String) call.argument("value")).$getValue()
      %%PARAMETER type:typeParameter%%
      %%PARAMETERS%%
      )
      %%POSTMETHODCALLS%%
      %%POSTMETHODCALL returns:void%%
      ;
      return null;
      %%POSTMETHODCALL returns:void%%
      %%POSTMETHODCALL returns:supported%%
      ;
      %%POSTMETHODCALL returns:supported%%
      %%POSTMETHODCALL returns:wrapper%%
      );
      return null;
      %%POSTMETHODCALL returns:wrapper%%
      %%POSTMETHODCALL returns:typeParameter%%
      ;
      if (result == null) return null;

      final Class wrapperClass;
      try {
        wrapperClass = Class.forName(String.format("__package__.ChannelGenerated$%sWrapper", result.getClass().getSimpleName()));
      } catch (ClassNotFoundException e) {
        return result;
      }

      try {
        final Constructor constructor = wrapperClass.getConstructor(ChannelGenerated.class, String.class, result.getClass());
        constructor.newInstance(ChannelGenerated.this, call.argument("$newUniqueId"), result);
      } catch (NoSuchMethodException e) {
        e.printStackTrace();
      } catch (IllegalAccessException e) {
        e.printStackTrace();
      } catch (InstantiationException e) {
        e.printStackTrace();
      } catch (InvocationTargetException e) {
        e.printStackTrace();
      }
      return null;
      %%POSTMETHODCALL returns:typeParameter%%
      %%POSTMETHODCALLS%%
    }
    %%METHOD%%
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

  String createMethod(
    MethodChannelType returnTypeChannelType, {
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

  String createMethodCallParam(
    MethodChannelType channelType, {
    String parameterName,
  }) {
    return _replace(
      _Block.methodCallParam(channelType)
          .exp
          .firstMatch(template.value)
          .group(1),
      <Pattern, String>{
        _Replacement.parameterName.name: parameterName,
      },
    );
  }

  String createClass({
    Iterable<String> typeParameters,
    Iterable<String> constructors,
    Iterable<String> methods,
    String className,
    String platformClassName,
  }) {
    return _replace(
      _Block.aClass.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        _Replacement.typeParameters.name:
            typeParameters.isEmpty ? '' : '<${typeParameters.join(', ')}>',
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
    MethodChannelType returnTypeChannelType, {
    Iterable<String> parameters,
    String returnType,
    String methodName,
    String variableName,
    String package,
  }) {
    return _replace(
      _Block.method.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        _Block.preMethodCalls.exp:
            _Block.channelPreMethodCall(returnTypeChannelType)
                .exp
                .firstMatch(template.value)
                .group(1),
        _Block.postMethodCalls.exp:
            _Block.channelPostMethodCall(returnTypeChannelType)
                .exp
                .firstMatch(template.value)
                .group(1),
        _Block.parameters.exp: parameters.join(','),
        _Replacement.returnType.name: returnType,
        _Replacement.methodName.name: methodName,
        _Replacement.package.name: package,
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

enum MethodChannelType { $void, supported, wrapper, typeParameter }

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

  static final _Block preMethodCalls = _Block('PREMETHODCALLS');

  //  For Android and iOS
  static _Block channelPreMethodCall(MethodChannelType type) {
    final List<String> configs = <String>[];
    switch (type) {
      case MethodChannelType.$void:
        configs.add('returns:void');
        break;
      case MethodChannelType.supported:
        configs.add('returns:supported');
        break;
      case MethodChannelType.wrapper:
        configs.add('returns:wrapper');
        break;
      case MethodChannelType.typeParameter:
        configs.add('returns:typeParameter');
        break;
    }

    return _Block('PREMETHODCALL', configs.join(' '));
  }

  static final _Block postMethodCalls = _Block('POSTMETHODCALLS');

  //  For Android and iOS
  static _Block channelPostMethodCall(MethodChannelType type) {
    final List<String> configs = <String>[];
    switch (type) {
      case MethodChannelType.$void:
        configs.add('returns:void');
        break;
      case MethodChannelType.supported:
        configs.add('returns:supported');
        break;
      case MethodChannelType.wrapper:
        configs.add('returns:wrapper');
        break;
      case MethodChannelType.typeParameter:
        configs.add('returns:typeParameter');
        break;
    }

    return _Block('POSTMETHODCALL', configs.join(' '));
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
      case MethodChannelType.typeParameter:
        configs.add('type:typeParameter');
        break;
      case MethodChannelType.$void:
        throw ArgumentError.value(type, 'type', 'Not supported for parameters');
    }

    return _Block(parameter.identifier, configs.join(' '));
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

  static _Block methodCallParam(MethodChannelType type) {
    final List<String> configs = <String>[];
    switch (type) {
      case MethodChannelType.wrapper:
        configs.add('type:wrapper');
        break;
      case MethodChannelType.supported:
        configs.add('type:supported');
        break;
      case MethodChannelType.typeParameter:
        configs.add('type:typeParameter');
        break;
      case MethodChannelType.$void:
        throw ArgumentError.value(
          type,
          'type',
          'Not supported for MethodCall parameters.',
        );
    }

    return _Block('METHODCALLPARAM', configs.join(' '));
  }

  static final _Block methodCallParams = _Block('METHODCALLPARAMS');
}

class _Replacement {
  const _Replacement(this.name);

  final String name;

  static final _Replacement methodName = _Replacement('__methodName__');
  static final _Replacement className = _Replacement('__className__');
  static final _Replacement channelName = _Replacement('__channelName__');
  static final _Replacement package = _Replacement('__package__');
  static final _Replacement classPackage = _Replacement('__classPackage__');
  static final _Replacement platformClassName = _Replacement(
    '__platformClassName__',
  );
  static final _Replacement parameterName = _Replacement('__parameterName__');
  static final _Replacement parameterType = _Replacement('__parameterType__');
  static final _Replacement returnType = _Replacement('__returnType__');
  static final _Replacement typeParameters = _Replacement('__typeParameters__');
}
