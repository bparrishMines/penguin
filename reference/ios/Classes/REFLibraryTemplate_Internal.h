#import "REFMethodChannelReferencePairManager.h"

NS_ASSUME_NONNULL_BEGIN

@class _p_ClassTemplate;

//@interface _p_ReferencePairManager : REFMethodChannelReferencePairManager
//- (instancetype)initWithChannelName:(NSString *)channelName
//                    binaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
//// TODO: Constructor with messageCodec
//@end

@protocol _p_ClassTemplate <NSObject>
- (NSNumber *_Nullable)fieldTemplate;
- (NSObject *_Nullable)methodTemplate:(NSString *_Nullable)parameterTemplate;

//+ (void)_staticMethodTemplate:(_p_ReferencePairManager *)manager
//            parameterTemplate:(NSString *_Nullable)parameterTemplate
//                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
//- (void)_methodTemplate:(_p_ReferencePairManager *)manager
//      parameterTemplate:(NSString *_Nullable)parameterTemplate
//             completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
@end

@interface _p_ClassTemplateCreationArgs : NSObject
@property NSNumber *_Nullable fieldTemplate;
@end

@interface _p_ClassTemplateChannel : REFReferenceChannel
- (instancetype)initWithManager:(REFReferenceChannelManager *)manager;
- (void)invoke_staticMethodTemplate:(NSString *_Nullable)parameterTemplate
                         completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
- (void)invoke_methodTemplate:(NSObject<_p_ClassTemplate> *)instance
            parameterTemplate:(NSString *_Nullable)parameterTemplate
                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
@end

@interface _p_ClassTemplateHandler : NSObject<REFReferenceChannelHandler>
- (NSObject<_p_ClassTemplate> *)onCreate:(REFReferenceChannelManager *)manager
                                             args:(_p_ClassTemplateCreationArgs *)args;
- (NSObject *_Nullable)on_staticMethodTemplate:(REFReferenceChannelManager *)manager
                             parameterTemplate:(NSString *_Nullable)parameterTemplate;
@end

//@interface _p_LocalHandler : NSObject <REFLocalReferenceCommunicationHandler>
//- (_p_ClassTemplate *)createClassTemplate:(REFReferencePairManager *)manager
//                                     args:(_p_ClassTemplateCreationArgs *)args;
//- (id _Nullable)classTemplate_staticMethodTemplate:(REFReferencePairManager *)manager
//                                 parameterTemplate:(NSString *_Nullable)parameterTemplate;
//@end
//
//@interface _p_RemoteHandler : REFMethodChannelRemoteHandler
//- (instancetype)initWithChannelName:(NSString *)channelName
//                    binaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
//@end

NS_ASSUME_NONNULL_END
