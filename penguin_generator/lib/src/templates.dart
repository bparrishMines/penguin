class _Template {
  const _Template._(this.value);

  final String value;

  static const _Template methodChannel = _Template._(r'''
import 'dart:async';

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
    %%FIELDSETTER methodChannel:supported%%
    __fieldType__ __fieldName__,
    %%FIELDSETTER methodChannel:supported%%
    %%FIELDSETTER methodChannel:wrapper%%
    $__fieldType__ __fieldName__,
    %%FIELDSETTER methodChannel:wrapper%%
    %%FIELDSETTER methodChannel:typeParameter%%
    __fieldType__ __fieldName__,
    %%FIELDSETTER methodChannel:typeParameter%%
    %%FIELDSETTERS%%
    String $newUniqueId,
  }) {
    return MethodCall(
      '__platformClassName__.__fieldName__',
      <String, dynamic>{
        r'$uniqueId': $uniqueId,
        r'$newUniqueId': $newUniqueId,
        %%FIELDSETTERPARAMS%%
        %%FIELDSETTERPARAM methodChannel:supported%%
        '__fieldName__': __fieldName__,
        %%FIELDSETTERPARAM methodChannel:supported%%
        %%FIELDSETTERPARAM methodChannel:wrapper%%
        '__fieldName__': __fieldName__?.$uniqueId,
        %%FIELDSETTERPARAM methodChannel:wrapper%%
        %%FIELDSETTERPARAM methodChannel:typeParameter%%
        if (__fieldName__ is $Wrapper) '__fieldName__': __fieldName__?.$uniqueId,
        if (__fieldName__ is! $Wrapper) '__fieldName__': __fieldName__,
        %%FIELDSETTERPARAM methodChannel:typeParameter%%
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
  %%PARAMETER methodChannel:supported%%
  __parameterType__ __parameterName__,
  %%PARAMETER methodChannel:supported%%
  %%PARAMETER methodChannel:wrapper%%
  $__parameterType__ __parameterName__,
  %%PARAMETER methodChannel:wrapper%%
  %%PARAMETER methodChannel:typeParameter%%
  __parameterType__ __parameterName__,
  %%PARAMETER methodChannel:typeParameter%%
  %%PARAMETERS%%
  [String $newUniqueId,]
  ) {
    return MethodCall(
      '__platformClassName__#__methodName__',
       <String, dynamic>{r'$uniqueId': $uniqueId,
       r'$newUniqueId': $newUniqueId,
       %%METHODCALLPARAMS%%
       %%METHODCALLPARAM methodChannel:supported%%
       '__parameterName__': __parameterName__,
       %%METHODCALLPARAM methodChannel:supported%%
       %%METHODCALLPARAM methodChannel:wrapper%%
       '__parameterName__': __parameterName__?.$uniqueId,
       %%METHODCALLPARAM methodChannel:wrapper%%
       %%METHODCALLPARAM methodChannel:typeParameter%%
       if (__parameterName__ is $Wrapper) '__parameterName__': __parameterName__?.$uniqueId,
       if (__parameterName__ is! $Wrapper) '__parameterName__': __parameterName__,
       %%METHODCALLPARAM methodChannel:typeParameter%%
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

Future<T> $invoke<T>(
  MethodChannel channel,
  MethodCall call, [
  MethodCall call2,
  MethodCall call3,
  MethodCall call4,
  MethodCall call5,
  MethodCall call6,
  MethodCall call7,
  MethodCall call8,
  MethodCall call9,
]) {
  final Completer<T> completer = Completer<T>();

  $invokeAll(
    channel,
    <MethodCall>[call, call2, call3, call4, call5, call6, call7, call8, call9]
        .where((MethodCall call) => call != null),
  ).then(
    (List<dynamic> results) => completer.complete(results.last),
  );

  return completer.future;
}

Future<List<T>> $invokeList<T>(
  MethodChannel channel,
  MethodCall call, [
  MethodCall call2,
  MethodCall call3,
  MethodCall call4,
  MethodCall call5,
  MethodCall call6,
  MethodCall call7,
  MethodCall call8,
  MethodCall call9,
]) {
  final Completer<List<T>> completer = Completer<List<T>>();

  $invokeAll(
    channel,
    <MethodCall>[call, call2, call3, call4, call5, call6, call7, call8, call9]
        .where((MethodCall call) => call != null),
  ).then(
    (List<dynamic> results) => completer.complete(results.last.cast<T>()),
  );

  return completer.future;
}

Future<Map<S, T>> $invokeMap<S, T>(
  MethodChannel channel,
  MethodCall call, [
  MethodCall call2,
  MethodCall call3,
  MethodCall call4,
  MethodCall call5,
  MethodCall call6,
  MethodCall call7,
  MethodCall call8,
  MethodCall call9,
]) {
  final Completer<Map<S, T>> completer = Completer<Map<S, T>>();

  $invokeAll(
    channel,
    <MethodCall>[call, call2, call3, call4, call5, call6, call7, call8, call9]
        .where((MethodCall call) => call != null),
  ).then(
    (List<dynamic> results) => completer.complete(results.last.cast<S, T>()),
  );

  return completer.future;
}

Future<List<dynamic>> $invokeAll(
  MethodChannel channel,
  Iterable<MethodCall> methodCalls,
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

    abstract Object onMethodCall(MethodCall call) throws Exception;
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
      final String uniqueId,
      final FlutterWrapper wrapper,
      HashMap<String, FlutterWrapper> wrapperMap) {
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
    } catch (Exception exception) {
      result.error(exception.getClass().getSimpleName(), exception.getMessage(), null);
    } finally {
      tempWrappers.clear();
    }
  }

  private Object onMethodCall(MethodCall call) throws Exception {
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
      %%STATICREDIRECT classMember:constructor%%
      case "__platformClassName__()": {
          return __platformClassName__Wrapper.onStaticMethodCall(this, call);
        }
      %%STATICREDIRECT classMember:constructor%%
      %%STATICREDIRECT classMember:method%%
      case "__platformClassName__#__methodName__": {
          return __platformClassName__Wrapper.onStaticMethodCall(this, call);
        }
      %%STATICREDIRECT classMember:method%%
      %%STATICREDIRECT classMember:field%%
      case "__platformClassName__.__fieldName__": {
          return __platformClassName__Wrapper.onStaticMethodCall(this, call);
        }
      %%STATICREDIRECT classMember:field%%
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
    
    static Object onStaticMethodCall(ChannelGenerated $channelGenerated, MethodCall call) throws Exception {
      switch(call.method) {
        %%STATICMETHODCALLS%%
        %%STATICMETHODCALL classMember:constructor%%
        case "__platformClassName__()": {
            new __platformClassName__Wrapper($channelGenerated, (String) call.argument("$uniqueId"));
            return null;
          }
        %%STATICMETHODCALL classMember:constructor%%
        %%STATICMETHODCALL classMember:method%%
        case "__platformClassName__#__methodName__": {
            return __platformClassName__Wrapper.__methodName__($channelGenerated, call);
          }
        %%STATICMETHODCALL classMember:method%%
        %%STATICMETHODCALL classMember:field%%
        case "__platformClassName__.__fieldName__": {
            return __platformClassName__Wrapper.__fieldName__($channelGenerated, call);
          }
        %%STATICMETHODCALL classMember:field%%
        %%STATICMETHODCALLS%%
        default:
          throw new NotImplementedException(call.method);
      }
    }

    @Override
    public Object onMethodCall(MethodCall call) throws Exception {
      switch(call.method) {
        case "__platformClassName__#allocate":
          allocate();
          return null;
        case "__platformClassName__#deallocate":
          deallocate();
          return null;
        %%METHODCALLS%%
        %%METHODCALL classMember:method%%
        case "__platformClassName__#__methodName__":
          return __methodName__(call);
        %%METHODCALL classMember:method%%
        %%METHODCALL classMember:field%%
        case "__platformClassName__.__fieldName__":
          return __fieldName__(call);
        %%METHODCALL classMember:field%%
        %%METHODCALLS%%
        default:
          throw new NotImplementedException(call.method);
      }
    }
    
    @Override
    public Object $getValue() {
      return $value;
    }
    
    %%FIELDS%%
    %%FIELD%%
    static private Object __fieldName__(ChannelGenerated $channelGenerated, MethodCall call) throws Exception {
      if (call.argument("__fieldName__") != null) {
        __methodCallerName__.__fieldName__ =
        %%FIELDSETTERS%%
        %%FIELDSETTER methodChannel:supported%%
        call.argument("__fieldName__") != null ? (__fieldType__) call.argument("__fieldName__") : null;
        %%FIELDSETTER methodChannel:supported%%
        %%FIELDSETTER methodChannel:wrapper%%
        call.argument("__fieldName__") != null ? ((__fieldType__Wrapper) $channelGenerated.getWrapper((String) call.argument("__fieldName__"))).$value : null;
        %%FIELDSETTER methodChannel:wrapper%%
        %%FIELDSETTER methodChannel:typeParameter%%
        call.argument("__fieldName__") != null && call.argument("__fieldName__") instanceof String && $channelGenerated.getWrapper((String) call.argument("__fieldName__")) != null ? $channelGenerated.getWrapper((String) call.argument("__fieldName__")).$getValue() : call.argument("__fieldName__");
        %%FIELDSETTER methodChannel:typeParameter%%
        %%FIELDSETTERS%%
      } 
      
      %%PREFIELDACCESSES%%
      %%PREFIELDACCESS methodChannel:supported%%
      return
      %%PREFIELDACCESS methodChannel:supported%%
      %%PREFIELDACCESS methodChannel:wrapper%%
      new __fieldType__Wrapper($channelGenerated, (String) call.argument("$newUniqueId"), 
      %%PREFIELDACCESS methodChannel:wrapper%%
      %%PREFIELDACCESS methodChannel:typeParameter%%
      final Object result = 
      %%PREFIELDACCESS methodChannel:typeParameter%%
      %%PREFIELDACCESSES%%
      __methodCallerName__.__fieldName__
      
      %%POSTFIELDACCESSES%%
      %%POSTFIELDACCESS methodChannel:supported%%
      ;
      %%POSTFIELDACCESS methodChannel:supported%%
      %%POSTFIELDACCESS methodChannel:wrapper%%
      );
      return null;
      %%POSTFIELDACCESS methodChannel:wrapper%%
      %%POSTFIELDACCESS methodChannel:typeParameter%%
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
      %%POSTFIELDACCESS methodChannel:typeParameter%%
      %%POSTFIELDACCESSES%%
    }
    %%FIELD%%
    %%FIELDS%%

    %%METHODS%%
    %%METHOD%%
    static Object __methodName__(ChannelGenerated $channelGenerated, MethodCall call) throws Exception {
      %%PREMETHODCALLS%%
      %%PREMETHODCALL methodChannel:void%%
      %%PREMETHODCALL methodChannel:void%%
      %%PREMETHODCALL methodChannel:supported%%
      return
      %%PREMETHODCALL methodChannel:supported%%
      %%PREMETHODCALL methodChannel:wrapper%%
      new __returnType__Wrapper($channelGenerated, (String) call.argument("$newUniqueId"),
      %%PREMETHODCALL methodChannel:wrapper%%
      %%PREMETHODCALL methodChannel:typeParameter%%
      final Object result = 
      %%PREMETHODCALL methodChannel:typeParameter%%
      %%PREMETHODCALLS%%
      
      __methodCallerName__.__methodName__(
      %%PARAMETERS%%
      %%PARAMETER methodChannel:supported%%
      call.argument("__parameterName__") != null ? (__parameterType__) call.argument("__parameterName__") : null
      %%PARAMETER methodChannel:supported%%
      %%PARAMETER methodChannel:wrapper%%
      call.argument("__parameterName__") != null ? ((__parameterType__Wrapper) $channelGenerated.getWrapper((String) call.argument("__parameterName__"))).$value : null
      %%PARAMETER methodChannel:wrapper%%
      %%PARAMETER methodChannel:typeParameter%%
      call.argument("__parameterName__") != null && call.argument("__parameterName__") instanceof String && call.$channelGenerated.getWrapper((String) call.argument("__parameterName__")) != null ? $channelGenerated.getWrapper((String) call.argument("__parameterName__")).$getValue() : call.argument("__parameterName__") 
      %%PARAMETER methodChannel:typeParameter%%
      %%PARAMETERS%%
      )
      %%POSTMETHODCALLS%%
      %%POSTMETHODCALL methodChannel:void%%
      ;
      return null;
      %%POSTMETHODCALL methodChannel:void%%
      %%POSTMETHODCALL methodChannel:supported%%
      ;
      %%POSTMETHODCALL methodChannel:supported%%
      %%POSTMETHODCALL methodChannel:wrapper%%
      );
      return null;
      %%POSTMETHODCALL methodChannel:wrapper%%
      %%POSTMETHODCALL methodChannel:typeParameter%%
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
      %%POSTMETHODCALL methodChannel:typeParameter%%
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
        _MethodChannelBlock.methodCallParams.exp: methodCallParams.join(),
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
      _MethodChannelBlock.fieldSetter(channelType)
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
      _MethodChannelBlock.parameter(channelType)
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
      _MethodChannelBlock.fieldSetterParam(channelType)
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
      _MethodChannelBlock.methodCallParam(channelType)
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

  String createField(
    MethodChannelType channelType, {
    bool isStatic,
    bool isMutable,
    String fieldType,
    String fieldName,
    String package,
    String platformClassName,
    String fieldSetter,
  }) {
    return _replace(
      _Block.field.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        if (!isStatic) 'static': '',
        if (!isStatic) r'ChannelGenerated $channelGenerated,': '',
        if (!isMutable)
          RegExp(r'if\s*(.*?)\s*{.*?}', multiLine: true, dotAll: true): '',
        _Replacement.methodCallerName.name:
            isStatic ? platformClassName : r'$value',
        _Block.preFieldAccesses.exp:
            _MethodChannelBlock.preFieldAccess(channelType)
                .exp
                .firstMatch(template.value)
                .group(1),
        _Block.postFieldAccesses.exp:
            _MethodChannelBlock.postFieldAccess(channelType)
                .exp
                .firstMatch(template.value)
                .group(1),
        _Block.fieldSetters.exp: _MethodChannelBlock.fieldSetter(channelType)
            .exp
            .firstMatch(template.value)
            .group(1),
        _Replacement.fieldType.name: fieldType,
        _Replacement.fieldName.name: fieldName,
        _Replacement.package.name: package,
      },
    );
  }

  String createMethod(
    MethodChannelType returnTypeChannelType,
    bool isStatic, {
    bool isMutable,
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
            _MethodChannelBlock.preMethodCall(returnTypeChannelType)
                .exp
                .firstMatch(template.value)
                .group(1),
        _Block.postMethodCalls.exp:
            _MethodChannelBlock.postMethodCall(returnTypeChannelType)
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
    MethodChannelType methodChannel, {
    String variableName,
    String parameterType,
    String parameterName,
  }) {
    return _replace(
      _MethodChannelBlock.parameter(methodChannel)
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
    Iterable<String> fields,
    String platformClassName,
    String variableName,
  }) {
    return _replace(
      _Block.aClass.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        _Block.constructors.exp: constructors.join(),
        _Block.methods.exp: methods.join(),
        _MethodChannelBlock.methodCalls.exp: methodCalls.join(),
        _MethodChannelBlock.staticMethodCalls.exp: staticMethodCalls.join(),
        _Block.fields.exp: fields.join(),
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
    ClassMemberType classMember, {
    String platformClassName,
    String methodName,
    String fieldName,
  }) {
    return _replace(
      _MethodChannelBlock.staticRedirect(classMember)
          .exp
          .firstMatch(template.value)
          .group(1),
      <Pattern, String>{
        _Replacement.platformClassName.name: platformClassName,
        if (methodName != null) _Replacement.methodName.name: methodName,
        if (fieldName != null) _Replacement.fieldName.name: fieldName,
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

  String createMethodCall(
    ClassMemberType classMember, {
    String platformClassName,
    String methodName,
    String fieldName,
  }) {
    return _replace(
      _MethodChannelBlock.methodCall(classMember)
          .exp
          .firstMatch(template.value)
          .group(1),
      <Pattern, String>{
        _Replacement.platformClassName.name: platformClassName,
        if (methodName != null) _Replacement.methodName.name: methodName,
        if (fieldName != null) _Replacement.fieldName.name: fieldName,
      },
    );
  }

  String createStaticMethodCall(
    ClassMemberType classMember, {
    String platformClassName,
    String methodName,
    String fieldName,
  }) {
    return _replace(
      _MethodChannelBlock.staticMethodCall(classMember)
          .exp
          .firstMatch(template.value)
          .group(1),
      <Pattern, String>{
        _Replacement.platformClassName.name: platformClassName,
        if (methodName != null) _Replacement.methodName.name: methodName,
        if (fieldName != null) _Replacement.fieldName.name: fieldName,
      },
    );
  }
}

enum MethodChannelType { $void, supported, wrapper, typeParameter }
enum ClassMemberType { constructor, method, field }

abstract class _TemplateCreator {
  _Template get template;

  String _replace(String value, Map<Pattern, String> replacements) {
    for (MapEntry<Pattern, String> entry in replacements.entries) {
      value = value.replaceAll(entry.key, entry.value);
    }
    return value;
  }
}

class _Block {
  _Block(this.identifier, [this.config])
      : exp = config == null || config.isEmpty
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

  static final _Block postMethodCalls = _Block('POSTMETHODCALLS');

  static final _Block preFieldAccesses = _Block('PREFIELDACCESSES');

  static final _Block postFieldAccesses = _Block('POSTFIELDACCESSES');

  static final _Block imports = _Block('IMPORTS');
  static final _Block import = _Block('IMPORT');

  static final _Block classes = _Block('CLASSES');
  static final _Block aClass = _Block('CLASS');

  static final _Block constructors = _Block('CONSTRUCTORS');
  static final _Block constructor = _Block('CONSTRUCTOR');

  static final _Block staticRedirects = _Block('STATICREDIRECTS');

  static final _Block parameters = _Block('PARAMETERS');
  static final _Block parameter = _Block('PARAMETER');

  static final _Block fieldSetters = _Block('FIELDSETTERS');

  static final _Block fields = _Block('FIELDS');
  static final _Block field = _Block('FIELD');

  static final _Block fieldSetterParams = _Block('FIELDSETTERPARAMS');
}

class _MethodChannelBlock extends _Block {
  _MethodChannelBlock(
    String identifier, {
    MethodChannelType methodChannel,
    ClassMemberType classMember,
  }) : super(identifier, createConfig(methodChannel, classMember));

  static String createConfig(
    MethodChannelType methodChannel,
    ClassMemberType classMember,
  ) {
    final List<String> configs = <String>[];
    switch (methodChannel) {
      case MethodChannelType.wrapper:
        configs.add('methodChannel:wrapper');
        break;
      case MethodChannelType.supported:
        configs.add('methodChannel:supported');
        break;
      case MethodChannelType.typeParameter:
        configs.add('methodChannel:typeParameter');
        break;
      case MethodChannelType.$void:
        configs.add('methodChannel:void');
        break;
    }

    switch (classMember) {
      case ClassMemberType.constructor:
        configs.add('classMember:constructor');
        break;
      case ClassMemberType.method:
        configs.add('classMember:method');
        break;
      case ClassMemberType.field:
        configs.add('classMember:field');
        break;
    }

    return configs.join(' ');
  }

  static _MethodChannelBlock fieldSetterParam(
          MethodChannelType methodChannel) =>
      _MethodChannelBlock('FIELDSETTERPARAM', methodChannel: methodChannel);

  static final _MethodChannelBlock methodCallParams =
      _MethodChannelBlock('METHODCALLPARAMS');
  static _MethodChannelBlock methodCallParam(MethodChannelType methodChannel) =>
      _MethodChannelBlock('METHODCALLPARAM', methodChannel: methodChannel);

  static _MethodChannelBlock fieldSetter(MethodChannelType methodChannel) =>
      _MethodChannelBlock('FIELDSETTER', methodChannel: methodChannel);

  static final _MethodChannelBlock staticMethodCalls =
      _MethodChannelBlock('STATICMETHODCALLS');
  static _MethodChannelBlock staticMethodCall(ClassMemberType classMember) =>
      _MethodChannelBlock('STATICMETHODCALL', classMember: classMember);

  static _MethodChannelBlock staticRedirect(ClassMemberType classMember) =>
      _MethodChannelBlock('STATICREDIRECT', classMember: classMember);

  static final _MethodChannelBlock methodCalls =
      _MethodChannelBlock('METHODCALLS');
  static _MethodChannelBlock methodCall(ClassMemberType classMember) =>
      _MethodChannelBlock('METHODCALL', classMember: classMember);

  static _MethodChannelBlock parameter(MethodChannelType methodChannel) =>
      _MethodChannelBlock(
        _Block.parameter.identifier,
        methodChannel: methodChannel,
      );

  static _MethodChannelBlock postFieldAccess(MethodChannelType methodChannel) =>
      _MethodChannelBlock('POSTFIELDACCESS', methodChannel: methodChannel);

  static _MethodChannelBlock preFieldAccess(MethodChannelType methodChannel) =>
      _MethodChannelBlock('PREFIELDACCESS', methodChannel: methodChannel);

  static _MethodChannelBlock postMethodCall(MethodChannelType methodChannel) =>
      _MethodChannelBlock('POSTMETHODCALL', methodChannel: methodChannel);

  static _MethodChannelBlock preMethodCall(MethodChannelType methodChannel) =>
      _MethodChannelBlock('PREMETHODCALL', methodChannel: methodChannel);
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
