#import "IosAvfoundationPlugin.h"

/*
@interface MyViewFactory : NSObject<FlutterPlatformViewFactory>
@end

@implementation MyViewFactory {
  REFTypeChannelMessenger *_messenger;
}

- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  self = [super init];
  if (self) {
    _messenger = messenger;
  }
  return self;
}

- (nonnull NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame
                                            viewIdentifier:(int64_t)viewId
                                                 arguments:(id _Nullable)args {
  REFPairedInstance *pairedInstance = (REFPairedInstance *) args;
  NSLog(@"pairedInstance: %@", pairedInstance);
  NSObject<FlutterPlatformView> *view = [_messenger getPairedObject:pairedInstance];
  NSLog(@"view: %@", view);
  return view;
}

- (NSObject<FlutterMessageCodec>*)createArgsCodec {
  return [FlutterStandardMessageCodec codecWithReaderWriter:[[REFReferenceReaderWriter alloc] init]];
}
@end
*/

@implementation IosAvfoundationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
/*
  REFTypeChannelMessenger *messenger = [ReferencePlugin getMessengerInstance:registrar.messenger];
    [PCMCaptureSession setupChannel:messenger];
    [PCMCaptureDevice setupChannel:messenger];
    [PCMCaptureDeviceInput setupChannel:messenger];
    [PCMPreviewController setupChannel:messenger];
    [registrar registerViewFactory:[[MyViewFactory alloc] initWithMessenger:messenger]
                            withId:@"penguin_camera/ios/Preview"];
                            */
}
@end
