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

@interface REFInstancePairManager : NSObject
- (BOOL)addPair:(NSObject *)instance instanceID:(NSString *)instanceID owner:(BOOL)owner;
- (BOOL)isPaired:(NSObject *)instance;
- (NSString *_Nullable)getInstanceID:(NSObject *)instance;
- (NSObject *_Nullable)getInstance:(NSString *)instanceID;
- (void)removePair:(NSString *)instanceID;
@end

NS_ASSUME_NONNULL_END
