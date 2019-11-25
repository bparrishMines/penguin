#import "TestPlugin.h"

@implementation TestClass1
- (void)returnVoid {
  return;
}

- (NSString *)returnString {
  return @"Amigo";
}

- (NSNumber *)returnInt {
  return @(69);
}

- (NSNumber *)returnDouble {
  return @(70.0F);
}

//- (NSString *)allParameterTypesMethod:(int)intValue {
//  return [NSString stringWithFormat:@"%d", intValue];
//}

- (NSObject *)returnObject {
  return @"Hello";
}

- (NSObject *)returnDynamic {
  return @3;
}
//
//
//- (int)returnInt32 {
//  return 56;
//}
//
//
- (NSNumber *)returnBool {
  return [NSNumber numberWithBool:NO];
}

- (NSArray *)returnList {
  return @[@(1.0), @(2.0)];
}

- (NSDictionary *)returnMap {
  return @{@"one": @1, @"two": @2};
}
@end
