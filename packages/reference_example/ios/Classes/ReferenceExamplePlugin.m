#import "ReferenceExamplePlugin.h"

@implementation ReferenceExamplePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  REFTypeChannelMessenger *messenger = [ReferencePlugin getMessengerInstance:registrar.messenger];
  
  EXPLibraryImplementations *implementations = [[EXPLibraryImplementations alloc] initWithMessenger:messenger];
  __prefix__ChannelRegistrar *libraryRegistrar = [[__prefix__ChannelRegistrar alloc]
                                                  initWithImplementation:implementations];
  [libraryRegistrar registerHandlers];
}
@end
