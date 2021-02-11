#import "REFMethodChannel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol REFClassTemplate;

@protocol REFClassTemplate <NSObject>
- (NSNumber *_Nullable)fieldTemplate;
- (NSObject *_Nullable)methodTemplate:(NSString *_Nullable)parameterTemplate /*following_parameters*/;
@end

@interface REFClassTemplateCreationArgs : NSObject
@property NSNumber *_Nullable fieldTemplate;
@end

@interface REFClassTemplateChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;
- (void)invoke_staticMethodTemplate:(NSString *_Nullable)parameterTemplate
/*following_parameters*/
                         completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
- (void)invoke_methodTemplate:(NSObject<REFClassTemplate> *)instance
            parameterTemplate:(NSString *_Nullable)parameterTemplate
                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
@end

@interface REFClassTemplateHandler : NSObject<REFTypeChannelHandler>
- (NSObject<REFClassTemplate> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(REFClassTemplateCreationArgs *)args;
- (NSObject *_Nullable)on_staticMethodTemplate:(REFTypeChannelMessenger *)messenger
                             parameterTemplate:(NSString *_Nullable)parameterTemplate;
@end

NS_ASSUME_NONNULL_END