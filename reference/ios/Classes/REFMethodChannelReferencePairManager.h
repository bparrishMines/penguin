#import <Flutter/Flutter.h>

#import "REFReferenceChannelManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface REFReferenceReaderWriter : FlutterStandardReaderWriter
@end

@interface REFMethodChannelReferenceChannelMessenger : NSObject<REFReferenceChannelMessenger>
@property(readonly) FlutterMethodChannel *channel;
- (instancetype)initWithChannel:(FlutterMethodChannel *)channel;
@end

@interface REFMethodChannelReferenceChannelManager : REFReferenceChannelManager
@property(readonly) FlutterMethodChannel *channel;
- (instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger
                            channelName:(NSString *)channelName;
@end

@interface REFMethodChannelError : NSError
@end

NS_ASSUME_NONNULL_END
