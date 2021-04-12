#import "REFTypeChannel.h"

@implementation REFTypeChannelMessenger {
@public
  REFThreadSafeMapTable<NSString *, NSObject<REFTypeChannelHandler> *> *_channelHandlers;
  REFInstancePairManager *_instancePairManager;
}

- (instancetype)initWithMessageDispatcher:(id<REFTypeChannelMessageDispatcher>)messageDispatcher {
  self = [super init];
  if (self) {
    _messageDispatcher = messageDispatcher;
    _channelHandlers = [REFThreadSafeMapTable strongToStrongObjectsMapTable];
    _instancePairManager = [[REFInstancePairManager alloc] init];
  }
  return self;
}

- (void)removeInstancePair:(REFPairedInstance *)pairedInstance {
  [[self instancePairManager] removePair:pairedInstance.instanceID];
}

- (BOOL)addInstancePair:(NSObject *)instance
         pairedInstance:(REFPairedInstance *)pairedInstance
                  owner:(BOOL)owner {
  return [[self instancePairManager] addPair:instance instanceID:pairedInstance.instanceID owner:owner];
}

- (REFInstancePairManager *)instancePairManager {
  return _instancePairManager;
}

- (id<REFInstanceConverter>)converter {
  return [[REFStandardInstanceConverter alloc] init];
}

- (BOOL)isPaired:(NSObject *)instance {
  return [[self instancePairManager] isPaired:instance];
}

- (REFPairedInstance *)getPairedPairedInstance:(NSObject *)instance {
  NSString *instanceID = [[self instancePairManager] getInstanceID:instance];
  if (instanceID) return [REFPairedInstance fromID:instanceID];
  return nil;
}

