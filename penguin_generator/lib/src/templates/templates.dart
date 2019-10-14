enum MethodChannelType { $void, supported, wrapper, typeParameter }
enum ClassMemberType { constructor, method, field }

class Template {
  const Template._(this.value);

  final String value;

  static const Template ios = Template._(r'''
#import "ChannelHandler+Generated.h"
%%IMPORTS%%
%%IMPORT%%
#import __classPackage__
%%IMPORT%%
%%IMPORTS%%

@interface NotImplementedException : NSException
+ (NSException *)exceptionWithMethod:(NSString *)methodName;
@end

@interface NoUniqueIdException : NSException
+ (NSException *)exceptionWithMethod:(NSString *)methodName;
@end

@interface WrapperNotFoundException : NSException
+ (NSException *)exceptionWithUniqueId:(NSString *)uniqueId;
@end

@interface FlutterWrapper : NSObject
- (instancetype _Nonnull)initWithHandler:(ChannelHandler *_Nonnull)handler
                                uniqueId:(NSString *_Nonnull)uniqueId;
- (NSObject *)handleMethodCall:(FlutterMethodCall *_Nonnull)call;
+ (NSObject *)handleStaticMethodCall:(ChannelHandler *_Nonnull)handler
                                call:(FlutterMethodCall *_Nonnull)call;
- (void)$allocate;
- (void)$deallocate;
@end

@interface ChannelHandler ()
@property NSMutableDictionary<NSString*, FlutterWrapper*> *allocatedWrappers;
@property NSMutableDictionary<NSString*, FlutterWrapper*> *tempWrappers;
- (void)addWrapper:(NSString *)uniqueId
           wrapper:(FlutterWrapper *)wrapper
 wrapperDictionary:(NSMutableDictionary *)wrapperDictionary;
- (void)addTempWrapper:(NSString *)uniqueId wrapper:(FlutterWrapper *)wrapper;
- (void)addAllocatedWrapper:(NSString *)uniqueId wrapper:(FlutterWrapper *)wrapper;
- (void)removeAllocatedWrapper:(NSString *)uniqueId;
- (BOOL)isAllocated:(NSString *)uniqueId;
- (FlutterWrapper *)getWrapper:(NSString *)uniqueId;
- (NSObject *)handleMethodCall:(FlutterMethodCall *)call;
@end

@implementation NotImplementedException 
+ (NSException *)exceptionWithMethod:(NSString *)methodName {
  return [NSException exceptionWithName:@"NotImplementedException"
                                 reason:[NSString stringWithFormat:@"No implementation for %@.", methodName]
                               userInfo:nil];
}
@end

@implementation NoUniqueIdException
+ (NSException *)exceptionWithMethod:(NSString *)methodName {
  return [NSException exceptionWithName:@"NotImplementedException"
                                 reason:[NSString stringWithFormat:@"MethodCall was made without a unique handle for %@.", methodName]
                               userInfo:nil];
}
@end

@implementation WrapperNotFoundException
+ (NSException *)exceptionWithUniqueId:(NSString *)uniqueId {
  return [NSException exceptionWithName:@"NotImplementedException"
      reason:[NSString stringWithFormat:@"MethodCall was made without a unique handle for %@.", uniqueId]
                               userInfo:nil];
}
@end

@implementation FlutterWrapper {
  @public
  ChannelHandler *$handler;
  NSString *$uniqueId;
}
- (instancetype _Nonnull)initWithHandler:(ChannelHandler *_Nonnull)handler
                                uniqueId:(NSString *_Nonnull)uniqueId {
  self = [super init];
  if (self) {
    $handler = handler;
    $uniqueId = uniqueId;
  }
  [$handler addTempWrapper:$uniqueId wrapper:self];
  return self;
}

+ (NSObject *)handleStaticMethodCall:(ChannelHandler *_Nonnull)handler
                                call:(FlutterMethodCall *_Nonnull)call {
  [self doesNotRecognizeSelector:_cmd];
  return [NSNull null];
}

- (NSObject *)handleMethodCall:(FlutterMethodCall *_Nonnull)call {
  [self doesNotRecognizeSelector:_cmd];
  return [NSNull null];
}

- (void)$allocate {
  [$handler addAllocatedWrapper:$uniqueId wrapper:self];
}

- (void)$deallocate {
  [$handler removeAllocatedWrapper:$uniqueId];
}
@end

%%CLASSES%%
%%CLASS%%
@interface __platformClassName__Wrapper : FlutterWrapper
@property __platformClassName__ *$value;
@end
@implementation __platformClassName__Wrapper
- (instancetype _Nonnull)initWithHandler:(ChannelHandler *_Nonnull)handler
                                uniqueId:(NSString *_Nonnull)uniqueId
                                value:(__platformClassName__ *_Nonnull)value {
  self = [super initWithHandler:handler uniqueId:uniqueId];
  if (self) {
    _$value = value;
  }
  return self;
}

%%CONSTRUCTORS%%
%%CONSTRUCTOR%%
- (instancetype _Nonnull)initWithHandler:(ChannelHandler *_Nonnull)handler
                                uniqueId:(NSString *_Nonnull)uniqueId {
  self = [super initWithHandler:handler uniqueId:uniqueId];
  if (self) {
    _$value = [[__platformClassName__ alloc] init];
  }
  return self;
}
%%CONSTRUCTOR%%
%%CONSTRUCTORS%%

+ (NSObject *)handleStaticMethodCall:(ChannelHandler *_Nonnull)handler
                                call:(FlutterMethodCall *_Nonnull)call {
  %%STATICMETHODCALLS%%
  %%STATICMETHODCALL classMember:constructor%%
  if ([@"__platformClassName__()" isEqualToString:call.method]) {
    [[__platformClassName__Wrapper alloc] initWithHandler:handler uniqueId:call.arguments[@"$uniqueId"]];
    return [NSNull null];
  }
  %%STATICMETHODCALL classMember:constructor%%
  %%STATICMETHODCALL classMember:method%%
  if ([@"__platformClassName__#__methodName__" isEqualToString:call.method]) {
    return [__platformClassName__Wrapper __methodName__:handler call:call];
  }
  %%STATICMETHODCALL classMember:method%%
  %%STATICMETHODCALL classMember:field%%
  if ([@"__platformClassName__.__fieldName__" isEqualToString:call.method]) {
    return [__platformClassName__Wrapper __fieldName__:handler call:call];
  }
  %%STATICMETHODCALL classMember:field%%
  %%STATICMETHODCALLS%%
  
  @throw [NotImplementedException exceptionWithMethod:call.method];
}

- (NSObject *)handleMethodCall:(FlutterMethodCall *_Nonnull)call {
  if ([@"__platformClassName__#allocate" isEqualToString:call.method]) {
  
  } else if ([@"__platformClassName__#deallocate" isEqualToString:call.method]) {
  
  }
  %%METHODCALLS%%
  %%METHODCALL classMember:method%%
  else if ([@"__platformClassName__#__methodName__" isEqualToString:call.method]) {
    return [self __methodName__:call];
  }
  %%METHODCALL classMember:method%%
  %%METHODCALL classMember:field%%
  else if ([@"__platformClassName__.__fieldName__" isEqualToString:call.method]) {
    return [self __fieldName__:call];
  }
  %%METHODCALL classMember:field%%
  %%METHODCALLS%%
  
  @throw [NotImplementedException exceptionWithMethod:call.method];
}

%%METHODS%%
%%METHOD%%
+ (NSObject *)__methodName__:(ChannelHandler *)$handler call:(FlutterMethodCall *)call {
  %%PREMETHODCALLS%%
  %%PREMETHODCALL methodChannel:void%%
  %%PREMETHODCALL methodChannel:void%%
  %%PREMETHODCALL methodChannel:supported%%
  return
  %%PREMETHODCALL methodChannel:supported%%
  %%PREMETHODCALL methodChannel:wrapper%%
  [__returnType__Wrapper initWithHandler:$handler uniqueId:call.arguments[@"uniqueId"] value:
  %%PREMETHODCALL methodChannel:wrapper%%
  %%PREMETHODCALLS%%
  
  [__methodCallerName__ __methodName__
  %%PARAMETERS%%
  %%PARAMETER methodChannel:supported%%
  __parameterName__:call.arguments[@"__parameterName__"]
  %%PARAMETER methodChannel:supported%%
  %%PARAMETER methodChannel:wrapper%%
  __parameterName__:[$handler getWrapper:call.arguments[@"__parameterName__"]
  %%PARAMETER methodChannel:wrapper%%
  %%PARAMETERS%%
  ]
  
  %%POSTMETHODCALLS%%
  %%POSTMETHODCALL methodChannel:void%%
  ;
  return [NSNull null];
  %%POSTMETHODCALL methodChannel:void%%
  %%POSTMETHODCALL methodChannel:supported%%
  ;
  %%POSTMETHODCALL methodChannel:supported%%
  %%POSTMETHODCALL methodChannel:wrapper%%
  ];
  return [NSNull null];
  %%POSTMETHODCALL methodChannel:wrapper%%
  %%POSTMETHODCALLS%%
}
%%METHOD%%
%%METHODS%%
@end
%%CLASS%%
%%CLASSES%%

@implementation ChannelHandler
- (instancetype)init {
  self = [super init];
  if (self) {
    _allocatedWrappers = [NSMutableDictionary dictionary];
    _tempWrappers = [NSMutableDictionary dictionary];
  }
  return self;
}

- (void)addWrapper:(NSString *)uniqueId
           wrapper:(FlutterWrapper *)wrapper
 wrapperDictionary:(NSMutableDictionary *)wrapperDictionary {
  if ([wrapperDictionary objectForKey:uniqueId] != nil) {
    NSException *exception = [NSException
       exceptionWithName:@"IllegalArgumentException"
                  reason:[NSString stringWithFormat:@"Object for uniqueId already exists: %@", uniqueId]
                userInfo:nil];
    @throw exception;
  }
  wrapperDictionary[uniqueId] = wrapper;
}

- (void)addTempWrapper:(NSString *)uniqueId wrapper:(FlutterWrapper *)wrapper {
  [self addWrapper:uniqueId wrapper:wrapper wrapperDictionary:_tempWrappers];
}

- (void)addAllocatedWrapper:(NSString *)uniqueId wrapper:(FlutterWrapper *)wrapper {
  [self addWrapper:uniqueId wrapper:wrapper wrapperDictionary:_allocatedWrappers];
}

- (void)removeAllocatedWrapper:(NSString *)uniqueId {
  [_allocatedWrappers removeObjectForKey:uniqueId];
}

- (BOOL)isAllocated:(NSString *)uniqueId {
  return [_allocatedWrappers objectForKey:uniqueId] != nil;
}

- (FlutterWrapper *)getWrapper:(NSString *)uniqueId {
  FlutterWrapper *wrapper = [_allocatedWrappers objectForKey:uniqueId];
  if (wrapper != nil) return wrapper;
  return [_tempWrappers objectForKey:uniqueId];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
  @try {
    NSObject *object = [self handleMethodCall:call];
    result(object);
  }
  @catch(NSException *exception) {
    result([FlutterError errorWithCode:exception.name message:exception.reason details:nil]);
  }
}

- (NSObject *)handleMethodCall:(FlutterMethodCall *)call {
  if ([@"MultiInvoke" isEqualToString:call.method]) {
    NSArray<NSDictionary*> *allMethodCalls = call.arguments;
    NSMutableArray<NSObject *> *resultData = [NSMutableArray array];
    for (NSDictionary *methodCallData in allMethodCalls) {
      NSString *method = methodCallData[@"method"];
      NSDictionary *arguments = methodCallData[@"arguments"];
      
      FlutterMethodCall *methodCall = [FlutterMethodCall
         methodCallWithMethodName:method
                        arguments:arguments];
                        
      [resultData addObject:[self handleMethodCall:methodCall]];
    }
    
    return resultData;
  }
  %%STATICREDIRECTS%%
  %%STATICREDIRECT classMember:constructor%%
  else if ([@"__platformClassName__()" isEqualToString:call.method]) {
    return [__platformClassName__Wrapper handleStaticMethodCall:self call:call];
  }
  %%STATICREDIRECT classMember:constructor%%
  %%STATICREDIRECT classMember:method%%
  else if ([@"__platformClassName__#__methodName__" isEqualToString:call.method]) {
    return [__platformClassName__Wrapper handleStaticMethodCall:self call:call];
  }
  %%STATICREDIRECT classMember:method%%
  %%STATICREDIRECT classMember:field%%
  else if ([@"__platformClassName__.__fieldName__" isEqualToString:call.method]) {
    return [__platformClassName__Wrapper handleStaticMethodCall:self call:call];
  }
  %%STATICREDIRECT classMember:field%%
  %%STATICREDIRECTS%%
  
  NSString *uniqueId = call.arguments[@"$uniqueId"];
  if (uniqueId == nil) {
    @throw [NoUniqueIdException exceptionWithMethod:call.method];
  } else if ([self getWrapper:uniqueId] == nil) {
    @throw [WrapperNotFoundException exceptionWithUniqueId:uniqueId];
  }
  
  return [[self getWrapper:uniqueId] handleMethodCall:call];
}
@end
''');

