#import "ReferencePlugin.h"

static REFThreadSafeMapTable<NSObject<FlutterBinaryMessenger> *, REFTypeChannelMessenger *> *messengers;

@implementation REFReferenceViewFactory {
  REFInstanceManager *_manager;
}

- (instancetype)initWithManager:(REFInstanceManager *)manager {
  self = [super init];
  if (self) {
    _manager = manager;
  }
  return self;
}

- (nonnull NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame
                                            viewIdentifier:(int64_t)viewId
                                                 arguments:(id _Nullable)args {
  NSString *instanceID = (NSString *) args;
  NSObject<FlutterPlatformView> *view = (NSObject<FlutterPlatformView> *) [_manager getInstance:instanceID];
  
  if (!view) {
    NSLog(@"Unable to find instance with instanceID: %@", instanceID);
  }
  return view;
}

- (NSObject<FlutterMessageCodec> *)createArgsCodec {
  return [FlutterStandardMessageCodec sharedInstance];
}
@end

@implementation ReferencePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  REFTypeChannelMessenger *messenger = [ReferencePlugin getMessengerInstance:registrar.messenger];
  
  [registrar registerViewFactory:[[REFReferenceViewFactory alloc] initWithManager:messenger.instanceManager]
                          withId:@"github.penguin.reference/UiKitReferenceWidget"];
}

+ (REFTypeChannelMessenger *)getMessengerInstance:(NSObject<FlutterBinaryMessenger> *)binaryMessenger {
  static dispatch_once_t once;
  dispatch_once(&once, ^ {
    messengers = [REFThreadSafeMapTable strongToStrongObjectsMapTable];
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
