#import "REFCollections_Internal.h"

@implementation REFThreadSafeMapTable {
  NSMapTable<id, id> *_table;
  dispatch_queue_t _lockQueue;
}

+ (REFThreadSafeMapTable *)weakToStrongObjectsMapTable {
  REFThreadSafeMapTable *table = [[REFThreadSafeMapTable alloc] init];
  table->_table = [NSMapTable weakToStrongObjectsMapTable];
  return table;
}

+ (REFThreadSafeMapTable *)weakToWeakObjectsMapTable {
  REFThreadSafeMapTable *table = [[REFThreadSafeMapTable alloc] init];
  table->_table = [NSMapTable weakToWeakObjectsMapTable];
  return table;
}

+ (REFThreadSafeMapTable *)strongToWeakObjectsMapTable {
  REFThreadSafeMapTable *table = [[REFThreadSafeMapTable alloc] init];
  table->_table = [NSMapTable strongToWeakObjectsMapTable];
  return table;
}

+ (REFThreadSafeMapTable *)strongToStrongObjectsMapTable {
  REFThreadSafeMapTable *table = [[REFThreadSafeMapTable alloc] init];
  table->_table = [NSMapTable strongToStrongObjectsMapTable];
  return table;
}

- (instancetype _Nonnull)init {
  self = [super init];
  if (self) {
    _lockQueue = dispatch_queue_create("REFThreadSafeMapTable", DISPATCH_QUEUE_SERIAL);
  }
  return self;
}

- (void)setObject:(id _Nonnull)object forKey:(id _Nonnull)key {
  if (key && object) {
    dispatch_async(_lockQueue, ^{
      [self->_table setObject:object forKey:key];
    });
  }
}

- (void)removeObjectForKey:(id _Nonnull)key {
  if (key != nil) {
    dispatch_async(_lockQueue, ^{
      [self->_table removeObjectForKey:key];
    });
  }
}

- (id _Nullable)objectForKey:(id _Nonnull)key {
  id __block object = nil;
  dispatch_sync(_lockQueue, ^{
    object = [self->_table objectForKey:key];
  });
  return object;
}

- (NSEnumerator<id> *)objectEnumerator {
  __block NSEnumerator<id> *enumerator = nil;
  dispatch_sync(_lockQueue, ^{
    enumerator = self->_table.objectEnumerator;
  });
  return enumerator;
}
@end

@implementation REFInstancePairManager {
  REFThreadSafeMapTable<NSObject *, NSString *> *_instanceIds;
  REFThreadSafeMapTable<NSString *, NSObject *> *_strongReferences;
  REFThreadSafeMapTable<NSString *, NSObject *> *_weakReferences;
}

//+ (REFInstancePairManager *)sharedInstance {
//  static REFInstancePairManager *sharedInstance = nil;
//  static dispatch_once_t onceToken;
//  dispatch_once(&onceToken, ^{
//    sharedInstance = [[REFInstancePairManager alloc] init];
//  });
//  return sharedInstance;
//}

- (instancetype)init {
  self = [super init];
  if (self) {
    _instanceIds = [REFThreadSafeMapTable weakToStrongObjectsMapTable];
    _strongReferences = [REFThreadSafeMapTable strongToStrongObjectsMapTable];
    _weakReferences = [REFThreadSafeMapTable strongToWeakObjectsMapTable];
  }
  return self;
}

- (BOOL)isPaired:(NSObject *)instance {
  return [_instanceIds objectForKey:instance] != nil;
}

- (BOOL)addPair:(NSObject *)instance instanceID:(NSString *)instanceID owner:(BOOL)owner {
  if ([self isPaired:instance]) return NO;
  NSAssert(![self getInstance:instanceID], @"");
  
  [_instanceIds setObject:instanceID forKey:instance];
  
  if (owner) {
    [_weakReferences setObject:instance forKey:instanceID];
  } else {
    [_strongReferences setObject:instance forKey:instanceID];
  }
//
//  if (!wasPaired) {
//    [_pairedInstances setObject:pairedInstance forKey:object];
//    [_owners setObject:[NSMutableSet set] forKey:object];
//  }
//
//  [[_owners objectForKey:object] addObject:owner];
//  return !wasPaired;
  return YES;
}

//- (BOOL)removePairWithObject:(id)object
//                       owner:(NSObject *)owner
//                       force:(BOOL)force {
//  if (![self isPaired:object]) return NO;
//
//  NSMutableSet *objectOwners = [_owners objectForKey:object];
//  [objectOwners removeObject:owner];
//
//  if (!force && [objectOwners count] > 0) return NO;
//
//  [_pairedInstances removeObjectForKey:object];
//  [_owners removeObjectForKey:object];
//  return YES;
//}

- (void)removePair:(NSString *)instanceID {
  NSObject *instance = [self getInstance:instanceID];
  if (instance) {
    [_instanceIds removeObjectForKey:instance];
    [_strongReferences removeObjectForKey:instanceID];
  }
  
  [_weakReferences removeObjectForKey:instanceID];
}

- (NSString *_Nullable)getInstanceID:(NSObject *)instance {
  return [_instanceIds objectForKey:instance];
}

- (NSObject *_Nullable)getInstance:(NSString *)instanceID {
  NSObject *instance = [_strongReferences objectForKey:instanceID];
  if (instance) return instance;
  return [_weakReferences objectForKey:instanceID];
}

//- (void)removePair:(NSString *)instanceID {
//  NSAssert([self isPaired:instance], @"");
//
//  NSString *instanceID = [_instanceIds objectForKey:instance];
//  [_weakReferences removeObjectForKey:instanceID];
//  [_instanceIds removeObjectForKey:instance];
//  //release_dart_handle(std::string(instanceID.UTF8String));
//}
@end

//void referenceLog(const char *message) {
//  NSLog(@"Reference: %@", [NSString stringWithCString:message
//                                             encoding:[NSString defaultCStringEncoding]]);
//}
//
//void removePair(const char *instanceID) {
//  NSString *objInstanceID = [NSString stringWithCString:instanceID
//                                               encoding:[NSString defaultCStringEncoding]];
//  [[REFInstancePairManager sharedInstance] removePair:objInstanceID];
//}
