#import <Flutter/Flutter.h>

#import "REFPoolableReferencePairManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface REFMethodChannelError : NSError
@end

@interface REFReferenceReaderWriter : FlutterStandardReaderWriter
@end

@interface REFMethodChannelRemoteHandler : NSObject<REFRemoteReferenceCommunicationHandler>
@property (readonly) id<FlutterBinaryMessenger> binaryMessenger;
@property (readonly) FlutterMethodChannel *channel;
// TODO: Switch order of channelName and binaryMessenger
- (instancetype)initWithChannelName:(NSString *)channelName
                    binaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
@end

@interface REFMethodChannelReferencePairManager : REFPoolableReferencePairManager
@property (readonly) NSString* channelName;
@property (readonly) id<FlutterBinaryMessenger> binaryMessenger;
@property (readonly) FlutterMethodChannel *channel;
- (instancetype) initWithSupportedClasses:(NSArray<REFClass *> *)supportedClasses
                          binaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger
                              channelName:(NSString *)channelName;
// TODO: Constructor with ReaderWriter and poolID
@end

NS_ASSUME_NONNULL_END
