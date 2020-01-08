enum MethodChannelType {
  $void,
  supported,
  wrapper,
  primitive,
  struct,
  typeParameter,
}
enum ClassMemberType { constructor, method, field }
enum Structure { $class, struct, protocol }

class Template {
  const Template._(this.value);

  final String value;

  static const Template ios = Template._(r'''
#include <objc/message.h>
  
#import "ChannelHandler+Generated.h"

static void *wrapperCallbackKey = &wrapperCallbackKey;

@interface NotImplementedException : NSException
- (instancetype _Nonnull)initWithMethod:(NSString *)methodName;
@end

@interface NoUniqueIdException : NSException
- (instancetype _Nonnull)initWithMethod:(NSString *)methodName;
@end

@interface WrapperNotFoundException : NSException
- (instancetype _Nonnull)initWithUniqueId:(NSString *)uniqueId;
@end

@interface Wrapper ()
@property NSString *$uniqueId;
@property FlutterMethodChannel *callbackChannel;
- (instancetype _Nonnull)initWithWrapperManager:(WrapperManager *_Nonnull)wrapperManager
                                       uniqueId:(NSString *_Nonnull)uniqueId;
- (instancetype _Nonnull)initWithWrapperManager:(WrapperManager *_Nonnull)wrapperManager
                                           call:(FlutterMethodCall *_Nonnull)call;
- (NSObject *)onMethodCall:(WrapperManager *_Nonnull)wrapperManager
                      call:(FlutterMethodCall *_Nonnull)call;
+ (NSObject *)onStaticMethodCall:(WrapperManager *_Nonnull)wrapperManager
                            call:(FlutterMethodCall *_Nonnull)call;
- (NSObject *)getValue;
- (void)$allocate:(WrapperManager *)wrapperManager;
- (void)$deallocate:(WrapperManager *)wrapperManager;
@end

@interface WrapperManager ()
@property NSMutableDictionary<NSString*, Wrapper*> *allocatedWrappers;
@property NSMutableDictionary<NSString*, Wrapper*> *temporaryWrappers;
- (void)addTemporaryWrapper:(Wrapper *)wrapper;
- (Wrapper *)getWrapper:(NSString *)uniqueId;
- (void)clearTemporaryWrappers;
@end

@interface ViewFactory : NSObject<FlutterPlatformViewFactory>
- (instancetype _Nonnull)initWithWrapperManager:(WrapperManager *_Nonnull)wrapperManager
                              methodCallHandler:(MethodCallHandler *_Nonnull)methodCallHandler
                                callbackChannel:(FlutterMethodChannel *_Nonnull)callbackChannel;
@property WrapperManager *_Nonnull wrapperManager;
@property MethodCallHandler *_Nonnull methodCallHandler;
@property FlutterMethodChannel *_Nonnull callbackChannel;
@end

@interface MethodCallHandler ()
@property WrapperManager *wrapperManager;
@property FlutterMethodChannel *_Nonnull callbackChannel;
- (instancetype _Nonnull)initWithWrapperManager:(WrapperManager *_Nonnull)wrapperManager
                                callbackChannel:(FlutterMethodChannel *_Nullable)callbackChannel;
@end

@implementation NotImplementedException 
- (instancetype _Nonnull)initWithMethod:(NSString *)methodName {
  return self = [super initWithName:@"NotImplementedException"
                             reason:[NSString stringWithFormat:@"No implementation for %@.", methodName]
                           userInfo:nil];
}
@end

@implementation NoUniqueIdException
- (instancetype _Nonnull)initWithMethod:(NSString *)methodName {
  return self = [super initWithName:@"NoUniqueIdException"
                             reason:[NSString stringWithFormat:@"MethodCall was made without a unique handle for %@.", methodName]
                           userInfo:nil];
}
@end

@implementation WrapperNotFoundException
- (instancetype _Nonnull)initWithUniqueId:(NSString *)uniqueId {
  return self = [super initWithName:@"WrapperNotFoundException"
                             reason:[NSString
                   stringWithFormat:@"Could not find Wrapper with uniqueId %@.", uniqueId]
                          userInfo:nil];
}
@end

@implementation Wrapper

- (instancetype _Nonnull)initWithWrapperManager:(WrapperManager *_Nonnull)wrapperManager
                                       uniqueId:(NSString *_Nonnull)uniqueId {
  self = [super init];
  if (self) {
    _$uniqueId = uniqueId;
  }
  [wrapperManager addTemporaryWrapper:self];
  return self;
}

- (instancetype _Nonnull)initWithWrapperManager:(WrapperManager *_Nonnull)wrapperManager
                                           call:(FlutterMethodCall *_Nonnull)call {
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

+ (NSObject *)onStaticMethodCall:(WrapperManager *_Nonnull)wrapperManager
                                call:(FlutterMethodCall *_Nonnull)call {
  [self doesNotRecognizeSelector:_cmd];
  return [NSNull null];
}

- (NSObject *)onMethodCall:(WrapperManager *_Nonnull)wrapperManager call:(FlutterMethodCall *_Nonnull)call {
  [self doesNotRecognizeSelector:_cmd];
  return [NSNull null];
}

- (NSObject *)getValue {
  [self doesNotRecognizeSelector:_cmd];
  return [NSNull null];
}

- (void)$allocate:(WrapperManager *)wrapperManager {
  [wrapperManager addAllocatedWrapper:self];
}

- (void)$deallocate:(WrapperManager *)wrapperManager {
  [wrapperManager removeAllocatedWrapper:_$uniqueId];
}

- (nonnull UIView *)view {
  return [self getValue];
}
@end

@implementation  NSValue (Structs)
%%STRUCTS%%
%%STRUCT%%
+ (struct __platformClassName__)get__platformClassName__:(NSValue *)wrapperValue {
  struct __platformClassName__ value;
  [wrapperValue getValue:&value];
  return value;
}
%%STRUCT%%
%%STRUCTS%%
@end

%%CLASSES%%
%%CLASS%%
@interface $__platformClassName__Impl : NSObject<__platformClassName__>
@end

@implementation $__platformClassName__Impl
@end

@implementation $__platformClassName__ {
  %%VALUETYPES%%
  %%VALUETYPE structure:class%%
  __platformClassName__ *
  %%VALUETYPE structure:class%%
  %%VALUETYPE structure:struct%%
  NSValue *
  %%VALUETYPE structure:struct%%
  %%VALUETYPE structure:protocol%%
  id<__platformClassName__>
  %%VALUETYPE structure:protocol%%
  %%VALUETYPES%%
  _value;
}

- (instancetype _Nonnull)initWithWrapperManager:(WrapperManager *_Nonnull)wrapperManager
                                       uniqueId:(NSString *_Nonnull)uniqueId
                                          value:(%%VALUETYPES%%%%VALUETYPES%% _Nullable)value {
  self = [super initWithWrapperManager:wrapperManager uniqueId:uniqueId];
  if (self) {
    _value = value;
  }
  return self;
}

- (instancetype _Nonnull)initWithWrapperManager:(WrapperManager *_Nonnull)wrapperManager
                                callbackChannel:(FlutterMethodChannel *_Nullable)callbackChannel
                                           call:(FlutterMethodCall *_Nonnull)call {
  self = [super initWithWrapperManager:wrapperManager uniqueId:call.arguments[@"$uniqueId"]];
  if (!self) return self;
  
  self.callbackChannel = callbackChannel;
  %%CONSTRUCTORS%%
  %%CONSTRUCTOR%%
  if ([@"__platformClassName__(__constructorSignature__)" isEqualToString:call.method]) {
    _value = [[__implementationName__ alloc] __constructorName__
      %%PARAMETERS%%
      %%PARAMETERS%%
    ];  
  }
  %%CONSTRUCTOR%%
  %%CONSTRUCTORS%%
  
  %%CALLBACKSWIZZLES%%
  %%CALLBACKSWIZZLE%%
  class_replaceMethod([(id)_value class], NSSelectorFromString(@"__methodName__"),
    class_getMethodImplementation([self class], NSSelectorFromString(@"__methodName__$Callback")),
    method_getTypeEncoding(class_getInstanceMethod([(id)_value class], NSSelectorFromString(@"__methodName__"))));  
  objc_setAssociatedObject(_value, wrapperCallbackKey, self, OBJC_ASSOCIATION_RETAIN);
  %%CALLBACKSWIZZLE%%
  %%CALLBACKSWIZZLES%%
  
  return self;
}

+ (NSObject *)onStaticMethodCall:(WrapperManager *_Nonnull)wrapperManager
                            call:(FlutterMethodCall *_Nonnull)call {
  %%STATICMETHODCALLS%%
  %%STATICMETHODCALL classMember:method%%
  if ([@"__platformClassName__#__methodName__" isEqualToString:call.method]) {
    return [$__platformClassName__ __methodName__:wrapperManager call:call];
  }
  %%STATICMETHODCALL classMember:method%%
  %%STATICMETHODCALL classMember:field%%
  if ([@"__platformClassName__.__fieldName__" isEqualToString:call.method]) {
    return [$__platformClassName__ __fieldName__:wrapperManager call:call];
  }
  %%STATICMETHODCALL classMember:field%%
  %%STATICMETHODCALLS%%
  
  @throw [[NotImplementedException alloc] initWithMethod:call.method];
}

- (NSObject *)onMethodCall:(WrapperManager *)wrapperManager call:(FlutterMethodCall *_Nonnull)call {
  if ([@"__platformClassName__#allocate" isEqualToString:call.method]) {
    [self $allocate:wrapperManager];
    return [NSNull null];
  } else if ([@"__platformClassName__#deallocate" isEqualToString:call.method]) {
    [self $deallocate:wrapperManager];
    return [NSNull null];
  }
  %%METHODCALLS%%
  %%METHODCALL classMember:method%%
  else if ([@"__platformClassName__#__methodName__" isEqualToString:call.method]) {
    return [self __methodName__:wrapperManager call:call];
  }
  %%METHODCALL classMember:method%%
  %%METHODCALL classMember:field%%
  else if ([@"__platformClassName__.__fieldName__" isEqualToString:call.method]) {
    return [self __fieldName__:wrapperManager call:call];
  }
  %%METHODCALL classMember:field%%
  %%METHODCALLS%%
  
  @throw [[NotImplementedException alloc] initWithMethod:call.method];
}

%%CALLBACKS%%
%%CALLBACK%%
- (void)__methodName__$Callback {
  $__platformClassName__ *wrapper = objc_getAssociatedObject(self, wrapperCallbackKey);
  [wrapper.callbackChannel invokeMethod:@"__platformClassName__#__methodName__" arguments:@{@"$uniqueId": wrapper.$uniqueId}];
}
%%CALLBACK%%
%%CALLBACKS%%

%%FIELDS%%
%%FIELD%%
+ (NSObject *)__fieldName__:(WrapperManager *)wrapperManager call:(FlutterMethodCall *)call {
  if (call.arguments[@"__fieldName__"] != nil) {
    __methodCallerName__.__fieldName__ =
    %%PARAMETERS%%
    %%PARAMETERS%%
    ;
  }
  
  %%PREMETHODCALLS%%
  %%PREMETHODCALLS%%

  __methodCallerName__.__fieldName__

  %%POSTMETHODCALLS%%
  %%POSTMETHODCALLS%%
}
%%FIELD%%
%%FIELDS%%

%%METHODS%%
%%METHOD%%
+ (NSObject *)__methodName__:(WrapperManager *)wrapperManager call:(FlutterMethodCall *)call {
  %%PREMETHODCALLS%%
  %%PREMETHODCALL methodChannel:void%%
  %%PREMETHODCALL methodChannel:void%%
  %%PREMETHODCALL methodChannel:supported%%
  return
  %%PREMETHODCALL methodChannel:supported%%
  %%PREMETHODCALL methodChannel:wrapper%%
  [[$__returnType__ alloc] initWithWrapperManager:wrapperManager uniqueId:call.arguments[@"$newUniqueId"] value:
  %%PREMETHODCALL methodChannel:wrapper%%
  %%PREMETHODCALL methodChannel:primitive%%
  return @(
  %%PREMETHODCALL methodChannel:primitive%%
  %%PREMETHODCALL methodChannel:struct%%
  %%PREMETHODCALL methodChannel:struct%%
  %%PREMETHODCALL methodChannel:typeParameter%%
  NSObject *result =
  %%PREMETHODCALL methodChannel:typeParameter%%
  %%PREMETHODCALLS%%
  
  [__methodCallerName__ __methodName__
  %%PARAMETERS%%
  %%PARAMETER methodChannel:supported%%
  __parameterName__:call.arguments[@"__parameterName__"]
  %%PARAMETER methodChannel:supported%%
  %%PARAMETER methodChannel:wrapper%%
  __parameterName__:![call.arguments[@"__parameterName__"] isEqual:[NSNull null]] ? [[wrapperManager getWrapper:call.arguments[@"__parameterName__"]] getValue] : nil
  %%PARAMETER methodChannel:wrapper%%
  %%PARAMETER methodChannel:primitive%%
  __parameterName__:[call.arguments[@"__parameterName__"] __primitiveConvertMethod__]
  %%PARAMETER methodChannel:primitive%%
  %%PARAMETER methodChannel:struct%%
  __parameterName__:[NSValue get__parameterType__:[[wrapperManager getWrapper:call.arguments[@"__parameterName__"]] getValue]]
  %%PARAMETER methodChannel:struct%%
  %%PARAMETER methodChannel:typeParameter%%
  __parameterName__:[call.arguments[@"__parameterName__$isWrapper"] boolValue] ? (![call.arguments[@"__parameterName__"] isEqual:[NSNull null]] ? [[wrapperManager getWrapper:call.arguments[@"__parameterName__"]] getValue] : nil) : call.arguments[@"__parameterName__"]
  %%PARAMETER methodChannel:typeParameter%%
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
  %%POSTMETHODCALL methodChannel:primitive%%
  );
  %%POSTMETHODCALL methodChannel:primitive%%
  %%POSTMETHODCALL methodChannel:struct%%
  ];
  return [NSNull null];
  %%POSTMETHODCALL methodChannel:struct%%
  %%POSTMETHODCALL methodChannel:typeParameter%%
  ;
  if (![call.arguments[@"$returnTypeIsWrapper"] boolValue]) return result;
  NSString *wrapperClassName = [NSString stringWithFormat:@"$%@", call.arguments[@"$returnTypePlatformName"]];
  Class wrapperClass = NSClassFromString(wrapperClassName);
  [[wrapperClass alloc] initWithWrapperManager:wrapperManager uniqueId:call.arguments[@"$newUniqueId"] value:result];
  return [NSNull null];
  %%POSTMETHODCALL methodChannel:typeParameter%%
  %%POSTMETHODCALLS%%
}
%%METHOD%%
%%METHODS%%

- (id)getValue {
  return _value;
}
@end
%%CLASS%%
%%CLASSES%%

@implementation ChannelHandler
- (instancetype _Nonnull)initWithCallbackChannel:(FlutterMethodChannel *_Nonnull)callbackChannel {
  self = [self init];
  if (self) {
    _wrapperManager = [[WrapperManager alloc] init];
    _methodCallHandler = [[MethodCallHandler alloc] initWithWrapperManager:_wrapperManager
                                                           callbackChannel:callbackChannel];
    _callbackChannel = callbackChannel;
    _viewFactory = [[ViewFactory alloc] initWithWrapperManager:_wrapperManager
                                             methodCallHandler:_methodCallHandler
                                               callbackChannel:_callbackChannel];
  }
  return self;
}
@end

@implementation WrapperManager
- (instancetype)init {
  self = [super init];
  if (self) {
    _allocatedWrappers = [NSMutableDictionary dictionary];
    _temporaryWrappers = [NSMutableDictionary dictionary];
  }
  return self;
}

- (void)addAllocatedWrapper:(Wrapper *)wrapper {
  [self addWrapper:wrapper wrapperDictionary:_allocatedWrappers];
}

- (void)removeAllocatedWrapper:(NSString *)uniqueId {
  [_allocatedWrappers removeObjectForKey:uniqueId];
}

- (void)addTemporaryWrapper:(Wrapper *)wrapper {
  [self addWrapper:wrapper wrapperDictionary:_temporaryWrappers];
}

- (void)addWrapper:(Wrapper *)wrapper wrapperDictionary:(NSMutableDictionary *)wrapperDictionary {
  Wrapper *existingWrapper;
  @try {
    existingWrapper = [self getWrapper:wrapper.$uniqueId];
  } @catch (WrapperNotFoundException *exception) {
    [wrapperDictionary setObject:wrapper forKey:wrapper.$uniqueId];
    return;
  }
  
  if ([existingWrapper getValue] != [wrapper getValue]) {
    @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"Object for uniqueId already exists: %@", wrapper.$uniqueId] userInfo:nil];
  }
  
  if ([wrapperDictionary objectForKey:wrapper.$uniqueId] == nil) {
    [wrapperDictionary setObject:wrapper forKey:wrapper.$uniqueId];
  }  
}

- (Wrapper *)getWrapper:(NSString *)uniqueId {
  if ([_allocatedWrappers objectForKey:uniqueId] != nil) return [_allocatedWrappers objectForKey:uniqueId];
  if ([_temporaryWrappers objectForKey:uniqueId] != nil) return [_temporaryWrappers objectForKey:uniqueId];
  @throw [[WrapperNotFoundException alloc] initWithUniqueId:uniqueId];
}

- (void)clearTemporaryWrappers {
  [_temporaryWrappers removeAllObjects];
}
@end

@implementation MethodCallHandler
- (instancetype _Nonnull)initWithWrapperManager:(WrapperManager *_Nonnull)wrapperManager
                                callbackChannel:(FlutterMethodChannel *_Nullable)callbackChannel {
  self = [super init];
  if (self) {
    _wrapperManager = wrapperManager;
    _callbackChannel = callbackChannel;
  }
  return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
  @try {
    NSObject *object = [self onMethodCall:call];
    result(object);
  } @catch(NSException *exception) {
    result([FlutterError errorWithCode:exception.name message:exception.reason details:[NSThread callStackSymbols]]);
  } @finally {
    [_wrapperManager clearTemporaryWrappers];
  }
}

- (NSObject *)onMethodCall:(FlutterMethodCall *)call {
  if ([@"MultiInvoke" isEqualToString:call.method]) {
    NSArray<NSDictionary*> *allMethodCalls = call.arguments;
    NSMutableArray<NSObject *> *resultData = [NSMutableArray array];
    for (NSDictionary *methodCallData in allMethodCalls) {
      NSString *method = methodCallData[@"method"];
      NSDictionary *arguments = methodCallData[@"arguments"];
      
      FlutterMethodCall *methodCall = [FlutterMethodCall
         methodCallWithMethodName:method
                        arguments:arguments];
                        
      [resultData addObject:[self onMethodCall:methodCall]];
    }
    
    return resultData;
  }
  %%STATICREDIRECTS%%
  %%STATICREDIRECT classMember:constructor%%
  else if ([@"__platformClassName__(__constructorName__)" isEqualToString:call.method]) {
    [[$__platformClassName__ alloc] initWithWrapperManager:_wrapperManager callbackChannel:_callbackChannel call:call];
    return [NSNull null];
  }
  %%STATICREDIRECT classMember:constructor%%
  %%STATICREDIRECT classMember:method%%
  else if ([@"__platformClassName__#__methodName__" isEqualToString:call.method]) {
    return [$__platformClassName__ onStaticMethodCall:_wrapperManager call:call];
  }
  %%STATICREDIRECT classMember:method%%
  %%STATICREDIRECT classMember:field%%
  else if ([@"__platformClassName__.__fieldName__" isEqualToString:call.method]) {
    return [$__platformClassName__ onStaticMethodCall:_wrapperManager call:call];
  }
  %%STATICREDIRECT classMember:field%%
  %%STATICREDIRECTS%%
  
  NSString *uniqueId = call.arguments[@"$uniqueId"];
  if (uniqueId == nil) {
    @throw [[NoUniqueIdException alloc] initWithMethod:call.method];
  }

  return [[_wrapperManager getWrapper:uniqueId] onMethodCall:_wrapperManager call:call];
}
@end

@interface PlatformViewFrame : NSObject<FlutterPlatformView>
@property UIView *frame;
@end

@implementation PlatformViewFrame
- (nonnull UIView *)view {
  return _frame;
}
@end

@implementation ViewFactory
- (instancetype _Nonnull)initWithWrapperManager:(WrapperManager *_Nonnull)wrapperManager
                              methodCallHandler:(MethodCallHandler *_Nonnull)methodCallHandler
                                callbackChannel:(FlutterMethodChannel *_Nonnull)callbackChannel {
  self = [self init];
  if (self) {
    _wrapperManager = wrapperManager;
    _methodCallHandler = methodCallHandler;
    _callbackChannel = callbackChannel;
  }
  
  return self;
}

- (nonnull NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame
                                            viewIdentifier:(int64_t)viewId
                                                 arguments:(id _Nullable)args {
  __block NSString *uniqueId = args;
  __block PlatformViewFrame *viewFrame = [[PlatformViewFrame alloc] init];
  viewFrame.frame = [[UIView alloc] initWithFrame:frame];
  
  NSValue *rectValue = [NSValue valueWithBytes:&frame objCType:@encode(CGRect)];
  __block $CGRect *cgRectWrapper = [[$CGRect alloc] initWithWrapperManager:_wrapperManager
                                                                  uniqueId:[[NSUUID UUID] UUIDString]
                                                                     value:rectValue];
  
  NSDictionary *callbackArguments = @{@"cgRect": cgRectWrapper.$uniqueId, @"$uniqueId": args};
  
  [_callbackChannel invokeMethod:@"CreateView"
                       arguments:callbackArguments
                          result:^(id  _Nullable result) {
                            [self->_wrapperManager addTemporaryWrapper:cgRectWrapper];
                            @try {
                              FlutterMethodCall *methodCall = [FlutterMethodCall methodCallWithMethodName:@"MultiInvoke" arguments:result];
                              [self->_methodCallHandler onMethodCall:methodCall];
                              [viewFrame.frame addSubview:[[self->_wrapperManager getWrapper:uniqueId] getValue]];
                              [viewFrame.frame subviews][0].autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                            } @finally {
                              [self->_wrapperManager clearTemporaryWrappers];
                            }
                          }];
  
  return viewFrame;
}

- (NSObject<FlutterMessageCodec>*)createArgsCodec {
  return [FlutterStandardMessageCodec sharedInstance];
}
@end
''');

