#import "$TemplateReferencePairManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface ClassTemplate : _ClassTemplate
-(instancetype)initWithFieldTemplate:(NSNumber *)fieldTemplate;
@end

@interface PluginTemplate : NSObject<FlutterPlugin>
@end

NS_ASSUME_NONNULL_END
