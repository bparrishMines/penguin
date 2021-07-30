#import "AFPChannelRegistrar.h"

@implementation AFPChannelRegistrar
@end

@implementation AFPLibraryImplementations
- (AFPCaptureDeviceHandler *)handlerCaptureDevice {
  return [[AFPCaptureDeviceHandler alloc] initWithImplementations:self];
}

- (AFPCaptureDeviceInputHandler *)handlerCaptureDeviceInput {
  return [[AFPCaptureDeviceInputHandler alloc] init];
}

- (AFPCaptureSessionHandler *)handlerCaptureSession {
  return [[AFPCaptureSessionHandler alloc] init];
}

- (AFPPreviewControllerHandler *)handlerPreviewController {
  return [[AFPPreviewControllerHandler alloc] initWithImplementations:self];
}

- (AFPCapturePhotoCaptureDelegateHandler *)handlerCapturePhotoCaptureDelegate {
  return [[AFPCapturePhotoCaptureDelegateHandler alloc] initWithImplementations:self];
}

- (AFPCapturePhotoSettingsHandler *)handlerCapturePhotoSettings {
  return [[AFPCapturePhotoSettingsHandler alloc] init];
}

- (AFPCapturePhotoOutputHandler *)handlerCapturePhotoOutput {
  return [[AFPCapturePhotoOutputHandler alloc] initWithImplementations:self];
}

- (AFPCaptureDeviceDiscoverySessionHandler *)handlerCaptureDeviceDiscoverySession {
  return [[AFPCaptureDeviceDiscoverySessionHandler alloc] initWithImplementations:self];
}

- (AFPCaptureMovieFileOutputHandler *)handlerCaptureMovieFileOutput {
  return [[AFPCaptureMovieFileOutputHandler alloc] initWithImplementations:self];
}

- (AFPCaptureFileOutputRecordingDelegateHandler *)handlerCaptureFileOutputRecordingDelegate {
  return [[AFPCaptureFileOutputRecordingDelegateHandler alloc] init];
}

- (AFPCaptureConnectionHandler *)handlerCaptureConnection {
  return [[AFPCaptureConnectionHandler alloc] init];
}
@end

@implementation AFPCaptureDeviceHandler {
  AFPLibraryImplementations *_implementations;
}

- (instancetype)initWithImplementations:(AFPLibraryImplementations *)implementations {
  self = [super init];
  if (self) {
    _implementations = implementations;
  }
  return self;
}

- (id)_defaultDeviceWithMediaType:(REFTypeChannelMessenger *)messenger mediaType:(NSString *)mediaType {
  return [AFPCaptureDeviceProxy defaultDeviceWithMediaType:mediaType implementations:_implementations];
}
@end

@implementation AFPCaptureDeviceInputHandler
- (AFPCaptureDeviceInputProxy *)_create_:(REFTypeChannelMessenger *)messenger
                                        device:(NSObject<_AFPCaptureDevice> *)device {
  return [[AFPCaptureDeviceInputProxy alloc] initWithDevice:((AFPCaptureDeviceProxy *)device)];
}
@end

@implementation AFPCaptureSessionHandler
- (AFPCaptureSessionProxy *)_create_:(REFTypeChannelMessenger *)messenger {
  return [[AFPCaptureSessionProxy alloc] init];
}
@end

@implementation AFPPreviewControllerHandler {
  AFPLibraryImplementations *_implementations;
}

- (instancetype)initWithImplementations:(AFPLibraryImplementations *)implementations {
  self = [super init];
  if (self) {
    _implementations = implementations;
  }
  return self;
}

- (AFPPreviewControllerProxy *)_create_:(REFTypeChannelMessenger *)messenger
                               captureSession:(NSObject<_AFPCaptureSession> *)captureSession {
  return [[AFPPreviewControllerProxy alloc] initWithCaptureSession:((AFPCaptureSessionProxy *)captureSession)
                                                   implementations:_implementations];
}
@end

