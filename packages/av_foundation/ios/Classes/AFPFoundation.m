#import "AFPFoundation.h"

@implementation AFPCaptureDeviceProxy
+ (NSArray<AFPCaptureDeviceProxy*> *)asProxyList:(NSArray<AVCaptureDevice *> *)captureDevices
                                 implementations:(AFPLibraryImplementations *)implementations {
  NSMutableArray<AFPCaptureDeviceProxy *> *deviceProxies = [NSMutableArray arrayWithCapacity:captureDevices.count];
  for (AVCaptureDevice *device in captureDevices) {
    [deviceProxies addObject:[[AFPCaptureDeviceProxy alloc] initWithCaptureDevice:device implementations:implementations]];
  }
  return deviceProxies;
}

+ (AFPCaptureDeviceProxy *_Nullable)defaultDeviceWithMediaType:(NSString *)mediaType
                                               implementations:(AFPLibraryImplementations *)implementations {
  AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:mediaType];
  if (!device) return nil;

  return [[AFPCaptureDeviceProxy alloc] initWithCaptureDevice:device implementations:implementations];
}

- (instancetype)initWithCaptureDevice:(AVCaptureDevice *)captureDevice
                      implementations:(AFPLibraryImplementations *)implementations {
  self = [super init];
  if (self) {
    _captureDevice = captureDevice;
  }
  [implementations.channelCaptureDevice _create_:self
                                          _owner:NO
                                        uniqueId:captureDevice.uniqueID
                                        position:@(captureDevice.position)
                      isSmoothAutoFocusSupported:@(captureDevice.isSmoothAutoFocusSupported)
                                        hasFlash:@(captureDevice.hasFlash)
                                        hasTorch:@(captureDevice.hasTorch)
                          maxAvailableTorchLevel:@(AVCaptureMaxAvailableTorchLevel)
                                      completion:^(REFPairedInstance *pairedInstance, NSError *error) {}];
  return self;
}

- (NSNumber * _Nullable)position {
  return @(_captureDevice.position);
}

- (NSString * _Nullable)uniqueId {
  return _captureDevice.uniqueID;
}

- (NSArray<NSNumber *> *)exposureModesSupported:(NSArray<NSNumber *> * _Nullable)modes {
  NSMutableArray<NSNumber *> *validModes = [NSMutableArray array];
  for (NSNumber *mode in modes) {
    if ([_captureDevice isExposureModeSupported:mode.intValue]) {
      [validModes addObject:mode];
    }
  }
  return validModes;
}

- (NSArray<NSNumber *> *)focusModesSupported:(NSArray<NSNumber *> * _Nullable)modes {
  NSMutableArray<NSNumber *> *validModes = [NSMutableArray array];
  for (NSNumber *mode in modes) {
    if ([_captureDevice isFocusModeSupported:mode.intValue]) {
      [validModes addObject:mode];
    }
  }
  return validModes;
}

- (NSNumber *)isAdjustingExposure {
  return @([_captureDevice isAdjustingExposure]);
}

- (NSNumber *)isAdjustingFocus {
  return @([_captureDevice isAdjustingFocus]);
}

- (NSNumber *)isFlashAvailable {
  return @([_captureDevice isFlashAvailable]);
}

- (NSNumber *)lockForConfiguration {
  NSError *error;
  BOOL locked = [_captureDevice lockForConfiguration:&error];
  if (error) {
    @throw [NSException exceptionWithName:error.domain reason:error.localizedDescription userInfo:nil];
  }
  return @(locked);
}

- (id _Nullable)setExposureMode:(NSNumber * _Nullable)mode {
  [_captureDevice setExposureMode:mode.intValue];
  return nil;
}

- (id _Nullable)setFocusMode:(NSNumber * _Nullable)mode {
  [_captureDevice setFocusMode:mode.intValue];
  return nil;
}

