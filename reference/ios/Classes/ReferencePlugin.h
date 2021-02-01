#import <Flutter/Flutter.h>

#import "REFPluginTemplate_Internal.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReferencePlugin : NSObject <FlutterPlugin>
+ (REFTypeChannelMessenger *)getManagerInstance:(NSObject<FlutterBinaryMessenger> *)messenger;
@end

NS_ASSUME_NONNULL_END