  static const Template dartMethodChannel = Template._(r'''
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
  Iterable<MethodCall> following = const <MethodCall>[],
]) {
  final Completer<T> completer = Completer<T>();

  $invokeAll(
    channel,
    <MethodCall>[call, ...following].where((MethodCall call) => call != null),
  ).then(
    (List<dynamic> results) => completer.complete(results.last),
  );

  return completer.future;
}

Future<List<T>> $invokeList<T>(
  MethodChannel channel,
  MethodCall call, [
  Iterable<MethodCall> following = const <MethodCall>[],
]) {
  final Completer<List<T>> completer = Completer<List<T>>();

  $invokeAll(
    channel,
    <MethodCall>[call, ...following].where((MethodCall call) => call != null),
  ).then(
    (List<dynamic> results) => completer.complete(results.last.cast<T>()),
  );

  return completer.future;
}

Future<Map<S, T>> $invokeMap<S, T>(
  MethodChannel channel,
  MethodCall call, [
  Iterable<MethodCall> following = const <MethodCall>[],
]) {
  final Completer<Map<S, T>> completer = Completer<Map<S, T>>();

  $invokeAll(
    channel,
    <MethodCall>[call, ...following].where((MethodCall call) => call != null),
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

  static const Template android = Template._(r'''
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

class Block {
  Block(this.identifier, [this.config])
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

  static final Block methods = Block('METHODS');
  static final Block method = Block('METHOD');

  static final Block preMethodCalls = Block('PREMETHODCALLS');

  static final Block postMethodCalls = Block('POSTMETHODCALLS');

  static final Block preFieldAccesses = Block('PREFIELDACCESSES');

  static final Block postFieldAccesses = Block('POSTFIELDACCESSES');

  static final Block imports = Block('IMPORTS');
  static final Block import = Block('IMPORT');

  static final Block classes = Block('CLASSES');
  static final Block aClass = Block('CLASS');

  static final Block constructors = Block('CONSTRUCTORS');
  static final Block constructor = Block('CONSTRUCTOR');

  static final Block staticRedirects = Block('STATICREDIRECTS');

  static final Block parameters = Block('PARAMETERS');
  static final Block parameter = Block('PARAMETER');

  static final Block fieldSetters = Block('FIELDSETTERS');

  static final Block fields = Block('FIELDS');
  static final Block field = Block('FIELD');

  static final Block fieldSetterParams = Block('FIELDSETTERPARAMS');
}

class MethodChannelBlock extends Block {
  MethodChannelBlock(
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

  static MethodChannelBlock fieldSetterParam(MethodChannelType methodChannel) =>
      MethodChannelBlock('FIELDSETTERPARAM', methodChannel: methodChannel);

  static final MethodChannelBlock methodCallParams =
      MethodChannelBlock('METHODCALLPARAMS');
  static MethodChannelBlock methodCallParam(MethodChannelType methodChannel) =>
      MethodChannelBlock('METHODCALLPARAM', methodChannel: methodChannel);

  static MethodChannelBlock fieldSetter(MethodChannelType methodChannel) =>
      MethodChannelBlock('FIELDSETTER', methodChannel: methodChannel);

  static final MethodChannelBlock staticMethodCalls =
      MethodChannelBlock('STATICMETHODCALLS');
  static MethodChannelBlock staticMethodCall(ClassMemberType classMember) =>
      MethodChannelBlock('STATICMETHODCALL', classMember: classMember);

  static MethodChannelBlock staticRedirect(ClassMemberType classMember) =>
      MethodChannelBlock('STATICREDIRECT', classMember: classMember);

  static final MethodChannelBlock methodCalls =
      MethodChannelBlock('METHODCALLS');
  static MethodChannelBlock methodCall(ClassMemberType classMember) =>
      MethodChannelBlock('METHODCALL', classMember: classMember);

  static MethodChannelBlock parameter(MethodChannelType methodChannel) =>
      MethodChannelBlock(
        Block.parameter.identifier,
        methodChannel: methodChannel,
      );

  static MethodChannelBlock postFieldAccess(MethodChannelType methodChannel) =>
      MethodChannelBlock('POSTFIELDACCESS', methodChannel: methodChannel);

  static MethodChannelBlock preFieldAccess(MethodChannelType methodChannel) =>
      MethodChannelBlock('PREFIELDACCESS', methodChannel: methodChannel);

  static MethodChannelBlock postMethodCall(MethodChannelType methodChannel) =>
      MethodChannelBlock('POSTMETHODCALL', methodChannel: methodChannel);

  static MethodChannelBlock preMethodCall(MethodChannelType methodChannel) =>
      MethodChannelBlock('PREMETHODCALL', methodChannel: methodChannel);
}

class Replacement {
  const Replacement(this.name);

  final String name;

  static final Replacement methodName = Replacement('__methodName__');
  static final Replacement className = Replacement('__className__');
  static final Replacement channelName = Replacement('__channelName__');
  static final Replacement package = Replacement('__package__');
  static final Replacement classPackage = Replacement('__classPackage__');
  static final Replacement platformClassName = Replacement(
    '__platformClassName__',
  );
  static final Replacement parameterName = Replacement('__parameterName__');
  static final Replacement parameterType = Replacement('__parameterType__');
  static final Replacement returnType = Replacement('__returnType__');
  static final Replacement typeParameters = Replacement('__typeParameters__');
  static final Replacement methodCallerName =
      Replacement('__methodCallerName__');
  static final Replacement fieldName = Replacement('__fieldName__');
  static final Replacement fieldType = Replacement('__fieldType__');
}
