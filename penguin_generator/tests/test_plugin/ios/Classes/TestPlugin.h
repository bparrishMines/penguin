#import <Flutter/Flutter.h>

@interface TestPlugin : NSObject<FlutterPlugin>
@end

@interface TestClass1 : NSObject
- (NSNumber *)noParametersMethod;
- (NSString *)singleParameterMethod:(NSString *)value;
- (void)returnVoid;
- (NSObject *)returnObject;
- (NSObject *)returnDynamic;
- (NSString *)returnString;
- (NSNumber *)returnInt;
- (NSNumber *)returnDouble;
- (NSNumber *)returnBool;
- (NSArray *)returnList;
- (NSDictionary *)returnMap;
@end
