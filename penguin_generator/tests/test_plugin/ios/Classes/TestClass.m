#import "TestPlugin.h"

@implementation TestClass1
- (NSNumber *)noParametersMethod {
  return [NSNumber numberWithInt:4];
}
- (NSString *)singleParameterMethod:(NSString *)value {
  return [value stringByAppendingString:@"two"];
}
@end
