#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface REFClass : NSObject<NSCopying>
@property (readonly) Class clazz;
+ (REFClass *)fromClass:(Class)clazz;
@end

@protocol REFReference <NSObject>
@end

@protocol REFLocalReference <REFReference>
- (REFClass *)referenceClass;
@end

@interface REFRemoteReference : NSObject<REFReference, NSCopying>
@property (readonly) NSString *referenceID;
+ (REFRemoteReference *)fromID:(NSString *)referenceID;
- (instancetype)initWithReferenceID:(NSString *)referenceID;
@end

@interface REFUnpairedReference : NSObject<REFReference, NSCopying>
@property (readonly) NSUInteger classID;
@property (readonly) NSArray<id> *creationArguments;
@property (readonly) NSString *_Nullable managerPoolID;
- (instancetype)initWithClassID:(NSUInteger)classID
              creationArguments:(NSArray<id> *)creationArguments;
- (instancetype)initWithClassID:(NSUInteger)classID
              creationArguments:(NSArray<id> *)creationArguments
                  managerPoolID:(NSString *)managerPoolID;
@end

NS_ASSUME_NONNULL_END
