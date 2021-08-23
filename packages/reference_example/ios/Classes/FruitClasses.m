//
//  FruitClasses.m
//  reference_example
//
//  Created by Maurice Parrish on 8/22/21.
//

#import "FruitClasses.h"

@implementation EXPAppleProxy : NSObject
-(instancetype)initWithImplementations:(__prefix__LibraryImplementations *)implementations
                                create:(BOOL)create {
  return nil;
}
-(instancetype)initWithImplementations:(__prefix__LibraryImplementations *)implementations
                                create:(BOOL)create
                                 color:(NSString *)color {
  return nil;
}
-(void)takeBite {
  
}
-(void)a {
  
}
@end

@implementation EXPFruitBasketProxy : NSObject
-(instancetype)initWithImplementations:(__prefix__LibraryImplementations *)implementations
                                create:(BOOL)create {
  return nil;
}
-(NSNumber *)addApples:(NSArray<EXPAppleProxy *> *)apples {
  return nil;
}
- (NSDictionary<NSArray<NSString *> *, NSDictionary<NSString *, NSNumber *> *> *_Nullable)_go:(NSDictionary<NSArray<NSString *> *, NSDictionary<NSString *, NSNumber *> *> * _Nullable)a {
  return nil;
}
@end
