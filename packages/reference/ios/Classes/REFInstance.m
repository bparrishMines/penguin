#import "REFInstance.h"

@implementation REFPairedInstance
- (instancetype)initWithInstanceID:(NSString *_Nonnull)instanceID {
  self = [super init];
  if (self) {
    _instanceID = instanceID;
  }
  return self;
}

+ (REFPairedInstance *)fromID:(NSString *)instanceID {
  return [[REFPairedInstance alloc] initWithInstanceID:instanceID];
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
    REFPairedInstance *instance = other;
    return [_instanceID isEqualToString:instance.instanceID];
  }
}

- (NSUInteger)hash {
  int hash = 0x1fffffff & (17 + _instanceID.hash);
  hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
  return hash ^ (hash >> 6);
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
          _channelName, [_creationArguments.description stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
}
@end
