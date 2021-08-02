#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"

@import av_foundation;

@interface SaveToGalleryDelegate : AFPCapturePhotoCaptureDelegateProxy
@end

@interface SaveToGalleryHandler : AFPCapturePhotoCaptureDelegateHandler
@end

@interface CustomImplementations : AFPLibraryImplementations
@end

@implementation SaveToGalleryDelegate
- (void)captureOutput:(AVCapturePhotoOutput *)output
didFinishProcessingPhoto:(AVCapturePhoto *)photo
                error:(NSError *)error  API_AVAILABLE(ios(11.0)) {
  UIImageWriteToSavedPhotosAlbum([[UIImage alloc] initWithData:photo.fileDataRepresentation], nil, nil, nil);
  [super captureOutput:output didFinishProcessingPhoto:photo error:error];
}
@end

@implementation SaveToGalleryHandler
- (SaveToGalleryDelegate *)_create_:(REFTypeChannelMessenger *)messenger
           didFinishProcessingPhoto:(_AFPFinishProcessingPhotoCallback)didFinishProcessingPhoto {
  return [[SaveToGalleryDelegate alloc] initWithCallback:didFinishProcessingPhoto implementations:[self implementations]];
}
@end

@implementation CustomImplementations
- (SaveToGalleryHandler *)handlerCapturePhotoCaptureDelegate {
  return [[SaveToGalleryHandler alloc] initWithImplementations:self];
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];

  REFTypeChannelMessenger *messenger = [ReferencePlugin getMessengerInstance:[self
                                                                              registrarForPlugin:@"MyApp"].messenger];
  CustomImplementations *implementations = [[CustomImplementations alloc] initWithMessenger:messenger];
  AFPChannelRegistrar *channels = [[AFPChannelRegistrar alloc] initWithImplementation:implementations];
  [channels registerHandlers];

  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
@end
