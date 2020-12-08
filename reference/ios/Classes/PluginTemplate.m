#import "PluginTemplate.h"

//@interface LocalHandlerImpl : _p_LocalHandler
//@end
//
//@interface ReferencePairManagerTemplate : _p_ReferencePairManager
//@end

@interface ClassTemplateHandler : _p_ClassTemplateHandler
@end

@implementation ClassTemplate {
  NSNumber *_fieldTemplate;
}

+ (void)setupChannel:(REFReferenceChannelManager *)manager {
  _p_ClassTemplateChannel *channel = [[_p_ClassTemplateChannel alloc] initWithManager:manager];
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
- (NSObject<_p_ClassTemplate> *)onCreate:(REFReferenceChannelManager *)manager args:(_p_ClassTemplateCreationArgs *)args {
  return [[ClassTemplate alloc] initWithFieldTemplate:args.fieldTemplate];
}

- (NSObject *)on_staticMethodTemplate:(REFReferenceChannelManager *)manager
                    parameterTemplate:(NSString *)parameterTemplate {
  return [ClassTemplate staticMethodTemplate:parameterTemplate];
}
@end

//@implementation LocalHandlerImpl
//- (_p_ClassTemplate *)createClassTemplate:(REFReferencePairManager *)manager
//                                     args:(_p_ClassTemplateCreationArgs *)args {
//  return [[ClassTemplate alloc] initWithFieldTemplate:args.fieldTemplate];
//}
//
//- (id)classTemplate_staticMethodTemplate:(REFReferencePairManager *)manager
//                       parameterTemplate:(NSString *)parameterTemplate {
//  return [ClassTemplate staticMethodTemplate:parameterTemplate];
//}
//@end
//
//@implementation ReferencePairManagerTemplate
//- (instancetype _Nonnull)initBinaryMessenger:(id<FlutterBinaryMessenger> _Nonnull)binaryMessenger {
//  return self = [super initWithChannelName:@"github.penguin/reference/template"
//                           binaryMessenger:binaryMessenger];
//}
//
//- (id<REFLocalReferenceCommunicationHandler>)localHandler {
//  return [[LocalHandlerImpl alloc] init];
//}
//@end

@implementation PluginTemplate
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  REFReferenceChannelManager *manager = [ReferencePlugin getManagerInstance:registrar.messenger];
  [ClassTemplate setupChannel:manager];
//  ReferencePairManagerTemplate *manager =
//      [[ReferencePairManagerTemplate alloc] initBinaryMessenger:registrar.messenger];
  //[manager initialize];
}
@end
