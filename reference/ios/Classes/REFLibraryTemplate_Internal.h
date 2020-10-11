#import "REFMethodChannelReferencePairManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface _p_ReferencePairManager : REFMethodChannelReferencePairManager
- (instancetype)initWithChannelName:(NSString *)channelName
                    binaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
// TODO: Constructor with messageCodec
@end

@interface _p_ClassTemplate : NSObject <REFLocalReference>
- (NSNumber *_Nullable)fieldTemplate;
- (NSObject *_Nullable)methodTemplate:(NSString *_Nullable)parameterTemplate;

+ (void)_staticMethodTemplate:(_p_ReferencePairManager *)manager
            parameterTemplate:(NSString *_Nullable)parameterTemplate
                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
- (void)_methodTemplate:(_p_ReferencePairManager *)manager
      parameterTemplate:(NSString *_Nullable)parameterTemplate
             completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
@end

@interface _p_ClassTemplateCreationArgs : NSObject
@property NSNumber *_Nullable fieldTemplate;
@end

@interface _p_LocalHandler : NSObject <REFLocalReferenceCommunicationHandler>
- (_p_ClassTemplate *)createClassTemplate:(REFReferencePairManager *)manager
                                     args:(_p_ClassTemplateCreationArgs *)args;
- (id _Nullable)classTemplate_staticMethodTemplate:(REFReferencePairManager *)manager
                                 parameterTemplate:(NSString *_Nullable)parameterTemplate;
@end

@interface _p_RemoteHandler : REFMethodChannelRemoteHandler
- (instancetype)initWithChannelName:(NSString *)channelName
                    binaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
@end

NS_ASSUME_NONNULL_END
