#import "$TemplateReferencePairManager.h"

@implementation ClassTemplate
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

- (REFClass *)referenceClass {
  return [REFClass fromClass:[ClassTemplate class]];
}
@end

@implementation _LocalHandler
-(ClassTemplate *)createClassTemplate:(REFReferencePairManager *)manager fieldTemplate:(NSNumber *)fieldTemplate {
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
  if (referenceClass == [ClassTemplate class]) {
    return [self createClassTemplate:referencePairManager fieldTemplate:arguments[0]];
  }
  
  return nil;
}

- (id _Nullable)invokeStaticMethod:(nonnull REFReferencePairManager *)referencePairManager
                    referenceClass:(nonnull Class)referenceClass
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray<id> *)arguments {
  if (referenceClass == ClassTemplate.class) {
    if ([methodName isEqualToString:@"staticMethodTemplate"]) {
      return [self classTemplate_staticMethodTemplate:referencePairManager parameterTemplate:arguments[0]];
    }
  }
  @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:nil userInfo:nil];
}

- (id _Nullable)invokeMethod:(nonnull REFReferencePairManager *)referencePairManager
              localReference:(nonnull id<REFLocalReference>)localReference
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray<id> *)arguments {
  if (localReference.referenceClass.clazz == [ClassTemplate class]) {
    if ([methodName  isEqualToString: @"methodTemplate"]) {
      ClassTemplate *classTemplate = localReference;
      return [classTemplate methodTemplate:arguments[0]];
    }
  }
  
  return nil;
}
@end

@implementation _RemoteHandler
-(instancetype)initWithChannelName:(NSString *)channelName binaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger {
  return self = [super initWithChannelName:channelName binaryMessenger:binaryMessenger];
}

- (NSArray<id> *)getCreationArguments:(id<REFLocalReference>)localReference {
  if (localReference.referenceClass.clazz == [ClassTemplate class]) {
    ClassTemplate *classTemplate = localReference;
    return @[classTemplate.fieldTemplate];
  }
  
  return nil;
}
@end

@implementation _TemplateReferencePairManager
-(instancetype)initWithChannelName:(NSString *)channelName binaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger {
  return self = [super initWithSupportedClasses:@[[REFClass fromClass:[ClassTemplate class]]]
                                binaryMessenger:binaryMessenger
                                    channelName:channelName];
}

- (id<REFRemoteReferenceCommunicationHandler>)remoteHandler {
  return [[_RemoteHandler alloc] initWithChannelName:self.channelName binaryMessenger:self.binaryMessenger];
}
@end
