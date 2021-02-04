#import "PenguinCameraPlugin.h"

@implementation PenguinCameraPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  REFTypeChannelMessenger *messenger = [ReferencePlugin getMessengerInstance:registrar.messenger];
  [PCMCaptureSession setupChannel:messenger];
  [PCMCaptureDevice setupChannel:messenger];
  [PCMCaptureDeviceInput setupChannel:messenger];
  [PCMPreviewController setupChannel:messenger];
}
@end