@implementation AFPCapturePhotoCaptureDelegateHandler {
  AFPLibraryImplementations *_implementations;
}

- (instancetype)initWithImplementations:(AFPLibraryImplementations *)implementations {
  self = [super init];
  if (self) {
    _implementations = implementations;
  }
  return self;
}

- (NSObject<_AFPCapturePhotoCaptureDelegate> *)_create_:(REFTypeChannelMessenger *)messenger didFinishProcessingPhoto:(_AFPFinishProcessingPhotoCallback)didFinishProcessingPhoto {
  if (@available(iOS 10.0, *)) {
    return [[AFPCapturePhotoCaptureDelegateProxy alloc] initWithCallback:didFinishProcessingPhoto
                                                         implementations:_implementations];
  }
  @throw [NSException exceptionWithName:@"IosAvfoundationPluginException"
                                 reason:@"Requires version >= ios 10.0"
                               userInfo:nil];
}
@end

@implementation AFPCapturePhotoSettingsHandler
- (AFPCapturePhotoSettingsProxy *)_create_:(REFTypeChannelMessenger *)messenger {
  return [[AFPCapturePhotoSettingsProxy alloc] init];
}

- (AFPCapturePhotoSettingsProxy *)_create_photoSettingsWithFormat:(REFTypeChannelMessenger *)messenger
                                                           format:(NSDictionary<NSString *,NSObject *> *)format {
  return [[AFPCapturePhotoSettingsProxy alloc] initWithFormat:format];
}
@end

@implementation AFPCapturePhotoOutputHandler {
  AFPLibraryImplementations *_implementations;
}

- (instancetype)initWithImplementations:(AFPLibraryImplementations *)implementations {
  self = [super init];
  if (self) {
    _implementations = implementations;
  }
  return self;
}

- (AFPCapturePhotoOutputProxy *)_create_:(REFTypeChannelMessenger *)messenger {
  if (@available(iOS 10.0, *)) {
    return [[AFPCapturePhotoOutputProxy alloc] initWithImplementations:_implementations];
  }
  @throw [NSException exceptionWithName:@"IosAvfoundationPluginException"
                                 reason:@"Requires version >= ios 10.0"
                               userInfo:nil];
}
@end

@implementation AFPCaptureDeviceDiscoverySessionHandler {
  AFPLibraryImplementations *_implementations;
}

- (instancetype)initWithImplementations:(AFPLibraryImplementations *)implementations {
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
  return [AFPCaptureDeviceDiscoverySessionProxy discoverySessionWithDeviceTypes:deviceTypes
                                                                      mediaType:mediaType
                                                                       position:position
                                                                implementations:_implementations];
}
@end

@implementation AFPCaptureMovieFileOutputHandler {
  AFPLibraryImplementations *_implementations;
}

- (instancetype)initWithImplementations:(AFPLibraryImplementations *)implementations {
  self = [super init];
  if (self) {
    _implementations = implementations;
  }
  return self;
}

- (AFPCaptureMovieFileOutputProxy *)_create_:(REFTypeChannelMessenger *)messenger {
  return [[AFPCaptureMovieFileOutputProxy alloc] initWithImplementations:_implementations];
}
@end

@implementation AFPCaptureFileOutputRecordingDelegateHandler
- (AFPCaptureFileOutputRecordingDelegateProxy *)_create_:(REFTypeChannelMessenger *)messenger {
  return [[AFPCaptureFileOutputRecordingDelegateProxy alloc] init];
}
@end

@implementation AFPCaptureConnectionHandler
- (AFPCaptureConnectionProxy *)_create_:(REFTypeChannelMessenger *)messenger
                             inputPorts:(NSArray<NSObject<_AFPCaptureInputPort> *> *)inputPorts output:(NSObject<_AFPCaptureOutput> *)output {
  return [[AFPCaptureConnectionProxy alloc] initWithInputPorts:(NSArray<AFPCaptureInputPortProxy *> *)inputPorts
                                                        output:(AFPCaptureOutputProxy *)output];
}
@end
