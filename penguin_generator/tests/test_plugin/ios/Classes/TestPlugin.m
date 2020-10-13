#import "TestPlugin.h"
#import "ChannelHandler+Generated.h"

@interface TestPlugin ()
@property ChannelHandler *handler;
@end

@implementation TestPlugin
- (instancetype)initWithChannel:(FlutterMethodChannel *)channel {
  self = [super init];
  if (self) {
    _handler = [[ChannelHandler alloc] initWithCallbackChannel:channel];
  }
  return self;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"test_plugin"
            binaryMessenger:[registrar messenger]];
  TestPlugin* instance = [[TestPlugin alloc] initWithChannel:channel];
  [registrar addMethodCallDelegate:instance channel:channel];
  [registrar registerViewFactory:instance.handler.viewFactory withId:@"test_plugin/view"];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  [_handler.methodCallHandler onMethodCall:call result:result];
}

@end
