#import "REFLibraryTemplate_Internal.h"

typedef id<REFLocalReference> (^_LocalCreatorHandler)(_p_LocalHandler *_Nonnull,
                                                      REFReferencePairManager *_Nonnull,
                                                      NSArray<id> *_Nonnull);

typedef id (^_LocalStaticMethodHandler)(_p_LocalHandler *_Nonnull, REFReferencePairManager *_Nonnull,
                                        NSArray<id> *_Nonnull);

typedef id (^_LocalMethodHandler)(id<REFLocalReference> _Nonnull localReference,
                                  NSArray<id> *_Nonnull);

typedef NSArray<id> * (^_CreationArgumentsHandler)(id<REFLocalReference> _Nonnull localReference);

@implementation _p_ClassTemplate
- (NSNumber *)fieldTemplate {
  NSString *message = [NSString
      stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
  @throw
      [NSException exceptionWithName:NSInternalInconsistencyException reason:message userInfo:nil];
}

- (NSString *_Nullable)methodTemplate:(NSString *_Nullable)parameterTemplate {
  NSString *message = [NSString
      stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
  @throw
      [NSException exceptionWithName:NSInternalInconsistencyException reason:message userInfo:nil];
}

+ (void)_staticMethodTemplate:(_p_ReferencePairManager *)manager
            parameterTemplate:(NSString *_Nullable)parameterTemplate
                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [manager invokeRemoteStaticMethod:[_p_ClassTemplate class]
                         methodName:@"staticMethodTemplate"
                          arguments:@[ parameterTemplate ]
                         completion:completion];
}

- (void)_methodTemplate:(_p_ReferencePairManager *)manager
      parameterTemplate:(NSString *_Nullable)parameterTemplate
             completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  if (![manager getPairedRemoteReference:self]) {
    [manager invokeRemoteMethodOnUnpairedReference:self
                                        methodName:@"methodTemplate"
                                         arguments:@[ parameterTemplate ]
                                        completion:completion];
  }

  [manager invokeRemoteMethod:[manager getPairedRemoteReference:self]
                   methodName:@"methodTemplate"
                    arguments:@[ parameterTemplate ]
                   completion:completion];
}

- (REFClass *)referenceClass {
  return [REFClass fromClass:[_p_ClassTemplate class]];
}
@end

@implementation _p_ClassTemplateCreationArgs
@end

@implementation _p_ReferencePairManager
- (instancetype)initWithChannelName:(NSString *)channelName
                    binaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger {
  return self = [super initWithSupportedClasses:@[ [REFClass fromClass:[_p_ClassTemplate class]] ]
                                binaryMessenger:binaryMessenger
                                    channelName:channelName];
}

- (id<REFRemoteReferenceCommunicationHandler>)remoteHandler {
  return [[_p_RemoteHandler alloc] initWithChannelName:self.channelName
                                     binaryMessenger:self.binaryMessenger];
}
@end

static NSDictionary<REFClass *, _LocalCreatorHandler> *creators = nil;
static NSDictionary<REFClass *, NSDictionary<NSString *, _LocalStaticMethodHandler> *>
    *staticMethods = nil;
static NSDictionary<REFClass *, NSDictionary<NSString *, _LocalMethodHandler> *> *methods = nil;

@implementation _p_LocalHandler
- (instancetype)init {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    creators = @{[REFClass fromClass:_p_ClassTemplate.class] : ^(
        _p_LocalHandler *localHandler, REFReferencePairManager *manager, NSArray<id> *arguments) {
        _p_ClassTemplateCreationArgs *args = [[_p_ClassTemplateCreationArgs alloc] init];
        args.fieldTemplate = arguments[0];
        return [localHandler createClassTemplate:manager args:args];
      }
    };
    staticMethods =
      @{[REFClass fromClass:_p_ClassTemplate.class] : @{@"staticMethodTemplate" : ^(
          _p_LocalHandler *localHandler, REFReferencePairManager *manager, NSArray<id> *arguments) {
          return [localHandler classTemplate_staticMethodTemplate:manager
                                              parameterTemplate:arguments[0]];
          }
        }
      };
    methods =
      @{[REFClass fromClass:_p_ClassTemplate.class] :
          @{@"methodTemplate" : ^(id<REFLocalReference> localReference, NSArray<id> *arguments) {
              _p_ClassTemplate *value = localReference;
              return [value methodTemplate:arguments[0]];
            }
          }
      };
  });
  return [super init];
}

- (_p_ClassTemplate *)createClassTemplate:(REFReferencePairManager *)manager
                                     args:(_p_ClassTemplateCreationArgs *)args {
  NSString *message = [NSString
      stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
  @throw
      [NSException exceptionWithName:NSInternalInconsistencyException reason:message userInfo:nil];
}

- (id _Nullable)classTemplate_staticMethodTemplate:(REFReferencePairManager *)manager
                                 parameterTemplate:(NSString *_Nullable)parameterTemplate {
  NSString *message = [NSString
      stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
  @throw
      [NSException exceptionWithName:NSInternalInconsistencyException reason:message userInfo:nil];
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
  return staticMethods[[REFClass fromClass:referenceClass]][methodName](self, referencePairManager,
                                                                        arguments);
}

- (id _Nullable)invokeMethod:(nonnull REFReferencePairManager *)referencePairManager
              localReference:(nonnull id<REFLocalReference>)localReference
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray<id> *)arguments {
  _LocalMethodHandler handler = methods[localReference.referenceClass][methodName];
  if (handler) return handler(localReference, arguments);

  // Based on inheritance.
  if ([localReference isKindOfClass:_p_ClassTemplate.class]) {
    if ([@"methodTemplate" isEqualToString:methodName]) {
      _p_ClassTemplate *value = localReference;
      return [value methodTemplate:arguments[0]];
    }
  }

  NSString *reason =
      [NSString stringWithFormat:@"Unable to invoke method `%@` on (localReference): %@",
                                 methodName, localReference.description];
  @throw [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
}
@end

static NSDictionary<REFClass *, _CreationArgumentsHandler> *creationArguments = nil;

@implementation _p_RemoteHandler
- (instancetype)initWithChannelName:(NSString *)channelName
                    binaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    creationArguments =
        @{[REFClass fromClass:_p_ClassTemplate.class] : ^(id<REFLocalReference> localReference) {
            _p_ClassTemplate *value = localReference;
            return @[ value.fieldTemplate ];
          }
        };
  });
  return self = [super initWithChannelName:channelName binaryMessenger:binaryMessenger];
}

- (NSArray<id> *)getCreationArguments:(id<REFLocalReference>)localReference {
  return creationArguments[localReference.referenceClass](localReference);
}
@end
