#import "EXPChannelRegistrar.h"

@implementation EXPLibraryImplementations
- (nonnull EXPClassTemplateHandler *)classTemplateHandler {
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
- (EXPClassTemplateProxy *)_create:(REFTypeChannelMessenger *)messenger fieldTemplate:(NSNumber *)fieldTemplate {
  return [[EXPClassTemplateProxy alloc] initWithFieldTemplate:fieldTemplate];
}

- (NSNumber *)_onStaticMethodTemplate:(REFTypeChannelMessenger *)messenger parameterTemplate:(NSString *)parameterTemplate {
  return [EXPClassTemplateProxy staticMethodTemplate:parameterTemplate];
}

- (NSString *)_onMethodTemplate:(NSObject<REFClassTemplate> *)_instance parameterTemplate:(NSString *)parameterTemplate {
  EXPClassTemplateProxy *proxy = (EXPClassTemplateProxy *)_instance;
  return [proxy methodTemplate:parameterTemplate];
}
@end
