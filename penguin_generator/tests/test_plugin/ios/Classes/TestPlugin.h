#import <Flutter/Flutter.h>

@interface TestPlugin : NSObject<FlutterPlugin>
@end

@interface TestClass1 : NSObject
- (void)parameterMethod:(NSString *)supported primitive:(int)primitive;
- (void)returnVoid;
- (NSObject *)returnObject;
- (NSObject *)returnDynamic;
- (NSString *)returnString;
- (NSNumber *)returnInt;
- (int)returnInt32;
- (NSNumber *)returnDouble;
- (NSNumber *)returnBool;
- (NSArray *)returnList;
- (NSDictionary *)returnMap;
@end
