#import <Foundation/Foundation.h>

#import "IAFChannelLibrary_Internal.h"
#import "REFTypeChannel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IAFLibraryImplementations : NSObject<_IAFLibraryImplementations>
-(instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;
@end

@interface IAFChannelRegistrar : _IAFChannelRegistrar
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
