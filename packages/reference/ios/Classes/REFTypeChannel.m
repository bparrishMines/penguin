#import "REFTypeChannel.h"

@implementation REFTypeChannelMessenger {
@public
  REFThreadSafeMapTable<NSString *, NSObject<REFTypeChannelHandler> *> *_channelHandlers;
  InstancePairManager *_instancePairManager;
}

- (instancetype)initWithMessageDispatcher:(id<REFTypeChannelMessageDispatcher>)messenger {
  self = [super init];
  if (self) {
    _messageDispatcher = messenger;
    _channelHandlers = [[REFThreadSafeMapTable alloc] init];
    _instancePairManager = [[InstancePairManager alloc] init];
  }
  return self;
}

- (BOOL)addInstancePair:(NSString *)channelName
               instance:(NSObject *)instance
         pairedInstance:(REFPairedInstance *)pairedInstance
                  owner:(NSObject *)owner {
  if ([_instancePairManager addPair:instance pairedInstance:pairedInstance owner:owner]) {
    NSObject<REFTypeChannelHandler> *handler = [self getChannelHandler:channelName];
    if (!handler) [handler onInstanceAdded:self instance:instance];
    return YES;
  }
  return NO;
}

- (BOOL)removeInstancePair:(NSString *)channelName
                  instance:(NSObject *)instance
                     owner:(NSObject *)owner
                     force:(BOOL)force {
  if ([_instancePairManager removePairWithObject:instance owner:owner force:force]) {
    NSObject<REFTypeChannelHandler> *handler = [self getChannelHandler:channelName];
    if (!handler) [handler onInstanceRemoved:self instance:instance];
    return YES;
  }
  
  return NO;
}

- (id<REFInstanceConverter>)converter {
  return [[REFStandardInstanceConverter alloc] init];
}

- (BOOL)isPaired:(NSObject *)instance {
  return [_instancePairManager isPaired:instance];
}

- (REFPairedInstance *)getPairedPairedInstance:(NSObject *)object {
  return [_instancePairManager getPairedPairedInstance:object];
}

- (NSObject *)getPairedObject:(REFPairedInstance *)pairedInstance {
  return [_instancePairManager getPairedObject:pairedInstance];
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

- (void)sendCreateNewInstancePair:(NSString *)channelName
                         instance:(NSObject *)instance
                            owner:(NSObject *)owner
                       completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  REFPairedInstance *pairedInstance = [REFPairedInstance fromID:[self generateUniqueInstanceId:instance]];
  
  NSObject<REFTypeChannelHandler> *handler = [self getChannelHandler:channelName];
  if (!handler) {
    NSLog(@"A `REFTypeChannelHandler` must be set for channel of: %@.", channelName);
    return;
  }
  
  BOOL createdNewInstance = [self addInstancePair:channelName
                                         instance:instance
                                   pairedInstance:pairedInstance
                                            owner:owner];
  
  if (!createdNewInstance) {
    completion(nil, nil);
    return;
  }
  
  NSArray<id> *creationArguments = [self.converter convertForRemoteMessenger:self
                                                                         obj:[[self
                                                                               getChannelHandler:channelName]
                                                                              getCreationArguments:self
                                                                              instance:instance]];
  
  [_messageDispatcher sendCreateNewInstancePair:channelName
                                 pairedInstance:pairedInstance
                                      arguments:creationArguments
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
                                   arguments:[self.converter convertForRemoteMessenger:self obj:arguments]
                                  completion:^(id result, NSError *error) {
    if (error) {
      completion(nil, error);
    } else {
      completion([self.converter convertForLocalMessenger:self obj:result], nil);
    }
  }];
}

- (void)sendInvokeMethod:(NSString *)channelName
                instance:(NSObject *)instance
              methodName:(NSString *)methodName
               arguments:(NSArray<id> *)arguments
              completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  if (![self isPaired:instance]) {
    [self sendInvokeMethodOnUnpairedInstance:channelName
                                      object:instance
                                  methodName:methodName
                                   arguments:arguments
                                  completion:completion];
    return;
  }
  
  [_messageDispatcher sendInvokeMethod:channelName
                        pairedInstance:[_instancePairManager getPairedPairedInstance:instance]
                            methodName:methodName
                             arguments:[self.converter convertForRemoteMessenger:self obj:arguments]
                            completion:^(id result, NSError *error) {
    if (error) {
      completion(nil, error);
    } else {
      completion([self.converter convertForLocalMessenger:self obj:result], nil);
    }
  }];
}

