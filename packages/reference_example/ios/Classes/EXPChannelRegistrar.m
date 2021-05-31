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

- (NSString *_Nullable)methodTemplate:(NSString *_Nullable)parameterTemplate {
  return [_classTemplate methodTemplate:parameterTemplate];
}
@end

@implementation EXPClassTemplateHandler
- (NSObject<__prefix____class_name__> *)__create:(REFTypeChannelMessenger *)messenger
                                  __field_name__:(NSNumber *)__field_name__ {
  return [[EXPClassTemplateProxy alloc] initWithFieldTemplate:__field_name__];
}

- (NSObject *)___staticMethod_name__:(REFTypeChannelMessenger *)messenger
                  __parameter_name__:(NSString *)__parameter_name__ {
  return [EXPClassTemplateProxy staticMethodTemplate:__parameter_name__];
}

- (NSObject *)___method_name__:(NSObject<__prefix____class_name__> *)_instance
            __parameter_name__:(NSString *)__parameter_name__ {
  EXPClassTemplateProxy *proxy = (EXPClassTemplateProxy *)_instance;
  return [proxy methodTemplate:__parameter_name__];
}
@end
