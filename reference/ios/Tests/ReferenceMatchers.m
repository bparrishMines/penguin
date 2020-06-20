#import "ReferenceMatchers.h"

@implementation IsUnpairedReference

- (instancetype)initWithClassID:(NSUInteger)classID
              creationArguments:(id)creationArguments
                  managerPoolID:(NSString *)managerPoolID {
  self = [super init];
  if (self) {
    _classID = classID;
    _creationArguments = creationArguments;
    _managerPoolID = managerPoolID;
  }
  return self;
}

- (BOOL)matches:(id)item {
  if (![item isKindOfClass:[REFUnpairedReference class]]) return NO;
  REFUnpairedReference *reference = item;


  if (_classID != reference.classID) return NO;
  if (_managerPoolID && [_managerPoolID isEqualToString:reference.managerPoolID]) {
    return NO;
  }
  if (reference.managerPoolID && [reference.managerPoolID isEqualToString:_managerPoolID]) {
    return NO;
  }
  if ([_creationArguments isKindOfClass:[HCBaseMatcher class]]) {
    return [_creationArguments matches:reference.creationArguments];
  }

  return [_creationArguments isEqualToArray:reference.creationArguments];
}

- (void)describeTo:(id <HCDescription>)description {
  [[[[[[description
     appendText:[NSString stringWithFormat:@" An %@ with classID: ", NSStringFromClass([REFUnpairedReference class])]]
     appendText:[NSString stringWithFormat:@"%lu", (unsigned long)_classID]]
     appendText:@" and creation arguments "]
     appendText:[_creationArguments description]]
     appendText:@" and managerPoolID: "]
     appendText:_managerPoolID ? _managerPoolID : @"nil"
  ];
}
@end

id isUnpairedReference(NSUInteger classID, id creationArguments, NSString *managerPoolID) {
  return [[IsUnpairedReference alloc] initWithClassID:classID
                                    creationArguments:creationArguments
                                        managerPoolID:managerPoolID];
}
