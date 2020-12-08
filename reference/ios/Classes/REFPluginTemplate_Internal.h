#import "REFLibraryTemplate_Internal.h"
#import "ReferencePlugin.h"

NS_ASSUME_NONNULL_BEGIN

@interface ClassTemplate : NSObject<REFClassTemplate>
- (instancetype)initWithFieldTemplate:(NSNumber *)fieldTemplate;
@end

@interface PluginTemplate : NSObject <FlutterPlugin>
@end

NS_ASSUME_NONNULL_END
