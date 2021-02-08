#import "REFCollections_Internal.h"

@interface REFBiMapTable<KeyType, ObjectType> : NSObject
// Inverse of inverse is null
@property(readonly) REFBiMapTable<ObjectType, KeyType> *_Nullable inverse;
- (void)setObject:(ObjectType)object forKey:(KeyType)key;
- (void)removeObjectForKey:(KeyType)key;
- (ObjectType _Nullable)objectForKey:(KeyType)key;
- (NSEnumerator<ObjectType> *)objectEnumerator;
@end

@implementation REFThreadSafeMapTable {
  NSMapTable<id, id> *_table;
  dispatch_queue_t _lockQueue;
}

- (instancetype _Nonnull)init {
  self = [super init];
  if (self) {
    _table = [NSMapTable strongToStrongObjectsMapTable];
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

@implementation REFBiMapTable {
  REFThreadSafeMapTable<id, id> *_table;
  dispatch_queue_t _lockQueue;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _table = [[REFThreadSafeMapTable alloc] init];
    _inverse = [[REFBiMapTable alloc] initWithoutInverse];
  }
  return self;
}

- (instancetype)initWithoutInverse {
  self = [super init];
  if (self) {
    _table = [[REFThreadSafeMapTable alloc] init];
  }
  return self;
}

- (void)setObject:(id _Nonnull)object forKey:(id _Nonnull)key {
  if (key && object && ![self objectForKey:key] && ![self.inverse objectForKey:object]) {
    [_table setObject:object forKey:key];
    [_inverse->_table setObject:key forKey:object];
  }
}

- (void)removeObjectForKey:(id _Nonnull)key {
  if (key) {
    id object = [_table objectForKey:key];
    [_table removeObjectForKey:key];
    [_inverse->_table removeObjectForKey:object];
  }
}

- (id _Nullable)objectForKey:(id _Nonnull)key {
  return [_table objectForKey:key];
}

- (NSEnumerator<id> *)objectEnumerator {
  return _table.objectEnumerator;
}
@end

@implementation InstancePairManager {
  REFBiMapTable<NSObject *, REFPairedInstance *> *_pairedInstances;
  // TODO: Need to make thread-safe owner sets
  REFThreadSafeMapTable<NSObject *, NSMutableSet<NSObject *> *> *_owners;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _pairedInstances = [[REFBiMapTable alloc] init];
    _owners = [[REFThreadSafeMapTable alloc] init];
  }
  return self;
}

- (BOOL)isPaired:(NSObject *)object {
  return [self getPairedPairedInstance:object] != nil;
}

- (BOOL)addPair:(NSObject *)object
 pairedInstance:(REFPairedInstance *)pairedInstance
          owner:(NSObject *)owner {
  BOOL wasPaired = [self isPaired:object];
  
  if (!wasPaired) {
    [_pairedInstances setObject:pairedInstance forKey:object];
    [_owners setObject:[NSMutableSet set] forKey:object];
  }
  
  [[_owners objectForKey:object] addObject:owner];
  return !wasPaired;
}

- (BOOL)removePairWithObject:(id)object
                       owner:(NSObject *)owner
                       force:(BOOL)force {
  if (![self isPaired:object]) return NO;
  
  NSMutableSet *objectOwners = [_owners objectForKey:object];
  [objectOwners removeObject:owner];
  
  if (!force && [objectOwners count] > 0) return NO;
  
  [_pairedInstances removeObjectForKey:object];
  [_owners removeObjectForKey:object];
  return YES;
}

- (REFPairedInstance *_Nullable)getPairedPairedInstance:(id)object {
  return [_pairedInstances objectForKey:object];
}

- (id _Nullable)getPairedObject:(REFPairedInstance *)pairedInstance {
  return [_pairedInstances.inverse objectForKey:pairedInstance];
}
@end
