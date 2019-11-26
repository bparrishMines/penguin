#import "TestPlugin.h"

@implementation TestClass1
- (instancetype _Nonnull)initNamedConstructor:(NSString *_Nonnull)supported
                                    primitive:(int)primitive
                                      wrapper:(TestClass2 *_Nonnull)wrapper; {
  if ([supported isEqual:[NSNull null]] || [wrapper isEqual:[NSNull null]]) {
    @throw [NSException exceptionWithName:NSInvalidArgumentException reason:nil userInfo:nil];
  }
  return self = [self init];
}

+ (void)staticMethod {
  
}

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

- (void)parameterMethod:(NSString *)supported primitive:(int)primitive wrapper:(TestClass2 *)wrapper {
  if ([supported isEqual:[NSNull null]] || [wrapper isEqual:[NSNull null]]) {
    @throw [NSException exceptionWithName:NSInvalidArgumentException reason:nil userInfo:nil];
  }
}

- (NSObject *)returnObject {
  return @"Hello";
}

- (NSObject *)returnDynamic {
  return @3;
}


- (int)returnInt32 {
  return 56;
}


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

@implementation TestClass2
@end
