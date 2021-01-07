#import "REFPluginTemplate_Internal.h"

@interface ClassTemplateHandler : REFClassTemplateHandler
@end

@implementation ClassTemplate
+ (void)setupChannel:(REFTypeChannelManager *)manager {
  REFClassTemplateChannel *channel = [[REFClassTemplateChannel alloc] initWithManager:manager];
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
- (NSObject<REFClassTemplate> *)onCreate:(REFTypeChannelManager *)manager args:(REFClassTemplateCreationArgs *)args {
  return [[ClassTemplate alloc] initWithFieldTemplate:args.fieldTemplate];
}

- (NSObject *)on_staticMethodTemplate:(REFTypeChannelManager *)manager
                    parameterTemplate:(NSString *)parameterTemplate {
  return [ClassTemplate staticMethodTemplate:parameterTemplate];
}
@end

@implementation PluginTemplate
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  REFTypeChannelManager *manager = [ReferencePlugin getManagerInstance:registrar.messenger];
  [ClassTemplate setupChannel:manager];
}
@end
