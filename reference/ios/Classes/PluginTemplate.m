#import "PluginTemplate.h"

@interface LocalHandlerImpl : _LocalHandler
@end

@interface ReferencePairManagerTemplate : _TemplateReferencePairManager
@end

@implementation ClassTemplateImpl {
  NSNumber *_fieldTemplate;
}

-(instancetype)initWithFieldTemplate:(NSNumber *)fieldTemplate {
  self = [super init];
  if (self) {
    _fieldTemplate = fieldTemplate;
  }
  return self;
}

+(NSNumber *)staticMethodTemplate:(NSString *)parameterTemplate {
  return @(16.0);
}

-(NSNumber *)fieldTemplate {
  return _fieldTemplate;
}

-(NSString *_Nullable)methodTemplate:(NSString *)parameterTemplate {
  return [NSString stringWithFormat:@"%@ World!", parameterTemplate];
}
@end

@implementation LocalHandlerImpl
-(ClassTemplate *)createClassTemplate:(REFReferencePairManager *)manager fieldTemplate:(NSNumber *)fieldTemplate {
  return [[ClassTemplateImpl alloc] initWithFieldTemplate:fieldTemplate];
}

-(id)classTemplate_staticMethodTemplate:(REFReferencePairManager *)manager
                      parameterTemplate:(NSString *)parameterTemplate {
  return [ClassTemplateImpl staticMethodTemplate:parameterTemplate];
}
@end

@implementation ReferencePairManagerTemplate
-(instancetype _Nonnull)initBinaryMessenger:(id<FlutterBinaryMessenger> _Nonnull)binaryMessenger {
  return self = [super initWithChannelName:@"github.penguin/reference/template" binaryMessenger:binaryMessenger];
}

-(id<REFLocalReferenceCommunicationHandler>)localHandler {
  return [[LocalHandlerImpl alloc] init];
}
@end

@implementation PluginTemplate
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  ReferencePairManagerTemplate *manager = [[ReferencePairManagerTemplate alloc] initBinaryMessenger:registrar.messenger];
  [manager initialize];
}
@end
