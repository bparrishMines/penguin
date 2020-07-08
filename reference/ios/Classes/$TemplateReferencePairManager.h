#import "REFMethodChannelReferencePairManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface ClassTemplate : NSObject<REFLocalReference>
-(NSNumber *_Nullable)fieldTemplate;
-(NSString *_Nullable)methodTemplate:(NSString *_Nullable)parameterTemplate;
@end

@interface _LocalHandler : NSObject<REFLocalReferenceCommunicationHandler>
-(ClassTemplate *)createClassTemplate:(REFReferencePairManager *)manager fieldTemplate:(NSNumber *)fieldTemplate;
@end

@interface _RemoteHandler : REFMethodChannelRemoteHandler
-(instancetype)initWithChannelName:(NSString *)channelName binaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
@end

@interface _TemplateReferencePairManager : REFMethodChannelReferencePairManager
-(instancetype)initWithChannelName:(NSString *)channelName binaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
// TODO: Constructor with messageCodec
@end

NS_ASSUME_NONNULL_END
