#import <Flutter/Flutter.h>

#import "REFTypeChannel.h"

NS_ASSUME_NONNULL_BEGIN

@interface REFReferenceReaderWriter : FlutterStandardReaderWriter
@end

@interface REFMethodChannelMessageDispatcher : NSObject<REFTypeChannelMessageDispatcher>
@property(readonly) FlutterMethodChannel *channel;
- (instancetype)initWithChannel:(FlutterMethodChannel *)channel;
@end

@interface REFMethodChannelMessenger : REFTypeChannelMessenger
@property(readonly) id<FlutterBinaryMessenger> binaryMessenger;
@property(readonly) FlutterMethodChannel *channel;
- (instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger
                            channelName:(NSString *)channelName;
@end

@interface REFMethodChannelError : NSError
@end

NS_ASSUME_NONNULL_END
