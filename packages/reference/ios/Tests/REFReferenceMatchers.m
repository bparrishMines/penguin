#import "REFReferenceMatchers.h"

@implementation REFTestMessenger {
  REFTestInstancePairManager *_testInstancePairManager;
}

- (instancetype)init {
  self = [super initWithMessageDispatcher:[[REFTestMessageDispatcher alloc] init]];
  if (self) {
    _testHandler = [[REFTestHandler alloc] init];
    [self registerHandler:@"test_channel" handler:_testHandler];
    _testInstancePairManager = [[REFTestInstancePairManager alloc] init];
  }
  return self;
}

- (REFInstancePairManager *)instancePairManager {
  return _testInstancePairManager;
}

- (NSString *)generateUniqueInstanceId:(NSObject *)instance {
  return @"test_instance_id";
}
@end

@implementation REFTestHandler
-(instancetype)init {
  self = [super init];
  if (self) {
    _testClassInstance = [[REFTestClass alloc] init];
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
@end

@implementation REFTestClass
@end

@implementation REFTestMessageDispatcher
- (void)sendCreateNewInstancePair:(NSString *)channelName
                   pairedInstance:(REFPairedInstance *)pairedInstance
                        arguments:(NSArray<id> *)arguments
                            owner:(BOOL)owner
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

- (void)sendDisposeInstancePair:(REFPairedInstance *)pairedInstance
                     completion:(void (^)(NSError *_Nullable))completion {
  completion(nil);
}
@end

@implementation REFTestInstancePairManager {
  REFThreadSafeMapTable *_instanceIdToInstance;
  REFThreadSafeMapTable *_instanceToInstanceId;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _instanceIdToInstance = [REFThreadSafeMapTable strongToStrongObjectsMapTable];
    _instanceToInstanceId = [REFThreadSafeMapTable strongToStrongObjectsMapTable];
  }
  return self;
}

- (BOOL)addPair:(NSObject *)instance instanceID:(NSString *)instanceID owner:(BOOL)owner {
  if ([self isPaired:instance]) return NO;
  [_instanceToInstanceId setObject:instanceID forKey:instance];
  [_instanceIdToInstance setObject:instance forKey:instanceID];
  return YES;
}

- (BOOL)isPaired:(NSObject *)instance {
  return [_instanceToInstanceId objectForKey:instance] != nil;
}

- (NSString *_Nullable)getInstanceID:(NSObject *)instance {
  return [_instanceToInstanceId objectForKey:instance];
}

- (NSObject *_Nullable)getInstance:(NSString *)instanceID {
  return [_instanceIdToInstance objectForKey:instanceID];
}

- (void)removePair:(NSString *)instanceID {
  NSObject *instance = [self getInstance:instanceID];
  [_instanceIdToInstance removeObjectForKey:instanceID];
  [_instanceToInstanceId removeObjectForKey:instance];
}
@end