- (id _Nullable)setSmoothAutoFocusEnabled:(NSNumber * _Nullable)enabled {
  [_captureDevice setSmoothAutoFocusEnabled:enabled.boolValue];
  return nil;
}

- (NSArray<NSString *> *)supportsCaptureSessionPresets:(NSArray<NSString *> * _Nullable)presets {
  NSMutableArray<NSString *> *validPresets = [NSMutableArray array];
  for (NSString *preset in presets) {
    if ([_captureDevice supportsAVCaptureSessionPreset:preset]) {
      [validPresets addObject:preset];
    }
  }
  return validPresets;
}

- (id _Nullable)unlockForConfiguration {
  [_captureDevice unlockForConfiguration];
  return nil;
}

- (id _Nullable)cancelVideoZoomRamp {
  [_captureDevice cancelVideoZoomRamp];
  return nil;
}


- (NSNumber *)isRampingVideoZoom {
  return @([_captureDevice isRampingVideoZoom]);
}


- (NSNumber *)maxAvailableVideoZoomFactor {
  if (@available(iOS 11.0, *)) {
    return @([_captureDevice maxAvailableVideoZoomFactor]);
  } else {
    @throw [NSException exceptionWithName:@"IosAvfoundationPluginException"
                                   reason:@"Requires version >= ios 11.0"
                                 userInfo:nil];
  }
}


- (NSNumber *)minAvailableVideoZoomFactor {
  if (@available(iOS 11.0, *)) {
    return @([_captureDevice minAvailableVideoZoomFactor]);
  } else {
    @throw [NSException exceptionWithName:@"IosAvfoundationPluginException"
                                   reason:@"Requires version >= ios 11.0"
                                 userInfo:nil];
  }
}


- (id _Nullable)rampToVideoZoomFactor:(NSNumber * _Nullable)factor rate:(NSNumber * _Nullable)rate {
  [_captureDevice rampToVideoZoomFactor:factor.floatValue withRate:rate.floatValue];
  return nil;
}


- (id _Nullable)setVideoZoomFactor:(NSNumber * _Nullable)factor {
  [_captureDevice setVideoZoomFactor:factor.floatValue];
  return nil;
}

- (NSNumber *)isTorchActive {
  return @(_captureDevice.isTorchActive);
}


- (NSNumber *)isTorchAvailable {
  return @(_captureDevice.isTorchAvailable);
}


- (id _Nullable)setTorchMode:(NSNumber * _Nullable)mode {
  [_captureDevice setTorchMode:mode.intValue];
  return nil;
}


- (id _Nullable)setTorchModeOnWithLevel:(NSNumber * _Nullable)torchLevel {
  NSError *error;
  [_captureDevice setTorchModeOnWithLevel:torchLevel.floatValue error:&error];
  if (error) {
    @throw [NSException exceptionWithName:@"AFPTorchException" reason:error.description userInfo:nil];
  }
  return nil;
}


- (NSNumber *)torchLevel {
  return @(_captureDevice.torchLevel);
}


- (NSArray<NSNumber *> *)torchModesSupported:(NSArray<NSNumber *> * _Nullable)modes {
  NSMutableArray<NSNumber *> *validModes = [NSMutableArray array];
  for (NSNumber *mode in modes) {
    if ([_captureDevice isTorchModeSupported:mode.intValue]) {
      [validModes addObject:mode];
    }
  }
  return validModes;
}

@end

@implementation AFPCaptureSessionProxy
- (instancetype)init {
  return [self initWithCaptureSession:[[AVCaptureSession alloc] init]];
}

- (instancetype)initWithCaptureSession:(AVCaptureSession *)captureSession {
  self = [super init];
  if (self) {
    _captureSession = captureSession;
  }
  return self;
}

- (id)startRunning {
  [_captureSession startRunning];
  return nil;
}

- (id)stopRunning {
  [_captureSession stopRunning];
  return nil;
}

