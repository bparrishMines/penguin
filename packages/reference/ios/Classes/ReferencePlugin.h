#import <Flutter/Flutter.h>
#import "REFMethodChannel.h"

NS_ASSUME_NONNULL_BEGIN

@interface REFReferenceViewFactory : NSObject<FlutterPlatformViewFactory>
- (instancetype)initWithManager:(REFInstanceManager *)manager;
@end

@interface ReferencePlugin : NSObject <FlutterPlugin>
+ (REFTypeChannelMessenger *)getMessengerInstance:(NSObject<FlutterBinaryMessenger> *)messenger;
@end

NS_ASSUME_NONNULL_END
