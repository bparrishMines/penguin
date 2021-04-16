#import "IAFChannelRegistrar.h"

@implementation IAFChannelRegistrar
@end

@implementation IAFLibraryImplementations {
  IAFCaptureDeviceInputChannel *_captureDeviceInputChannel;
  IAFCaptureSessionChannel *_captureSessionChannel;
  IAFCaptureDeviceChannel *_captureDeviceChannel;
  IAFPreviewControllerChannel *_previewControllerChannel;
  IAFCaptureInputChannel *_captureInputChannel;
  IAFCapturePhotoOutputChannel *_capturePhotoOutputChannel;
  IAFCaptureOutputChannel *_captureOutputChannel;
  IAFCapturePhotoSettingsChannel *_capturePhotoSettingsChannel;
  IAFCapturePhotoChannel *_capturePhotoChannel;
  IAFCapturePhotoCaptureDelegateChannel *_capturePhotoCaptureDelegateChannel;
  
  IAFCaptureDeviceInputHandler *_captureDeviceInputHandler;
  IAFCaptureSessionHandler *_captureSessionHandler;
  IAFCaptureDeviceHandler *_captureDeviceHandler;
  IAFPreviewControllerHandler *_previewControllerHandler;
  IAFCaptureInputHandler *_captureInputHandler;
  IAFCapturePhotoOutputHandler *_capturePhotoOutputHandler;
  IAFCaptureOutputHandler *_captureOutputHandler;
  IAFCapturePhotoSettingsHandler *_capturePhotoSettingsHandler;
  IAFCapturePhotoHandler *_capturePhotoHandler;
  IAFCapturePhotoCaptureDelegateHandler *_capturePhotoCaptureDelegateHandler;
}

-(instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  self = [super init];
  if (self) {
    _captureDeviceInputChannel = [[IAFCaptureDeviceInputChannel alloc] initWithMessenger:messenger];
    _captureSessionChannel = [[IAFCaptureSessionChannel alloc] initWithMessenger:messenger];
    _captureDeviceChannel = [[IAFCaptureDeviceChannel alloc] initWithMessenger:messenger];
    _previewControllerChannel = [[IAFPreviewControllerChannel alloc] initWithMessenger:messenger];
    _captureInputChannel = [[IAFCaptureInputChannel alloc] initWithMessenger:messenger];
    _capturePhotoOutputChannel = [[IAFCapturePhotoOutputChannel alloc] initWithMessenger:messenger];
    _captureOutputChannel = [[IAFCaptureOutputChannel alloc] initWithMessenger:messenger];
    _capturePhotoSettingsChannel = [[IAFCapturePhotoSettingsChannel alloc] initWithMessenger:messenger];
    _capturePhotoChannel = [[IAFCapturePhotoChannel alloc] initWithMessenger:messenger];
    _capturePhotoCaptureDelegateChannel = [[IAFCapturePhotoCaptureDelegateChannel alloc] initWithMessenger:messenger];
    
    _captureDeviceInputHandler = [[IAFCaptureDeviceInputHandler alloc] init];
    _captureSessionHandler = [[IAFCaptureSessionHandler alloc] init];
    _captureDeviceHandler = [[IAFCaptureDeviceHandler alloc] initWithImplementations:self];
    _previewControllerHandler = [[IAFPreviewControllerHandler alloc] init];
    _captureInputHandler = [[IAFCaptureInputHandler alloc] init];
    _capturePhotoOutputHandler = [[IAFCapturePhotoOutputHandler alloc] init];
    _captureOutputHandler = [[IAFCaptureOutputHandler alloc] init];
    _capturePhotoSettingsHandler = [[IAFCapturePhotoSettingsHandler alloc] init];
    _capturePhotoHandler = [[IAFCapturePhotoHandler alloc] init];
    _capturePhotoCaptureDelegateHandler = [[IAFCapturePhotoCaptureDelegateHandler alloc] initWithImplementations:self];
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

- (nonnull IAFCaptureOutputChannel *)captureOutputChannel {
  return _captureOutputChannel;
}


- (nonnull IAFCaptureOutputHandler *)captureOutputHandler {
  return _captureOutputHandler;
}


- (nonnull IAFCapturePhotoCaptureDelegateChannel *)capturePhotoCaptureDelegateChannel {
  return _capturePhotoCaptureDelegateChannel;
}


- (nonnull IAFCapturePhotoCaptureDelegateHandler *)capturePhotoCaptureDelegateHandler {
  return _capturePhotoCaptureDelegateHandler;
}


- (nonnull IAFCapturePhotoChannel *)capturePhotoChannel {
  return _capturePhotoChannel;
}


- (nonnull IAFCapturePhotoHandler *)capturePhotoHandler {
  return _capturePhotoHandler;
}


- (nonnull IAFCapturePhotoOutputChannel *)capturePhotoOutputChannel {
  return _capturePhotoOutputChannel;
}


- (nonnull IAFCapturePhotoOutputHandler *)capturePhotoOutputHandler {
  return _capturePhotoOutputHandler;
}


- (nonnull IAFCapturePhotoSettingsChannel *)capturePhotoSettingsChannel {
  return _capturePhotoSettingsChannel;
}


- (nonnull IAFCapturePhotoSettingsHandler *)capturePhotoSettingsHandler {
  return _capturePhotoSettingsHandler;
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
