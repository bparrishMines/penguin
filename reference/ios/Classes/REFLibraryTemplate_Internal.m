// GENERATED CODE - DO NOT MODIFY BY HAND

#import "REFLibraryTemplate_Internal.h"

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

@implementation REFClassTemplateCreationArgs
@end

@implementation REFClassTemplateChannel
- (instancetype)initWithManager:(REFTypeChannelManager *)manager {
  return self = [super initWithManager:manager name:@"github.penguin/template/template/ClassTemplate"];
}

- (void)invoke_staticMethodTemplate:(NSString *_Nullable)parameterTemplate
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
- (NSObject<REFClassTemplate> *)onCreate:(REFTypeChannelManager *)manager
                                             args:(REFClassTemplateCreationArgs *)args {
  return nil;
}

- (NSObject *_Nullable)on_staticMethodTemplate:(REFTypeChannelManager *)manager
                             parameterTemplate:(NSString *_Nullable)parameterTemplate {
  return nil;
}

- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelManager *)manager
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  if ([@"staticMethodTemplate" isEqualToString:methodName]) {
    return [self on_staticMethodTemplate:manager parameterTemplate:arguments[0]];
  }
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull NSArray *)getCreationArguments:(nonnull REFTypeChannelManager *)manager
                                 instance:(nonnull NSObject *)instance {
  NSObject<REFClassTemplate> *value = (NSObject<REFClassTemplate> *) instance;
  return @[value.fieldTemplate];
}

- (nonnull id)createInstance:(nonnull REFTypeChannelManager *)manager
                   arguments:(nonnull NSArray *)arguments {
  REFClassTemplateCreationArgs *args = [[REFClassTemplateCreationArgs alloc] init];
  args.fieldTemplate = arguments[0];
  return [self onCreate:manager args:args];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelManager *)manager
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

- (void)onInstanceDisposed:(nonnull REFTypeChannelManager *)manager
                  instance:(nonnull NSObject *)instance {}
@end
