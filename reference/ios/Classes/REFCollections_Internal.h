#import <Foundation/Foundation.h>

#import "REFInstance.h"

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

@interface REFPairedInstanceMap : NSObject
- (void)add:(id)instance pairedInstance:(REFPairedInstance *)pairedInstance;
- (REFPairedInstance *_Nullable)removePairWithObject:(id)object;
- (id _Nullable)removePairWithPairedInstance:(REFPairedInstance *)pairedInstance;
- (REFPairedInstance *_Nullable)getPairedInstance:(id)object;
- (id _Nullable)getPairedObject:(REFPairedInstance *)pairedInstance;
@end

NS_ASSUME_NONNULL_END
