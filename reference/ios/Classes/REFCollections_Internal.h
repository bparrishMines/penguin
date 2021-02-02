#import <Foundation/Foundation.h>

#import "REFInstance.h"

NS_ASSUME_NONNULL_BEGIN

@interface REFThreadSafeMapTable<KeyType, ObjectType> : NSObject
- (void)setObject:(ObjectType)object forKey:(KeyType)key;
- (void)removeObjectForKey:(KeyType)key;
- (ObjectType _Nullable)objectForKey:(KeyType)key;
- (NSEnumerator<ObjectType> *)objectEnumerator;
@end

@interface InstancePairManager : NSObject
- (BOOL)addPair:(NSObject *)object
 pairedInstance:(REFPairedInstance *)pairedInstance
          owner:(NSObject *)owner;
- (BOOL)isPaired:(NSObject *)object;
- (BOOL)removePairWithObject:(id)object
                       owner:(NSObject *)owner
                       force:(BOOL)force;
- (REFPairedInstance *_Nullable)getPairedPairedInstance:(id)object;
- (id _Nullable)getPairedObject:(REFPairedInstance *)pairedInstance;
@end

NS_ASSUME_NONNULL_END