- (void)sendInvokeMethodOnUnpairedInstance:(NSString *)channelName
                                    object:(NSObject *)object
                                methodName:(NSString *)methodName
                                 arguments:(NSArray<id> *)arguments
                                completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [_messageDispatcher sendInvokeMethodOnUnpairedInstance:[self createUnpairedInstance:channelName
                                                                                  obj:object]
   
                                              methodName:methodName
                                               arguments:[self.converter
                                                          convertForRemoteMessenger:self
                                                          obj:arguments]
                                              completion:^(id result, NSError *error) {
    if (error) {
      completion(nil, error);
    } else {
      completion([self.converter convertForLocalMessenger:self obj:result], nil);
    }
  }];
}

- (void)sendDisposeInstancePair:(NSString *)channelName
                       instance:(NSObject *)instance
                          owner:(NSObject *)owner
                     completion:(void (^)(NSError *_Nullable))completion {
  if (![self isPaired:instance]) {
    completion(nil);
    return;
  }
  
  REFPairedInstance *pairedInstance = [_instancePairManager getPairedPairedInstance:instance];
  
  BOOL removedInstance = [self removeInstancePair:channelName instance:instance owner:owner force:NO];
  if (removedInstance) {
    [_messageDispatcher sendDisposeInstancePair:channelName
                                 pairedInstance:pairedInstance
                                     completion:completion];
  }
}

- (NSObject *)onReceiveCreateNewInstancePair:(NSString *)channelName
                              pairedInstance:(REFPairedInstance *)pairedInstance
                                   arguments:(NSArray<id> *)arguments {
  if ([_instancePairManager getPairedObject:pairedInstance]) return nil;
  
  NSObject *object = [[self getChannelHandler:channelName] createInstance:self
                                                                arguments:[[self converter]
                                                                           convertForLocalMessenger:self obj:arguments]];
  NSAssert(![self isPaired:object], @"");
  [self addInstancePair:channelName instance:object pairedInstance:pairedInstance owner:object];
  return object;
}

- (id)onReceiveInvokeStaticMethod:(NSString *)channelName
                       methodName:(NSString *)methodName
                        arguments:(NSArray<id> *)arguments {
  NSObject *object = [[self getChannelHandler:channelName] invokeStaticMethod:self
                                                                   methodName:methodName
                                                                    arguments:[[self converter] convertForLocalMessenger:self obj:arguments]];
  return [[self converter] convertForRemoteMessenger:self obj:object];
}

- (REFNewUnpairedInstance *)createUnpairedInstance:(NSString *)channelName obj:(id)obj {
  NSObject<REFTypeChannelHandler> *handler = [_channelHandlers objectForKey:channelName];
  if (!handler) return nil;
  
  return [[REFNewUnpairedInstance alloc] initWithChannelName:channelName
                                           creationArguments:[handler getCreationArguments:self instance:obj]];
}

- (id)onReceiveInvokeMethod:(NSString *)channelName
             pairedInstance:(REFPairedInstance *)pairedInstance
                 methodName:(NSString *)methodName
                  arguments:(NSArray<id> *)arguments {
  NSObject *object = [[self getChannelHandler:channelName] invokeMethod:self
                                                               instance:[_instancePairManager getPairedObject:pairedInstance]
                                                             methodName:methodName
                                                              arguments:[[self converter]
                                                                         convertForLocalMessenger:self
                                                                         obj:arguments]];
  
  return [[self converter] convertForRemoteMessenger:self obj:object];
}

- (id)onReceiveInvokeMethodOnUnpairedInstance:(REFNewUnpairedInstance *)unpairedInstance
                                   methodName:(NSString *)methodName
                                    arguments:(NSArray<id> *)arguments {
  NSObject<REFTypeChannelHandler> *handler = [self getChannelHandler:unpairedInstance.channelName];
  NSObject *object = [handler createInstance:self
                                   arguments:[[self converter] convertForLocalMessenger:self
                                                                                    obj:unpairedInstance.creationArguments]];
  NSObject *result = [handler invokeMethod:self
                                  instance:object
                                methodName:methodName
                                 arguments:[[self converter] convertForLocalMessenger:self
                                                                                  obj:arguments]];
  
  return [[self converter] convertForRemoteMessenger:self obj:result];
}

