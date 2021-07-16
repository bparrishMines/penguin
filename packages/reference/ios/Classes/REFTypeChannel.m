#import "REFTypeChannel.h"

@implementation REFTypeChannelMessenger {
@public
  REFThreadSafeMapTable<NSString *, NSObject<REFTypeChannelHandler> *> *_channelHandlers;
  REFInstanceManager *_instanceManager;
}

- (instancetype)initWithMessageDispatcher:(id<REFTypeChannelMessageDispatcher>)messageDispatcher {
  self = [super init];
  if (self) {
    _messageDispatcher = messageDispatcher;
    _channelHandlers = [REFThreadSafeMapTable strongToStrongObjectsMapTable];
    _instanceManager = [[REFInstanceManager alloc] init];
  }
  return self;
}

- (BOOL)addInstancePair:(NSObject *)instance
             instanceID:(NSString *_Nullable)instanceID
                  owner:(BOOL)owner {
  if (owner && instanceID) {
    return [[self instanceManager] addTemporaryStrongReference:instance
                                                    instanceID:instanceID
                                                    onFinalize:^(NSString *instanceID) {
      [[self messageDispatcher] sendDisposeInstancePair:[REFPairedInstance fromID:instanceID]
                                             completion:^(NSError *error) {}];
    }];
  } else if (owner) {
    return [[self instanceManager] addWeakReference:instance
                                         instanceID:instanceID
                                         onFinalize:^(NSString *instanceID) {
      [[self messageDispatcher] sendDisposeInstancePair:[REFPairedInstance fromID:instanceID]
                                             completion:^(NSError *error) {}];
    }];
  } else {
    return [[self instanceManager] addStrongReference:instance instanceID:instanceID];
  }
}

- (REFInstanceManager *)instanceManager {
  return _instanceManager;
}

- (id<REFInstanceConverter>)converter {
  return [[REFStandardInstanceConverter alloc] init];
}

- (BOOL)isPaired:(NSObject *)instance {
  return [[self instanceManager] containsInstance:instance];
}

- (REFPairedInstance *)getPairedPairedInstance:(NSObject *)instance {
  NSString *instanceID = [[self instanceManager] getInstanceID:instance];
  if (instanceID) return [REFPairedInstance fromID:instanceID];
  return nil;
}

- (NSObject *)getPairedObject:(REFPairedInstance *)pairedInstance {
  return [[self instanceManager] getInstance:pairedInstance.instanceID];
}

- (void)registerHandler:(NSString *)channelName handler:(NSObject<REFTypeChannelHandler> *)handler {
  [_channelHandlers setObject:handler forKey:channelName];
}

- (void)unregisterHandler:(NSString *)channelName {
  [_channelHandlers removeObjectForKey:channelName];
}

- (NSObject<REFTypeChannelHandler> *)getChannelHandler:(NSString *)channelName {
  return [_channelHandlers objectForKey:channelName];
}

- (void)createNewInstancePair:(NSString *)channelName
                     instance:(NSObject *)instance
                    arguments:(nonnull NSArray<id> *)arguments
                        owner:(BOOL)owner
                   completion:(nonnull void (^)(REFPairedInstance * _Nullable, NSError * _Nullable))completion {
  if ([self isPaired:instance]) {
    completion(nil, nil);
    return;
  }
  
  [self addInstancePair:instance instanceID:nil owner:owner];
  REFPairedInstance *pairedInstance = [self getPairedPairedInstance:instance];
  NSArray<id> *creationArguments = [self.converter convertInstances:[self instanceManager]
                                                                obj:arguments];
  
  [_messageDispatcher sendCreateNewInstancePair:channelName
                                 pairedInstance:pairedInstance
                                      arguments:creationArguments
                                          owner:!owner
                                     completion:^(NSError *error) {
    if (error) {
      completion(nil, error);
    } else {
      completion(pairedInstance, nil);
    }
  }];
}

- (void)sendInvokeStaticMethod:(NSString *)channelName
                    methodName:(NSString *)methodName
                     arguments:(NSArray<id> *)arguments
                    completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [_messageDispatcher sendInvokeStaticMethod:channelName
                                  methodName:methodName
                                   arguments:[self.converter convertInstances:[self instanceManager] obj:arguments]
                                  completion:^(id result, NSError *error) {
    if (error) {
      completion(nil, error);
    } else {
      completion([self.converter convertPairedInstances:[self instanceManager] obj:result], nil);
    }
  }];
}

- (void)sendInvokeMethod:(NSString *)channelName
                instance:(NSObject *)instance
              methodName:(NSString *)methodName
               arguments:(NSArray<id> *)arguments
              completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  NSAssert([self isPaired:instance], @"");
  
  [_messageDispatcher sendInvokeMethod:channelName
                        pairedInstance:[self getPairedPairedInstance:instance]
                            methodName:methodName
                             arguments:[self.converter convertInstances:[self instanceManager] obj:arguments]
                            completion:^(id result, NSError *error) {
    if (error) {
      completion(nil, error);
    } else {
      completion([self.converter convertPairedInstances:[self instanceManager] obj:result], nil);
    }
  }];
}

- (void)disposeInstancePair:(NSObject *)instance
                 completion:(void (^)(NSError *_Nullable))completion {
  if (![self isPaired:instance]) {
    completion(nil);
    return;
  }
  
  REFPairedInstance *pairedInstance = [self getPairedPairedInstance:instance];
  [[self instanceManager] removeInstance:pairedInstance.instanceID];
  [_messageDispatcher sendDisposeInstancePair:pairedInstance completion:completion];
}

