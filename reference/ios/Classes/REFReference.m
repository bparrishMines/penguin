#import "REFReference.h"

//@implementation REFClass
//- (instancetype)initWithClass:(Class)clazz {
//  self = [super init];
//  if (self) {
//    _clazz = clazz;
//  }
//  return self;
//}
//
//+ (REFClass *_Nonnull)fromClass:(Class)clazz {
//  return [[REFClass alloc] initWithClass:clazz];
//}
//
//- (BOOL)isEqual:(id)other {
//  if (other == self) {
//    return YES;
//  } else if (![super isKindOfClass:[REFClass class]]) {
//    return NO;
//  } else {
//    REFClass *clazz = other;
//    return _clazz == clazz.clazz;
//  }
//}
//
//- (NSUInteger)hash {
//  return NSStringFromClass(_clazz).hash;
//}
//
//- (nonnull id)copyWithZone:(nullable NSZone *)zone {
//  return [REFClass fromClass:_clazz];
//}
//@end

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

- (id)copyWithZone:(NSZone *)zone {
  return [REFRemoteReference fromID:_referenceID];
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
  return 31 * _referenceID.hash;
}

- (NSString *)description {
  return [NSString stringWithFormat:@"REFRemoteReference(%@)", _referenceID];
}
@end

@implementation REFUnpairedReference
- (instancetype)initWithChannel:(NSString *)handlerChannel
              creationArguments:(NSArray<id> *)creationArguments {
  self = [super init];
  if (self) {
    _handlerChannel = handlerChannel;
    _creationArguments = creationArguments.copy;
  }
  return self;
}

- (id)copyWithZone:(NSZone *)zone {
  return [[REFUnpairedReference alloc] initWithChannel:_handlerChannel
                                     creationArguments:_creationArguments.copy];
}

- (NSString *)description {
  return [NSString
      stringWithFormat:@"REFUnpairedReference(%@, %@)",
          _handlerChannel, _creationArguments.description];
}
@end
