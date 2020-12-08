// GENERATED CODE - DO NOT MODIFY BY HAND

#import "REFLibraryTemplate_Internal.h"

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

@implementation _p_ClassTemplateCreationArgs
@end

@implementation _p_ClassTemplateChannel
- (instancetype)initWithManager:(REFReferenceChannelManager *)manager {
  return self = [super initWithManager:manager channelName:@"github.penguin/template/template/ClassTemplate"];
}

- (void)invoke_staticMethodTemplate:(NSString *_Nullable)parameterTemplate
                         completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [self invokeStaticMethod:@"staticMethodTemplate" arguments:@[parameterTemplate] completion:completion];
}

- (void)invoke_methodTemplate:(NSObject<_p_ClassTemplate> *)instance
            parameterTemplate:(NSString *_Nullable)parameterTemplate
                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  NSString *_methodName = @"methodTemplate";
  NSArray<id> *_arguments = @[parameterTemplate];
  
  if ([[self manager] isPaired:instance]) {
    [self invokeMethod:instance methodName:_methodName arguments:_arguments completion:completion];
    return;
  }
  
  [self invokeMethodOnUnpairedReference:instance methodName:_methodName arguments:_arguments completion:completion];
}
@end

@implementation _p_ClassTemplateHandler
- (NSObject<_p_ClassTemplate> *)onCreate:(REFReferenceChannelManager *)manager
                                             args:(_p_ClassTemplateCreationArgs *)args {
  return nil;
}

- (NSObject *_Nullable)on_staticMethodTemplate:(REFReferenceChannelManager *)manager
                             parameterTemplate:(NSString *_Nullable)parameterTemplate {
  return nil;
}

- (id _Nullable)invokeStaticMethod:(nonnull REFReferenceChannelManager *)manager
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  if ([@"staticMethodTemplate" isEqualToString:methodName]) {
    return [self on_staticMethodTemplate:manager parameterTemplate:arguments[0]];
  }
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull NSArray *)getCreationArguments:(nonnull REFReferenceChannelManager *)manager
                                 instance:(nonnull NSObject *)instance {
  NSObject<_p_ClassTemplate> *value = (NSObject<_p_ClassTemplate> *) instance;
  return @[value.fieldTemplate];
}

- (nonnull id)createInstance:(nonnull REFReferenceChannelManager *)manager
                   arguments:(nonnull NSArray *)arguments {
  _p_ClassTemplateCreationArgs *args = [[_p_ClassTemplateCreationArgs alloc] init];
  args.fieldTemplate = arguments[0];
  return [self onCreate:manager args:args];
}

- (id _Nullable)invokeMethod:(nonnull REFReferenceChannelManager *)manager
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_p_ClassTemplate> *value = (NSObject<_p_ClassTemplate> *) instance;
  if ([@"methodTemplate" isEqualToString:methodName]) {
    return [value methodTemplate:arguments[0]];
  }
  
  NSLog(@"Unable to invoke method %@", methodName);
  return nil;
}

- (void)onInstanceDisposed:(nonnull REFReferenceChannelManager *)manager
                  instance:(nonnull NSObject *)instance {}
@end

