#import <Foundation/Foundation.h>

#import "reference.cpp"

NS_ASSUME_NONNULL_BEGIN

void referenceLog(char *message);
void removePair(std::string instanceID);

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
