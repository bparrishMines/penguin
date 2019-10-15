#import "TestPlugin.h"

@implementation TestClass1
- (NSNumber *)noParametersMethod {
  return [NSNumber numberWithInt:4];
}
- (NSString *)singleParameterMethod:(NSString *)value {
  return [value stringByAppendingString:@"two"];
}

- (void)returnVoid {
  return;
}

- (NSObject *)returnObject {
  return @"PoPo";
}

- (NSObject *)returnDynamic {
  return @45;
}

- (NSString *)returnString {
  return @"PoPo?";
}

- (NSNumber *)returnInt {
  return @(12);
}

- (NSNumber *)returnDouble {
  return @(70.0F);
}

- (NSNumber *)returnBool {
  return [NSNumber numberWithBool:YES];
}

- (NSArray *)returnList {
  return @[@(3.0), @(4.0)];
}

- (NSDictionary *)returnMap {
  return @{@"three": @3, @"four": @4};
}
@end
