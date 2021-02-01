#import "REFReferenceMatchers.h"

@implementation REFTestMessenger
- (instancetype)init {
  self = [super initWithMessageDispatcher:[[REFTestMessageDispatcher alloc] init]];
  if (self) {
    _testHandler = [[REFTestHandler alloc] initWithMessenger:self];
    [self registerHandler:@"test_channel" handler:_testHandler];
  }
  return self;
}

- (NSString *)generateUniqueInstanceId {
  return @"test_instance_id";
}
@end

@implementation REFTestHandler
-(instancetype)initWithMessenger:(REFTestMessenger *)messenger {
  self = [super init];
  if (self) {
    _testClassInstance = [[REFTestClass alloc] initWithMessenger:messenger];
  }
  return self;
}

- (NSArray *)getCreationArguments:(REFTypeChannelMessenger *)messenger instance:(NSObject *)instance {
  return @[];
}

- (id)createInstance:(REFTypeChannelMessenger *)manager arguments:(NSArray *)arguments {
  return _testClassInstance;
}

- (id _Nullable)invokeStaticMethod:(REFTypeChannelMessenger *)messenger
                        methodName:(NSString *)methodName
                         arguments:(NSArray *)arguments {
  return @"return_value";
}

- (id _Nullable)invokeMethod:(REFTypeChannelMessenger *)messenger
                    instance:(NSObject *)instance
                  methodName:(NSString *)methodName
                   arguments:(NSArray *)arguments {
  return @"return_value";
}

- (void)onInstanceAdded:(nonnull REFTypeChannelMessenger *)messenger instance:(nonnull NSObject *)instance {
  // Do nothing.
}


- (void)onInstanceRemoved:(nonnull REFTypeChannelMessenger *)messenger instance:(nonnull NSObject *)instance {
  // Do nothing.
}
@end

@implementation REFTestClass
-(instancetype)initWithMessenger:(REFTestMessenger *)messenger {
  self = [super init];
  if (self) {
    _testMessenger = messenger;
  }
  return self;
}

- (REFTypeChannel *)typeChannel {
  return [[REFTypeChannel alloc] initWithMessenger:_testMessenger name:@"test_channel"];
}
@end

@implementation REFTestMessageDispatcher
- (void)sendCreateNewInstancePair:(NSString *)channelName
                   pairedInstance:(REFPairedInstance *)pairedInstance
                        arguments:(NSArray<id> *)arguments
                       completion:(void (^)(NSError *_Nullable))completion {
  completion(nil);
}

- (void)sendInvokeStaticMethod:(NSString *)channelName
                    methodName:(NSString *)methodName
                     arguments:(NSArray<id> *)arguments
                    completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  completion(@"return_value", nil);
}

- (void)sendInvokeMethod:(NSString *)channelName
          pairedInstance:(REFPairedInstance *)pairedInstance
              methodName:(NSString *)methodName
               arguments:(NSArray<id> *)arguments
              completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  completion(@"return_value", nil);
}

- (void)sendInvokeMethodOnUnpairedInstance:(REFNewUnpairedInstance *)unpairedReference
                                methodName:(NSString *)methodName
                                 arguments:(NSArray<id> *)arguments
                                completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  completion(@"return_value", nil);
}

- (void)sendDisposeInstancePair:(NSString *)channelName
                 pairedInstance:(REFPairedInstance *)pairedInstance
                     completion:(void (^)(NSError *_Nullable))completion {
  completion(nil);
}
@end

@implementation IsUnpairedInstance
- (instancetype _Nonnull)initWithChannelName:(NSString *_Nonnull)channelName
                           creationArguments:(id _Nonnull)creationArguments {
  self = [super init];
  if (self) {
    _channelName = channelName;
    _creationArguments = creationArguments;
  }
  return self;
}

- (BOOL)matches:(id)item {
  if (![item isKindOfClass:[REFNewUnpairedInstance class]]) return NO;
  REFNewUnpairedInstance *unpairedInstance = item;
  
  if (_channelName != unpairedInstance.channelName) return NO;
  if ([_creationArguments isKindOfClass:[HCBaseMatcher class]]) {
    return [_creationArguments matches:unpairedInstance.creationArguments];
  }
  
  return [_creationArguments isEqualToArray:unpairedInstance.creationArguments];
}

- (void)describeTo:(id<HCDescription>)description {
  [[[description
     appendText:[NSString stringWithFormat:@" A %@ with channelName: ",
                 NSStringFromClass([REFNewUnpairedInstance class])]]
    appendText:_channelName]
   appendText:@" and creation arguments: "];
  
  if ([_creationArguments isKindOfClass:[HCBaseMatcher class]]) {
    [_creationArguments describeTo:description];
  } else {
    [description appendText:[_creationArguments description]];
  }
}
@end

id isUnpairedInstance(NSString *_Nonnull channelName, id _Nonnull creationArguments) {
  return [[IsUnpairedInstance alloc] initWithChannelName:channelName
                                       creationArguments:creationArguments];
}
