#import "REFLibraryTemplate.h"
#import "FakeLibrary.h"

NS_ASSUME_NONNULL_BEGIN

@interface EXPClassTemplateProxy : NSObject<REFClassTemplate>
@property (readonly) ClassTemplate *classTemplate;
-(instancetype)initWithFieldTemplate:(NSNumber *)fieldTemplate;
-(instancetype)initWithClassTemplate:(ClassTemplate *)classTemplate;
@end

@interface EXPLibraryImplementations : REFLibraryImplementations
@end

@interface EXPClassTemplateHandler : REFClassTemplateHandler
@end

NS_ASSUME_NONNULL_END
