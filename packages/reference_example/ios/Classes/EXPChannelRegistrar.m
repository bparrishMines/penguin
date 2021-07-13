#import "EXPChannelRegistrar.h"

@implementation EXPLibraryImplementations
- (nonnull EXPClassTemplateHandler *)handler__class_name__ {
  return [[EXPClassTemplateHandler alloc] init];
}
@end

@implementation EXPClassTemplateProxy
+ (NSNumber *)staticMethodTemplate:(NSString *)parameterTemplate {
  return @([ClassTemplate staticMethodTemplate:parameterTemplate]);
}

- (instancetype)initWithFieldTemplate:(NSNumber *)fieldTemplate {
  ClassTemplate *classTemplate = [[ClassTemplate alloc] initWithFieldTemplate:fieldTemplate.unsignedIntegerValue];
  return [self initWithClassTemplate:classTemplate];
}

- (instancetype)initWithClassTemplate:(ClassTemplate *)classTemplate {
  self = [super init];
  if (self) {
    _classTemplate = classTemplate;
  }
  return self;
}

- (id _Nullable)__method_name__:(NSString * _Nullable)__parameter_name__
    __followingParameter_name__:(NSString * _Nullable)__followingParameter_name__ {
  return [_classTemplate methodTemplate:__parameter_name__];
}
@end

@implementation EXPClassTemplateHandler
- (NSObject<__prefix____class_name__> *)__create___constructor_name__:(REFTypeChannelMessenger *)messenger
                                                        _parameter_name__:(NSNumber *)__parameter_name__ {
  return [[EXPClassTemplateProxy alloc] initWithFieldTemplate:__parameter_name__];
}

- (id)invokeMethod:(REFTypeChannelMessenger *)messenger
          instance:(NSObject *)instance
        methodName:(NSString *)methodName
         arguments:(NSArray *)arguments {
  if ([@"callbackTest" isEqualToString:methodName]) {
    __prefix____function_name__ callback = (__prefix____function_name__) arguments[0];
    callback(@"Eureka!");
    return nil;
  }
  return [super invokeMethod:messenger instance:instance methodName:methodName arguments:arguments];
}

- (NSObject *)___staticMethod_name__:(REFTypeChannelMessenger *)messenger
                  __parameter_name__:(NSString *)__parameter_name__ {
  return [EXPClassTemplateProxy staticMethodTemplate:__parameter_name__];
}
@end
