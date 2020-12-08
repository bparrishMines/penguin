#import <Flutter/Flutter.h>

#import "PluginTemplate.h"

@interface ReferencePlugin : NSObject <FlutterPlugin>
+ (REFReferenceChannelManager *)getManagerInstance:(NSObject<FlutterBinaryMessenger> *)messenger;
@end
