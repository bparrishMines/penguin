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

@implementation REFInstanceManager {
  REFThreadSafeMapTable<NSObject *, NSString *> *_instanceIds;
  REFThreadSafeMapTable<NSString *, NSObject *> *_temporaryStrongReferences;
  REFThreadSafeMapTable<NSString *, NSObject *> *_strongReferences;
  REFThreadSafeMapTable<NSString *, NSObject *> *_weakReferences;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _instanceIds = [REFThreadSafeMapTable weakToStrongObjectsMapTable];
    _temporaryStrongReferences = [REFThreadSafeMapTable strongToStrongObjectsMapTable];
    _strongReferences = [REFThreadSafeMapTable strongToStrongObjectsMapTable];
    _weakReferences = [REFThreadSafeMapTable strongToWeakObjectsMapTable];
  }
  return self;
}

- (BOOL)containsInstance:(NSObject *)instance {
  return [_instanceIds objectForKey:instance] != nil;
}

- (BOOL)addWeakReference:(NSObject *)instance instanceID:(NSString *_Nullable)instanceID {
  if ([self containsInstance:instance]) return NO;
  
  NSString *newID = instanceID ? instanceID : [self generateUniqueInstanceID:instance];

  [_instanceIds setObject:newID forKey:instance];
  [_weakReferences setObject:instance forKey:newID];
  return YES;
}

- (BOOL)addStrongReference:(NSObject *)instance instanceID:(NSString *_Nullable)instanceID {
  if ([self containsInstance:instance]) return NO;
  
  NSString *newID = instanceID ? instanceID : [self generateUniqueInstanceID:instance];
  
  [_instanceIds setObject:newID forKey:instance];
  [_strongReferences setObject:instance forKey:newID];
  return YES;
}

- (BOOL)addTemporaryStrongReference:(NSObject *)instance instanceID:(NSString *_Nullable)instanceID {
  if ([self containsInstance:instance]) return NO;
  
  NSString *newID = instanceID ? instanceID : [self generateUniqueInstanceID:instance];
  
  [_instanceIds setObject:newID forKey:instance];
  [_temporaryStrongReferences setObject:instance forKey:newID];
  return YES;
}

- (void)removeInstance:(NSString *)instanceID {
  NSObject *instance = [self getInstance:instanceID];
  if (instance) [_instanceIds removeObjectForKey:instance];

  [_temporaryStrongReferences removeObjectForKey:instanceID];
  [_strongReferences removeObjectForKey:instanceID];
  [_weakReferences removeObjectForKey:instanceID];
}

- (NSString *_Nullable)getInstanceID:(NSObject *)instance {
  return [_instanceIds objectForKey:instance];
}

- (NSObject *_Nullable)getInstance:(NSString *)instanceID {
  NSObject *tempInstance = [_temporaryStrongReferences objectForKey:instanceID];
  if (tempInstance) {
    [_instanceIds removeObjectForKey:tempInstance];
    [_temporaryStrongReferences removeObjectForKey:instanceID];
    [self addWeakReference:tempInstance instanceID:instanceID];
    return tempInstance;
  }
  
  NSObject *instance = [_strongReferences objectForKey:instanceID];
  if (instance) return instance;
  return [_weakReferences objectForKey:instanceID];
}

- (NSString *)generateUniqueInstanceID:(NSObject *)instance {
  return [NSString stringWithFormat:@"%@(%@)", NSStringFromClass(instance.class), [@(instance.hash) stringValue]];
}
@end
