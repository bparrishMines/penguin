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
  
  %%FIELDS%%
  %%FIELD%%
  static MethodCall $__fieldName__({
    %%FIELDSETTERS%%
    %%FIELDSETTER type:supported%%
    __fieldType__ __fieldName__,
    %%FIELDSETTER type:supported%%
    %%FIELDSETTER type:wrapper%%
    $__fieldType__ __fieldName__,
    %%FIELDSETTER type:wrapper%%
    %%FIELDSETTER type:typeParameter%%
    __fieldType__ __fieldName__,
    %%FIELDSETTER type:typeParameter%%
    %%FIELDSETTERS%%
    String $newUniqueId,
  }) {
    return MethodCall(
      '__platformClassName__.__fieldName__',
      <String, dynamic>{
        r'$uniqueId': $uniqueId,
        r'$newUniqueId': $newUniqueId,
        %%FIELDSETTERPARAMS%%
        %%FIELDSETTERPARAM type:supported%%
        '__fieldName__': __fieldName__,
        %%FIELDSETTERPARAM type:supported%%
        %%FIELDSETTERPARAM type:wrapper%%
        '__fieldName__': __fieldName__.$uniqueId,
        %%FIELDSETTERPARAM type:wrapper%%
        %%FIELDSETTERPARAM type:typeParameter%%
        if (__fieldName__ is $Wrapper) '__fieldName__': __fieldName__.$uniqueId,
        if (__fieldName__ is! $Wrapper) '__fieldName__': __fieldName__,
        %%FIELDSETTERPARAM type:typeParameter%%
        %%FIELDSETTERPARAMS%%
      },
    );
  }
  %%FIELD%%
  %%FIELDS%%

  %%METHODS%%
  %%METHOD%%
  static MethodCall $__methodName__(
  %%PARAMETERS%%
  %%PARAMETER type:supported%%
  __parameterType__ __parameterName__,
  %%PARAMETER type:supported%%
  %%PARAMETER type:wrapper%%
  $__parameterType__ __parameterName__,
  %%PARAMETER type:wrapper%%
  %%PARAMETER type:typeParameter%%
  __parameterType__ __parameterName__,
  %%PARAMETER type:typeParameter%%
  %%PARAMETERS%%
  [String $newUniqueId,]
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

Future<T> $invoke<T>(MethodChannel channel, MethodCall call) {
  return channel.invokeMethod<T>(call.method, call.arguments);
}

Future<List<T>> $invokeList<T>(MethodChannel channel, MethodCall call) {
  return channel.invokeListMethod<T>(call.method, call.arguments);
}

Future<Map<S, T>> $invokeMap<S, T>(MethodChannel channel, MethodCall call) {
  return channel.invokeMapMethod<S, T>(call.method, call.arguments);
}

Future<List<dynamic>> $invokeAll(
  MethodChannel channel,
  List<MethodCall> methodCalls,
) {
  final List<Map<String, dynamic>> serializedCalls = methodCalls
      .map<Map<String, dynamic>>(
        (MethodCall methodCall) => <String, dynamic>{
          'method': methodCall.method,
          'arguments': methodCall.arguments,
        },
      )
      .toList();

  return channel.invokeListMethod<dynamic>('MultiInvoke', serializedCalls);
}

bool _isTypeOf<ThisType, OfType>() =>
    _Instance<ThisType>() is _Instance<OfType>;
class _Instance<T> {}
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
  private static abstract class FlutterWrapper {
    final ChannelGenerated $channelGenerated;
    final String $uniqueId;
    
    FlutterWrapper(ChannelGenerated $channelGenerated, String $uniqueId) {
      this.$channelGenerated = $channelGenerated;
      this.$uniqueId = $uniqueId;
    }

    abstract Object onMethodCall(MethodCall call) throws NotImplementedException;
    abstract Object $getValue();

    void allocate() {
      if ($channelGenerated.isAllocated($uniqueId)) return;
      $channelGenerated.addWrapper($uniqueId, this, $channelGenerated.allocatedWrappers);
    }

    void deallocate() {
      $channelGenerated.removeWrapper($uniqueId);
    }
  }

  private static class NotImplementedException extends Exception {
    NotImplementedException(String method) {
      super(String.format(Locale.getDefault(),"No implementation for %s.", method));
    }
  }

  private static class NoUniqueIdException extends Exception {
    NoUniqueIdException(String method) {
      super(String.format("MethodCall was made without a unique handle for %s.", method));
    }
  }

  private static class WrapperNotFoundException extends Exception {
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
      %%STATICREDIRECTS%%
      %%STATICREDIRECT redirect:constructor%%
      case "__platformClassName__()": {
          return __platformClassName__Wrapper.onStaticMethodCall(this, call);
        }
      %%STATICREDIRECT redirect:constructor%%
      %%STATICREDIRECT redirect:method%%
      case "__platformClassName__#__methodName__": {
          return __platformClassName__Wrapper.onStaticMethodCall(this, call);
        }
      %%STATICREDIRECT redirect:method%%
      %%STATICREDIRECTS%%
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
  private static class __platformClassName__Wrapper extends FlutterWrapper {
    private final __platformClassName__ $value;

    public __platformClassName__Wrapper(ChannelGenerated $channelGenerated, String $uniqueId, __platformClassName__ $value) {
      super($channelGenerated, $uniqueId);
      this.$value = $value;
      $channelGenerated.addWrapper($uniqueId, this, $channelGenerated.tempWrappers);
    }

    %%CONSTRUCTORS%%
    %%CONSTRUCTOR%%
    private __platformClassName__Wrapper(ChannelGenerated $channelGenerated, final String $uniqueId) {
      super($channelGenerated, $uniqueId);
      this.$value = new __platformClassName__();
      $channelGenerated.addWrapper($uniqueId, this, $channelGenerated.tempWrappers);
    }
    %%CONSTRUCTOR%%
    %%CONSTRUCTORS%%
    
    static Object onStaticMethodCall(ChannelGenerated $channelGenerated, MethodCall call) throws NotImplementedException {
      switch(call.method) {
        %%STATICMETHODCALLS%%
        %%STATICMETHODCALL redirect:constructor%%
        case "__platformClassName__()": {
            new __platformClassName__Wrapper($channelGenerated, (String) call.argument("$uniqueId"));
            return null;
          }
        %%STATICMETHODCALL redirect:constructor%%
        %%STATICMETHODCALL redirect:method%%
        case "__platformClassName__#__methodName__": {
            return __platformClassName__Wrapper.__methodName__($channelGenerated, call);
          }
        %%STATICMETHODCALL redirect:method%%
        %%STATICMETHODCALLS%%
        default:
          throw new NotImplementedException(call.method);
      }
    }

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
    static Object __methodName__(ChannelGenerated $channelGenerated, MethodCall call) {
      %%PREMETHODCALLS%%
      %%PREMETHODCALL returns:void%%
      %%PREMETHODCALL returns:void%%
      %%PREMETHODCALL returns:supported%%
      return
      %%PREMETHODCALL returns:supported%%
      %%PREMETHODCALL returns:wrapper%%
      new __returnType__Wrapper($channelGenerated, (String) call.argument("$newUniqueId"),
      %%PREMETHODCALL returns:wrapper%%
      %%PREMETHODCALL returns:typeParameter%%
      final Object result = 
      %%PREMETHODCALL returns:typeParameter%%
      %%PREMETHODCALLS%%
      
      __methodCallerName__.__methodName__(
      %%PARAMETERS%%
      %%PARAMETER type:supported%%
      call.argument("__parameterName__") == null ? null : (__parameterType__) call.argument("__parameterName__")
      %%PARAMETER type:supported%%
      %%PARAMETER type:wrapper%%
      ((__parameterType__Wrapper) $channelGenerated.getWrapper((String) call.argument("__parameterName__"))).$value
      %%PARAMETER type:wrapper%%
      %%PARAMETER type:typeParameter%%
      $channelGenerated.getWrapper((String) call.argument("value")) == null ? call.argument("value") : $channelGenerated.getWrapper((String) call.argument("value")).$getValue()
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
        constructor.newInstance($channelGenerated, call.argument("$newUniqueId"), result);
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
    bool isStatic, {
    Iterable<String> parameters,
    Iterable<String> methodCallParams,
    String platformClassName,
    String methodName,
  }) {
    return _replace(
      _Block.method.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        if (!isStatic) 'static': '',
        if (isStatic) r"r'$uniqueId': $uniqueId,": '',
        _Block.parameters.exp: parameters.join(),
        _Block.methodCallParams.exp: methodCallParams.join(),
        _Replacement.platformClassName.name: platformClassName,
        _Replacement.methodName.name: methodName,
      },
    );
  }

  String createField(
    bool isStatic, {
    String platformClassName,
    String fieldName,
    String fieldType,
    String fieldSetterParam,
    String fieldSetter,
  }) {
    return _replace(
      _Block.field.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        if (!isStatic) 'static': '',
        if (isStatic) r"r'$uniqueId': $uniqueId,": '',
        _Replacement.platformClassName.name: platformClassName,
        _Replacement.fieldName.name: fieldName,
        _Replacement.fieldType.name: fieldType,
        _Block.fieldSetterParams.exp: fieldSetterParam,
        _Block.fieldSetters.exp: fieldSetter,
      },
    );
  }

  String createFieldSetter(
    MethodChannelType channelType, {
    String fieldType,
    String fieldName,
  }) {
    return _replace(
      _Block.channelFieldSetter(channelType)
          .exp
          .firstMatch(template.value)
          .group(1),
      <Pattern, String>{
        _Replacement.fieldType.name: fieldType,
        _Replacement.fieldName.name: fieldName,
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

  String createFieldSetterParam(MethodChannelType channelType,
      {String fieldName}) {
    return _replace(
      _Block.channelFieldSetterParam(channelType)
          .exp
          .firstMatch(template.value)
          .group(1),
      <Pattern, String>{
        _Replacement.fieldName.name: fieldName,
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
    Iterable<String> fields,
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
        _Block.fields.exp: fields.join(),
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
    MethodChannelType returnTypeChannelType,
    bool isStatic, {
    Iterable<String> parameters,
    String returnType,
    String methodName,
    String platformClassName,
    String variableName,
    String package,
  }) {
    return _replace(
      _Block.method.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        if (!isStatic) 'static': '',
        if (!isStatic) r'ChannelGenerated $channelGenerated,': '',
        _Replacement.methodCallerName.name:
            isStatic ? platformClassName : r'$value',
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
    Iterable<String> staticMethodCalls,
    String platformClassName,
    String variableName,
  }) {
    return _replace(
      _Block.aClass.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        _Block.constructors.exp: constructors.join(),
        _Block.methods.exp: methods.join(),
        _Block.methodCalls.exp: methodCalls.join(),
        _Block.staticMethodCalls.exp: staticMethodCalls.join(),
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

  String createStaticRedirect(
    MethodChannelStaticRedirect redirect, {
    String platformClassName,
    String methodName,
  }) {
    return _replace(
      _Block.channelStaticRedirect(redirect)
          .exp
          .firstMatch(template.value)
          .group(1),
      <Pattern, String>{
        _Replacement.platformClassName.name: platformClassName,
        _Replacement.methodName.name: methodName,
      },
    );
  }

  String createFile({
    Iterable<String> imports,
    Iterable<String> classes,
    Iterable<String> staticRedirects,
    String package,
  }) {
    return _replace(
      template.value,
      <Pattern, String>{
        _Block.imports.exp: imports.join(),
        _Block.classes.exp: classes.join(),
        _Block.staticRedirects.exp: staticRedirects.join(),
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

  String createStaticMethodCall(
    MethodChannelStaticRedirect redirect, {
    String platformClassName,
    String methodName,
  }) {
    return _replace(
      _Block.channelStaticMethodCall(redirect)
          .exp
          .firstMatch(template.value)
          .group(1),
      <Pattern, String>{
        _Replacement.platformClassName.name: platformClassName,
        _Replacement.methodName.name: methodName,
      },
    );
  }
}

enum MethodChannelType { $void, supported, wrapper, typeParameter }
enum MethodChannelStaticRedirect { constructor, method }

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

  static final _Block staticRedirects = _Block('STATICREDIRECTS');
  static _Block channelStaticRedirect(MethodChannelStaticRedirect redirect) {
    final List<String> configs = <String>[];

    switch (redirect) {
      case MethodChannelStaticRedirect.constructor:
        configs.add('redirect:constructor');
        break;
      case MethodChannelStaticRedirect.method:
        configs.add('redirect:method');
        break;
    }

    return _Block('STATICREDIRECT', configs.join(' '));
  }

  static final _Block staticMethodCalls = _Block('STATICMETHODCALLS');
  static _Block channelStaticMethodCall(MethodChannelStaticRedirect redirect) {
    final List<String> configs = <String>[];

    switch (redirect) {
      case MethodChannelStaticRedirect.constructor:
        configs.add('redirect:constructor');
        break;
      case MethodChannelStaticRedirect.method:
        configs.add('redirect:method');
        break;
    }

    return _Block('STATICMETHODCALL', configs.join(' '));
  }

  static final _Block parameters = _Block('PARAMETERS');
  static final _Block parameter = _Block('PARAMETER');

  static final _Block fieldSetters = _Block('FIELDSETTERS');
  static _Block channelFieldSetter(MethodChannelType type) {
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

    return _Block('FIELDSETTER', configs.join(' '));
  }

  static final _Block fields = _Block('FIELDS');
  static final _Block field = _Block('FIELD');

  static final _Block methodCallParams = _Block('METHODCALLPARAMS');
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

  static final _Block fieldSetterParams = _Block('FIELDSETTERPARAMS');
  static _Block channelFieldSetterParam(MethodChannelType type) {
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

    return _Block('FIELDSETTERPARAM', configs.join(' '));
  }
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
  static final _Replacement methodCallerName =
      _Replacement('__methodCallerName__');
  static final _Replacement fieldName = _Replacement('__fieldName__');
  static final _Replacement fieldType = _Replacement('__fieldType__');
}
