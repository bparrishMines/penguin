#import <Flutter/Flutter.h>

@interface TestPlugin : NSObject<FlutterPlugin>
@end

@interface TestClass2 : NSObject
@end

@interface TestClass1 : NSObject
- (instancetype _Nonnull)initNamedConstructor;
+ (void)staticMethod;
- (void)parameterMethod:(NSString *_Nonnull)supported primitive:(int)primitive wrapper:(TestClass2 *_Nonnull)wrapper;
- (void)returnVoid;
- (NSObject *_Nonnull)returnObject;
- (NSObject *_Nonnull)returnDynamic;
- (NSString *_Nonnull)returnString;
- (NSNumber *_Nonnull)returnInt;
- (int)returnInt32;
- (NSNumber *_Nonnull)returnDouble;
- (NSNumber *_Nonnull)returnBool;
- (NSArray *_Nonnull)returnList;
- (NSDictionary *_Nonnull)returnMap;
@end
