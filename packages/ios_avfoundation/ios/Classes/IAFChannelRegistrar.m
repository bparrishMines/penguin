#import "IAFChannelRegistrar.h"

@implementation IAFChannelRegistrar
@end

@implementation IAFLibraryImplementations
- (IAFCaptureDeviceHandler *)handlerCaptureDevice {
  return [[IAFCaptureDeviceHandler alloc] initWithImplementations:self];
}

- (IAFCaptureDeviceInputHandler *)handlerCaptureDeviceInput {
  return [[IAFCaptureDeviceInputHandler alloc] init];
}

- (IAFCaptureSessionHandler *)handlerCaptureSession {
  return [[IAFCaptureSessionHandler alloc] init];
}

- (IAFPreviewControllerHandler *)handlerPreviewController {
  return [[IAFPreviewControllerHandler alloc] init];
}

- (IAFCapturePhotoCaptureDelegateHandler *)handlerCapturePhotoCaptureDelegate {
  return [[IAFCapturePhotoCaptureDelegateHandler alloc] initWithImplementations:self];
}

- (IAFCapturePhotoSettingsHandler *)handlerCapturePhotoSettings {
  return [[IAFCapturePhotoSettingsHandler alloc] init];
}

- (IAFCapturePhotoOutputHandler *)handlerCapturePhotoOutput {
  return [[IAFCapturePhotoOutputHandler alloc] init];
}

- (IAFCaptureDeviceDiscoverySessionHandler *)handlerCaptureDeviceDiscoverySession {
  return [[IAFCaptureDeviceDiscoverySessionHandler alloc] initWithImplementations:self];
}

- (IAFCaptureMovieFileOutputHandler *)handlerCaptureMovieFileOutput {
  return [[IAFCaptureMovieFileOutputHandler alloc] init];
}

- (IAFCaptureFileOutputRecordingDelegateHandler *)handlerCaptureFileOutputRecordingDelegate {
  return [[IAFCaptureFileOutputRecordingDelegateHandler alloc] init];
}

- (IAFCaptureConnectionHandler *)handlerCaptureConnection {
  return [[IAFCaptureConnectionHandler alloc] init];
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

- (id)_defaultDeviceWithMediaType:(REFTypeChannelMessenger *)messenger mediaType:(NSString *)mediaType {
  return [IAFCaptureDeviceProxy defaultDeviceWithMediaType:mediaType implementations:_implementations];
}
@end

@implementation IAFCaptureDeviceInputHandler
- (IAFCaptureDeviceInputProxy *)_create_:(REFTypeChannelMessenger *)messenger
                                        device:(NSObject<_IAFCaptureDevice> *)device {
  return [[IAFCaptureDeviceInputProxy alloc] initWithDevice:((IAFCaptureDeviceProxy *)device)];
}
@end

@implementation IAFCaptureSessionHandler
- (IAFCaptureSessionProxy *)_create_:(REFTypeChannelMessenger *)messenger {
  return [[IAFCaptureSessionProxy alloc] init];
}
@end

@implementation IAFPreviewControllerHandler
- (IAFPreviewControllerProxy *)_create_:(REFTypeChannelMessenger *)messenger
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

- (NSObject<_IAFCapturePhotoCaptureDelegate> *)_create_:(REFTypeChannelMessenger *)messenger didFinishProcessingPhoto:(_IAFFinishProcessingPhotoCallback)didFinishProcessingPhoto {
  if (@available(iOS 10.0, *)) {
    return [[IAFCapturePhotoCaptureDelegateProxy alloc] initWithCallback:didFinishProcessingPhoto
                                                         implementations:_implementations];
  }
  @throw [NSException exceptionWithName:@"IosAvfoundationPluginException"
                                 reason:@"Requires version >= ios 10.0"
                               userInfo:nil];
}
@end

@implementation IAFCapturePhotoSettingsHandler
- (IAFCapturePhotoSettingsProxy *)_create_:(REFTypeChannelMessenger *)messenger {
  return [[IAFCapturePhotoSettingsProxy alloc] init];
}

- (IAFCapturePhotoSettingsProxy *)_create_photoSettingsWithFormat:(REFTypeChannelMessenger *)messenger
                                                           format:(NSDictionary<NSString *,NSObject *> *)format {
  return [[IAFCapturePhotoSettingsProxy alloc] initWithFormat:format];
}
@end

@implementation IAFCapturePhotoOutputHandler
- (IAFCapturePhotoOutputProxy *)_create_:(REFTypeChannelMessenger *)messenger {
  if (@available(iOS 10.0, *)) {
    return [[IAFCapturePhotoOutputProxy alloc] init];
  }
  @throw [NSException exceptionWithName:@"IosAvfoundationPluginException"
                                 reason:@"Requires version >= ios 10.0"
                               userInfo:nil];
}
@end

@implementation IAFCaptureDeviceDiscoverySessionHandler {
  IAFLibraryImplementations *_implementations;
}

- (instancetype)initWithImplementations:(IAFLibraryImplementations *)implementations {
  self = [super init];
  if (self) {
    _implementations = implementations;
  }
  return self;
}

- (id)_discoverySessionWithDeviceTypes:(REFTypeChannelMessenger *)messenger
                           deviceTypes:(NSArray<NSString *> *)deviceTypes
                             mediaType:(NSString *)mediaType
                              position:(NSNumber *)position {
  return [IAFCaptureDeviceDiscoverySessionProxy discoverySessionWithDeviceTypes:deviceTypes
                                                                      mediaType:mediaType
                                                                       position:position
                                                                implementations:_implementations];
}
@end

@implementation IAFCaptureMovieFileOutputHandler
- (IAFCaptureMovieFileOutputProxy *)_create_:(REFTypeChannelMessenger *)messenger {
  return [[IAFCaptureMovieFileOutputProxy alloc] init];
}
@end

@implementation IAFCaptureFileOutputRecordingDelegateHandler
- (IAFCaptureFileOutputRecordingDelegateProxy *)_create_:(REFTypeChannelMessenger *)messenger {
  return [[IAFCaptureFileOutputRecordingDelegateProxy alloc] init];
}
@end

@implementation IAFCaptureConnectionHandler
- (IAFCaptureConnectionProxy *)_create_:(REFTypeChannelMessenger *)messenger
                             inputPorts:(NSArray<NSObject<_IAFCaptureInputPort> *> *)inputPorts output:(NSObject<_IAFCaptureOutput> *)output {
  return [[IAFCaptureConnectionProxy alloc] initWithInputPorts:(NSArray<IAFCaptureInputPortProxy *> *)inputPorts
                                                        output:(IAFCaptureOutputProxy *)output];
}
@end
