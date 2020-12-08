#import "REFReferenceChannelManager.h"

@implementation REFReferenceChannelManager {
@public
  REFThreadSafeMapTable<NSString *, NSObject<REFReferenceChannelHandler> *> *_channelHandlers;
  REFRemoteReferenceMap *_referencePairs;
}

- (instancetype)initWithMessenger:(id<REFReferenceChannelMessenger>)messenger {
  self = [super init];
  if (self) {
    _messenger = messenger;
    _channelHandlers = [[REFThreadSafeMapTable alloc] init];
  }
  return self;
}

- (id<REFReferenceConverter>)converter {
  return [[REFStandardReferenceConverter alloc] init];
}

- (BOOL)isPaired:(NSObject *)instance {
  return [_referencePairs getPairedRemoteReference:instance] != nil;
}

- (void)registerHandler:(NSString *)channelName handler:(NSObject<REFReferenceChannelHandler> *)handler {
  [_channelHandlers setObject:handler forKey:channelName];
}

- (NSObject<REFReferenceChannelHandler> *)getChannelHandler:(NSString *)channelName {
  return [_channelHandlers objectForKey:channelName];
}

- (id)onReceiveCreateNewPair:(NSString *)handlerChannel
             remoteReference:(REFRemoteReference *)remoteReference
                   arguments:(NSArray<id> *)arguments {
  if ([_referencePairs getPairedObject:remoteReference]) return nil;
  
  NSObject *object = [[self getChannelHandler:handlerChannel] createInstance:self
                                                                   arguments:[[self converter] convertReferencesForLocalManager:self obj:arguments]];
  NSAssert(![self isPaired:object], @"");
  [_referencePairs add:object remoteReference:remoteReference];
  return object;
}

- (id)onReceiveInvokeStaticMethod:(NSString *)handlerChannel methodName:(NSString *)methodName arguments:(NSArray<id> *)arguments {
  NSObject *object = [[self getChannelHandler:handlerChannel] invokeStaticMethod:self
                                                                      methodName:methodName
                                                                       arguments:[[self converter] convertReferencesForLocalManager:self obj:arguments]];
  
  return [[self converter] convertReferencesForRemoteManager:self obj:object];
}

- (REFUnpairedReference *)createUnpairedReference:(NSString *)handlerChannel obj:(id)obj {
  NSObject<REFReferenceChannelHandler> *handler = [_channelHandlers objectForKey:handlerChannel];
  if (handler) return nil;
  
  return [[REFUnpairedReference alloc] initWithChannel:handlerChannel
                                     creationArguments:[handler getCreationArguments:self instance:obj]];
}

- (id)onReceiveInvokeMethod:(NSString *)handlerChannel
            remoteReference:(REFRemoteReference *)remoteReference
                 methodName:(NSString *)methodName
                  arguments:(NSArray<id> *)arguments {
  NSObject *object = [[self getChannelHandler:handlerChannel] invokeMethod:self
                                                                  instance:[_referencePairs getPairedObject:remoteReference]
                                                                methodName:methodName
                                                                 arguments:[[self converter] convertReferencesForLocalManager:self
                                                                                                                          obj:arguments]];
  
  return [[self converter] convertReferencesForRemoteManager:self obj:object];
}

- (id)onReceiveInvokeMethodOnUnpairedReference:(REFUnpairedReference *)unpairedReference
                                    methodName:(NSString *)methodName
                                     arguments:(NSArray<id> *)arguments {
  NSObject<REFReferenceChannelHandler> *handler = [self getChannelHandler:unpairedReference.handlerChannel];
  NSObject *object = [handler createInstance:self
                                   arguments:[[self converter] convertReferencesForLocalManager:self
                                                                                            obj:unpairedReference.creationArguments]];
  NSObject *result = [handler invokeMethod:self
                                  instance:object
                                methodName:methodName
                                 arguments:[[self converter] convertReferencesForLocalManager:self
                                                                                          obj:arguments]];
  
  return [[self converter] convertReferencesForRemoteManager:self obj:result];
}

- (void)onReceiveDisposePair:(NSString *)handlerChannel remoteReference:(REFRemoteReference *)remoteReference {
  NSObject *instance = [_referencePairs getPairedObject:remoteReference];
  if (!instance) return;
  
  [_referencePairs removePairWithObject:instance];
  [[self getChannelHandler:handlerChannel] onInstanceDisposed:self instance:instance];
}

- (NSString *)getNewReferenceId {
  return [[NSUUID UUID] UUIDString];
}
@end

@implementation REFReferenceChannel
- (instancetype)initWithManager:(REFReferenceChannelManager *)manager
                    channelName:(NSString *)channelName {
  self = [super init];
  if (self) {
    _manager = manager;
    _channelName = channelName;
  }
  return self;
}

- (void)registerHandler:(NSObject<REFReferenceChannelHandler> *)handler {
  [_manager registerHandler:_channelName handler:handler];
}

