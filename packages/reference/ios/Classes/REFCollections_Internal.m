#import "REFCollections_Internal.h"
#import <objc/runtime.h>

// Tracks when an object is garbage collected.
@interface REFObjectTracker : NSObject
@property (nonatomic) REFOnFinalizeCallback callback;
@property (nonatomic, copy) NSString *instanceID;
+ (void)trackObject:(NSObject *)object instanceID:(NSString *)instanceID callback:(REFOnFinalizeCallback)callback;
+ (void)untrackObject:(NSObject *)object;
@end

@implementation REFObjectTracker
-(void) dealloc {
  if (_callback) _callback(_instanceID);
}

+ (void)trackObject:(NSObject *)object instanceID:(NSString *)instanceID callback:(REFOnFinalizeCallback)callback {
  REFObjectTracker *tracker = [[self alloc] init];
  tracker.instanceID = instanceID;
  tracker.callback = callback;
  objc_setAssociatedObject(object, _cmd, tracker, OBJC_ASSOCIATION_RETAIN);
}

+ (void)untrackObject:(NSObject *)object {
  REFObjectTracker *tracker = objc_getAssociatedObject(object, @selector(trackObject:instanceID:callback:));
  [tracker setCallback:nil];
}
@end

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
  REFThreadSafeMapTable<NSString *, NSObject *> *_strongReferences;
  REFThreadSafeMapTable<NSString *, NSObject *> *_temporaryStrongReferences;
  REFThreadSafeMapTable<NSString *, NSObject *> *_weakReferences;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _instanceIds = [REFThreadSafeMapTable weakToStrongObjectsMapTable];
    _strongReferences = [REFThreadSafeMapTable strongToStrongObjectsMapTable];
    _temporaryStrongReferences = [REFThreadSafeMapTable strongToStrongObjectsMapTable];
    _weakReferences = [REFThreadSafeMapTable strongToWeakObjectsMapTable];
  }
  return self;
}

- (BOOL)addWeakReference:(NSObject *)instance
              instanceID:(NSString *_Nullable)instanceID
              onFinalize:(REFOnFinalizeCallback)onFinalize {
  if ([self containsInstance:instance]) return NO;
  
  NSString *newID = instanceID ? instanceID : [self generateUniqueInstanceID:instance];

  [_instanceIds setObject:newID forKey:instance];
  [_weakReferences setObject:instance forKey:newID];
  
  __weak __block REFInstanceManager *weakSelf = self;
  [REFObjectTracker trackObject:instance instanceID:instanceID callback:^(NSString * _Nonnull instanceID) {
    [weakSelf removeInstance:instanceID];
    onFinalize(instanceID);
  }];
  return YES;
}

- (BOOL)addStrongReference:(NSObject *)instance instanceID:(NSString *_Nullable)instanceID {
  if ([self containsInstance:instance]) return NO;
  
  NSString *newID = instanceID ? instanceID : [self generateUniqueInstanceID:instance];
  
  [_instanceIds setObject:newID forKey:instance];
  [_strongReferences setObject:instance forKey:newID];
  return YES;
}

- (BOOL)addTemporaryStrongReference:(NSObject *)instance
                         instanceID:(NSString *_Nullable)instanceID
                         onFinalize:(REFOnFinalizeCallback)onFinalize {
  NSString *newID = instanceID ? instanceID : [self generateUniqueInstanceID:instance];

  if ([self addWeakReference:instance instanceID:newID onFinalize:onFinalize]) {
    [_temporaryStrongReferences setObject:instance forKey:newID];
    return YES;
  }

  return NO;
}

- (BOOL)containsInstance:(NSObject *)instance {
  return [_instanceIds objectForKey:instance] != nil;
}

- (void)removeInstance:(NSString *)instanceID {
  NSObject *instance = [self getInstance:instanceID];
  if (instance) {
    [_instanceIds removeObjectForKey:instance];
    [REFObjectTracker untrackObject:instance];
  }

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
    [_temporaryStrongReferences removeObjectForKey:instanceID];
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
