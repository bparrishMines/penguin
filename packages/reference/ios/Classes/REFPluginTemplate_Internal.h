#import "REFLibraryTemplate_Internal.h"
#import "ReferencePlugin.h"

NS_ASSUME_NONNULL_BEGIN

@interface ClassTemplate : NSObject<REFClassTemplate>
@property (readonly) NSNumber *fieldTemplate;
- (instancetype)initWithFieldTemplate:(NSNumber *)fieldTemplate;
@end

@interface PluginTemplate : NSObject <FlutterPlugin>
@end

@interface ClassTemplateChannel : REFClassTemplateChannel
@end

@interface ClassTemplateHandler : REFClassTemplateHandler
@end

@interface Channels : NSObject<REFChannels>
-(instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;
@end

NS_ASSUME_NONNULL_END
