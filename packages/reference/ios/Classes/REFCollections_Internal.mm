#import "REFCollections_Internal.h"

//@interface REFBiMapTable<KeyType, ObjectType> : NSObject
//// Inverse of inverse is null
//@property(readonly) REFBiMapTable<ObjectType, KeyType> *_Nullable inverse;
//- (void)setObject:(ObjectType)object forKey:(KeyType)key;
//- (void)removeObjectForKey:(KeyType)key;
//- (ObjectType _Nullable)objectForKey:(KeyType)key;
//- (NSEnumerator<ObjectType> *)objectEnumerator;
//@end

@implementation REFThreadSafeMapTable {
  NSMapTable<id, id> *_table;
  dispatch_queue_t _lockQueue;
}

- (instancetype _Nonnull)init {
  self = [super init];
  if (self) {
    _table = [NSMapTable weakToStrongObjectsMapTable];
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

//@implementation REFBiMapTable {
//  REFThreadSafeMapTable<id, id> *_table;
//  dispatch_queue_t _lockQueue;
//}
//
//- (instancetype)init {
//  self = [super init];
//  if (self) {
//    _table = [[REFThreadSafeMapTable alloc] init];
//    _inverse = [[REFBiMapTable alloc] initWithoutInverse];
//  }
//  return self;
//}
//
//- (instancetype)initWithoutInverse {
//  self = [super init];
//  if (self) {
//    _table = [[REFThreadSafeMapTable alloc] init];
//  }
//  return self;
//}
//
//- (void)setObject:(id _Nonnull)object forKey:(id _Nonnull)key {
//  if (key && object && ![self objectForKey:key] && ![self.inverse objectForKey:object]) {
//    [_table setObject:object forKey:key];
//    [_inverse->_table setObject:key forKey:object];
//  }
//}
//
//- (void)removeObjectForKey:(id _Nonnull)key {
//  if (key) {
//    id object = [_table objectForKey:key];
//    [_table removeObjectForKey:key];
//    [_inverse->_table removeObjectForKey:object];
//  }
//}
//
//- (id _Nullable)objectForKey:(id _Nonnull)key {
//  return [_table objectForKey:key];
//}
//
//- (NSEnumerator<id> *)objectEnumerator {
//  return _table.objectEnumerator;
//}
//@end

@implementation InstancePairManager {
  REFThreadSafeMapTable<NSObject *, NSString *> *_instanceIds;
//  REFThreadSafeMapTable<NSObject *, NSMutableSet<NSObject *> *> *_owners;
}

+ (InstancePairManager *)sharedInstance {
  
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _instanceIds = [[REFThreadSafeMapTable alloc] init];
//    _owners = [[REFThreadSafeMapTable alloc] init];
  }
  return self;
}

- (BOOL)isPaired:(NSObject *)instance {
  return [_instanceIds objectForKey:instance] != nil;
//  return [self getPairedPairedInstance:object] != nil;
}

- (BOOL)addPair:(NSObject *)instance instanceID:(NSString *)instanceID owner:(BOOL)owner {
  if ([self isPaired:instance]) return NO;
  NSAssert(![self getInstance:instanceID], @"");
  
  [_instanceIds setObject:instanceID forKey:instance];
  // TODO: native add pair
//
//  if (!wasPaired) {
//    [_pairedInstances setObject:pairedInstance forKey:object];
//    [_owners setObject:[NSMutableSet set] forKey:object];
//  }
//
//  [[_owners objectForKey:object] addObject:owner];
//  return !wasPaired;
  return NO;
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

- (NSObject *_Nullable)getInstanceID:(NSString *)instanceID {
  return nil;
//  return [_pairedInstances objectForKey:object];
}

- (id _Nullable)getInstance:(NSString *)instanceId {
  return nil;
//  return [_pairedInstances.inverse objectForKey:pairedInstance];
}

- (void)releaseDartHandle:(NSObject *)instance {
  
}
@end
