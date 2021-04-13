#import <Flutter/Flutter.h>
#import "REFMethodChannel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReferencePlugin : NSObject <FlutterPlugin>
+ (REFTypeChannelMessenger *)getMessengerInstance:(NSObject<FlutterBinaryMessenger> *)messenger;
@end

NS_ASSUME_NONNULL_END
