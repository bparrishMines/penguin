#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface REFPairedInstance : NSObject <NSCopying>
@property(readonly) NSString *instanceID;
+ (REFPairedInstance *)fromID:(NSString *)instanceID;
- (instancetype)initWithInstanceID:(NSString *)instanceID;
@end

NS_ASSUME_NONNULL_END