- (NSObject *)getPairedObject:(REFPairedInstance *)pairedInstance {
  return [[self instancePairManager] getInstance:pairedInstance.instanceID];
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
                            owner:(BOOL)owner
                       completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  if ([self isPaired:instance]) {
    completion(nil, nil);
    return;
  }
  
  NSObject<REFTypeChannelHandler> *handler = [self getChannelHandler:channelName];
  if (!handler) {
    NSLog(@"A `REFTypeChannelHandler` must be set for channel of: %@.", channelName);
    return;
  }
  
  REFPairedInstance *pairedInstance = [REFPairedInstance fromID:[self generateUniqueInstanceID:instance]];
  
  [self addInstancePair:instance
         pairedInstance:pairedInstance
                  owner:owner];
  
  NSArray<id> *creationArguments = [self.converter convertInstancesToPairedInstances:self
                                                                         obj:[[self
                                                                               getChannelHandler:channelName]
                                                                              getCreationArguments:self
                                                                              instance:instance]];
  
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
                                   arguments:[self.converter convertInstancesToPairedInstances:self obj:arguments]
                                  completion:^(id result, NSError *error) {
    if (error) {
      completion(nil, error);
    } else {
      completion([self.converter convertPairedInstancesToInstances:self obj:result], nil);
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
                             arguments:[self.converter convertInstancesToPairedInstances:self obj:arguments]
                            completion:^(id result, NSError *error) {
    if (error) {
      completion(nil, error);
    } else {
      completion([self.converter convertPairedInstancesToInstances:self obj:result], nil);
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
  [self removeInstancePair:pairedInstance];
  [_messageDispatcher sendDisposeInstancePair:pairedInstance completion:completion];
}

- (NSObject *)onReceiveCreateNewInstancePair:(NSString *)channelName
                              pairedInstance:(REFPairedInstance *)pairedInstance
                                   arguments:(NSArray<id> *)arguments
                                       owner:(BOOL)owner {
  NSAssert(![self getPairedObject:pairedInstance], @"An object with `PairedInstance` has already been created.");
  NSObject *instance = [[self getChannelHandler:channelName] createInstance:self
                                                                arguments:[[self converter]
                                                                           convertPairedInstancesToInstances:self obj:arguments]];

  NSAssert(![self isPaired:instance], @"");
  [self addInstancePair:instance pairedInstance:pairedInstance owner:owner];
  return instance;
}

- (id)onReceiveInvokeStaticMethod:(NSString *)channelName
                       methodName:(NSString *)methodName
                        arguments:(NSArray<id> *)arguments {
  NSObject *object = [[self getChannelHandler:channelName] invokeStaticMethod:self
                                                                   methodName:methodName
                                                                    arguments:[[self converter] convertPairedInstancesToInstances:self obj:arguments]];
  return [[self converter] convertInstancesToPairedInstances:self obj:object];
}

- (id)onReceiveInvokeMethod:(NSString *)channelName
             pairedInstance:(REFPairedInstance *)pairedInstance
                 methodName:(NSString *)methodName
                  arguments:(NSArray<id> *)arguments {
  NSObject *object = [[self getChannelHandler:channelName] invokeMethod:self
                                                               instance:[self getPairedObject:pairedInstance]
                                                             methodName:methodName
                                                              arguments:[[self converter]
                                                                         convertPairedInstancesToInstances:self
                                                                         obj:arguments]];
  
  return [[self converter] convertInstancesToPairedInstances:self obj:object];
}

- (void)onReceiveDisposeInstancePair:(REFPairedInstance *)pairedInstance {
  NSAssert([self getPairedObject:pairedInstance], @"The Object with the following PairedInstance has already been disposed: %@", pairedInstance);
  [self removeInstancePair:pairedInstance];
}

- (NSString *)generateUniqueInstanceID:(NSObject *)instance {
  return [@(instance.hash) stringValue];
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
                   completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  return [self createNewInstancePair:instance owner:instance completion:completion];
}

- (void)createNewInstancePair:(NSObject *)instance
                        owner:(BOOL)owner
                   completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [_messenger createNewInstancePair:_name instance:instance owner:owner completion:completion];
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
- (id _Nullable)convertInstancesToPairedInstances:(REFTypeChannelMessenger *)messenger
                                      obj:(id _Nullable)obj {
  if ([messenger isPaired:obj]) {
    return [messenger getPairedPairedInstance:obj];
  } else if ([obj isKindOfClass:[NSArray class]]) {
    NSArray *array = obj;
    NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:array.count];
    for (id object in array) {
      [newArray addObject:[self convertInstancesToPairedInstances:messenger obj:object]];
    }
    return newArray;
  } else if ([obj isKindOfClass:[NSDictionary class]]) {
    NSDictionary *dictionary = obj;
    NSMutableDictionary *newDictionary =
    [NSMutableDictionary dictionaryWithCapacity:dictionary.count];
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull object,
                                                    BOOL *_Nonnull stop) {
      [newDictionary setObject:[self convertInstancesToPairedInstances:messenger obj:object]
                        forKey:[self convertInstancesToPairedInstances:messenger obj:key]];
    }];
    
    return newDictionary;
  }
  
  return obj;
}

- (id _Nullable)convertPairedInstancesToInstances:(REFTypeChannelMessenger *)messenger
                                     obj:(id _Nullable)obj {
  if ([obj isKindOfClass:[REFPairedInstance class]]) {
    return [messenger getPairedObject:obj];
  } else if ([obj isKindOfClass:[NSArray class]]) {
    NSArray *array = obj;
    NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:array.count];
    for (id object in array) {
      [newArray addObject:[self convertPairedInstancesToInstances:messenger obj:object]];
    }
    return newArray;
  } else if ([obj isKindOfClass:[NSDictionary class]]) {
    NSDictionary *dictionary = obj;
    NSMutableDictionary *newDictionary =
    [NSMutableDictionary dictionaryWithCapacity:dictionary.count];
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull object,
                                                    BOOL *_Nonnull stop) {
      [newDictionary setObject:[self convertPairedInstancesToInstances:messenger obj:object]
                        forKey:[self convertPairedInstancesToInstances:messenger obj:key]];
    }];
    
    return newDictionary;
  }
  
  return obj;
}
@end