- (void)onReceiveDisposeInstancePair:(NSString *)channelName
                      pairedInstance:(REFPairedInstance *)pairedInstance {
  NSObject *instance = [_instancePairManager getPairedObject:pairedInstance];
  if (!instance) return;
  
  [self removeInstancePair:channelName instance:instance owner:instance force:YES];
}

- (NSString *)generateUniqueInstanceId:(NSObject *)instance {
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

- (REFNewUnpairedInstance *_Nullable)createUnpairedInstance:(id)instance {
  return [_messenger createUnpairedInstance:_name obj:instance];
}

- (void)createNewInstancePair:(NSObject *)instance
                   completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  return [self createNewInstancePair:instance owner:instance completion:completion];
}

- (void)createNewInstancePair:(NSObject *)instance
                        owner:(NSObject *)owner
                   completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [_messenger sendCreateNewInstancePair:_name instance:instance owner:owner completion:completion];
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

- (void)disposeInstancePair:(id)instance
                 completion:(void (^)(NSError *_Nullable))completion {
  [self disposeInstancePair:instance owner:instance completion:completion];
}

- (void)disposeInstancePair:(id)instance
                      owner:(NSObject *)owner
                 completion:(void (^)(NSError *_Nullable))completion {
  [_messenger sendDisposeInstancePair:_name instance:instance owner:owner completion:completion];
}
@end

@implementation REFStandardInstanceConverter
- (id _Nullable)convertForRemoteMessenger:(REFTypeChannelMessenger *)messenger
                                      obj:(id _Nullable)obj {
  if ([messenger isPaired:obj]) {
    return [messenger getPairedPairedInstance:obj];
  } else if (![messenger isPaired:obj] && [obj conformsToProtocol:@protocol(REFReferenceType)]) {
    id<REFReferenceType> referencable = (id<REFReferenceType>) obj;
    return [referencable.typeChannel createUnpairedInstance:obj];
  } else if ([obj isKindOfClass:[NSArray class]]) {
    NSArray *array = obj;
    NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:array.count];
    for (id object in array) {
      [newArray addObject:[self convertForRemoteMessenger:messenger obj:object]];
    }
    return newArray;
  } else if ([obj isKindOfClass:[NSDictionary class]]) {
    NSDictionary *dictionary = obj;
    NSMutableDictionary *newDictionary =
    [NSMutableDictionary dictionaryWithCapacity:dictionary.count];
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull object,
                                                    BOOL *_Nonnull stop) {
      [newDictionary setObject:[self convertForRemoteMessenger:messenger obj:object]
                        forKey:[self convertForRemoteMessenger:messenger obj:key]];
    }];
    
    return newDictionary;
  }
  
  return obj;
}

- (id _Nullable)convertForLocalMessenger:(REFTypeChannelMessenger *)messenger
                                     obj:(id _Nullable)obj {
  if ([obj isKindOfClass:[REFPairedInstance class]]) {
    return [messenger getPairedObject:obj];
  } else if ([obj isKindOfClass:[REFNewUnpairedInstance class]]) {
    REFNewUnpairedInstance *unpairedReference = (REFNewUnpairedInstance *)obj;
    return [[messenger
             getChannelHandler:unpairedReference.channelName] createInstance:messenger
            arguments:[self convertForLocalMessenger:messenger
                                                 obj:unpairedReference.creationArguments]];
  } else if ([obj isKindOfClass:[NSArray class]]) {
    NSArray *array = obj;
    NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:array.count];
    for (id object in array) {
      [newArray addObject:[self convertForLocalMessenger:messenger obj:object]];
    }
    return newArray;
  } else if ([obj isKindOfClass:[NSDictionary class]]) {
    NSDictionary *dictionary = obj;
    NSMutableDictionary *newDictionary =
    [NSMutableDictionary dictionaryWithCapacity:dictionary.count];
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull object,
                                                    BOOL *_Nonnull stop) {
      [newDictionary setObject:[self convertForLocalMessenger:messenger obj:object]
                        forKey:[self convertForLocalMessenger:messenger obj:key]];
    }];
    
    return newDictionary;
  }
  
  return obj;
}
@end
