#import "TestPlugin.h"
#import "ChannelHandler+Generated.h"

@interface TestPlugin ()
@property ChannelHandler *handler;
@end

@implementation TestPlugin
- (instancetype)init {
  self = [super init];
  if (self) {
    _handler = [[ChannelHandler alloc] init];
  }
  return self;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"test_plugin"
            binaryMessenger:[registrar messenger]];
  TestPlugin* instance = [[TestPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  [_handler handleMethodCall:call result:result];
}

@end
