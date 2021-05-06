#import "REFReferenceMatchers.h"

@implementation REFTestMessenger {
  REFTestInstanceManager *_testInstanceManager;
}

- (instancetype)init {
  self = [super initWithMessageDispatcher:[[REFTestMessageDispatcher alloc] init]];
  if (self) {
    _testHandler = [[REFTestHandler alloc] init];
    [self registerHandler:@"test_channel" handler:_testHandler];
    _testInstanceManager = [[REFTestInstanceManager alloc] init];
  }
  return self;
}

- (REFInstanceManager *)instanceManager {
  return _testInstanceManager;
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

@implementation REFTestInstanceManager
- (NSString *)generateUniqueInstanceID:(NSObject *)instance {
  return @"test_instance_id";
}
@end
