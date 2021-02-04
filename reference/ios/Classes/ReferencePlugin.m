#import "ReferencePlugin.h"

static REFThreadSafeMapTable<NSObject<FlutterBinaryMessenger> *, REFTypeChannelMessenger *> *messengers;

@implementation ReferencePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [PluginTemplate registerWithRegistrar:registrar];
}

+ (REFTypeChannelMessenger *)getMessengerInstance:(NSObject<FlutterBinaryMessenger> *)binaryMessenger {
  static dispatch_once_t once;
  dispatch_once(&once, ^ {
    messengers = [[REFThreadSafeMapTable alloc] init];
  });
  
  REFTypeChannelMessenger *typeChannelMessenger = [messengers objectForKey:binaryMessenger];
  if (!typeChannelMessenger) {
    typeChannelMessenger = [[REFMethodChannelMessenger alloc] initWithBinaryMessenger:binaryMessenger
                                                                          channelName:@"github.penguin/reference"];
    [messengers setObject:typeChannelMessenger forKey:binaryMessenger];
  }
  return typeChannelMessenger;
}

// TODO: actually called?
- (void)detachFromEngineForRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  [messengers removeObjectForKey:registrar.messenger];
}
@end
