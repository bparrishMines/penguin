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

+ (REFRemoteReference *)fromID:(NSString *)referenceID {
  return [[REFRemoteReference alloc] initWithReferenceID:referenceID];
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

- (NSString *)description {
  return [NSString stringWithFormat:@"%@(%@)", NSStringFromClass([REFRemoteReference class]), _referenceID];
}
@end

@implementation REFUnpairedReference
- (instancetype)initWithClassID:(NSUInteger)classID
              creationArguments:(NSArray<id> *)creationArguments {
  self = [super init];
  if (self) {
    _classID = classID;
    _creationArguments = creationArguments.copy;
  }
  return self;
}

- (instancetype)initWithClassID:(NSUInteger)classID
              creationArguments:(NSArray<id> *)creationArguments
                  managerPoolID:(NSString *)managerPoolID {
  self = [self initWithClassID:classID creationArguments:creationArguments];
  if (self) {
    _managerPoolID = managerPoolID;
  }
  return self;
}

- (NSString *)description {
  return [NSString stringWithFormat:@"%@(%lu, %@, %@)", NSStringFromClass([REFUnpairedReference class]),
          (unsigned long)_classID,
          _creationArguments.description,
          _managerPoolID];
}
@end
