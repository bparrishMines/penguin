#import "EXPChannelRegistrar.h"

@implementation EXPLibraryImplementations
- (nonnull EXPClassTemplateHandler *)classTemplateHandler {
  return [[EXPClassTemplateHandler alloc] init];
}
@end

@implementation EXPClassTemplateProxy
+(NSNumber *)staticMethodTemplate:(NSString *)parameterTemplate {
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

- (NSNumber * _Nullable)fieldTemplate {
  return nil;
}

- (NSString *_Nullable)methodTemplate:(NSString *_Nullable)parameterTemplate {
  return [_classTemplate methodTemplate:parameterTemplate];
}
@end

@implementation EXPClassTemplateHandler
- (NSObject<REFClassTemplate> *)onCreate:(REFTypeChannelMessenger *)messenger args:(REFClassTemplateCreationArgs *)args {
  return [[EXPClassTemplateProxy alloc] initWithFieldTemplate:args.fieldTemplate];
}

- (NSNumber *)on_staticMethodTemplate:(REFTypeChannelMessenger *)messenger parameterTemplate:(NSString *)parameterTemplate {
  return [EXPClassTemplateProxy staticMethodTemplate:parameterTemplate];
}
@end
