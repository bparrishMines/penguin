// GENERATED CODE - DO NOT MODIFY BY HAND

#import "REFMethodChannel.h"

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

NS_ASSUME_NONNULL_BEGIN

@protocol REFClassTemplate;

@protocol REFClassTemplate <NSObject>
@end

@interface REFClassTemplateChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;
- (void)_create:(NSObject<REFClassTemplate> *)_instance
         _owner:(BOOL)_owner
  fieldTemplate:(NSNumber *_Nullable)fieldTemplate
     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;
- (void)_invokeStaticMethodTemplate:(NSString *_Nullable)parameterTemplate
/*following_parameters*/
                         completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
- (void)_invokeMethodTemplate:(NSObject<REFClassTemplate> *)instance
            parameterTemplate:(NSString *_Nullable)parameterTemplate
                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
@end

@interface REFClassTemplateHandler : NSObject<REFTypeChannelHandler>
- (NSObject<REFClassTemplate> *)_create:(REFTypeChannelMessenger *)messenger
                          fieldTemplate:(NSNumber *)fieldTemplate;
- (NSObject *_Nullable)_onStaticMethodTemplate:(REFTypeChannelMessenger *)messenger
                             parameterTemplate:(NSString *_Nullable)parameterTemplate;
- (NSObject *_Nullable)_onMethodTemplate:(NSObject<REFClassTemplate> *)_instance
                       parameterTemplate:(NSString *_Nullable)parameterTemplate;
@end

@interface REFLibraryImplementations : NSObject
@property (readonly) REFTypeChannelMessenger *messenger;
-(instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;
-(REFClassTemplateChannel *)classTemplateChannel;
-(REFClassTemplateHandler *)classTemplateHandler;
@end

@interface REFChannelRegistrar : NSObject
@property (readonly) REFLibraryImplementations *implementations;
- (instancetype)initWithImplementation:(REFLibraryImplementations *)implementations;
- (void)registerHandlers;
- (void)unregisterHandlers;
@end

NS_ASSUME_NONNULL_END