//typedef id<REFLocalReference> (^_LocalCreatorHandler)(_p_LocalHandler *_Nonnull,
//                                                      REFReferencePairManager *_Nonnull,
//                                                      NSArray<id> *_Nonnull);
//
//typedef id (^_LocalStaticMethodHandler)(_p_LocalHandler *_Nonnull,
//                                        REFReferencePairManager *_Nonnull, NSArray<id> *_Nonnull);
//
//typedef id (^_LocalMethodHandler)(id<REFLocalReference> _Nonnull localReference,
//                                  NSArray<id> *_Nonnull);
//
//typedef NSArray<id> * (^_CreationArgumentsHandler)(id<REFLocalReference> _Nonnull localReference);
//
//@implementation _p_ClassTemplate
//- (NSNumber *)fieldTemplate {
//  NSString *message = [NSString
//      stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
//  @throw
//      [NSException exceptionWithName:NSInternalInconsistencyException reason:message userInfo:nil];
//}
//
//- (NSObject *_Nullable)methodTemplate:(NSString *_Nullable)parameterTemplate {
//  NSString *message = [NSString
//      stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
//  @throw
//      [NSException exceptionWithName:NSInternalInconsistencyException reason:message userInfo:nil];
//}
//
//+ (void)_staticMethodTemplate:(_p_ReferencePairManager *)manager
//            parameterTemplate:(NSString *_Nullable)parameterTemplate
//                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
//  [manager invokeRemoteStaticMethod:[_p_ClassTemplate class]
//                         methodName:@"staticMethodTemplate"
//                          arguments:@[ parameterTemplate ]
//                         completion:completion];
//}
//
//- (void)_methodTemplate:(_p_ReferencePairManager *)manager
//      parameterTemplate:(NSString *_Nullable)parameterTemplate
//             completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
//  if (![manager getPairedRemoteReference:self]) {
//    [manager invokeRemoteMethodOnUnpairedReference:self
//                                        methodName:@"methodTemplate"
//                                         arguments:@[ parameterTemplate ]
//                                        completion:completion];
//  }
//
//  [manager invokeRemoteMethod:[manager getPairedRemoteReference:self]
//                   methodName:@"methodTemplate"
//                    arguments:@[ parameterTemplate ]
//                   completion:completion];
//}
//
//- (REFClass *)referenceClass {
//  return [REFClass fromClass:[_p_ClassTemplate class]];
//}
//@end
//
//@implementation _p_ClassTemplateCreationArgs
//@end
//
//@implementation _p_ReferencePairManager
//- (instancetype)initWithChannelName:(NSString *)channelName
//                    binaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger {
//  return self = [super initWithSupportedClasses:@[ [REFClass fromClass:[_p_ClassTemplate class]] ]
//                                binaryMessenger:binaryMessenger
//                                    channelName:channelName];
//}
//
//- (id<REFRemoteReferenceCommunicationHandler>)remoteHandler {
//  return [[_p_RemoteHandler alloc] initWithChannelName:self.channelName
//                                       binaryMessenger:self.binaryMessenger];
//}
//@end
//
//static NSDictionary<REFClass *, _LocalCreatorHandler> *creators = nil;
//static NSDictionary<REFClass *, NSDictionary<NSString *, _LocalStaticMethodHandler> *>
//    *staticMethods = nil;
//static NSDictionary<REFClass *, NSDictionary<NSString *, _LocalMethodHandler> *> *methods = nil;
//
//@implementation _p_LocalHandler
//- (instancetype)init {
//  static dispatch_once_t onceToken;
//  dispatch_once(&onceToken, ^{
//    creators = @{[REFClass fromClass:_p_ClassTemplate.class] : ^(
//        _p_LocalHandler *localHandler, REFReferencePairManager *manager, NSArray<id> *arguments){
//        _p_ClassTemplateCreationArgs *args = [[_p_ClassTemplateCreationArgs alloc] init];
//    args.fieldTemplate = arguments[0];
//    return [localHandler createClassTemplate:manager args:args];
//      }
//};
//staticMethods =
//    @{[REFClass fromClass:_p_ClassTemplate.class] : @{@"staticMethodTemplate" : ^(
//        _p_LocalHandler *localHandler, REFReferencePairManager *manager, NSArray<id> *arguments){
//        return
//        [localHandler classTemplate_staticMethodTemplate:manager parameterTemplate:arguments[0]];
//}
//}
//}
//;
//methods =
//    @{[REFClass fromClass:_p_ClassTemplate.class] :
//          @{@"methodTemplate" : ^(id<REFLocalReference> localReference, NSArray<id> *arguments){
//              _p_ClassTemplate *value = localReference;
//return [value methodTemplate:arguments[0]];
//}
//}
//}
//;
//});
//return [super init];
//}
//
//- (_p_ClassTemplate *)createClassTemplate:(REFReferencePairManager *)manager
//                                     args:(_p_ClassTemplateCreationArgs *)args {
//  NSString *message = [NSString
//      stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
//  @throw
//      [NSException exceptionWithName:NSInternalInconsistencyException reason:message userInfo:nil];
//}
//
//- (id _Nullable)classTemplate_staticMethodTemplate:(REFReferencePairManager *)manager
//                                 parameterTemplate:(NSString *_Nullable)parameterTemplate {
//  NSString *message = [NSString
//      stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
//  @throw
//      [NSException exceptionWithName:NSInternalInconsistencyException reason:message userInfo:nil];
//}
//
//- (nonnull id<REFLocalReference>)create:(nonnull REFReferencePairManager *)referencePairManager
//                         referenceClass:(nonnull Class)referenceClass
//                              arguments:(nonnull NSArray<id> *)arguments {
//  return creators[[REFClass fromClass:referenceClass]](self, referencePairManager, arguments);
//}
//
//- (id _Nullable)invokeStaticMethod:(nonnull REFReferencePairManager *)referencePairManager
//                    referenceClass:(nonnull Class)referenceClass
//                        methodName:(nonnull NSString *)methodName
//                         arguments:(nonnull NSArray<id> *)arguments {
//  return staticMethods[[REFClass fromClass:referenceClass]][methodName](self, referencePairManager,
//                                                                        arguments);
//}
//
//- (id _Nullable)invokeMethod:(nonnull REFReferencePairManager *)referencePairManager
//              localReference:(nonnull id<REFLocalReference>)localReference
//                  methodName:(nonnull NSString *)methodName
//                   arguments:(nonnull NSArray<id> *)arguments {
//  _LocalMethodHandler handler = methods[localReference.referenceClass][methodName];
//  if (handler) return handler(localReference, arguments);
//
//  // Based on inheritance.
//  if ([localReference isKindOfClass:_p_ClassTemplate.class]) {
//    if ([@"methodTemplate" isEqualToString:methodName]) {
//      _p_ClassTemplate *value = localReference;
//      return [value methodTemplate:arguments[0]];
//    }
//  }
//
//  NSString *reason =
//      [NSString stringWithFormat:@"Unable to invoke method `%@` on (localReference): %@",
//                                 methodName, localReference.description];
//  @throw [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
//}
//@end
//
//static NSDictionary<REFClass *, _CreationArgumentsHandler> *creationArguments = nil;
//
//@implementation _p_RemoteHandler
//- (instancetype)initWithChannelName:(NSString *)channelName
//                    binaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger {
//  static dispatch_once_t onceToken;
//  dispatch_once(&onceToken, ^{
//    creationArguments =
//        @{[REFClass fromClass:_p_ClassTemplate.class] : ^(id<REFLocalReference> localReference){
//            _p_ClassTemplate *value = localReference;
//    return @[ value.fieldTemplate ];
//          }
//};
//});
//return self = [super initWithChannelName:channelName binaryMessenger:binaryMessenger];
//}
//
//- (NSArray<id> *)getCreationArguments:(id<REFLocalReference>)localReference {
//  return creationArguments[localReference.referenceClass](localReference);
//}
//@end