  static const Template dartMethodChannel = Template._(r'''
part of '__filename__';

%%CLASSES%%
%%CLASS%%
class $__className____typeParameters__ extends __wrapperInterface__ {
  $__className__(String uniqueId, 
  {List<MethodCall> Function(__platformViewClass__ __platformViewVariable__) onCreateView,}
  ) : super(uniqueId: uniqueId, platformClassName: '__platformClassName__', onCreateView: onCreateView,);

  @override
  Future<void> onMethodCall(MethodCall call) async {
    switch (call.method) {
      %%CALLBACKS%%
      %%CALLBACK%%      
      case '__wrapperName__#__methodName__':
        (this as __className__).__methodName__(
          %%CALLBACKCHANNELPARAMS%%
          %%CALLBACKCHANNELPARAM methodChannel:wrapper%%
          await __className__.onAllocated($__className__(call.arguments['__parameterName__'])),
          %%CALLBACKCHANNELPARAM methodChannel:wrapper%%
          %%CALLBACKCHANNELPARAM methodChannel:primitive%%
          call.arguments['__parameterName__'],
          %%CALLBACKCHANNELPARAM methodChannel:primitive%%
          %%CALLBACKCHANNELPARAM methodChannel:struct%%
          await __className__.onAllocated($__className__(call.arguments['__parameterName__'])),
          %%CALLBACKCHANNELPARAM methodChannel:struct%%
          %%CALLBACKCHANNELPARAM methodChannel:supported%%
          call.arguments['__parameterName__'],
          %%CALLBACKCHANNELPARAM methodChannel:supported%%
          %%CALLBACKCHANNELPARAMS%%
        );
        break;
      %%CALLBACK%%
      %%CALLBACKS%%
    }
    throw UnimplementedError('No implementation for ${call.method}.');
  }

  %%CONSTRUCTORS%%
  %%CONSTRUCTOR%%
  MethodCall $__className____dartConstructorName__(
  %%PARAMETERS%%
  %%PARAMETERS%%
  ) {
    return MethodCall(
      '__platformClassName__(__constructorName__)',
      <String, dynamic>{r'$uniqueId': uniqueId,
       %%METHODCALLPARAMS%%
       %%METHODCALLPARAMS%%
      },
    );
  }
  %%CONSTRUCTOR%%
  %%CONSTRUCTORS%%

  %%FIELDS%%
  %%FIELD%%
  static MethodCall $__fieldName__({
    %%PARAMETERS%%
    %%PARAMETERS%%
    String $newUniqueId,
  }) {
    return MethodCall(
      '__platformClassName__.__fieldName__',
      <String, dynamic>{
        r'$uniqueId': uniqueId,
        r'$newUniqueId': $newUniqueId,
        if (__fieldName__ != null)
        %%METHODCALLPARAMS%%
        %%METHODCALLPARAMS%%
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
  __parameterType__ __parameterName__,
  %%PARAMETER methodChannel:wrapper%%
  %%PARAMETER methodChannel:struct%%
  __parameterType__ __parameterName__,
  %%PARAMETER methodChannel:struct%%
  %%PARAMETER methodChannel:primitive%%
  __parameterType__ __parameterName__,
  %%PARAMETER methodChannel:primitive%%
  %%PARAMETER methodChannel:typeParameter%%
  __parameterType__ __parameterName__,
  %%PARAMETER methodChannel:typeParameter%%
  %%PARAMETERS%%
  [String $newUniqueId,]
  ) {
    return MethodCall(
      '__platformClassName__#__methodName__',
       <String, dynamic>{r'$uniqueId': uniqueId,
       r'$newUniqueId': $newUniqueId,
       r'$returnTypeIsWrapper': isTypeOf<__returnType__, Wrapper>(),
       r'$returnTypePlatformName': isTypeOf<__returnType__, Wrapper>() ? _GenericHelper.getWrapperForType<__returnType__>('').platformClassName : null,
       %%METHODCALLPARAMS%%
       %%METHODCALLPARAM methodChannel:supported%%
       '__parameterName__': __parameterName__,
       %%METHODCALLPARAM methodChannel:supported%%
       %%METHODCALLPARAM methodChannel:wrapper%%
       '__parameterName__': (__parameterName__ as Wrapper)?.uniqueId,
       %%METHODCALLPARAM methodChannel:wrapper%%
       %%METHODCALLPARAM methodChannel:struct%%
       '__parameterName__': (__parameterName__ as Wrapper)?.uniqueId,
       %%METHODCALLPARAM methodChannel:struct%%
       %%METHODCALLPARAM methodChannel:primitive%%
       '__parameterName__': __parameterName__,
       %%METHODCALLPARAM methodChannel:primitive%%
       %%METHODCALLPARAM methodChannel:typeParameter%%
       r'__parameterName__$isWrapper':  __parameterName__ is Wrapper,
       '__parameterName__': __parameterName__ is Wrapper ? (__parameterName__ as Wrapper)?.uniqueId : __parameterName__,
       %%METHODCALLPARAM methodChannel:typeParameter%%
       %%METHODCALLPARAMS%%
       },
    );
  }
  %%METHOD%%
  %%METHODS%%
}
%%CLASS%%
%%CLASSES%%

class _GenericHelper {
  _GenericHelper._();
  
  static Wrapper getWrapperForType<T>(String uniqueId) {
    assert(isTypeOf<T, Wrapper>());
    
    %%GENERICTYPEHELPERS%%
    %%GENERICTYPEHELPER%%
    if (isTypeOf<T, __className__>()) {
      return $__className__(uniqueId);
    }
    %%GENERICTYPEHELPER%%
    %%GENERICTYPEHELPERS%%
    
    throw UnsupportedError('Could not instantiate class ${T.toString()}');
  }

  static FutureOr<dynamic> onAllocated(Wrapper wrapper) {
    %%GENERICCREATIONHELPERS%%
    %%GENERICCREATIONHELPER%%
    if (wrapper is $__className__) {
      return __className__.onAllocated(wrapper as $__className__);
    }
    %%GENERICCREATIONHELPER%%
    %%GENERICCREATIONHELPERS%%

    throw UnsupportedError('Could not instantiate class ${wrapper.runtimeType}');
  }
}
''');

