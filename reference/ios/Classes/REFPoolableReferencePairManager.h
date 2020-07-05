#import "REFReferencePairManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface REFPoolableReferenceConverter : REFStandardReferenceConverter
@end

@interface REFPoolableReferencePairManager : REFReferencePairManager
@property (readonly) NSString *poolID;
-(instancetype)initWithSupportedClasses:(NSArray<REFClass *> *)supportedClasses
                                 poolID:(NSString *)poolID;
@end

@interface REFReferencePairManagerPool : NSObject
- (BOOL)add:(REFPoolableReferencePairManager *)manager;
- (void)remove:(REFPoolableReferencePairManager *)manager;
@end

NS_ASSUME_NONNULL_END