- (id)addInput:(NSObject<_AFPCaptureInput> * _Nullable)input {
  AFPCaptureInputProxy *inputProxy = (AFPCaptureInputProxy *)input;
  [_captureSession addInput:inputProxy.captureInput];
  return nil;
}

- (id)addOutput:(NSObject<_AFPCaptureOutput> * _Nullable)output {
  AFPCaptureOutputProxy *outputProxy = (AFPCaptureOutputProxy *)output;
  [_captureSession addOutput:outputProxy.captureOutput];
  return nil;
}

- (id)setSessionPreset:(NSString *)preset {
  [_captureSession setSessionPreset:preset];
  return nil;
}

- (NSArray<NSString *> *)canSetSessionPresets:(NSArray<NSString *> *)presets {
  NSMutableArray<NSString *> *validPresets = [NSMutableArray array];
  for (NSString *preset in presets) {
    if ([_captureSession canSetSessionPreset:preset]) {
      [validPresets addObject:preset];
    }
  }
  return validPresets;
}

- (NSNumber *)canAddInput:(NSObject<_AFPCaptureInput> * _Nullable)input {
  AFPCaptureInputProxy *inputProxy = (AFPCaptureInputProxy *)input;
  return @([_captureSession canAddInput:inputProxy.captureInput]);
}


- (id _Nullable)canAddOutput:(NSObject<_AFPCaptureOutput> * _Nullable)output {
  AFPCaptureOutputProxy *outputProxy = (AFPCaptureOutputProxy *)output;
  return @([_captureSession canAddOutput:outputProxy.captureOutput]);
}


- (NSNumber *)isInterrupted {
  return @(_captureSession.isInterrupted);
}


- (NSNumber *)isRunning {
  return @(_captureSession.isRunning);
}


- (id _Nullable)removeInput:(NSObject<_AFPCaptureInput> * _Nullable)input {
  AFPCaptureInputProxy *inputProxy = (AFPCaptureInputProxy *)input;
  [_captureSession removeInput:inputProxy.captureInput];
  return nil;
}


- (id _Nullable)removeOutput:(NSObject<_AFPCaptureOutput> * _Nullable)output {
  AFPCaptureOutputProxy *outputProxy = (AFPCaptureOutputProxy *)output;
  [_captureSession removeOutput:outputProxy.captureOutput];
  return nil;
}
@end

@implementation AFPCaptureInputProxy
- (instancetype)initWithCaptureInput:(AVCaptureInput *)captureInput {
  self = [super init];
  if (self) {
    _captureInput = captureInput;
  }
  return self;
}
@end

@implementation AFPCaptureDeviceInputProxy
- (instancetype)initWithDevice:(AFPCaptureDeviceProxy *)device {
  NSError *error;
  AVCaptureDeviceInput *captureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:device.captureDevice
                                                                                    error:&error];
  if (error) {
    @throw [NSException exceptionWithName:error.domain reason:error.description userInfo:nil];
  }
  return self = [self initWithCaptureInput:captureDeviceInput];
}

- (NSObject<_AFPCaptureDevice> * _Nullable)device {
  return nil;
}
@end

@implementation AFPPreviewView {
  AVCaptureVideoPreviewLayer *_layer;
}

-(instancetype)initWithCaptureSession:(AVCaptureSession *)captureSession {
  self = [super initWithFrame:CGRectMake(0, 0, 100, 100)];
  if (self) {
    _layer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:captureSession];
    [self.layer addSublayer:_layer];
  }
  return self;
}

- (void)layoutSubviews {
  self.layer.frame = self.bounds;
  NSArray<CALayer *> *sublayers = self.layer.sublayers;
  if (sublayers) {
    for (CALayer *layer in sublayers) layer.frame = self.bounds;
  }
}

- (AVCaptureConnection *_Nullable)connection {
  return _layer.connection;
}
@end

@implementation AFPPreviewControllerProxy {
  AFPPreviewView *_view;
  AFPLibraryImplementations *_implementations;
}

