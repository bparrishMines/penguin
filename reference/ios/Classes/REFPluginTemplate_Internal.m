#import "REFPluginTemplate_Internal.h"

@interface ClassTemplateHandler : REFClassTemplateHandler
@end

@implementation ClassTemplate {
  NSNumber *_fieldTemplate;
}

+ (void)setupChannel:(REFReferenceChannelManager *)manager {
  REFClassTemplateChannel *channel = [[REFClassTemplateChannel alloc] initWithManager:manager];
  [channel registerHandler:[[ClassTemplateHandler alloc] init]];
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

- (NSNumber *)fieldTemplate {
  return _fieldTemplate;
}

- (NSString *_Nullable)methodTemplate:(NSString *)parameterTemplate {
  return [NSString stringWithFormat:@"%@ World!", parameterTemplate];
}
@end

@implementation ClassTemplateHandler
- (NSObject<REFClassTemplate> *)onCreate:(REFReferenceChannelManager *)manager args:(REFClassTemplateCreationArgs *)args {
  return [[ClassTemplate alloc] initWithFieldTemplate:args.fieldTemplate];
}

- (NSObject *)on_staticMethodTemplate:(REFReferenceChannelManager *)manager
                    parameterTemplate:(NSString *)parameterTemplate {
  return [ClassTemplate staticMethodTemplate:parameterTemplate];
}
@end

@implementation PluginTemplate
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  REFReferenceChannelManager *manager = [ReferencePlugin getManagerInstance:registrar.messenger];
  [ClassTemplate setupChannel:manager];
}
@end
