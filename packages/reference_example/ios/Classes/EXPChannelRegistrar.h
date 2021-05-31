#import "REFLibraryTemplate.h"
#import "FakeLibrary.h"

NS_ASSUME_NONNULL_BEGIN

@interface EXPClassTemplateProxy : NSObject<__prefix____class_name__>
@property (readonly) ClassTemplate *classTemplate;
-(instancetype)initWithFieldTemplate:(NSNumber *)fieldTemplate;
-(instancetype)initWithClassTemplate:(ClassTemplate *)classTemplate;
@end

@interface EXPLibraryImplementations : __prefix__LibraryImplementations
@end

@interface EXPClassTemplateHandler : __prefix____class_name__Handler
@end

NS_ASSUME_NONNULL_END
