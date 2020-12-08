#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface REFRemoteReference : NSObject <NSCopying>
@property(readonly) NSString *referenceID;
+ (REFRemoteReference *)fromID:(NSString *)referenceID;
- (instancetype)initWithReferenceID:(NSString *)referenceID;
@end

@interface REFUnpairedReference : NSObject <NSCopying>
@property(readonly) NSString *handlerChannel;
@property(readonly) NSArray<id> *creationArguments;
- (instancetype)initWithChannel:(NSString *)handlerChannel
              creationArguments:(NSArray<id> *)creationArguments;
@end

NS_ASSUME_NONNULL_END
