#import <Flutter/Flutter.h>

#import "REFPoolableReferencePairManager.h"


NS_ASSUME_NONNULL_BEGIN

@interface REFReferenceReaderWriter : FlutterStandardReaderWriter
@end

@interface REFMethodChannelRemoteHandler : NSObject<REFRemoteReferenceCommunicationHandler>
@property (readonly) id<FlutterBinaryMessenger> binaryMessenger;
@property (readonly) FlutterMethodChannel *channel;
- (instancetype)initWithName:(NSString *)name binaaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
@end

@interface REFMethodChannelReferencePairManager : REFPoolableReferencePairManager
@end

NS_ASSUME_NONNULL_END