- (instancetype)initWithCaptureSession:(AFPCaptureSessionProxy *)captureSession
                       implementations:(AFPLibraryImplementations *)implementations {
  AFPPreviewView *view = [[AFPPreviewView alloc] initWithCaptureSession:captureSession.captureSession];
  return [self initWithView:view implementations:implementations];
}

- (instancetype)initWithView:(AFPPreviewView *)view implementations:(AFPLibraryImplementations *)implementations {
  self = [super init];
  if (self) {
    _view = view;
    _implementations = implementations;
  }
  return self;
}

- (UIView *)view {
  return _view;
}

- (AFPCaptureConnectionProxy *_Nullable)connection {
  AVCaptureConnection *connection = _view.connection;
  if (connection) {
    return [[AFPCaptureConnectionProxy alloc] initWithCaptureConnection:connection implementations:_implementations];
  }
  return nil;
}
@end

@implementation AFPCaptureOutputProxy {
  AFPLibraryImplementations *_implementations;
}

- (instancetype)initWithCaptureOutputWithoutCreate:(AVCaptureOutput *)captureOutput
                                   implementations:(AFPLibraryImplementations *)implementations {
  self = [super init];
  if (self) {
    _captureOutput = captureOutput;
    _implementations = implementations;
  }
  return self;
}

- (instancetype)initWithCaptureOutput:(AVCaptureOutput *)captureOutput
                      implementations:(AFPLibraryImplementations *)implementations {
  self = [self initWithCaptureOutputWithoutCreate:captureOutput implementations:implementations];
  if (self) {
    [implementations.channelCaptureOutput _create_:self
                                            _owner:NO
                                        completion:^(REFPairedInstance *instance, NSError * error) {}];
  }
  return self;
}

- (AFPCaptureConnectionProxy *_Nullable)connectionWithMediaType:(NSString * _Nullable)mediaType {
  AVCaptureConnection *connection = [_captureOutput connectionWithMediaType:mediaType];
  if (connection) {
    AFPCaptureConnectionProxy *proxy = [[AFPCaptureConnectionProxy alloc] initWithCaptureConnection:connection
                                                                                    implementations:_implementations];
    return proxy;
  }
  return nil;
}
@end

@implementation AFPCapturePhotoOutputProxy
- (instancetype)initWithImplementations:(AFPLibraryImplementations *)implementations {
  return [self initWithCapturePhotoOutput:[AVCapturePhotoOutput new] implementations:implementations];
}

- (instancetype)initWithCapturePhotoOutput:(AVCapturePhotoOutput *)capturePhotoOutput
                           implementations:(AFPLibraryImplementations *)implementations {
  return [self initWithCaptureOutputWithoutCreate:capturePhotoOutput implementations:implementations];
}

- (NSObject *)capturePhoto:(AFPCapturePhotoSettingsProxy *_Nullable)settings
                  delegate:(AFPCapturePhotoCaptureDelegateProxy *_Nullable)delegate {
  [((AVCapturePhotoOutput *)self.captureOutput) capturePhotoWithSettings:settings.capturePhotoSettings delegate:delegate];
  return nil;
}
- (id _Nullable)capturePhotoWithSettings:(AFPCapturePhotoSettingsProxy *)settings
                                delegate:(AFPCapturePhotoCaptureDelegateProxy *)delegate {
  [((AVCapturePhotoOutput *)self.captureOutput) capturePhotoWithSettings:settings.capturePhotoSettings delegate:delegate];
  return nil;
}

- (NSArray<NSNumber *> *)supportedFlashModes {
  return [((AVCapturePhotoOutput *)self.captureOutput) supportedFlashModes];
}
@end

@implementation AFPCapturePhotoSettingsProxy
- (instancetype)init {
  return [self initWithCapturePhotoSettings:[AVCapturePhotoSettings photoSettings]];
}

- (instancetype)initWithFormat:(NSDictionary<NSString *, NSObject *> *)format {
  return [self initWithCapturePhotoSettings:[AVCapturePhotoSettings photoSettingsWithFormat:format]];
}

