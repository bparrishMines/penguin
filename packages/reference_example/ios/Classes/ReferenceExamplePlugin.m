#import "ReferenceExamplePlugin.h"

@implementation ReferenceExamplePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  REFTypeChannelMessenger *messenger = [ReferencePlugin getMessengerInstance:registrar.messenger];
  
  EXPLibraryImplementations *implementations = [[EXPLibraryImplementations alloc] initWithMessenger:messenger];
  EXPChannelRegistrar *libraryRegistrar = [[EXPChannelRegistrar alloc] initWithImplementation:implementations];
  [libraryRegistrar registerHandlers];
}
@end
