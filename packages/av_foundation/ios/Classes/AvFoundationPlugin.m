#import "AvFoundationPlugin.h"

@implementation AvFoundationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  REFTypeChannelMessenger *messenger = [ReferencePlugin getMessengerInstance:registrar.messenger];
    
  AFPLibraryImplementations *implementations = [[AFPLibraryImplementations alloc] initWithMessenger:messenger];
  AFPChannelRegistrar *channels = [[AFPChannelRegistrar alloc] initWithImplementation:implementations];
  [channels registerHandlers];
}
@end
