#import "REFMethodChannelReferencePairManager.h"

NS_ASSUME_NONNULL_BEGIN

@class REFClassTemplate;

@protocol REFClassTemplate <NSObject>
- (NSNumber *_Nullable)fieldTemplate;
- (NSObject *_Nullable)methodTemplate:(NSString *_Nullable)parameterTemplate;
@end

@interface REFClassTemplateCreationArgs : NSObject
@property NSNumber *_Nullable fieldTemplate;
@end

@interface REFClassTemplateChannel : REFReferenceChannel
- (instancetype)initWithManager:(REFReferenceChannelManager *)manager;
- (void)invoke_staticMethodTemplate:(NSString *_Nullable)parameterTemplate
                         completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
- (void)invoke_methodTemplate:(NSObject<REFClassTemplate> *)instance
            parameterTemplate:(NSString *_Nullable)parameterTemplate
                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
@end

@interface REFClassTemplateHandler : NSObject<REFReferenceChannelHandler>
- (NSObject<REFClassTemplate> *)onCreate:(REFReferenceChannelManager *)manager
                                             args:(REFClassTemplateCreationArgs *)args;
- (NSObject *_Nullable)on_staticMethodTemplate:(REFReferenceChannelManager *)manager
                             parameterTemplate:(NSString *_Nullable)parameterTemplate;
@end

NS_ASSUME_NONNULL_END
