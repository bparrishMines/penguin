#import <Flutter/Flutter.h>

#import "REFTypeChannel.h"

NS_ASSUME_NONNULL_BEGIN

@interface REFReferenceReaderWriter : FlutterStandardReaderWriter
@end

@interface REFMethodChannelMessenger : NSObject<REFTypeChannelMessenger>
@property(readonly) FlutterMethodChannel *channel;
- (instancetype)initWithChannel:(FlutterMethodChannel *)channel;
@end

@interface REFMethodChannelManager : REFTypeChannelManager
@property(readonly) FlutterMethodChannel *channel;
- (instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger
                            channelName:(NSString *)channelName;
@end

@interface REFMethodChannelError : NSError
@end

NS_ASSUME_NONNULL_END
