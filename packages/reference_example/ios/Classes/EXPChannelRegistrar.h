#import "REFLibraryTemplate.h"
#import "FakeLibrary.h"

@class __prefix__LibraryImplementations;

NS_ASSUME_NONNULL_BEGIN

typedef void (^__function_name__) (NSString *_Nullable __parameter_name__);

@interface __class_name__ : NSObject
@property (readonly) __prefix__LibraryImplementations *implementations;
@property (readonly) ClassTemplate *classTemplate;
-(instancetype)initWithImplementations:(__prefix__LibraryImplementations *)implementations
                                create:(BOOL)create
                    __parameter_name__:(NSNumber *)__parameter_name__;
-(instancetype)initWithClassTemplate:(__prefix__LibraryImplementations *)implementations
                              create:(BOOL)create
                       classTemplate:(ClassTemplate *)classTemplate;
+ (NSNumber *)__staticMethod_name__:(NSString *)__parameter_name__;
- (NSString *)__method_name__:(NSString *_Nullable)__parameter_name__;
@end

NS_ASSUME_NONNULL_END