  static const Template android = Template._(r'''
package __package__;

import android.content.Context;
import android.os.Build;
import android.view.View;
import androidx.annotation.RequiresApi;
import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;
import java.util.UUID;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;
import android.view.ViewGroup;
import android.widget.FrameLayout;
%%IMPORTS%%
%%IMPORT%%
import __classPackage__.__platformClassName__;
%%IMPORT%%
%%IMPORTS%%

public class ChannelGenerated {
  public final PlatformViewFactory viewFactory = new ViewFactoryImpl();
  public final WrapperManager wrapperManager = new WrapperManager();
  public final MethodCallHandler methodCallHandler = new MethodCallHandlerImpl();
  public final MethodChannel callbackChannel;
  
  public ChannelGenerated(MethodChannel callbackChannel) {
    this.callbackChannel = callbackChannel;
  }
  
  private class ViewFactoryImpl extends PlatformViewFactory {
    ViewFactoryImpl() {
      super(StandardMessageCodec.INSTANCE);
    }

    @Override
    public PlatformView create(final Context context, int viewId, final Object args) {
      final FrameLayout frameLayout = new FrameLayout(context);
      
      final $Context contextWrapper = new $Context(wrapperManager, UUID.randomUUID().toString(), context);

      final HashMap<String, Object> arguments = new HashMap<>();
      arguments.put("context", contextWrapper.$uniqueId);
      arguments.put("$uniqueId", args);
      
      callbackChannel.invokeMethod("CreateView", arguments, new Result() {
        @Override
        public void success(Object result) {
          try {
            wrapperManager.addTemporaryWrapper(contextWrapper);

            final MethodCallHandlerImpl handlerImpl = (MethodCallHandlerImpl) methodCallHandler;
            handlerImpl.onMethodCall(new MethodCall("MultiInvoke", result));

            final View view = wrapperManager.getWrapper((String) args).getView();
            frameLayout.addView(view,
                new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
          } catch (Exception exception) {
            exception.printStackTrace();
          } finally {
            wrapperManager.clearTemporaryWrappers();
          }
        }

        @Override
        public void error(String errorCode, String errorMessage, Object errorDetails) {
          throw new RuntimeException(errorMessage);
        }

        @Override
        public void notImplemented() {
          throw new RuntimeException("notImplemented");
        }
      });

      return new PlatformView() {
        @Override
        public View getView() {
          return frameLayout;
        }

        @Override
        public void dispose() {
          // Do nothing
        }
      };
    }
  }
  
  private class MethodCallHandlerImpl implements MethodCallHandler {
    private MethodCallHandlerImpl() {}
    
    @Override
    public void onMethodCall(MethodCall call, Result result) {
      try {
        final Object value = onMethodCall(call);
        result.success(value);
      } catch (Exception exception) {
        result.error(exception.getClass().getSimpleName(), exception.getMessage(), android.util.Log.getStackTraceString(exception));
      } finally {
        wrapperManager.clearTemporaryWrappers();
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
        case "__wrapperName__(__constructorName__)": {
            if (Build.VERSION.SDK_INT >= __api__) {
              new $__wrapperName__(this, wrapperManager, callbackChannel, call);
              return null;
            } else {
              throw new UnsupportedOperationException("This operation requires api __api__ and above");
            }
          }
        %%STATICREDIRECT classMember:constructor%%
        %%STATICREDIRECT classMember:method%%
        case "__wrapperName__#__methodName__": {
            return $__wrapperName__.onStaticMethodCall(wrapperManager, call);
          }
        %%STATICREDIRECT classMember:method%%
        %%STATICREDIRECT classMember:field%%
        case "__wrapperName__.__fieldName__": {
            return $__wrapperName__.onStaticMethodCall(wrapperManager, call);
          }
        %%STATICREDIRECT classMember:field%%
        %%STATICREDIRECTS%%
        default:
          final String $uniqueId = call.argument("$uniqueId");
          if ($uniqueId == null) throw new NoUniqueIdException(call.method);
          return wrapperManager.getWrapper($uniqueId).onMethodCall(wrapperManager, call);
      }
    }
  }

  private static abstract class Wrapper implements PlatformView {
    final String $uniqueId;
    
    private Wrapper(String uniqueId) {
      this.$uniqueId = uniqueId;
    }

    abstract Object onMethodCall(WrapperManager wrapperManager, MethodCall call) throws Exception;
    abstract Object $getValue();

    void allocate(WrapperManager wrapperManager) {
      wrapperManager.addAllocatedWrapper(this);
    }

    void deallocate(WrapperManager wrapperManager) {
      wrapperManager.removeAllocatedWrapper($uniqueId);
    }
    
    @Override
    public View getView() {
      return (View) $getValue();
    }

    @Override
    public void dispose() {
      // Do nothing
    }
  }
  
  public class WrapperManager {
    private final HashMap<String, Wrapper> allocatedWrappers = new HashMap<>();
    private final HashMap<String, Wrapper> temporaryWrappers = new HashMap<>();

    private WrapperManager() {
      // Do nothing
    }
    
    public void addAllocatedWrapper(final Wrapper wrapper) {
      addWrapper(wrapper, allocatedWrappers);
    }

    public void removeAllocatedWrapper(String uniqueId) {
      allocatedWrappers.remove(uniqueId);
    }

    private void addTemporaryWrapper(final Wrapper wrapper) {
      addWrapper(wrapper, temporaryWrappers);
    }

    private void addWrapper(final Wrapper wrapper, HashMap<String, Wrapper> wrapperMap) {
      final Wrapper existingWrapper;
      try {
        existingWrapper = getWrapper(wrapper.$uniqueId);
      } catch (WrapperNotFoundException exception) {
        wrapperMap.put(wrapper.$uniqueId, wrapper);
        return;
      }

      if (existingWrapper.$getValue() != wrapper.$getValue()) {
        final String message = String.format("Object for uniqueId already exists: %s", wrapper.$uniqueId);
        throw new IllegalArgumentException(message);
      }
      
      if (!wrapperMap.containsKey(wrapper.$uniqueId)) wrapperMap.put(wrapper.$uniqueId, wrapper);
    }

    private Wrapper getWrapper(String uniqueId) throws WrapperNotFoundException {
      if (allocatedWrappers.containsKey(uniqueId)) return allocatedWrappers.get(uniqueId);
      if (temporaryWrappers.containsKey(uniqueId)) return temporaryWrappers.get(uniqueId);
      throw new WrapperNotFoundException(uniqueId);
    }
    
    private void clearTemporaryWrappers() {
      temporaryWrappers.clear();
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
      super(String.format("Could not find Wrapper with uniqueId %s.", uniqueId));
    }
  }

  %%CLASSES%%
  %%CLASS%%
  @RequiresApi(api = __api__)
  public static class $__wrapperName__ extends Wrapper {
    private final __platformClassName__ $value;

    public $__wrapperName__(final WrapperManager wrapperManager, final String uniqueId, final __platformClassName__ value) {
      super(uniqueId);
      this.$value = value;
      wrapperManager.addTemporaryWrapper(this);
    }

    private $__wrapperName__(final MethodCallHandlerImpl methodCallHandler, final WrapperManager wrapperManager, final MethodChannel callbackChannel, final MethodCall call) throws Exception {
      super((String) call.argument("$uniqueId"));
      switch(call.method) {
        %%CONSTRUCTORS%%
        %%CONSTRUCTOR%%
        case "__wrapperName__(__constructorName__)":
          this.$value = new __platformClassName__(
          %%PARAMETERS%%
          %%PARAMETERS%%
          ) {
            %%CALLBACKS%%
            %%CALLBACK%%
            @Override
            public void __methodName__(
            %%CALLBACKPARAMS%%
            %%CALLBACKPARAM%%
            __parameterType__ $__parameterName__
            %%CALLBACKPARAM%%
            %%CALLBACKPARAMS%%
            ) {
              final HashMap<String, Object> arguments = new HashMap<>();
              arguments.put("$uniqueId", $uniqueId);

              %%CALLBACKCHANNELPARAMS%%
              %%CALLBACKCHANNELPARAM methodChannel:wrapper%%
              final String $$__parameterName__Id = UUID.randomUUID().toString();
              wrapperManager.addAllocatedWrapper(new $__wrapperName__(wrapperManager, $$__parameterName__Id, $__parameterName__));
              arguments.put("__parameterName__", $$__parameterName__Id);
              %%CALLBACKCHANNELPARAM methodChannel:wrapper%%
              %%CALLBACKCHANNELPARAM methodChannel:supported%%
              arguments.put("__parameterName__", $__parameterName__);
              %%CALLBACKCHANNELPARAM methodChannel:supported%%
              %%CALLBACKCHANNELPARAM methodChannel:primitive%%
              arguments.put("__parameterName__", $__parameterName__);
              %%CALLBACKCHANNELPARAM methodChannel:primitive%%
              %%CALLBACKCHANNELPARAMS%%
              
              callbackChannel.invokeMethod("__wrapperName__#__methodName__", arguments);  
            }
            %%CALLBACK%%
            %%CALLBACKS%%
          };
          break; 
        %%CONSTRUCTOR%%
        %%CONSTRUCTORS%%
        default:
          this.$value = null;
      }
      wrapperManager.addTemporaryWrapper(this);
    }
    
    static Object onStaticMethodCall(WrapperManager wrapperManager, MethodCall call) throws Exception {
      switch(call.method) {
        %%STATICMETHODCALLS%%
        %%STATICMETHODCALL classMember:method%%
        case "__wrapperName__#__methodName__": {
            return $__wrapperName__.__methodName__(wrapperManager, call);
          }
        %%STATICMETHODCALL classMember:method%%
        %%STATICMETHODCALL classMember:field%%
        case "__wrapperName__.__fieldName__": {
            return $__wrapperName__.__fieldName__(wrapperManager, call);
          }
        %%STATICMETHODCALL classMember:field%%
        %%STATICMETHODCALLS%%
        default:
          throw new NotImplementedException(call.method);
      }
    }

    @Override
    public Object onMethodCall(WrapperManager wrapperManager, MethodCall call) throws Exception {
      switch(call.method) {
        case "__platformClassName__#allocate":
          allocate(wrapperManager);
          return null;
        case "__platformClassName__#deallocate":
          deallocate(wrapperManager);
          return null;
        %%METHODCALLS%%
        %%METHODCALL classMember:method%%
        case "__wrapperName__#__methodName__":
          return __methodName__(wrapperManager, call);
        %%METHODCALL classMember:method%%
        %%METHODCALL classMember:field%%
        case "__wrapperName__.__fieldName__":
          return __fieldName__(wrapperManager, call);
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
    static private Object __fieldName__(WrapperManager wrapperManager, MethodCall call) throws Exception {
      if (((HashMap<String, Object>) call.arguments).containsKey("__fieldName__")) {
         __methodCallerName__.__fieldName__ =
         %%PARAMETERS%%
         %%PARAMETERS%%
        ;
      }
      
      %%PREMETHODCALLS%%
      %%PREMETHODCALLS%%
      
      __methodCallerName__.__fieldName__
      
      %%POSTMETHODCALLS%%
      %%POSTMETHODCALLS%%
    }
    %%FIELD%%
    %%FIELDS%%

    %%METHODS%%
    %%METHOD%%
    static Object __methodName__(WrapperManager wrapperManager, MethodCall call) throws Exception {
      %%PREMETHODCALLS%%
      %%PREMETHODCALL methodChannel:void%%
      %%PREMETHODCALL methodChannel:void%%
      %%PREMETHODCALL methodChannel:supported%%
      return
      %%PREMETHODCALL methodChannel:supported%%
      %%PREMETHODCALL methodChannel:primitive%%
      return
      %%PREMETHODCALL methodChannel:primitive%%
      %%PREMETHODCALL methodChannel:wrapper%%
      new $__returnType__(wrapperManager, (String) call.argument("$newUniqueId"),
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
      %%PARAMETER methodChannel:primitive%%
      call.argument("__parameterName__") != null ? ((__parameterType__) call.argument("__parameterName__")).__primitiveConvertMethod__() : null
      %%PARAMETER methodChannel:primitive%%
      %%PARAMETER methodChannel:wrapper%%
      call.argument("__parameterName__") != null ? (__parameterType__) wrapperManager.getWrapper((String) call.argument("__parameterName__")).$getValue() : null
      %%PARAMETER methodChannel:wrapper%%
      %%PARAMETER methodChannel:typeParameter%%
      call.argument("__parameterName__$isWrapper") ? (call.argument("__parameterName__") != null ? wrapperManager.getWrapper((String) call.argument("__parameterName__")).$getValue() : null) : call.argument("__parameterName__")
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
      %%POSTMETHODCALL methodChannel:primitive%%
      ;
      %%POSTMETHODCALL methodChannel:primitive%%
      %%POSTMETHODCALL methodChannel:wrapper%%
      );
      return null;
      %%POSTMETHODCALL methodChannel:wrapper%%
      %%POSTMETHODCALL methodChannel:typeParameter%%
      ;
      if (!(Boolean)call.argument("$returnTypeIsWrapper")) return result;
      final Class wrapperClass = Class.forName(String.format("__package__.ChannelGenerated$$%s", (String) call.argument("$returnTypePlatformName")));
      final Constructor constructor = wrapperClass.getConstructor(WrapperManager.class, String.class, result.getClass());
      constructor.newInstance(wrapperManager, call.argument("$newUniqueId"), result);
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

  static final Block imports = Block('IMPORTS');
  static final Block import = Block('IMPORT');

  static final Block classes = Block('CLASSES');
  static final Block aClass = Block('CLASS');

  static final Block constructors = Block('CONSTRUCTORS');
  static final Block constructor = Block('CONSTRUCTOR');

  static final Block staticRedirects = Block('STATICREDIRECTS');

  static final Block parameters = Block('PARAMETERS');
  static final Block parameter = Block('PARAMETER');

  static final Block callback = Block('CALLBACK');
  static final Block callbacks = Block('CALLBACKS');

  static final Block fields = Block('FIELDS');
  static final Block field = Block('FIELD');

  static final Block callbackParams = Block('CALLBACKPARAMS');
  static final Block callbackParam = Block('CALLBACKPARAM');

  static final Block structs = Block('STRUCTS');
  static final Block struct = Block('STRUCT');

  static Block callbackSwizzles = Block('CALLBACKSWIZZLES');
  static Block callbackSwizzle = Block('CALLBACKSWIZZLE');

  static Block genericTypeHelpers = Block('GENERICTYPEHELPERS');
  static Block genericTypeHelper = Block('GENERICTYPEHELPER');

  static Block genericCreationHelpers = Block('GENERICCREATIONHELPERS');
  static Block genericCreationHelper = Block('GENERICCREATIONHELPER');
}

class MethodChannelBlock extends Block {
  MethodChannelBlock(
    String identifier, {
    MethodChannelType methodChannel,
    ClassMemberType classMember,
    Structure structure,
  }) : super(identifier, createConfig(methodChannel, classMember, structure));

  static String createConfig(
    MethodChannelType methodChannel,
    ClassMemberType classMember,
    Structure structure,
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
      case MethodChannelType.primitive:
        configs.add('methodChannel:primitive');
        break;
      case MethodChannelType.struct:
        configs.add('methodChannel:struct');
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

    switch (structure) {
      case Structure.$class:
        configs.add('structure:class');
        break;
      case Structure.struct:
        configs.add('structure:struct');
        break;
      case Structure.protocol:
        configs.add('structure:protocol');
        break;
    }

    return configs.join(' ');
  }

  static final MethodChannelBlock methodCallParams =
      MethodChannelBlock('METHODCALLPARAMS');
  static MethodChannelBlock methodCallParam(MethodChannelType methodChannel) =>
      MethodChannelBlock('METHODCALLPARAM', methodChannel: methodChannel);

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

  static MethodChannelBlock postMethodCall(MethodChannelType methodChannel) =>
      MethodChannelBlock('POSTMETHODCALL', methodChannel: methodChannel);

  static MethodChannelBlock preMethodCall(MethodChannelType methodChannel) =>
      MethodChannelBlock('PREMETHODCALL', methodChannel: methodChannel);

  static MethodChannelBlock callbackChannelParam(
          MethodChannelType methodChannel) =>
      MethodChannelBlock('CALLBACKCHANNELPARAM', methodChannel: methodChannel);

  static MethodChannelBlock callbackChannelParams() =>
      MethodChannelBlock('CALLBACKCHANNELPARAMS');

  static MethodChannelBlock valueType(Structure structure) =>
      MethodChannelBlock('VALUETYPE', structure: structure);

  static MethodChannelBlock valueTypes() => MethodChannelBlock('VALUETYPES');
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
  static final Replacement primitiveConvertMethod =
      Replacement('__primitiveConvertMethod__');
  static final Replacement wrapperName = Replacement('__wrapperName__');
  static final Replacement api = Replacement('__api__');
  static final Replacement constructorName = Replacement('__constructorName__');
  static final Replacement dartConstructorName =
      Replacement('__dartConstructorName__');
  static final Replacement constructorSignature =
      Replacement('__constructorSignature__');
  static final Replacement platformViewClass =
      Replacement('__platformViewClass__');
  static final Replacement platformViewVariable =
      Replacement('__platformViewVariable__');
  static final Replacement implementationName =
      Replacement('__implementationName__');
  static final Replacement filename = Replacement('__filename__');
  static final Replacement wrapperInterface =
      Replacement('__wrapperInterface__');
}
