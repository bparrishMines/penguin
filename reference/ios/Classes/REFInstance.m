#import "REFInstance.h"

@implementation REFPairedInstance
- (instancetype)initWithReferenceID:(NSString *_Nonnull)referenceID {
  self = [super init];
  if (self) {
    _instanceID = referenceID;
  }
  return self;
}

+ (REFPairedInstance *)fromID:(NSString *)referenceID {
  return [[REFPairedInstance alloc] initWithReferenceID:referenceID];
}

- (id)copyWithZone:(NSZone *)zone {
  return [REFPairedInstance fromID:_instanceID];
}

- (BOOL)isEqual:(id)other {
  if (other == self) {
    return YES;
  } else if (![other isKindOfClass:[REFPairedInstance class]]) {
    return NO;
  } else {
    REFPairedInstance *remoteReference = other;
    return [_instanceID isEqualToString:remoteReference.instanceID];
  }
}

- (NSUInteger)hash {
  // TODO: change hash
  return 31 * _instanceID.hash;
}

- (NSString *)description {
  return [NSString stringWithFormat:@"REFPairedInstance(%@)", _instanceID];
}
@end

@implementation REFNewUnpairedInstance
- (instancetype)initWithChannelName:(NSString *)channelName
              creationArguments:(NSArray<id> *)creationArguments {
  self = [super init];
  if (self) {
    _channelName = channelName;
    _creationArguments = creationArguments.copy;
  }
  return self;
}

- (id)copyWithZone:(NSZone *)zone {
  return [[REFNewUnpairedInstance alloc] initWithChannelName:_channelName
                                     creationArguments:_creationArguments.copy];
}

- (NSString *)description {
  return [NSString
      stringWithFormat:@"REFNewUnpairedReference(%@, %@)",
          _channelName, _creationArguments.description];
}
@end
