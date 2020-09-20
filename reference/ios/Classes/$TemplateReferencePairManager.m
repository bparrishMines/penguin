#import "$TemplateReferencePairManager.h"

typedef id<REFLocalReference> (^_LocalCreatorHandler)(_LocalHandler *_Nonnull,
                                                      REFReferencePairManager *_Nonnull,
                                                      NSArray<id> *_Nonnull);

typedef id (^_LocalStaticMethodHandler)(_LocalHandler *_Nonnull,
                                        REFReferencePairManager *_Nonnull,
                                        NSArray<id> *_Nonnull);

typedef id (^_LocalMethodHandler)(id<REFLocalReference> _Nonnull localReference, NSArray<id> *_Nonnull);

typedef NSArray<id>* (^_CreationArgumentsHandler)(id<REFLocalReference> _Nonnull localReference);

static NSDictionary<REFClass *, _LocalCreatorHandler> *creators = nil;
static NSDictionary<REFClass *, NSDictionary<NSString *, _LocalStaticMethodHandler>*> *staticMethods = nil;
static NSDictionary<REFClass *, NSDictionary<NSString *, _LocalMethodHandler>*> *methods = nil;
static NSDictionary<REFClass *, _CreationArgumentsHandler> *creationArguments = nil;

@implementation _ClassTemplate
+(NSNumber *_Nullable)staticMethodTemplate:(NSString *)parameterTemplate {
  NSString *message = [NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
  @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                 reason:message
                               userInfo:nil];
}

-(NSNumber *)fieldTemplate {
  NSString *message = [NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
  @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                 reason:message
                               userInfo:nil];
}

-(NSString *_Nullable)methodTemplate:(NSString *)parameterTemplate {
  NSString *message = [NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
  @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                 reason:message
                               userInfo:nil];
}

+(void)_staticMethodTemplate:(_TemplateReferencePairManager *)manager
           parameterTemplate:(NSString *_Nullable)parameterTemplate
                  completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [manager invokeRemoteStaticMethod:[_ClassTemplate class]
                         methodName:@"staticMethodTemplate"
                          arguments:@[parameterTemplate]
                         completion:completion];
}

-(void)_methodTemplate:(_TemplateReferencePairManager *)manager
     parameterTemplate:(NSString *_Nullable)parameterTemplate
            completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  if (![manager getPairedRemoteReference:self]) {
    [manager invokeRemoteMethodOnUnpairedReference:self
                                        methodName:@"methodTemplate"
                                         arguments:@[parameterTemplate]
                                        completion:completion];
  }
  
  [manager invokeRemoteMethod:[manager getPairedRemoteReference:self]
                   methodName:@"methodTemplate"
                    arguments:@[parameterTemplate]
                   completion:completion];
}

- (REFClass *)referenceClass {
  return [REFClass fromClass:[_ClassTemplate class]];
}
@end

@implementation _LocalHandler
-(instancetype)init {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    creators = @{
      [REFClass fromClass:_ClassTemplate.class]: ^(_LocalHandler *localHandler,
                                                   REFReferencePairManager *manager, NSArray<id> *arguments) {
        return [localHandler createClassTemplate:manager fieldTemplate:arguments[0]];
      },
    };
    staticMethods = @{
      [REFClass fromClass:_ClassTemplate.class]: @{@"staticMethodTemplate": ^(_LocalHandler *localHandler,
                                                                              REFReferencePairManager *manager, NSArray<id> *arguments) {
        return [localHandler classTemplate_staticMethodTemplate:manager parameterTemplate:arguments[0]];
      },},
    };
    methods = @{
      [REFClass fromClass:_ClassTemplate.class]: @{@"methodTemplate": ^(id<REFLocalReference> localReference,
                                                                        NSArray<id> *arguments) {
        _ClassTemplate *value = localReference;
        return [value methodTemplate:arguments[0]];
      },},
    };
  });
  return [super init];
}

-(_ClassTemplate *)createClassTemplate:(REFReferencePairManager *)manager fieldTemplate:(NSNumber *)fieldTemplate {
  NSString *message = [NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
  @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                 reason:message
                               userInfo:nil];
}

-(id _Nullable)classTemplate_staticMethodTemplate:(REFReferencePairManager *)manager
                                parameterTemplate:(NSString *)parameterTemplate {
  NSString *message = [NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
  @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                 reason:message
                               userInfo:nil];
}

- (nonnull id<REFLocalReference>)create:(nonnull REFReferencePairManager *)referencePairManager
                         referenceClass:(nonnull Class)referenceClass
                              arguments:(nonnull NSArray<id> *)arguments {
  return creators[[REFClass fromClass:referenceClass]](self, referencePairManager, arguments);
}

- (id _Nullable)invokeStaticMethod:(nonnull REFReferencePairManager *)referencePairManager
                    referenceClass:(nonnull Class)referenceClass
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray<id> *)arguments {
  return staticMethods[[REFClass fromClass:referenceClass]][methodName](self, referencePairManager, arguments);
}

- (id _Nullable)invokeMethod:(nonnull REFReferencePairManager *)referencePairManager
              localReference:(nonnull id<REFLocalReference>)localReference
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray<id> *)arguments {
  _LocalMethodHandler handler = methods[localReference.referenceClass][methodName];
  if (handler) return handler(localReference, arguments);
  
  // Based on inheritance.
  if ([localReference isKindOfClass:_ClassTemplate.class]) {
    if ([@"methodTemplate" isEqualToString:methodName]) {
      _ClassTemplate *value = localReference;
      return [value methodTemplate:arguments[0]];
    }
  }
  
  NSString *reason = [NSString stringWithFormat:@"Unable to invoke method `%@` on (localReference): %@",
                      methodName, localReference.description];
  @throw [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
}
@end

@implementation _RemoteHandler
-(instancetype)initWithChannelName:(NSString *)channelName binaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    creationArguments = @{
      [REFClass fromClass:_ClassTemplate.class]: ^(id<REFLocalReference> localReference) {
        _ClassTemplate *value = localReference;
        return @[value.fieldTemplate];
      },
    };
  });
  return self = [super initWithChannelName:channelName binaryMessenger:binaryMessenger];
}

- (NSArray<id> *)getCreationArguments:(id<REFLocalReference>)localReference {
  return creationArguments[localReference.referenceClass](localReference);
}
@end

@implementation _TemplateReferencePairManager
-(instancetype)initWithChannelName:(NSString *)channelName binaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger {
  return self = [super initWithSupportedClasses:@[[REFClass fromClass:[_ClassTemplate class]]]
                                binaryMessenger:binaryMessenger
                                    channelName:channelName];
}

- (id<REFRemoteReferenceCommunicationHandler>)remoteHandler {
  return [[_RemoteHandler alloc] initWithChannelName:self.channelName binaryMessenger:self.binaryMessenger];
}
@end
