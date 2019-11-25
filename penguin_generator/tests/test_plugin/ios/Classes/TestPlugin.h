#import <Flutter/Flutter.h>

@interface TestPlugin : NSObject<FlutterPlugin>
@end

@interface TestClass1 : NSObject
//- (NSString *)allParameterTypesMethod:(int)intValue;
- (void)returnVoid;
//- (NSObject *)returnObject;
//- (NSObject *)returnDynamic;
- (NSString *)returnString;
- (NSNumber *)returnInt;
//- (int)returnInt32;
- (NSNumber *)returnDouble;
- (NSNumber *)returnBool;
- (NSArray *)returnList;
- (NSDictionary *)returnMap;
@end
