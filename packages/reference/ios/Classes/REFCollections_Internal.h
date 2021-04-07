#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

void referenceLog(const char *message);
void removePair(const char *instanceID);

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
+ (REFInstancePairManager *)sharedInstance;
- (BOOL)addPair:(NSObject *)instance instanceID:(NSString *)instanceID owner:(BOOL)owner;
- (BOOL)isPaired:(NSObject *)instance;
- (NSString *_Nullable)getInstanceID:(NSObject *)instance;
- (NSObject *_Nullable)getInstance:(NSString *)instanceID;
- (void)releaseDartHandle:(NSObject *)instance;
@end

NS_ASSUME_NONNULL_END
