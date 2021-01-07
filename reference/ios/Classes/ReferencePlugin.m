#import "ReferencePlugin.h"

static REFThreadSafeMapTable<NSObject<FlutterBinaryMessenger> *, REFTypeChannelManager *> *managers;

@implementation ReferencePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [PluginTemplate registerWithRegistrar:registrar];
}

+ (REFTypeChannelManager *)getManagerInstance:(NSObject<FlutterBinaryMessenger> *)messenger {
  static dispatch_once_t once;
  dispatch_once(&once, ^ {
    managers = [[REFThreadSafeMapTable alloc] init];
  });
  
  REFTypeChannelManager *manager = [managers objectForKey:messenger];
  if (!manager) {
    manager = [[REFMethodChannelManager alloc] initWithBinaryMessenger:messenger
                                                           channelName:@"github.penguin/reference"];
    [managers setObject:manager forKey:messenger];
  }
  return manager;
}

// TODO: actually called?
- (void)detachFromEngineForRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  [managers removeObjectForKey:registrar.messenger];
}
@end
