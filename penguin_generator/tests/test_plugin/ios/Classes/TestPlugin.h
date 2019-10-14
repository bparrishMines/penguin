#import <Flutter/Flutter.h>

@interface TestPlugin : NSObject<FlutterPlugin>
@end

@interface TestClass1 : NSObject
- (NSNumber *)noParametersMethod;
- (NSString *)singleParameterMethod:(NSString *)value;
@end
