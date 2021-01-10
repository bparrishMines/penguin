#import "REFTypeChannel.h"

@implementation REFTypeChannelManager {
@public
  REFThreadSafeMapTable<NSString *, NSObject<REFTypeChannelHandler> *> *_channelHandlers;
  REFPairedInstanceMap *_instancePairs;
}

- (instancetype)initWithMessenger:(id<REFTypeChannelMessenger>)messenger {
  self = [super init];
  if (self) {
    _messenger = messenger;
    _channelHandlers = [[REFThreadSafeMapTable alloc] init];
    _instancePairs = [[REFPairedInstanceMap alloc] init];
  }
  return self;
}

- (id<REFInstanceConverter>)converter {
  return [[REFStandardInstanceConverter alloc] init];
}

- (BOOL)isPaired:(NSObject *)instance {
  return [_instancePairs getPairedInstance:instance] != nil;
}

- (void)registerHandler:(NSString *)channelName handler:(NSObject<REFTypeChannelHandler> *)handler {
  [_channelHandlers setObject:handler forKey:channelName];
}

- (NSObject<REFTypeChannelHandler> *)getChannelHandler:(NSString *)channelName {
  return [_channelHandlers objectForKey:channelName];
}

- (id)onReceiveCreateNewInstancePair:(NSString *)channelName
             pairedInstance:(REFPairedInstance *)pairedInstance
                   arguments:(NSArray<id> *)arguments {
  if ([_instancePairs getPairedObject:pairedInstance]) return nil;
  
  NSObject *object = [[self getChannelHandler:channelName] createInstance:self
                                                                   arguments:[[self converter] convertForLocalManager:self obj:arguments]];
  NSAssert(![self isPaired:object], @"");
  [_instancePairs add:object pairedInstance:pairedInstance];
  return object;
}

- (id)onReceiveInvokeStaticMethod:(NSString *)channelName
                       methodName:(NSString *)methodName
                        arguments:(NSArray<id> *)arguments {
  NSObject *object = [[self getChannelHandler:channelName] invokeStaticMethod:self
                                                                      methodName:methodName
                                                                       arguments:[[self converter] convertForLocalManager:self obj:arguments]];
  
  return [[self converter] convertForRemoteManager:self obj:object];
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
                                                                  instance:[_instancePairs getPairedObject:pairedInstance]
                                                                methodName:methodName
                                                                 arguments:[[self converter] convertForLocalManager:self
                                                                                                                          obj:arguments]];
  
  return [[self converter] convertForRemoteManager:self obj:object];
}

- (id)onReceiveInvokeMethodOnUnpairedInstance:(REFNewUnpairedInstance *)unpairedInstance
                                    methodName:(NSString *)methodName
                                     arguments:(NSArray<id> *)arguments {
  NSObject<REFTypeChannelHandler> *handler = [self getChannelHandler:unpairedInstance.channelName];
  NSObject *object = [handler createInstance:self
                                   arguments:[[self converter] convertForLocalManager:self
                                                                                            obj:unpairedInstance.creationArguments]];
  NSObject *result = [handler invokeMethod:self
                                  instance:object
                                methodName:methodName
                                 arguments:[[self converter] convertForLocalManager:self
                                                                                          obj:arguments]];
  
  return [[self converter] convertForRemoteManager:self obj:result];
}

- (void)onReceiveDisposePair:(NSString *)channelName pairedInstance:(REFPairedInstance *)pairedInstance {
  NSObject *instance = [_instancePairs getPairedObject:pairedInstance];
  if (!instance) return;
  
  [_instancePairs removePairWithObject:instance];
  [[self getChannelHandler:channelName] onInstanceDisposed:self instance:instance];
}

- (NSString *)generateUniqueInstanceId {
  return [[NSUUID UUID] UUIDString];
}
@end

@implementation REFTypeChannel
- (instancetype)initWithManager:(REFTypeChannelManager *)manager
                    name:(NSString *)channelName {
  self = [super init];
  if (self) {
    _manager = manager;
    _name = channelName;
  }
  return self;
}

- (void)setHandler:(NSObject<REFTypeChannelHandler> *)handler {
  [_manager registerHandler:_name handler:handler];
}

- (REFNewUnpairedInstance *_Nullable)createUnpairedInstance:(id)instance {
  return [_manager createUnpairedInstance:_name obj:instance];
}

- (void)createNewInstancePair:(id)instance
           completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  if ([_manager isPaired:instance]) {
    completion(nil, nil);
    return;
  }
  
  __block REFPairedInstance *remoteReference =
  [REFPairedInstance fromID:[_manager generateUniqueInstanceId]];
  [_manager->_instancePairs add:instance pairedInstance:remoteReference];
  
  NSArray<id> *creationArguments = [_manager.converter
                                    convertForRemoteManager:_manager
                                    obj:[[_manager getChannelHandler:_name] getCreationArguments:_manager instance:instance]];
  
  [_manager.messenger sendCreateNewInstancePair:_name
                        pairedInstance:remoteReference
                              arguments:creationArguments
                             completion:^(NSError *error) {
    if (error) {
      completion(nil, error);
    } else {
      completion(remoteReference, nil);
    }
  }];
}

