#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface REFPairedInstance : NSObject <NSCopying>
@property(readonly) NSString *instanceID;
+ (REFPairedInstance *)fromID:(NSString *)instanceID;
- (instancetype)initWithInstanceID:(NSString *)instanceID;
@end

@interface REFNewUnpairedInstance : NSObject <NSCopying>
@property(readonly) NSString *channelName;
@property(readonly) NSArray<id> *creationArguments;
- (instancetype)initWithChannelName:(NSString *)channelName
                  creationArguments:(NSArray<id> *)creationArguments;
@end

NS_ASSUME_NONNULL_END
