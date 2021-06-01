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

- (NSArray<IAFCaptureDeviceProxy *> *)_devicesWithMediaType:(REFTypeChannelMessenger *)messenger
                                                    mediaType:(NSString *_Nullable)mediaType {
  return [IAFCaptureDeviceProxy devicesWithMediaType:mediaType implementations:_implementations];
}
@end

@implementation IAFCaptureDeviceInputHandler
- (IAFCaptureDeviceInputProxy *)__create:(REFTypeChannelMessenger *)messenger
                                        device:(NSObject<_IAFCaptureDevice> *)device {
  return [[IAFCaptureDeviceInputProxy alloc] initWithDevice:((IAFCaptureDeviceProxy *)device)];
}
@end

@implementation IAFCaptureSessionHandler
- (IAFCaptureSessionProxy *)__create:(REFTypeChannelMessenger *)messenger {
  return [[IAFCaptureSessionProxy alloc] init];
}
@end

@implementation IAFPreviewControllerHandler
- (IAFPreviewControllerProxy *)__create:(REFTypeChannelMessenger *)messenger
                               captureSession:(NSObject<_IAFCaptureSession> *)captureSession {
  return [[IAFPreviewControllerProxy alloc] initWithCaptureSession:((IAFCaptureSessionProxy *)captureSession)];
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

- (NSObject<_IAFCapturePhotoCaptureDelegate> *)__create:(REFTypeChannelMessenger *)messenger {
  if (@available(iOS 10.0, *)) {
    return [[IAFCapturePhotoCaptureDelegateProxy alloc] initWithImplementations:_implementations];
  }
  NSLog(@"CapturePhotoCaptureDelegate is only supported on iOS 10+");
  return nil;
}
@end

@implementation IAFCapturePhotoSettingsHandler
- (NSObject<_IAFCapturePhotoSettings> *)__create:(REFTypeChannelMessenger *)messenger processedFormat:(NSDictionary<NSString *,NSObject *> *)processedFormat {
  if (@available(iOS 10.0, *)) {
    return [[IAFCapturePhotoSettingsProxy alloc] initwithProcessedFormat:processedFormat];
  }
  NSLog(@"IAFCapturePhotoSettings is only supported on iOS 10+");
  return nil;
}
@end

@implementation IAFCapturePhotoOutputHandler
- (NSObject<_IAFCapturePhotoOutput> *)__create:(REFTypeChannelMessenger *)messenger {
  if (@available(iOS 10.0, *)) {
    return [[IAFCapturePhotoOutputProxy alloc] init];
  }
  NSLog(@"IAFCapturePhotoOutput is only supported on iOS 10+");
  return nil;
}
@end