- (NSObject *)onReceiveCreateNewInstancePair:(NSString *)channelName
                              pairedInstance:(REFPairedInstance *)pairedInstance
                                   arguments:(NSArray<id> *)arguments
                                       owner:(BOOL)owner {
  NSAssert(![self getPairedObject:pairedInstance], @"An object with `PairedInstance` has already been created.");
  NSObject *instance = [[self getChannelHandler:channelName] createInstance:self
                                                                  arguments:[[self converter]
                                                                             convertPairedInstances:[self instanceManager] obj:arguments]];
  
  NSAssert(![self isPaired:instance], @"");
  [self addInstancePair:instance instanceID:pairedInstance.instanceID owner:owner];
  return instance;
}

- (id)onReceiveInvokeStaticMethod:(NSString *)channelName
                       methodName:(NSString *)methodName
                        arguments:(NSArray<id> *)arguments {
  NSObject *object = [[self getChannelHandler:channelName] invokeStaticMethod:self
                                                                   methodName:methodName
                                                                    arguments:[[self converter] convertPairedInstances:[self instanceManager] obj:arguments]];
  return [[self converter] convertInstances:[self instanceManager] obj:object];
}

- (id)onReceiveInvokeMethod:(NSString *)channelName
             pairedInstance:(REFPairedInstance *)pairedInstance
                 methodName:(NSString *)methodName
                  arguments:(NSArray<id> *)arguments {
  NSObject *object = [[self getChannelHandler:channelName] invokeMethod:self
                                                               instance:[self getPairedObject:pairedInstance]
                                                             methodName:methodName
                                                              arguments:[[self converter]
                                                                         convertPairedInstances:[self instanceManager]
                                                                         obj:arguments]];
  
  return [[self converter] convertInstances:[self instanceManager] obj:object];
}

- (void)onReceiveDisposeInstancePair:(REFPairedInstance *)pairedInstance {
  NSAssert([self getPairedObject:pairedInstance], @"The Object with the following PairedInstance has already been disposed: %@", pairedInstance);
  [[self instanceManager] removeInstance:pairedInstance.instanceID];
}
@end

@implementation REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger
                             name:(NSString *)channelName {
  self = [super init];
  if (self) {
    _messenger = messenger;
    _name = channelName;
  }
  return self;
}

- (void)setHandler:(NSObject<REFTypeChannelHandler> *)handler {
  [_messenger registerHandler:_name handler:handler];
}

- (void)removeHandler {
  [_messenger unregisterHandler:_name];
}

- (void)createNewInstancePair:(NSObject *)instance
                    arguments:(nonnull NSArray<id> *)arguments
                        owner:(BOOL)owner
                   completion:(nonnull void (^)(REFPairedInstance * _Nullable, NSError * _Nullable))completion {
  [_messenger createNewInstancePair:_name instance:instance arguments:arguments owner:owner completion:completion];
}

- (void)invokeStaticMethod:(NSString *)methodName
                 arguments:(NSArray<id> *)arguments
                completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  return [_messenger sendInvokeStaticMethod:_name
                                 methodName:methodName
                                  arguments:arguments
                                 completion:completion];
}

- (void)invokeMethod:(NSObject *)instance
          methodName:(NSString *)methodName
           arguments:(NSArray<id> *)arguments
          completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [_messenger sendInvokeMethod:_name
                      instance:instance
                    methodName:methodName
                     arguments:arguments
                    completion:completion];
}

- (void)disposeInstancePair:(NSObject *)instance
                 completion:(void (^)(NSError *_Nullable))completion {
  [_messenger disposeInstancePair:instance completion:completion];
}
@end

@implementation REFStandardInstanceConverter
- (id _Nullable)convertInstances:(REFInstanceManager *)manager
                             obj:(id _Nullable)obj {
  if ([manager containsInstance:obj]) {
    return [REFPairedInstance fromID:[manager getInstanceID:obj]];
  } else if ([obj isKindOfClass:[NSArray class]]) {
    NSArray *array = obj;
    NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:array.count];
    for (id object in array) {
      [newArray addObject:[self convertInstances:manager obj:object]];
    }
    return newArray;
  } else if ([obj isKindOfClass:[NSDictionary class]]) {
    NSDictionary *dictionary = obj;
    NSMutableDictionary *newDictionary =
    [NSMutableDictionary dictionaryWithCapacity:dictionary.count];
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull object,
                                                    BOOL *_Nonnull stop) {
      [newDictionary setObject:[self convertInstances:manager obj:object]
                        forKey:[self convertInstances:manager obj:key]];
    }];
    
    return newDictionary;
  }
  
  return obj;
}

- (id _Nullable)convertPairedInstances:(REFInstanceManager *)manager
                                   obj:(id _Nullable)obj {
  if ([obj isKindOfClass:[REFPairedInstance class]]) {
    REFPairedInstance *pairedInstance = (REFPairedInstance *) obj;
    return [manager getInstance:pairedInstance.instanceID];
  } else if ([obj isKindOfClass:[NSArray class]]) {
    NSArray *array = obj;
    NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:array.count];
    for (id object in array) {
      [newArray addObject:[self convertPairedInstances:manager obj:object]];
    }
    return newArray;
  } else if ([obj isKindOfClass:[NSDictionary class]]) {
    NSDictionary *dictionary = obj;
    NSMutableDictionary *newDictionary =
    [NSMutableDictionary dictionaryWithCapacity:dictionary.count];
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull object,
                                                    BOOL *_Nonnull stop) {
      [newDictionary setObject:[self convertPairedInstances:manager obj:object]
                        forKey:[self convertPairedInstances:manager obj:key]];
    }];
    
    return newDictionary;
  }
  
  return obj;
}
@end
