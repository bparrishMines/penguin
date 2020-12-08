#import "ReferencePlugin.h"

static REFThreadSafeMapTable<NSObject<FlutterBinaryMessenger> *, REFReferenceChannelManager *> *managers;

@implementation ReferencePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [PluginTemplate registerWithRegistrar:registrar];
}

+ (REFReferenceChannelManager *)getManagerInstance:(NSObject<FlutterBinaryMessenger> *)messenger {
  static dispatch_once_t once;
  dispatch_once(&once, ^ {
    managers = [[REFThreadSafeMapTable alloc] init];
  });
  
  REFReferenceChannelManager *manager = [managers objectForKey:messenger];
  if (!manager) {
    manager = [[REFMethodChannelReferenceChannelManager alloc] initWithBinaryMessenger:messenger
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
