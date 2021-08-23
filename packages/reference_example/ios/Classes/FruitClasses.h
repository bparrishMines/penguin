#import <Foundation/Foundation.h>

#import "AppleTypeChannels.h"

@class __prefix__LibraryImplementations;

//@interface __class_name__ : NSObject
//@property (readonly) __prefix__LibraryImplementations *implementations;
//@property (readonly) ClassTemplate *classTemplate;
//-(instancetype)initWithImplementations:(__prefix__LibraryImplementations *)implementations
//                                create:(BOOL)create
//                    __parameter_name__:(NSNumber *)__parameter_name__;
//-(instancetype)initWithClassTemplate:(__prefix__LibraryImplementations *)implementations
//                              create:(BOOL)create
//                       classTemplate:(ClassTemplate *)classTemplate;
//+ (NSNumber *)__staticMethod_name__:(NSString *)__parameter_name__;
//- (NSString *)__method_name__:(NSString *_Nullable)__parameter_name__;
//@end

NS_ASSUME_NONNULL_BEGIN

@interface EXPAppleProxy : NSObject
@property (readonly) __prefix__LibraryImplementations *implementations;
-(instancetype)initWithImplementations:(__prefix__LibraryImplementations *)implementations
                                create:(BOOL)create;
-(instancetype)initWithImplementations:(__prefix__LibraryImplementations *)implementations
                                create:(BOOL)create
                                 color:(NSString *)color;
-(void)takeBite;
-(void)a;
@end

@interface EXPFruitBasketProxy : NSObject
@property (readonly) __prefix__LibraryImplementations *implementations;
-(instancetype)initWithImplementations:(__prefix__LibraryImplementations *)implementations
                                create:(BOOL)create;
-(NSNumber *)addApples:(NSArray<EXPAppleProxy> *)apples;
- (NSDictionary<NSArray<NSString *> *, NSDictionary<NSString *, NSNumber *> *> *_Nullable)_go:(NSDictionary<NSArray<NSString *> *, NSDictionary<NSString *, NSNumber *> *> * _Nullable)a;
@end

NS_ASSUME_NONNULL_END
