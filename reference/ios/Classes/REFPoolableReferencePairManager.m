#import "REFPoolableReferencePairManager.h"

@interface REFReferencePairManagerPool ()
@property (readonly) REFBiMapTable<NSString *, REFPoolableReferencePairManager *> *managers;
@property (readonly) REFBiMapTable<REFClass *, REFPoolableReferencePairManager *> *classesToManagers;
@end

@interface REFPoolableReferencePairManager ()
// TODO: Thread-safe set
@property (readonly) NSMutableSet<REFReferencePairManagerPool *> *pools;
@end

@implementation REFPoolableReferenceConverter
+(REFPoolableReferencePairManager *_Nullable)managerFromClass:(NSSet<REFReferencePairManagerPool *> *_Nonnull)pools
                                                        clazz:(REFClass *_Nonnull)clazz {
  for (REFReferencePairManagerPool *pool in pools) {
    REFPoolableReferencePairManager *manager = [pool.classesToManagers objectForKey:clazz];
    if (manager) return manager;
  }
  
  return nil;
}

+(REFPoolableReferencePairManager *_Nullable)managerFromPoolID:(NSSet<REFReferencePairManagerPool *> *_Nonnull)pools
                                                        poolID:(NSString *_Nonnull)poolID {
  for (REFReferencePairManagerPool *pool in pools) {
    REFPoolableReferencePairManager *manager = [pool.managers objectForKey:poolID];
    if (manager) return manager;
  }
  
  return nil;
}

+(id<REFLocalReference> _Nullable)localRefFromRemoteRef:(NSSet<REFReferencePairManagerPool *> *_Nonnull)pools
                                        remoteReference:(REFRemoteReference *_Nonnull)remoteReference {
  for (REFReferencePairManagerPool *pool in pools) {
    NSEnumerator<REFPoolableReferencePairManager *> *enumerator =
    pool.managers.objectEnumerator;
    REFPoolableReferencePairManager *manager;
    
    while ((manager = [enumerator nextObject])) {
      id<REFLocalReference> localReference = [manager
                                              getPairedLocalReference:remoteReference];
      if (localReference) return localReference;
    }
  }
  
  return nil;
}

-(id)convertReferencesForRemoteManager:(REFReferencePairManager *)manager obj:(id)obj {
  if (![obj conformsToProtocol:@protocol(REFLocalReference)]) {
    return [super convertReferencesForRemoteManager:manager obj:obj];
  }
  
  id<REFLocalReference> localReference = obj;
  REFPoolableReferencePairManager *poolableManager = (REFPoolableReferencePairManager *) manager;
  
  BOOL isCorrectManager = [manager getClassID:localReference.referenceClass] != -1;
  REFPoolableReferencePairManager *correctManager = isCorrectManager ? poolableManager :
  [REFPoolableReferenceConverter managerFromClass:poolableManager.pools
                                            clazz:localReference.referenceClass];
  
  if ([correctManager getPairedRemoteReference:localReference]) {
    return [correctManager getPairedRemoteReference:localReference];
  }
  
  return [[REFUnpairedReference alloc] initWithClassID:[correctManager getClassID:localReference.referenceClass]
                                     creationArguments:[correctManager.converter
                                                        convertReferencesForRemoteManager:poolableManager
                                                        obj:[correctManager.remoteHandler
                                                             getCreationArguments:localReference]]
                                         managerPoolID:correctManager.poolID];
}

-(id)convertReferencesForLocalManager:(REFReferencePairManager *)manager obj:(id)obj {
  if (![obj isKindOfClass:[REFRemoteReference class]] && ![obj isKindOfClass:[REFUnpairedReference class]]) {
    return [super convertReferencesForLocalManager:manager obj:obj];
  }
  
  REFPoolableReferencePairManager *poolableManager = (REFPoolableReferencePairManager *) manager;
  
  BOOL objIsRemoteReference = [obj isKindOfClass:[REFRemoteReference class]];
  if (objIsRemoteReference && [manager getPairedLocalReference:obj]) {
    return [manager getPairedLocalReference:obj];
  } else if (objIsRemoteReference && ![manager getPairedLocalReference:obj]) {
    return [REFPoolableReferenceConverter localRefFromRemoteRef:poolableManager.pools remoteReference:obj];
  }
  
  REFUnpairedReference *unpairedReference = obj;
  REFPoolableReferencePairManager *correctManager = [poolableManager.poolID isEqualToString:unpairedReference.managerPoolID]
  ? poolableManager : [REFPoolableReferenceConverter managerFromPoolID:poolableManager.pools poolID:unpairedReference.managerPoolID];
  
  return [correctManager.localHandler create:correctManager
                              referenceClass:[correctManager getReferenceClass:unpairedReference.classID].clazz
                                   arguments:[self convertReferencesForLocalManager:manager
                                                                                obj:unpairedReference.creationArguments]];
}
@end

@implementation REFPoolableReferencePairManager
-(instancetype)initWithSupportedClasses:(NSArray<REFClass *> *)supportedClasses
                                 poolID:(NSString *)poolID {
  self = [super initWithSupportedClasses:supportedClasses];
  if (self) {
    _poolID = poolID;
    _pools = [NSMutableSet set];
  }
  return self;
}

- (id<REFReferenceConverter>)converter {
  return [[REFPoolableReferenceConverter alloc] init];
}
@end

@implementation REFReferencePairManagerPool
- (instancetype)init {
  self = [super init];
  if (self) {
    _managers = [[REFBiMapTable alloc] init];
    _classesToManagers = [[REFBiMapTable alloc] init];
  }
  return self;
}

- (BOOL)add:(REFPoolableReferencePairManager *)manager {
  if ([_managers objectForKey:manager.poolID] == manager) return YES;
  if ([_managers objectForKey:manager.poolID]) return false;
  
  for (REFClass *clazz in manager.supportedClasses) {
    if ([_classesToManagers objectForKey:clazz]) return false;
  }
  
  for (REFClass *clazz in manager.supportedClasses) {
    [_classesToManagers setObject:manager forKey:clazz];
  }
  
  [manager.pools addObject:self];
  [_managers setObject:manager forKey:manager.poolID];
  
  return YES;
}

- (void)remove:(REFPoolableReferencePairManager *)manager {
  if (![_managers objectForKey:manager.poolID]) return;
  
  for (REFClass *clazz in manager.supportedClasses) {
    [_classesToManagers removeObjectForKey:clazz];
  }
  
  [_managers removeObjectForKey:manager.poolID];
  [manager.pools removeObject:self];
}
@end