- (void)invokeStaticMethod:(NSString *)methodName
                 arguments:(NSArray<id> *)arguments
                completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [_manager.messenger
   sendInvokeStaticMethod:_name
   methodName:methodName
   arguments:[_manager.converter convertForRemoteManager:_manager obj:arguments]
   completion:^(id result, NSError *error) {
    if (error) {
      completion(nil, error);
    } else {
      completion([self->_manager.converter convertForLocalManager:self->_manager obj:result],
                 nil);
    }
  }];
}

- (void)invokeMethod:(id)instance
          methodName:(NSString *)methodName
           arguments:(NSArray<id> *)arguments
          completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [_manager.messenger sendInvokeMethod:_name
                       pairedInstance:[_manager->_instancePairs getPairedInstance:instance]
                            methodName:methodName
                             arguments:[_manager.converter convertForRemoteManager:_manager obj:arguments]
                            completion:^(id result, NSError *error) {
    if (error) {
      completion(nil, error);
    } else {
      completion([self->_manager.converter convertForLocalManager:self->_manager obj:result], nil);
    }
  }];
}

- (void)invokeMethodOnUnpairedReference:(id)obj
                             methodName:(NSString *)methodName
                              arguments:(NSArray<id> *)arguments
                             completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [_manager.messenger sendInvokeMethodOnUnpairedInstance:[_manager createUnpairedInstance:_name obj:obj]
                                               methodName:methodName
                                                arguments:[_manager.converter convertForRemoteManager:_manager obj:arguments]
                                               completion:^(id result, NSError *error) {
    if (error) {
      completion(nil, error);
    } else {
      completion([self->_manager.converter convertForLocalManager:self->_manager obj:result], nil);
    }
  }];
}

- (void)disposePair:(id)instance
         completion:(void (^)(NSError *_Nullable))completion {
  REFPairedInstance *remoteReference = [_manager->_instancePairs getPairedInstance:instance];
  if (remoteReference) {
    [_manager->_instancePairs removePairWithObject:instance];
    [_manager.messenger sendDisposePair:_name pairedInstance:remoteReference completion:completion];
  }
}
@end

@implementation REFStandardInstanceConverter
- (id _Nullable)convertForRemoteManager:(REFTypeChannelManager *)manager
                                              obj:(id _Nullable)obj {
  if ([manager isPaired:obj]) {
    return [manager->_instancePairs getPairedInstance:obj];
  } else if (![manager isPaired:obj] && [obj conformsToProtocol:@protocol(REFPairableInstance)]) {
    id<REFPairableInstance> referencable = (id<REFPairableInstance>) obj;
    return [referencable.typeChannel createUnpairedInstance:obj];
  } else if ([obj isKindOfClass:[NSArray class]]) {
    NSArray *array = obj;
    NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:array.count];
    for (id object in array) {
      [newArray addObject:[self convertForRemoteManager:manager obj:object]];
    }
    return newArray;
  } else if ([obj isKindOfClass:[NSDictionary class]]) {
    NSDictionary *dictionary = obj;
    NSMutableDictionary *newDictionary =
    [NSMutableDictionary dictionaryWithCapacity:dictionary.count];
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull object,
                                                    BOOL *_Nonnull stop) {
      [newDictionary setObject:[self convertForRemoteManager:manager obj:object]
                        forKey:[self convertForRemoteManager:manager obj:key]];
    }];
    
    return newDictionary;
  }
  
  return obj;
}

- (id _Nullable)convertForLocalManager:(REFTypeChannelManager *)manager
                                             obj:(id _Nullable)obj {
  if ([obj isKindOfClass:[REFPairedInstance class]]) {
    return [manager->_instancePairs getPairedObject:obj];
  } else if ([obj isKindOfClass:[REFNewUnpairedInstance class]]) {
    REFNewUnpairedInstance *unpairedReference = (REFNewUnpairedInstance *)obj;
    return [[manager
             getChannelHandler:unpairedReference.channelName] createInstance:manager
            arguments:[self convertForLocalManager:manager
                                                         obj:unpairedReference.creationArguments]];
  } else if ([obj isKindOfClass:[NSArray class]]) {
    NSArray *array = obj;
    NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:array.count];
    for (id object in array) {
      [newArray addObject:[self convertForLocalManager:manager obj:object]];
    }
    return newArray;
  } else if ([obj isKindOfClass:[NSDictionary class]]) {
    NSDictionary *dictionary = obj;
    NSMutableDictionary *newDictionary =
    [NSMutableDictionary dictionaryWithCapacity:dictionary.count];
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull object,
                                                    BOOL *_Nonnull stop) {
      [newDictionary setObject:[self convertForLocalManager:manager obj:object]
                        forKey:[self convertForLocalManager:manager obj:key]];
    }];
    
    return newDictionary;
  }
  
  return obj;
}
@end
