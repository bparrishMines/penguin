#import "REFReferencePairManager.h"

@implementation REFReferenceChannelManager {
@public
  REFThreadSafeMapTable<NSString *, NSObject<REFReferenceChannelHandler> *> *_channelHandlers;
  REFRemoteReferenceMap *_referencePairs;
}

- (instancetype)initWithMessenger:(id<REFReferenceChannelMessenger>)messenger {
  self = [super init];
  if (self) {
    _messenger = messenger;
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

//@implementation REFReferencePairManager {
//  REFBiMapTable<id<REFLocalReference>, REFRemoteReference *> *_referencePairs;
//  REFBiMapTable<NSNumber *, REFClass *> *_classIDs;
//  BOOL _isInitialized;
//}
//
//- (instancetype)initWithSupportedClasses:(NSArray<REFClass *> *)supportedClasses {
//  self = [super init];
//  if (self) {
//    _isInitialized = NO;
//    _supportedClasses = supportedClasses.copy;
//    _referencePairs = [[REFBiMapTable alloc] init];
//
//    _classIDs = [[REFBiMapTable alloc] init];
//    for (int i = 0; i < _supportedClasses.count; i++) {
//      [_classIDs setObject:_supportedClasses[i] forKey:@(i)];
//    }
//  }
//  return self;
//}
//
//- (id<REFRemoteReferenceCommunicationHandler>)remoteHandler {
//  NSString *message = [NSString
//      stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
//  @throw
//      [NSException exceptionWithName:NSInternalInconsistencyException reason:message userInfo:nil];
//}
//
//- (id<REFLocalReferenceCommunicationHandler>)localHandler {
//  NSString *message = [NSString
//      stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
//  @throw
//      [NSException exceptionWithName:NSInternalInconsistencyException reason:message userInfo:nil];
//}
//
//- (void)initialize {
//  _isInitialized = YES;
//}
//
//- (id<REFReferenceConverter>)converter {
//  return [[REFStandardReferenceConverter alloc] init];
//}
//
//- (NSUInteger)getClassID:(REFClass *)clazz {
//  NSNumber *classID = [_classIDs.inverse objectForKey:clazz];
//  if (classID) return classID.unsignedLongValue;
//  return -1;
//}
//
//- (REFClass *_Nullable)getReferenceClass:(NSUInteger)classID {
//  return [_classIDs objectForKey:@(classID)];
//}
//
//- (REFRemoteReference *_Nullable)getPairedRemoteReference:(id<REFLocalReference>)localReference {
//  [self assertInitialized];
//  return [_referencePairs objectForKey:localReference];
//}
//
//- (id<REFLocalReference> _Nullable)getPairedLocalReference:(REFRemoteReference *)remoteReference {
//  [self assertInitialized];
//  // TODO: Not bidirectional
//  return [_referencePairs.inverse objectForKey:remoteReference];
//}
//
//- (id<REFLocalReference>)pairWithNewLocalReference:(REFRemoteReference *)remoteReference
//                                           classID:(NSUInteger)classID {
//  return [self pairWithNewLocalReference:remoteReference classID:classID arguments:@[]];
//}
//
//- (id<REFLocalReference>)pairWithNewLocalReference:(REFRemoteReference *)remoteReference
//                                           classID:(NSUInteger)classID
//                                         arguments:(NSArray<id> *)arguments {
//  [self assertInitialized];
//  if ([self getPairedLocalReference:remoteReference]) {
//    return nil;
//  }
//
//  id<REFLocalReference> localReference = [self.localHandler
//              create:self
//      referenceClass:[self getReferenceClass:classID].clazz
//           arguments:[self.converter convertReferencesForLocalManager:self obj:arguments]];
//
//  NSAssert(![self getPairedRemoteReference:localReference], @"");
//
//  [_referencePairs setObject:remoteReference forKey:localReference];
//  return localReference;
//}
//
//- (id _Nullable)invokeLocalStaticMethod:(Class)referenceClass methodName:(NSString *)methodName {
//  return [self invokeLocalStaticMethod:referenceClass methodName:methodName arguments:@[]];
//}
//
//- (id _Nullable)invokeLocalStaticMethod:(Class)referenceClass
//                             methodName:(NSString *)methodName
//                              arguments:(NSArray<id> *)arguments {
//  [self assertInitialized];
//  NSAssert([self getClassID:[REFClass fromClass:referenceClass]] != -1, @"");
//  id result = [self.localHandler
//      invokeStaticMethod:self
//          referenceClass:referenceClass
//              methodName:methodName
//               arguments:[self.converter convertReferencesForLocalManager:self obj:arguments]];
//
//  return [self.converter convertReferencesForRemoteManager:self obj:result];
//}
//
//- (id _Nullable)invokeLocalMethod:(id<REFLocalReference>)localReference
//                       methodName:(NSString *)methodName {
//  return [self invokeLocalMethod:localReference methodName:methodName arguments:@[]];
//}
//
//- (id _Nullable)invokeLocalMethod:(id<REFLocalReference>)localReference
//                       methodName:(NSString *)methodName
//                        arguments:(NSArray<id> *)arguments {
//  [self assertInitialized];
//  id result = [self.localHandler
//        invokeMethod:self
//      localReference:localReference
//          methodName:methodName
//           arguments:[self.converter convertReferencesForLocalManager:self obj:arguments]];
//
//  return [self.converter convertReferencesForRemoteManager:self obj:result];
//}
//
//- (id _Nullable)invokeLocalMethodOnUnpairedReference:(REFUnpairedReference *)unpairedReference
//                                          methodName:(NSString *)methodName {
//  return [self invokeLocalMethodOnUnpairedReference:unpairedReference
//                                         methodName:methodName
//                                          arguments:@[]];
//}
//
//- (id _Nullable)invokeLocalMethodOnUnpairedReference:(REFUnpairedReference *)unpairedReference
//                                          methodName:(NSString *)methodName
//                                           arguments:(NSArray<id> *)arguments {
//  [self assertInitialized];
//  return [self
//      invokeLocalMethod:
//          [self.localHandler create:self
//                     referenceClass:[_classIDs objectForKey:@(unpairedReference.classID)].clazz
//                          arguments:[self.converter
//                                        convertReferencesForLocalManager:self
//                                                                     obj:unpairedReference
//                                                                             .creationArguments]]
//             methodName:methodName
//              arguments:arguments];
//}
//
//- (void)disposePairWithRemoteReference:(REFRemoteReference *)remoteReference {
//  [self assertInitialized];
//
//  id<REFLocalReference> localReference = [self getPairedLocalReference:remoteReference];
//  if (!localReference) return;
//
//  [_referencePairs removeObjectForKey:localReference];
//  [self.localHandler dispose:self localReference:localReference];
//}
//
//- (void)pairWithNewRemoteReference:(id<REFLocalReference>)localReference
//                        completion:(void (^)(REFRemoteReference *_Nullable,
//                                             NSError *_Nullable))completion {
//  [self assertInitialized];
//  NSAssert(localReference, @"LocalReference must not be null.");
//  if ([self getPairedRemoteReference:localReference]) {
//    completion(nil, nil);
//    return;
//  }
//
//  __block REFRemoteReference *remoteReference =
//      [REFRemoteReference fromID:[[NSUUID UUID] UUIDString]];
//  [_referencePairs setObject:remoteReference forKey:localReference];
//
//  NSArray<id> *creationArguments = [self.converter
//      convertReferencesForRemoteManager:self
//                                    obj:[self.remoteHandler getCreationArguments:localReference]];
//
//  [self.remoteHandler create:remoteReference
//                     classID:[self getClassID:localReference.referenceClass]
//                   arguments:creationArguments
//                  completion:^(NSError *error) {
//                    if (error) {
//                      completion(nil, error);
//                    } else {
//                      completion(remoteReference, nil);
//                    }
//                  }];
//}
//
//- (void)invokeRemoteStaticMethod:(Class)referenceClass
//                      methodName:(NSString *)methodName
//                      completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
//  return [self invokeRemoteStaticMethod:referenceClass
//                             methodName:methodName
//                              arguments:@[]
//                             completion:completion];
//}
//
//- (void)invokeRemoteStaticMethod:(Class)referenceClass
//                      methodName:(NSString *)methodName
//                       arguments:(NSArray<id> *)arguments
//                      completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
//  [self assertInitialized];
//  NSAssert([self getClassID:[REFClass fromClass:referenceClass]] != -1, @"");
//
//  [self.remoteHandler
//      invokeStaticMethod:[self getClassID:[REFClass fromClass:referenceClass]]
//              methodName:methodName
//               arguments:[self.converter convertReferencesForRemoteManager:self obj:arguments]
//              completion:^(id result, NSError *error) {
//                if (error) {
//                  completion(nil, error);
//                } else {
//                  completion([self.converter convertReferencesForLocalManager:self obj:result],
//                             nil);
//                }
//              }];
//}
//
//- (void)invokeRemoteMethod:(REFRemoteReference *)remoteReference
//                methodName:(NSString *)methodName
//                completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
//  return [self invokeRemoteMethod:remoteReference
//                       methodName:methodName
//                        arguments:@[]
//                       completion:completion];
//}
//
//- (void)invokeRemoteMethod:(REFRemoteReference *)remoteReference
//                methodName:(NSString *)methodName
//                 arguments:(NSArray<id> *)arguments
//                completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
//  [self assertInitialized];
//
//  [self.remoteHandler
//      invokeMethod:remoteReference
//        methodName:methodName
//         arguments:[self.converter convertReferencesForRemoteManager:self obj:arguments]
//        completion:^(id result, NSError *error) {
//          if (error) {
//            completion(nil, error);
//          } else {
//            completion([self.converter convertReferencesForLocalManager:self obj:result], nil);
//          }
//        }];
//}
//
//- (void)invokeRemoteMethodOnUnpairedReference:(id<REFLocalReference>)localReference
//                                   methodName:(NSString *)methodName
//                                   completion:
//                                       (void (^)(id _Nullable, NSError *_Nullable))completion {
//  return [self invokeRemoteMethodOnUnpairedReference:localReference
//                                          methodName:methodName
//                                           arguments:@[]
//                                          completion:completion];
//}
//
//- (void)invokeRemoteMethodOnUnpairedReference:(id<REFLocalReference>)localReference
//                                   methodName:(NSString *)methodName
//                                    arguments:(NSArray<id> *)arguments
//                                   completion:
//                                       (void (^)(id _Nullable, NSError *_Nullable))completion {
//  [self assertInitialized];
//
//  [self.remoteHandler
//      invokeMethodOnUnpairedReference:
//          [[REFUnpairedReference alloc]
//                initWithClassID:[self getClassID:localReference.referenceClass]
//              creationArguments:
//                  [self.converter
//                      convertReferencesForRemoteManager:self
//                                                    obj:[self.remoteHandler
//                                                            getCreationArguments:localReference]]]
//                           methodName:methodName
//                            arguments:[self.converter convertReferencesForRemoteManager:self
//                                                                                    obj:arguments]
//                           completion:^(id result, NSError *error) {
//                             if (error) {
//                               completion(nil, error);
//                             } else {
//                               completion([self.converter convertReferencesForLocalManager:self
//                                                                                       obj:result],
//                                          nil);
//                             }
//                           }];
//}
//
//- (void)disposePairWithLocalReference:(id<REFLocalReference>)localReference
//                           completion:(void (^)(NSError *_Nullable))completion {
//  [self assertInitialized];
//
//  REFRemoteReference *remoteReference = [self getPairedRemoteReference:localReference];
//  if (!remoteReference) return;
//
//  [_referencePairs removeObjectForKey:localReference];
//  [self.remoteHandler dispose:remoteReference completion:completion];
//}
//
//- (void)assertInitialized {
//  NSAssert(_isInitialized, @"Initialize has not been called.");
//}
//@end
