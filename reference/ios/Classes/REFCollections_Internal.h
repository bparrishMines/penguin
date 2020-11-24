#import <Foundation/Foundation.h>

#import "REFReference.h"

NS_ASSUME_NONNULL_BEGIN

@interface REFThreadSafeMapTable<KeyType, ObjectType> : NSObject
- (void)setObject:(ObjectType)object forKey:(KeyType)key;
- (void)removeObjectForKey:(KeyType)key;
- (ObjectType _Nullable)objectForKey:(KeyType)key;
- (NSEnumerator<ObjectType> *)objectEnumerator;
@end

@interface REFBiMapTable<KeyType, ObjectType> : NSObject
@property(readonly) REFBiMapTable<ObjectType, KeyType> *_Nullable inverse;
- (void)setObject:(ObjectType)object forKey:(KeyType)key;
- (void)removeObjectForKey:(KeyType)key;
- (ObjectType _Nullable)objectForKey:(KeyType)key;
- (NSEnumerator<ObjectType> *)objectEnumerator;
@end

@interface REFRemoteReferenceMap : NSObject
- (void)add:(id)instance remoteReference:(REFRemoteReference *)remoteReference;
- (REFRemoteReference *_Nullable)removePairWithObject:(id)object;
- (id _Nullable)removePairWithRemoteReference:(REFRemoteReference *)remoteReference;
- (REFRemoteReference *_Nullable)getPairedRemoteReference:(id)object;
- (id _Nullable)getPairedObject:(REFRemoteReference *)remoteReference;
@end

NS_ASSUME_NONNULL_END