- (instancetype)initWithCapturePhotoSettings:(AVCapturePhotoSettings *)capturePhotoSettings {
  self = [super init];
  if (self) {
    _capturePhotoSettings = capturePhotoSettings;
  }
  return self;
}

- (id _Nullable)photoSettingsWithFormat:(NSDictionary<NSString *,NSObject *> * _Nullable)format {
  _capturePhotoSettings = [AVCapturePhotoSettings photoSettingsWithFormat:format];
  return nil;
}

- (id _Nullable)setFlashMode:(NSNumber * _Nullable)mode {
  [_capturePhotoSettings setFlashMode:mode.intValue];
  return nil;
}

- (NSNumber *)uniqueID {
  return @([_capturePhotoSettings uniqueID]);
}
@end

@implementation AFPCapturePhotoCaptureDelegateProxy {
  _AFPFinishProcessingPhotoCallback _callback;
  AFPLibraryImplementations *_implementations;
}

- (instancetype)initWithCallback:(_AFPFinishProcessingPhotoCallback)callback
                 implementations:(AFPLibraryImplementations *)implementations {
  self = [self init];
  if (self) {
    _callback = callback;
    _implementations = implementations;
  }
  return self;
}

- (void)captureOutput:(AVCapturePhotoOutput *)output
didFinishProcessingPhoto:(AVCapturePhoto *)photo
                error:(NSError *)error  API_AVAILABLE(ios(11.0)) {
  _callback([[AFPCapturePhotoProxy alloc] initWithCapturePhoto:photo implementations:_implementations]);
}
@end

@implementation AFPCapturePhotoProxy
- (instancetype)initWithCapturePhoto:(AVCapturePhoto *)capturePhoto
                     implementations:(AFPLibraryImplementations *)implementations {
  self = [self init];
  if (self) {
    _capturePhoto = capturePhoto;
  }
  [implementations.channelCapturePhoto _create_:self
                                         _owner:false
                         fileDataRepresentation:capturePhoto.fileDataRepresentation
                                     completion:^(REFPairedInstance *instance, NSError * error) {}];
  return self;
}
@end

@implementation AFPCaptureDeviceDiscoverySessionProxy
+ (AFPCaptureDeviceDiscoverySessionProxy *)discoverySessionWithDeviceTypes:(NSArray<NSString *> *)deviceTypes
                                                                 mediaType:(NSString *)mediaType
                                                                  position:(NSNumber *)position
                                                           implementations:(AFPLibraryImplementations *)implementations {
  AVCaptureDeviceDiscoverySession *captureDeviceDiscovertySession = [AVCaptureDeviceDiscoverySession
                                                                     discoverySessionWithDeviceTypes:deviceTypes
                                                                     mediaType:mediaType
                                                                     position:position.intValue];
  return [[AFPCaptureDeviceDiscoverySessionProxy alloc] initWithCaptureDeviceDiscoverySession:captureDeviceDiscovertySession
                                                                              implementations:implementations];
}

- (instancetype)initWithCaptureDeviceDiscoverySession:(AVCaptureDeviceDiscoverySession *)captureDeviceDiscoverySession
                                      implementations:(AFPLibraryImplementations *)implementations {
  self = [self init];
  if (self) {
    _captureDeviceDiscoverySession = captureDeviceDiscoverySession;
  }
  
  NSArray<AFPCaptureDeviceProxy *> *devices = [AFPCaptureDeviceProxy asProxyList:captureDeviceDiscoverySession.devices
                                                                implementations:implementations];
  NSMutableArray<NSArray<AFPCaptureDeviceProxy *> *> *supportedMultiCamDeviceSets = [NSMutableArray array];
  if (@available(iOS 13.0, *)) {
    for (NSSet<AVCaptureDevice *> *deviceSet in captureDeviceDiscoverySession.supportedMultiCamDeviceSets) {
      NSArray<AFPCaptureDeviceProxy *> *deviceProxies = [AFPCaptureDeviceProxy asProxyList:deviceSet.allObjects
                                                                          implementations:implementations];
      [supportedMultiCamDeviceSets addObject:deviceProxies];
    }
  }
  [implementations.channelCaptureDeviceDiscoverySession _create_:self
                                                          _owner:NO
                                                         devices:devices
                                     supportedMultiCamDeviceSets:supportedMultiCamDeviceSets
                                                      completion:^(REFPairedInstance * instance, NSError *error) {
  }];
  return self;
}
@end

