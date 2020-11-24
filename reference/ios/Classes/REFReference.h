#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//@interface REFClass : NSObject <NSCopying>
//@property(readonly) Class clazz;
//+ (REFClass *)fromClass:(Class)clazz;
//@end

//@protocol REFReference <NSObject>
//@end

//@protocol REFLocalReference <REFReference>
//- (REFClass *)referenceClass;
//@end

@protocol REFReferencable
@end

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
