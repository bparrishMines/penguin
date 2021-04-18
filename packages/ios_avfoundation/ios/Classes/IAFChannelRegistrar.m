#import "IAFChannelRegistrar.h"

@implementation IAFChannelRegistrar
@end

@implementation IAFLibraryImplementations
- (IAFCaptureDeviceHandler *)captureDeviceHandler {
  return [[IAFCaptureDeviceHandler alloc] initWithImplementations:self];
}

- (IAFCaptureDeviceInputHandler *)captureDeviceInputHandler {
  return [[IAFCaptureDeviceInputHandler alloc] init];
}

- (IAFCaptureSessionHandler *)captureSessionHandler {
  return [[IAFCaptureSessionHandler alloc] init];
}

- (IAFPreviewControllerHandler *)previewControllerHandler {
  return [[IAFPreviewControllerHandler alloc] init];
}

- (IAFCapturePhotoCaptureDelegateHandler *)capturePhotoCaptureDelegateHandler {
  return [[IAFCapturePhotoCaptureDelegateHandler alloc] initWithImplementations:self];
}

- (IAFCapturePhotoSettingsHandler *)capturePhotoSettingsHandler {
  return [[IAFCapturePhotoSettingsHandler alloc] init];
}

- (IAFCapturePhotoOutputHandler *)capturePhotoOutputHandler {
  return [[IAFCapturePhotoOutputHandler alloc] init];
}
@end

@implementation IAFCaptureDeviceHandler {
  IAFLibraryImplementations *_implementations;
}

- (instancetype)initWithImplementations:(IAFLibraryImplementations *)implementations {
  self = [super init];
  if (self) {
    _implementations = implementations;
  }
  return self;
}

- (NSArray<IAFCaptureDeviceProxy *> *)on_devicesWithMediaType:(REFTypeChannelMessenger *)messenger
                                                    mediaType:(NSString *_Nullable)mediaType {
  return [IAFCaptureDeviceProxy devicesWithMediaType:mediaType implementations:_implementations];
}
@end

@implementation IAFCaptureDeviceInputHandler
- (IAFCaptureDeviceInputProxy *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(_IAFCaptureDeviceInputCreationArgs *)args {
  return [[IAFCaptureDeviceInputProxy alloc] initWithDevice:((IAFCaptureDeviceProxy *)args.device)];
}
@end

@implementation IAFCaptureSessionHandler
- (IAFCaptureSessionProxy *)onCreate:(REFTypeChannelMessenger *)messenger
                                args:(_IAFCaptureSessionCreationArgs *)args {
  return [[IAFCaptureSessionProxy alloc] init];
}
@end

@implementation IAFPreviewControllerHandler
- (IAFPreviewControllerProxy *)onCreate:(REFTypeChannelMessenger *)messenger
                                   args:(_IAFPreviewControllerCreationArgs *)args {
  return [[IAFPreviewControllerProxy alloc] initWithCaptureSession:((IAFCaptureSessionProxy *)args.captureSession)];
}
@end

@implementation IAFCapturePhotoCaptureDelegateHandler {
  IAFLibraryImplementations *_implementations;
}

- (instancetype)initWithImplementations:(IAFLibraryImplementations *)implementations {
  self = [super init];
  if (self) {
    _implementations = implementations;
  }
  return self;
}

- (IAFCapturePhotoCaptureDelegateProxy *)onCreate:(REFTypeChannelMessenger *)messenger
                                             args:(_IAFCapturePhotoCaptureDelegateCreationArgs *)args API_AVAILABLE(ios(10.0)){
  if (@available(iOS 10.0, *)) {
    return [[IAFCapturePhotoCaptureDelegateProxy alloc] initWithImplementations:_implementations];
  }
  NSLog(@"CapturePhotoCaptureDelegate is only supported on iOS 10+");
  return nil;
}
@end

@implementation IAFCapturePhotoSettingsHandler
- (IAFCapturePhotoSettingsProxy *)onCreate:(REFTypeChannelMessenger *)messenger
                                      args:(_IAFCapturePhotoSettingsCreationArgs *)args  API_AVAILABLE(ios(10.0)){
  if (@available(iOS 10.0, *)) {
    return [[IAFCapturePhotoSettingsProxy alloc] initwithProcessedFormat:args.processedFormat];
  }
  NSLog(@"IAFCapturePhotoSettings is only supported on iOS 10+");
  return nil;
}
@end

@implementation IAFCapturePhotoOutputHandler
- (IAFCapturePhotoOutputProxy *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(_IAFCapturePhotoOutputCreationArgs *)args  API_AVAILABLE(ios(10.0)){
  if (@available(iOS 10.0, *)) {
    return [[IAFCapturePhotoOutputProxy alloc] init];
  }
  NSLog(@"IAFCapturePhotoOutput is only supported on iOS 10+");
  return nil;
}
@end
