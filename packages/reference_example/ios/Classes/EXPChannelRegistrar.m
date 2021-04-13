#import "EXPChannelRegistrar.h"

@implementation EXPChannelRegistrar
@end

@implementation EXPLibraryImplementations {
  EXPClassTemplateChannel *_classTemplateChannel;
  EXPClassTemplateHandler *_classTemplateHandler;
}

- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  self = [super init];
  if (self) {
    _classTemplateChannel = [[EXPClassTemplateChannel alloc] initWithMessenger:messenger];
    _classTemplateHandler = [[EXPClassTemplateHandler alloc] init];
  }
  return self;
}

- (nonnull REFClassTemplateChannel *)classTemplateChannel {
  return _classTemplateChannel;
}

- (nonnull REFClassTemplateHandler *)classTemplateHandler {
  return _classTemplateHandler;
}
@end

@implementation EXPClassTemplateProxy
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

@implementation EXPClassTemplateChannel
@end

@implementation EXPClassTemplateHandler
- (NSObject<REFClassTemplate> *)onCreate:(REFTypeChannelMessenger *)messenger args:(REFClassTemplateCreationArgs *)args {
  return [[EXPClassTemplateProxy alloc] initWithFieldTemplate:args.fieldTemplate];
}
@end
