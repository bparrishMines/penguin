#import "PluginTemplate.h"

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

-(NSNumber *)fieldTemplate {
  return _fieldTemplate;
}

-(NSString *_Nullable)methodTemplate:(NSString *)parameterTemplate {
  return [NSString stringWithFormat:@"%@ World!", parameterTemplate];
}
@end

@implementation ReferencePairManagerTemplate
-(instancetype _Nonnull)initBinaryMessenger:(id<FlutterBinaryMessenger> _Nonnull)binaryMessenger {
  return self = [super initWithChannelName:@"github.penguin/reference/template" binaryMessenger:binaryMessenger];
}

@end

@implementation PluginTemplate
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  ReferencePairManagerTemplate *manager = [[ReferencePairManagerTemplate alloc] initBinaryMessenger:registrar.messenger];
  [manager initialize];
}
@end
