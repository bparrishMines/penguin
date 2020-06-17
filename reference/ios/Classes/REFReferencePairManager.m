#import "REFReferencePairManager.h"

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
                                          referenceClass:[_classIDs objectForKey:@(classID)].clazz
                                          arguments:[self replaceRemoteReferences:arguments]];
  
  [_referencePairs setObject:remoteReference forKey:localReference];
  return localReference;
}

- (void)assertInitialized {
  NSAssert(_isInitialized, @"Initialize has not been called.");
}

- (id _Nullable)replaceRemoteReferences:(id _Nullable)object {
  return object;
}
@end
