#import "IAFChannelRegistrar.h"

@implementation IAFChannelRegistrar
@end

@implementation IAFLibraryImplementations {
  IAFCaptureDeviceInputChannel *_captureDeviceInputChannel;
  IAFCaptureSessionChannel *_captureSessionChannel;
  IAFCaptureDeviceChannel *_captureDeviceChannel;
  IAFPreviewControllerChannel *_previewControllerChannel;
  IAFCaptureInputChannel *_captureInputChannel;
  
  IAFCaptureDeviceInputHandler *_captureDeviceInputHandler;
  IAFCaptureSessionHandler *_captureSessionHandler;
  IAFCaptureDeviceHandler *_captureDeviceHandler;
  IAFPreviewControllerHandler *_previewControllerHandler;
  IAFCaptureInputHandler *_captureInputHandler;
}

-(instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  self = [super init];
  if (self) {
    _captureDeviceInputChannel = [[IAFCaptureDeviceInputChannel alloc] initWithMessenger:messenger];
    _captureSessionChannel = [[IAFCaptureSessionChannel alloc] initWithMessenger:messenger];
    _captureDeviceChannel = [[IAFCaptureDeviceChannel alloc] initWithMessenger:messenger];
    _previewControllerChannel = [[IAFPreviewControllerChannel alloc] initWithMessenger:messenger];
    _captureInputChannel = [[IAFCaptureInputChannel alloc] initWithMessenger:messenger];
    
    _captureDeviceInputHandler = [[IAFCaptureDeviceInputHandler alloc] init];
    _captureSessionHandler = [[IAFCaptureSessionHandler alloc] init];
    _captureDeviceHandler = [[IAFCaptureDeviceHandler alloc] initWithImplementations:self];
    _previewControllerHandler = [[IAFPreviewControllerHandler alloc] init];
    _captureInputHandler = [[IAFCaptureInputHandler alloc] init];
  }
  return self;
}

- (nonnull IAFCaptureDeviceChannel *)captureDeviceChannel {
  return _captureDeviceChannel;
}

- (nonnull IAFCaptureDeviceHandler *)captureDeviceHandler {
  return _captureDeviceHandler;
}

- (nonnull IAFCaptureDeviceInputChannel *)captureDeviceInputChannel {
  return _captureDeviceInputChannel;
}

- (nonnull IAFCaptureDeviceInputHandler *)captureDeviceInputHandler {
  return _captureDeviceInputHandler;
}

- (nonnull IAFCaptureInputChannel *)captureInputChannel {
  return _captureInputChannel;
}

- (nonnull IAFCaptureInputHandler *)captureInputHandler {
  return _captureInputHandler;
}

- (nonnull IAFCaptureSessionChannel *)captureSessionChannel {
  return _captureSessionChannel;
}

- (nonnull IAFCaptureSessionHandler *)captureSessionHandler {
  return _captureSessionHandler;
}

- (nonnull IAFPreviewControllerChannel *)previewControllerChannel {
  return _previewControllerChannel;
}

- (nonnull IAFPreviewControllerHandler *)previewControllerHandler {
  return _previewControllerHandler;
}

- (nonnull _IAFCaptureOutputChannel *)captureOutputChannel {
  <#code#>
}


- (nonnull _IAFCaptureOutputHandler *)captureOutputHandler {
  <#code#>
}


- (nonnull _IAFCapturePhotoCaptureDelegateChannel *)capturePhotoCaptureDelegateChannel {
  <#code#>
}


- (nonnull _IAFCapturePhotoCaptureDelegateHandler *)capturePhotoCaptureDelegateHandler {
  <#code#>
}


- (nonnull _IAFCapturePhotoChannel *)capturePhotoChannel {
  <#code#>
}


- (nonnull _IAFCapturePhotoHandler *)capturePhotoHandler {
  <#code#>
}


- (nonnull _IAFCapturePhotoOutputChannel *)capturePhotoOutputChannel {
  <#code#>
}


- (nonnull _IAFCapturePhotoOutputHandler *)capturePhotoOutputHandler {
  <#code#>
}


- (nonnull _IAFCapturePhotoSettingsChannel *)capturePhotoSettingsChannel {
  <#code#>
}


- (nonnull _IAFCapturePhotoSettingsHandler *)capturePhotoSettingsHandler {
  <#code#>
}


@end

@implementation IAFCaptureDeviceInputChannel
@end

@implementation IAFCaptureSessionChannel
@end

@implementation IAFCaptureDeviceChannel
@end

@implementation IAFPreviewControllerChannel
@end

@implementation IAFCaptureInputChannel
@end

@implementation IAFCapturePhotoChannel
@end

@implementation IAFCaptureOutputChannel
@end

@implementation IAFCapturePhotoCaptureDelegateChannel
@end

@implementation IAFCapturePhotoSettingsChannel
@end

@implementation IAFCapturePhotoOutputChannel
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

@implementation IAFCaptureInputHandler
@end

@implementation IAFCapturePhotoHandler
@end

@implementation IAFCaptureOutputHandler
@end

@implementation IAFCapturePhotoCaptureDelegateHandler
@end

@implementation IAFCapturePhotoSettingsHandler
@end

@implementation IAFCapturePhotoOutputHandler
@end
