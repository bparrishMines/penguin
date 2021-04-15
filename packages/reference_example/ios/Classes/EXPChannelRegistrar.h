#import "REFLibraryTemplate.h"
#import "FakeLibrary.h"

NS_ASSUME_NONNULL_BEGIN

@interface EXPLibraryImplementations : NSObject<REFLibraryImplementations>
-(instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;
@end

@interface EXPChannelRegistrar : REFChannelRegistrar
@end

@interface EXPClassTemplateProxy : NSObject<REFClassTemplate>
@property (readonly) ClassTemplate *classTemplate;
-(instancetype)initWithFieldTemplate:(NSNumber *)fieldTemplate;
-(instancetype)initWithClassTemplate:(ClassTemplate *)classTemplate;
@end

@interface EXPClassTemplateChannel : REFClassTemplateChannel
@end

@interface EXPClassTemplateHandler : REFClassTemplateHandler
@end

NS_ASSUME_NONNULL_END
