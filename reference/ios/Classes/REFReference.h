#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface REFClass : NSObject
@property (readonly) Class clazz;
+ (REFClass *)fromClass:(Class)clazz;
@end

@protocol REFReference <NSObject>
@end

@protocol REFLocalReference <REFReference>
- (REFClass *)referenceClass;
@end

@interface REFRemoteReference : NSObject<REFReference>
@property (readonly) NSString *referenceID;
- (instancetype)initWithReferenceID:(NSString *)referenceID;
@end

@interface REFUnpairedReference : NSObject<REFReference>
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
