#import "REFPluginTemplate_Internal.h"

@implementation ClassTemplate
- (instancetype)initWithFieldTemplate:(NSNumber *)fieldTemplate {
  self = [super init];
  if (self) {
    _fieldTemplate = fieldTemplate;
  }
  return self;
}

+ (NSNumber *)staticMethodTemplate:(NSString *)parameterTemplate {
  return @(parameterTemplate.length / 1.0);
}

- (NSString *_Nullable)methodTemplate:(NSString *)parameterTemplate {
  return [NSString stringWithFormat:@"%@ World!", parameterTemplate];
}
@end

@implementation ClassTemplateChannel
@end

@implementation ClassTemplateHandler
- (NSObject<REFClassTemplate> *)onCreate:(REFTypeChannelMessenger *)manager
                                    args:(REFClassTemplateCreationArgs *)args {
  return [[ClassTemplate alloc] initWithFieldTemplate:args.fieldTemplate];
}

- (NSObject *)on_staticMethodTemplate:(REFTypeChannelMessenger *)manager
                    parameterTemplate:(NSString *)parameterTemplate {
  return [ClassTemplate staticMethodTemplate:parameterTemplate];
}
@end

@implementation Channels {
  ClassTemplateChannel *_classTemplateChannel;
}

-(instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  self = [self init];
  if (self) {
    _classTemplateChannel = [[ClassTemplateChannel alloc] initWithMessenger:messenger];
  }
  
  return self;
}

- (ClassTemplateChannel *)classTemplateChannel {
  return _classTemplateChannel;
}

- (void)registerHandlers {
  [_classTemplateChannel setHandler:[[ClassTemplateHandler alloc] init]];
}


- (void)unregisterHandlers {
  [_classTemplateChannel removeHandler];
}

@end

@implementation PluginTemplate
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  REFTypeChannelMessenger *messenger = [ReferencePlugin getMessengerInstance:registrar.messenger];
  Channels *channels = [[Channels alloc] initWithMessenger:messenger];
  [channels registerHandlers];
}
@end
