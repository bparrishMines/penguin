#import "REFPluginTemplate_Internal.h"

@interface ClassTemplateHandler : REFClassTemplateHandler
@end

@implementation ClassTemplate
+ (void)setupChannel:(REFTypeChannelMessenger *)manager {
  REFClassTemplateChannel *channel = [[REFClassTemplateChannel alloc] initWithMessenger:manager];
  [channel setHandler:[[ClassTemplateHandler alloc] init]];
}

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

@implementation PluginTemplate
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  REFTypeChannelMessenger *manager = [ReferencePlugin getMessengerInstance:registrar.messenger];
  [ClassTemplate setupChannel:manager];
}
@end
