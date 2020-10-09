#import "ReferencePlugin.h"

@implementation ReferencePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [PluginTemplate registerWithRegistrar:registrar];
}
@end
