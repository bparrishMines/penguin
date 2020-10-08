#import "PluginTemplate.h"

@interface LocalHandlerImpl : _LocalHandler
@end

@interface ReferencePairManagerTemplate : _ReferencePairManager
@end

@implementation ClassTemplate {
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
  return @(parameterTemplate.length / 1.0);
}

-(NSNumber *)fieldTemplate {
  return _fieldTemplate;
}

-(NSString *_Nullable)methodTemplate:(NSString *)parameterTemplate {
  return [NSString stringWithFormat:@"%@ World!", parameterTemplate];
}
@end

@implementation LocalHandlerImpl
-(_ClassTemplate *)createClassTemplate:(REFReferencePairManager *)manager args:(_ClassTemplateCreationArgs *)args {
    return [[ClassTemplate alloc] initWithFieldTemplate:args.fieldTemplate];
}

-(id)classTemplate_staticMethodTemplate:(REFReferencePairManager *)manager
                      parameterTemplate:(NSString *)parameterTemplate {
  return [ClassTemplate staticMethodTemplate:parameterTemplate];
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
  ReferencePairManagerTemplate *manager = [[ReferencePairManagerTemplate alloc]
                                           initBinaryMessenger:registrar.messenger];
  [manager initialize];
}
@end
