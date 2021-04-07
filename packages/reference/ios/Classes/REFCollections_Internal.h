#import <Foundation/Foundation.h>

#import "reference.cpp"

NS_ASSUME_NONNULL_BEGIN

void referenceLog(char *);
void releaseObject(void *objectInstance);

@interface REFThreadSafeMapTable<KeyType, ObjectType> : NSObject
- (void)setObject:(ObjectType)object forKey:(KeyType)key;
- (void)removeObjectForKey:(KeyType)key;
- (ObjectType _Nullable)objectForKey:(KeyType)key;
- (NSEnumerator<ObjectType> *)objectEnumerator;
@end

@interface InstancePairManager : NSObject
+ (InstancePairManager *)sharedInstance;
- (BOOL)addPair:(NSObject *)instance instanceID:(NSString *)instanceId owner:(BOOL)owner;
- (BOOL)isPaired:(NSObject *)instance;
- (NSString *_Nullable)getInstanceID:(NSObject *)instance;
- (id _Nullable)getInstance:(NSString *)instanceId;
- (void)releaseDartHandle:(NSObject *)instance;
@end

NS_ASSUME_NONNULL_END
