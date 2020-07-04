#import "REFCollections_Internal.h"

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

// TODO: Inverse of inverse not reachable
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
  if (key && object &&
      ![self objectForKey:key] &&
      ![self.inverse objectForKey:object]) {
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
