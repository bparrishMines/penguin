// GENERATED CODE - DO NOT MODIFY BY HAND

#import "REFLibraryTemplate_Internal.h"

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

@implementation REFClassTemplateCreationArgs
@end

@implementation REFClassTemplateChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"github.penguin/template/template/ClassTemplate"];
}

- (void)invoke_staticMethodTemplate:(NSString *_Nullable)parameterTemplate
/*following_parameters*/
                         completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [self invokeStaticMethod:@"staticMethodTemplate" arguments:@[parameterTemplate] completion:completion];
}

- (void)invoke_methodTemplate:(NSObject<REFClassTemplate> *)instance
            parameterTemplate:(NSString *_Nullable)parameterTemplate
                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [self invokeMethod:instance methodName:@"methodTemplate" arguments:@[parameterTemplate] completion:completion];
}
@end

@implementation REFClassTemplateHandler
- (NSObject<REFClassTemplate> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(REFClassTemplateCreationArgs *)args {
  return nil;
}

- (NSObject *_Nullable)on_staticMethodTemplate:(REFTypeChannelMessenger *)messenger
                             parameterTemplate:(NSString *_Nullable)parameterTemplate {
  return nil;
}

- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  if ([@"staticMethodTemplate" isEqualToString:methodName]) {
    return [self on_staticMethodTemplate:messenger parameterTemplate:arguments[0]];
  }
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull NSArray *)getCreationArguments:(nonnull REFTypeChannelMessenger *)messenger
                                 instance:(nonnull NSObject *)instance {
  NSObject<REFClassTemplate> *value = (NSObject<REFClassTemplate> *) instance;
  return @[value.fieldTemplate];
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  REFClassTemplateCreationArgs *args = [[REFClassTemplateCreationArgs alloc] init];
  args.fieldTemplate = arguments[0];
  return [self onCreate:messenger args:args];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<REFClassTemplate> *value = (NSObject<REFClassTemplate> *) instance;
  if ([@"methodTemplate" isEqualToString:methodName]) {
    return [value methodTemplate:arguments[0] /*following_arguments*/];
  }
  
  NSLog(@"Unable to invoke method %@", methodName);
  return nil;
}

- (void)onInstanceAdded:(nonnull REFTypeChannelMessenger *)messenger instance:(nonnull NSObject *)instance {}

- (void)onInstanceRemoved:(nonnull REFTypeChannelMessenger *)messenger
                 instance:(nonnull NSObject *)instance {}
@end
