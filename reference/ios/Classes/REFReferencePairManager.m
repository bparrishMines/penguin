#import "REFReferencePairManager.h"

@implementation REFStandardReferenceConverter
- (id _Nullable)convertReferencesForLocalManager:(REFReferencePairManager *)manager obj:(id _Nullable)obj {
  if ([obj isKindOfClass:[REFRemoteReference class]]) {
    return [manager getPairedLocalReference:obj];
  } else if ([obj isKindOfClass:[REFUnpairedReference class]]) {
    REFUnpairedReference *reference = obj;
    return [[manager localHandler] create:manager
                           referenceClass:[manager getReferenceClass:reference.classID].clazz
                                arguments:[self convertReferencesForLocalManager:manager obj:reference.creationArguments]];
  } else if ([obj isKindOfClass:[NSArray class]]) {
    NSArray *array = obj;
    NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:array.count];
    for (id object in array) {
      [newArray addObject:[self convertReferencesForLocalManager:manager obj:object]];
    }
    return newArray;
  } else if ([obj isKindOfClass:[NSDictionary class]]) {
    NSDictionary *dictionary = obj;
    NSMutableDictionary *newDictionary = [NSMutableDictionary
                                          dictionaryWithCapacity:dictionary.count];
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull object, BOOL * _Nonnull stop) {
      [newDictionary setObject:[self convertReferencesForLocalManager:manager obj:object]
                        forKey:[self convertReferencesForLocalManager:manager obj:key]];
    }];
    
    return newDictionary;
  }
  
  return obj;
}

- (id _Nullable)convertReferencesForRemoteManager:(REFReferencePairManager *)manager obj:(id _Nullable)obj {
  if ([obj conformsToProtocol:@protocol(REFLocalReference)] && [manager getPairedRemoteReference:obj]) {
    return [manager getPairedRemoteReference:obj];
  } else if ([obj conformsToProtocol:@protocol(REFLocalReference)] &&
             ![manager getPairedRemoteReference:obj]) {
    NSUInteger classID = [manager getClassID:[obj referenceClass]];
    NSArray<id> *creationArguments = [manager.remoteHandler getCreationArguments:obj];
    return [[REFUnpairedReference alloc] initWithClassID:classID
                                       creationArguments:[self convertReferencesForRemoteManager:manager
                                                                                             obj:creationArguments]];
  } else if ([obj isKindOfClass:[NSArray class]]) {
    NSArray *array = obj;
    NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:array.count];
    for (id object in array) {
      [newArray addObject:[self convertReferencesForRemoteManager:manager obj:object]];
    }
    return newArray;
  } else if ([obj isKindOfClass:[NSDictionary class]]) {
    NSDictionary *dictionary = obj;
    NSMutableDictionary *newDictionary = [NSMutableDictionary
                                          dictionaryWithCapacity:dictionary.count];
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull object, BOOL * _Nonnull stop) {
      [newDictionary setObject:[self convertReferencesForRemoteManager:manager obj:object]
                        forKey:[self convertReferencesForRemoteManager:manager obj:key]];
    }];
    
    return newDictionary;
  }
  
  return obj;
}
@end

@implementation REFReferencePairManager {
  REFBiMapTable<id<REFLocalReference>, REFRemoteReference *> *_referencePairs;
  REFBiMapTable<NSNumber *, REFClass *> *_classIDs;
  BOOL _isInitialized;
}

-(instancetype)initWithSupportedClasses:(NSArray<REFClass *> *)supportedClasses {
  self = [super init];
  if (self) {
    _isInitialized = NO;
    _supportedClasses = supportedClasses.copy;
    _referencePairs = [[REFBiMapTable alloc] init];
    
    _classIDs = [[REFBiMapTable alloc] init];
    for (int i = 0; i < _supportedClasses.count; i++) {
      [_classIDs setObject:_supportedClasses[i] forKey:@(i)];
    }
  }
  return self;
}

-(id<REFRemoteReferenceCommunicationHandler>)remoteHandler {
  NSString *message = [NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
  @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                 reason:message
                               userInfo:nil];
}

-(id<REFLocalReferenceCommunicationHandler>)localHandler {
  NSString *message = [NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
  @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                 reason:message
                               userInfo:nil];
}

-(void)initialize {
  _isInitialized = YES;
}

-(id<REFReferenceConverter>)converter {
  return [[REFStandardReferenceConverter alloc] init];
}

-(NSUInteger)getClassID:(REFClass *)clazz {
  return [_classIDs.inverse objectForKey:clazz].unsignedLongValue;
}

-(REFClass *_Nullable)getReferenceClass:(NSUInteger)classID {
  return [_classIDs objectForKey:@(classID)];
}

-(REFRemoteReference *_Nullable)getPairedRemoteReference:(id<REFLocalReference>)localReference {
  [self assertInitialized];
  return [_referencePairs objectForKey:localReference];
}

-(id<REFLocalReference> _Nullable)getPairedLocalReference:(REFRemoteReference *)remoteReference {
  [self assertInitialized];
  // TODO: Not bidirectional
  return [_referencePairs.inverse objectForKey:remoteReference];
}

-(id<REFLocalReference>)pairWithNewLocalReference:(REFRemoteReference *)remoteReference
                                          classID:(NSUInteger)classID {
  return [self pairWithNewLocalReference:remoteReference
                                 classID:classID
                               arguments:@[]];
}

-(id<REFLocalReference>)pairWithNewLocalReference:(REFRemoteReference *)remoteReference
                                          classID:(NSUInteger)classID
                                        arguments:(NSArray<id> *)arguments {
  [self assertInitialized];
  id<REFLocalReference> localReference = [self.localHandler
                                          create:self
                                          referenceClass:[self getReferenceClass:classID].clazz
                                          arguments:[self.converter convertReferencesForLocalManager:self obj:arguments]];
  
  [_referencePairs setObject:remoteReference forKey:localReference];
  return localReference;
}

-(id _Nullable)invokeLocalMethod:(id<REFLocalReference>)localReference
                      methodName:(NSString *)methodName {
  return [self invokeLocalMethod:localReference methodName:methodName arguments:@[]];
}

-(id _Nullable)invokeLocalMethod:(id<REFLocalReference>)localReference
                      methodName:(NSString *)methodName
                       arguments:(NSArray<id> *)arguments {
  [self assertInitialized];
  id result = [self.localHandler invokeMethod:self localReference:localReference methodName:methodName arguments:[self.converter convertReferencesForLocalManager:self obj:arguments]];
  
  return [self.converter convertReferencesForRemoteManager:self obj:result];
}

-(id _Nullable)invokeLocalMethodOnUnpairedReference:(REFUnpairedReference *)unpairedReference
                                         methodName:(NSString *)methodName {
  return [self invokeLocalMethodOnUnpairedReference:unpairedReference methodName:methodName arguments:@[]];
}

-(id _Nullable)invokeLocalMethodOnUnpairedReference:(REFUnpairedReference *)unpairedReference
                                         methodName:(NSString *)methodName
                                          arguments:(NSArray<id> *)arguments {
  [self assertInitialized];
  return [self invokeLocalMethod:[self.localHandler
                                  create:self
                                  referenceClass:[_classIDs objectForKey:@(unpairedReference.classID)].clazz
                                  arguments:[self.converter convertReferencesForLocalManager:self obj:unpairedReference.creationArguments]]
                      methodName:methodName
                       arguments:arguments];
}

- (void)assertInitialized {
  NSAssert(_isInitialized, @"Initialize has not been called.");
}
@end
