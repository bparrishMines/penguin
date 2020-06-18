#import "REFReference.h"

@implementation REFClass
- (instancetype)initWithClass:(Class)clazz {
  self = [super init];
  if (self) {
    _clazz = clazz;
  }
  return self;
}

+ (REFClass *_Nonnull)fromClass:(Class)clazz {
  return [[REFClass alloc] initWithClass:clazz];
}

- (BOOL)isEqual:(id)other {
  if (other == self) {
    return YES;
  } else if (![super isKindOfClass:[REFClass class]]) {
    return NO;
  } else {
    REFClass *clazz = other;
    return _clazz == clazz.clazz;
  }
}

- (NSUInteger)hash {
  return NSStringFromClass(_clazz).hash;
}
@end

@implementation REFRemoteReference
- (instancetype)initWithReferenceID:(NSString *_Nonnull)referenceID {
  self = [super init];
  if (self) {
    _referenceID = referenceID;
  }
  return self;
}

- (BOOL)isEqual:(id)other {
  if (other == self) {
    return YES;
  } else if (![other isKindOfClass:[REFRemoteReference class]]) {
    return NO;
  } else {
    REFRemoteReference *remoteReference = other;
    return [_referenceID isEqualToString:remoteReference.referenceID];
  }
}

- (NSUInteger)hash {
  return _referenceID.hash;
}
@end

@implementation REFUnpairedReference
- (instancetype)initWithClassID:(NSUInteger)classID
              creationArguments:(NSArray<id> *)creationArguments
                  managerPoolID:(NSString *_Nullable)managerPoolID {
  self = [super init];
  if (self) {
    _classID = classID;
    _creationArguments = creationArguments.copy;
    _managerPoolID = managerPoolID;
  }
  return self;
}
@end