@implementation AFPCaptureFileOutputProxy
- (instancetype)initWithCaptureFileOutput:(AVCaptureFileOutput *)captureFileOutput
                          implementations:(AFPLibraryImplementations *)implementations {
  return [self initWithCaptureOutputWithoutCreate:captureFileOutput implementations:implementations];
}

- (NSNumber *)isRecording {
  AVCaptureFileOutput *captureFileOuput = (AVCaptureFileOutput *) [self captureOutput];
  return @([captureFileOuput isRecording]);
}

- (id _Nullable)setMaxRecordedFileSize:(NSNumber *)fileSize {
  AVCaptureFileOutput *captureFileOuput = (AVCaptureFileOutput *) [self captureOutput];
  [captureFileOuput setMaxRecordedFileSize:fileSize.intValue];
  return nil;
}

- (id _Nullable)startRecordingToOutputFileURL:(NSString *)outputFileURL
                                     delegate:(NSObject<_AFPCaptureFileOutputRecordingDelegate> *)delegate {
  AVCaptureFileOutput *captureFileOuput = (AVCaptureFileOutput *) [self captureOutput];
  [captureFileOuput startRecordingToOutputFileURL:[NSURL fileURLWithPath:outputFileURL]
                                recordingDelegate:(AFPCaptureFileOutputRecordingDelegateProxy *)delegate];
  return nil;
}

- (id _Nullable)stopRecording {
  AVCaptureFileOutput *captureFileOuput = (AVCaptureFileOutput *) [self captureOutput];
  [captureFileOuput stopRecording];
  return nil;
}

- (NSString *)outputFileURL {
  AVCaptureFileOutput *captureFileOuput = (AVCaptureFileOutput *) [self captureOutput];
  return captureFileOuput.outputFileURL.absoluteString;
}
@end

@implementation AFPCaptureMovieFileOutputProxy
- (instancetype)initWithImplementations:(AFPLibraryImplementations *)implementations {
  return [self initWithCaptureMovieFileOutput:[[AVCaptureMovieFileOutput alloc] init]
                              implementations:implementations];
}

- (instancetype)initWithCaptureMovieFileOutput:(AVCaptureMovieFileOutput *)captureMovieFileOutput
                               implementations:(AFPLibraryImplementations *)implementations; {
  return [self initWithCaptureFileOutput:captureMovieFileOutput implementations:implementations];
}

- (NSArray<NSString *> *)availableVideoCodecTypes {
  AVCaptureMovieFileOutput *captureMovieFileOutput = (AVCaptureMovieFileOutput *) [self captureOutput];
  return [captureMovieFileOutput availableVideoCodecTypes];
}
@end

@implementation AFPCaptureFileOutputRecordingDelegateProxy
- (void)captureOutput:(nonnull AVCaptureFileOutput *)output
didFinishRecordingToOutputFileAtURL:(nonnull NSURL *)outputFileURL
      fromConnections:(nonnull NSArray<AVCaptureConnection *> *)connections
                error:(nullable NSError *)error {
  // TODO:
  NSLog(@"FINISHED RECORDING TO FILE");
}
@end

