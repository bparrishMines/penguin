#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface REFThreadSafeMapTable<KeyType, ObjectType> : NSObject
+ (REFThreadSafeMapTable *)weakToStrongObjectsMapTable;
+ (REFThreadSafeMapTable *)weakToWeakObjectsMapTable;
+ (REFThreadSafeMapTable *)strongToWeakObjectsMapTable;
+ (REFThreadSafeMapTable *)strongToStrongObjectsMapTable;
- (void)setObject:(ObjectType)object forKey:(KeyType)key;
- (void)removeObjectForKey:(KeyType)key;
- (ObjectType _Nullable)objectForKey:(KeyType)key;
- (NSEnumerator<ObjectType> *)objectEnumerator;
@end

@interface REFInstanceManager : NSObject
- (BOOL)addWeakReference:(NSObject *)instance instanceID:(NSString *_Nullable)instanceID;
- (BOOL)addStrongReference:(NSObject *)instance instanceID:(NSString *_Nullable)instanceID;
- (BOOL)addTemporaryStrongReference:(NSObject *)instance instanceID:(NSString *_Nullable)instanceID;
- (BOOL)containsInstance:(NSObject *)instance;
- (NSString *_Nullable)getInstanceID:(NSObject *)instance;
- (NSObject *_Nullable)getInstance:(NSString *)instanceID;
- (void)removeInstance:(NSString *)instanceID;
- (NSString *)generateUniqueInstanceID:(NSObject *)instance;
@end

NS_ASSUME_NONNULL_END
