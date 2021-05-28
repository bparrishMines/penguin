// GENERATED CODE - DO NOT MODIFY BY HAND

#import "REFLibraryTemplate.h"

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

@implementation REFClassTemplateChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"github.penguin/template/template/ClassTemplate"];
}

- (void)_create:(NSObject<REFClassTemplate> *)_instance
         _owner:(BOOL)_owner
  fieldTemplate:(NSNumber *)fieldTemplate
     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance arguments:@[fieldTemplate] owner:_owner completion:completion];
}

- (void)_invokeStaticMethodTemplate:(NSString *_Nullable)parameterTemplate
/*following_parameters*/
                         completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [self invokeStaticMethod:@"staticMethodTemplate" arguments:@[parameterTemplate] completion:completion];
}

- (void)_invokeMethodTemplate:(NSObject<REFClassTemplate> *)instance
            parameterTemplate:(NSString *_Nullable)parameterTemplate
                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [self invokeMethod:instance methodName:@"methodTemplate" arguments:@[parameterTemplate] completion:completion];
}
@end

@implementation REFClassTemplateHandler
- (NSObject<REFClassTemplate> *)_create:(REFTypeChannelMessenger *)messenger
                          fieldTemplate:(nonnull NSNumber *)fieldTemplate {
  @throw [NSException exceptionWithName:@"REFUnimplementedException" reason:nil userInfo:nil];
}

- (NSObject *_Nullable)_onStaticMethodTemplate:(REFTypeChannelMessenger *)messenger
                             parameterTemplate:(NSString *_Nullable)parameterTemplate {
  @throw [NSException exceptionWithName:@"REFUnimplementedException" reason:nil userInfo:nil];
}

- (NSObject *)_onMethodTemplate:(NSObject<REFClassTemplate> *)_instance parameterTemplate:(NSString *)parameterTemplate {
  @throw [NSException exceptionWithName:@"REFUnimplementedException" reason:nil userInfo:nil];
}

- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  if ([@"staticMethodTemplate" isEqualToString:methodName]) {
    return [self _onStaticMethodTemplate:messenger parameterTemplate:arguments[0]];
  }
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  return [self _create:messenger fieldTemplate:arguments[0]];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<REFClassTemplate> *value = (NSObject<REFClassTemplate> *) instance;
  if ([@"methodTemplate" isEqualToString:methodName]) {
    return [self _onMethodTemplate:value parameterTemplate:arguments[0]];
  }
  
  NSLog(@"Unable to invoke %@.%@", instance, methodName);
  return nil;
}
@end

@implementation REFLibraryImplementations
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  self = [super init];
  if (self) {
    _messenger = messenger;
  }
  return self;
}

- (REFClassTemplateChannel *)classTemplateChannel {
  return [[REFClassTemplateChannel alloc] initWithMessenger:_messenger];
}

- (REFClassTemplateHandler *)classTemplateHandler {
  return [[REFClassTemplateHandler alloc] init];
}
@end

@implementation REFChannelRegistrar
- (instancetype)initWithImplementation:(REFLibraryImplementations *)implementations {
  self = [super init];
  if (self) {
    _implementations = implementations;
  }
  return self;
}

- (void)registerHandlers {
  [_implementations.classTemplateChannel setHandler:_implementations.classTemplateHandler];
}

- (void)unregisterHandlers {
  [_implementations.classTemplateChannel removeHandler];
}
@end
