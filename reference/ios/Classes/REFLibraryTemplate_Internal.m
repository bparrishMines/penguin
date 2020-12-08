// GENERATED CODE - DO NOT MODIFY BY HAND

#import "REFLibraryTemplate_Internal.h"

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

@implementation REFClassTemplateCreationArgs
@end

@implementation REFClassTemplateChannel
- (instancetype)initWithManager:(REFReferenceChannelManager *)manager {
  return self = [super initWithManager:manager channelName:@"github.penguin/template/template/ClassTemplate"];
}

- (void)invoke_staticMethodTemplate:(NSString *_Nullable)parameterTemplate
                         completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [self invokeStaticMethod:@"staticMethodTemplate" arguments:@[parameterTemplate] completion:completion];
}

- (void)invoke_methodTemplate:(NSObject<REFClassTemplate> *)instance
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

@implementation REFClassTemplateHandler
- (NSObject<REFClassTemplate> *)onCreate:(REFReferenceChannelManager *)manager
                                             args:(REFClassTemplateCreationArgs *)args {
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
  NSObject<REFClassTemplate> *value = (NSObject<REFClassTemplate> *) instance;
  return @[value.fieldTemplate];
}

- (nonnull id)createInstance:(nonnull REFReferenceChannelManager *)manager
                   arguments:(nonnull NSArray *)arguments {
  REFClassTemplateCreationArgs *args = [[REFClassTemplateCreationArgs alloc] init];
  args.fieldTemplate = arguments[0];
  return [self onCreate:manager args:args];
}

- (id _Nullable)invokeMethod:(nonnull REFReferenceChannelManager *)manager
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<REFClassTemplate> *value = (NSObject<REFClassTemplate> *) instance;
  if ([@"methodTemplate" isEqualToString:methodName]) {
    return [value methodTemplate:arguments[0]];
  }
  
  NSLog(@"Unable to invoke method %@", methodName);
  return nil;
}

- (void)onInstanceDisposed:(nonnull REFReferenceChannelManager *)manager
                  instance:(nonnull NSObject *)instance {}
@end