@implementation AFPCaptureInputPortProxy
+ (NSArray<AFPCaptureInputPortProxy *> *)asProxyList:(NSArray<AVCaptureInputPort *> *)captureInputPorts
                                     implementations:(AFPLibraryImplementations *)implementations {
  NSMutableArray<AFPCaptureInputPortProxy *> *portProxies = [NSMutableArray arrayWithCapacity:captureInputPorts.count];
  for (AVCaptureInputPort *port in captureInputPorts) {
    [portProxies addObject:[[AFPCaptureInputPortProxy alloc] initWithCaptureInputPort:port
                                                                      implementations:implementations]];
  }
  return portProxies;
}

- (instancetype)initWithCaptureInputPort:(AVCaptureInputPort *)captureInputPort
                         implementations:(AFPLibraryImplementations *)implementations {
  self = [super init];
  if (self) {
    _captureInputPort = captureInputPort;
    NSString *sourceDeviceType;
    NSInteger sourceDevicePosition = AVCaptureDevicePositionUnspecified;
    if (@available(iOS 13.0, *)) {
      sourceDeviceType = captureInputPort.sourceDeviceType;
      sourceDevicePosition = captureInputPort.sourceDevicePosition;
    }
    [implementations.channelCaptureInputPort _create_:self
                                               _owner:false
                                            mediaType:captureInputPort.mediaType
                                     sourceDeviceType:sourceDeviceType
                                 sourceDevicePosition:@(sourceDevicePosition)
                                           completion:^(REFPairedInstance *instance, NSError *error) {
      
    }];
  }
  return self;
}

- (id)setEnabled:(NSNumber * _Nullable)enabled {
  [_captureInputPort setEnabled:enabled.boolValue];
  return nil;
}
@end

@implementation AFPCaptureConnectionProxy
- (instancetype)initWithInputPorts:(NSArray<AFPCaptureInputPortProxy *> *)ports
                            output:(AFPCaptureOutputProxy *)output {
  NSMutableArray<AVCaptureInputPort *> *portValues = [NSMutableArray arrayWithCapacity:ports.count];
  for (AFPCaptureInputPortProxy *portProxy in ports) {
    [portValues addObject:portProxy.captureInputPort];
  }
  return [self initWithCaptureConnection:[[AVCaptureConnection alloc] initWithInputPorts:portValues
                                                                                  output:output.captureOutput]];
}

- (instancetype)initWithCaptureConnection:(AVCaptureConnection *)captureConnection {
  self = [super init];
  if (self) {
    _captureConnection = captureConnection;
  }
  return self;
}

- (instancetype)initWithCaptureConnection:(AVCaptureConnection *)captureConnection
                          implementations:(AFPLibraryImplementations *)implementations {
  self = [self initWithCaptureConnection:captureConnection];
  
  AFPCaptureOutputProxy *outputProxy = [[AFPCaptureOutputProxy alloc] initWithCaptureOutput:captureConnection.output
                                                                            implementations:implementations];
  [implementations.channelCaptureConnection _create_:self
                                              _owner:false
                                          inputPorts:[AFPCaptureInputPortProxy asProxyList:captureConnection.inputPorts
                                                                           implementations:implementations]
                                              output:outputProxy
                                          completion:^(REFPairedInstance *instance, NSError *error) {
    
  }];
  return self;
}

- (NSNumber *)isVideoMirroringSupported {
  return @([_captureConnection isVideoMirroringSupported]);
}

- (NSNumber *)isVideoOrientationSupported {
  return @([_captureConnection isVideoOrientationSupported]);
}

- (id _Nullable)setAutomaticallyAdjustsVideoMirroring:(NSNumber * _Nullable)adjust {
  [_captureConnection setAutomaticallyAdjustsVideoMirroring:adjust.boolValue];
  return nil;
}

- (id _Nullable)setVideoMirrored:(NSNumber * _Nullable)mirrored {
  [_captureConnection setVideoMirrored:mirrored.boolValue];
  return nil;
}

- (id _Nullable)setVideoOrientation:(NSNumber * _Nullable)orientation {
  [_captureConnection setVideoOrientation:orientation.intValue];
  return nil;
}
@end

