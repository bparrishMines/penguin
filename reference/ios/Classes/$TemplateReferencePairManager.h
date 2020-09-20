#import "REFMethodChannelReferencePairManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface _TemplateReferencePairManager : REFMethodChannelReferencePairManager
-(instancetype)initWithChannelName:(NSString *)channelName binaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
// TODO: Constructor with messageCodec
@end

@interface _ClassTemplate : NSObject<REFLocalReference>
-(NSNumber *_Nullable)fieldTemplate;
+(NSNumber *_Nullable)staticMethodTemplate:(NSString *_Nullable)parameterTemplate;
-(NSString *_Nullable)methodTemplate:(NSString *_Nullable)parameterTemplate;

+(void)_staticMethodTemplate:(_TemplateReferencePairManager *)manager
                   parameterTemplate:(NSString *_Nullable)parameterTemplate
                          completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
-(void)_methodTemplate:(_TemplateReferencePairManager *)manager
             parameterTemplate:(NSString *_Nullable)parameterTemplate
                    completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
@end

@interface _LocalHandler : NSObject<REFLocalReferenceCommunicationHandler>
-(_ClassTemplate *)createClassTemplate:(REFReferencePairManager *)manager
                         fieldTemplate:(NSNumber *)fieldTemplate;
-(id _Nullable)classTemplate_staticMethodTemplate:(REFReferencePairManager *)manager
                                parameterTemplate:(NSString *)parameterTemplate;
@end

@interface _RemoteHandler : REFMethodChannelRemoteHandler
-(instancetype)initWithChannelName:(NSString *)channelName binaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
@end

NS_ASSUME_NONNULL_END