- (void)createNewPair:(id)instance
           completion:(void (^)(REFRemoteReference *_Nullable, NSError *_Nullable))completion {
  if ([_manager isPaired:instance]) {
    completion(nil, nil);
    return;
  }
  
  __block REFRemoteReference *remoteReference =
  [REFRemoteReference fromID:[_manager getNewReferenceId]];
  [_manager->_referencePairs add:instance remoteReference:remoteReference];
  
  NSArray<id> *creationArguments = [_manager.converter
                                    convertReferencesForRemoteManager:_manager
                                    obj:[[_manager getChannelHandler:_channelName] getCreationArguments:_manager instance:instance]];
  
  [_manager.messenger sendCreateNewPair:_channelName
                        remoteReference:remoteReference
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
   sendInvokeStaticMethod:_channelName
   methodName:methodName
   arguments:[_manager.converter convertReferencesForRemoteManager:_manager obj:arguments]
   completion:^(id result, NSError *error) {
    if (error) {
      completion(nil, error);
    } else {
      completion([self->_manager.converter convertReferencesForLocalManager:self->_manager obj:result],
                 nil);
    }
  }];
}

- (void)invokeMethod:(id)instance
          methodName:(NSString *)methodName
           arguments:(NSArray<id> *)arguments
          completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [_manager.messenger sendInvokeMethod:_channelName
                       remoteReference:[_manager->_referencePairs getPairedRemoteReference:instance]
                            methodName:methodName
                             arguments:[_manager.converter convertReferencesForRemoteManager:_manager obj:arguments]
                            completion:^(id result, NSError *error) {
    if (error) {
      completion(nil, error);
    } else {
      completion([self->_manager.converter convertReferencesForLocalManager:self->_manager obj:result], nil);
    }
  }];
}

- (void)invokeMethodOnUnpairedReference:(id)obj
                             methodName:(NSString *)methodName
                              arguments:(NSArray<id> *)arguments
                             completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [_manager.messenger sendInvokeMethodOnUnpairedReference:[_manager createUnpairedReference:_channelName obj:obj]
                                               methodName:methodName
                                                arguments:[_manager.converter convertReferencesForRemoteManager:_manager obj:arguments]
                                               completion:^(id result, NSError *error) {
    if (error) {
      completion(nil, error);
    } else {
      completion([self->_manager.converter convertReferencesForLocalManager:self->_manager obj:result], nil);
    }
  }];
}

- (void)disposePair:(id)instance
         completion:(void (^)(NSError *_Nullable))completion {
  REFRemoteReference *remoteReference = [_manager->_referencePairs getPairedRemoteReference:instance];
  if (remoteReference) {
    [_manager->_referencePairs removePairWithObject:instance];
    [_manager.messenger sendDisposePair:_channelName remoteReference:remoteReference completion:completion];
  }
}
@end

@implementation REFStandardReferenceConverter
- (id _Nullable)convertReferencesForRemoteManager:(REFReferenceChannelManager *)manager
                                              obj:(id _Nullable)obj {
  if ([manager isPaired:obj]) {
    return [manager->_referencePairs getPairedRemoteReference:obj];
  } else if (![manager isPaired:obj] && [obj conformsToProtocol:@protocol(REFReferencable)]) {
    id<REFReferencable> referencable = (id<REFReferencable>) obj;
    return [manager createUnpairedReference:referencable.referenceChannel.channelName obj:obj];
  } else if ([obj isKindOfClass:[NSArray class]]) {
    NSArray *array = obj;
    NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:array.count];
    for (id object in array) {
      [newArray addObject:[self convertReferencesForRemoteManager:manager obj:object]];
    }
    return newArray;
  } else if ([obj isKindOfClass:[NSDictionary class]]) {
    NSDictionary *dictionary = obj;
    NSMutableDictionary *newDictionary =
    [NSMutableDictionary dictionaryWithCapacity:dictionary.count];
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull object,
                                                    BOOL *_Nonnull stop) {
      [newDictionary setObject:[self convertReferencesForRemoteManager:manager obj:object]
                        forKey:[self convertReferencesForRemoteManager:manager obj:key]];
    }];
    
    return newDictionary;
  }
  
  return obj;
}

- (id _Nullable)convertReferencesForLocalManager:(REFReferenceChannelManager *)manager
                                             obj:(id _Nullable)obj {
  if ([obj isKindOfClass:[REFRemoteReference class]]) {
    return [manager->_referencePairs getPairedObject:obj];
  } else if ([obj isKindOfClass:[REFUnpairedReference class]]) {
    REFUnpairedReference *unpairedReference = (REFUnpairedReference *)obj;
    return [[manager
             getChannelHandler:unpairedReference.handlerChannel] createInstance:manager
            arguments:[self convertReferencesForLocalManager:manager
                                                         obj:unpairedReference.creationArguments]];
  } else if ([obj isKindOfClass:[NSArray class]]) {
    NSArray *array = obj;
    NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:array.count];
    for (id object in array) {
      [newArray addObject:[self convertReferencesForLocalManager:manager obj:object]];
    }
    return newArray;
  } else if ([obj isKindOfClass:[NSDictionary class]]) {
    NSDictionary *dictionary = obj;
    NSMutableDictionary *newDictionary =
    [NSMutableDictionary dictionaryWithCapacity:dictionary.count];
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull object,
                                                    BOOL *_Nonnull stop) {
      [newDictionary setObject:[self convertReferencesForLocalManager:manager obj:object]
                        forKey:[self convertReferencesForLocalManager:manager obj:key]];
    }];
    
    return newDictionary;
  }
  
  return obj;
}
@end
