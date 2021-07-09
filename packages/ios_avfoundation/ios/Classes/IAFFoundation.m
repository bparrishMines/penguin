#import "IAFFoundation.h"

@interface IAFPreviewView : UIView
@end

@implementation IAFCaptureDeviceProxy
+ (NSArray<IAFCaptureDeviceProxy*> *)asProxyList:(NSArray<AVCaptureDevice *> *)captureDevices
                                 implementations:(IAFLibraryImplementations *)implementations {
  NSMutableArray<IAFCaptureDeviceProxy *> *deviceProxies = [NSMutableArray arrayWithCapacity:captureDevices.count];
  for (AVCaptureDevice *device in captureDevices) {
    [deviceProxies addObject:[[IAFCaptureDeviceProxy alloc] initWithCaptureDevice:device implementations:implementations]];
  }
  return deviceProxies;
}

+ (IAFCaptureDeviceProxy *_Nullable)defaultDeviceWithMediaType:(NSString *)mediaType
                                               implementations:(IAFLibraryImplementations *)implementations {
  AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:mediaType];
  if (!device) return nil;

  return [[IAFCaptureDeviceProxy alloc] initWithCaptureDevice:device implementations:implementations];
}

- (instancetype)initWithCaptureDevice:(AVCaptureDevice *)captureDevice
                      implementations:(IAFLibraryImplementations *)implementations {
  self = [super init];
  if (self) {
    _captureDevice = captureDevice;
  }
  [implementations.channelCaptureDevice __create:self
                                          _owner:NO
                                        uniqueId:captureDevice.uniqueID
                                        position:@(captureDevice.position)
                                      completion:^(REFPairedInstance *pairedInstance, NSError *error) {}];
  return self;
}

- (NSNumber * _Nullable)position {
  return @(_captureDevice.position);
}

- (NSString * _Nullable)uniqueId {
  return _captureDevice.uniqueID;
}
@end

@implementation IAFCaptureSessionProxy
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

- (id)addInput:(NSObject<_IAFCaptureInput> * _Nullable)input {
  IAFCaptureInputProxy *inputProxy = (IAFCaptureInputProxy *)input;
  [_captureSession addInput:inputProxy.captureInput];
  return nil;
}

- (id)addOutput:(NSObject<_IAFCaptureOutput> * _Nullable)output {
  IAFCaptureOutputProxy *outputProxy = (IAFCaptureOutputProxy *)output;
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
@end

@implementation IAFCaptureInputProxy
- (instancetype)initWithCaptureInput:(AVCaptureInput *)captureInput {
  self = [super init];
  if (self) {
    _captureInput = captureInput;
  }
  return self;
}
@end

@implementation IAFCaptureDeviceInputProxy
- (instancetype)initWithDevice:(IAFCaptureDeviceProxy *)device {
  NSError *error;
  AVCaptureDeviceInput *captureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:device.captureDevice
                                                                                    error:&error];
  if (error) {
    @throw [NSException exceptionWithName:error.domain reason:error.description userInfo:nil];
  }
  return self = [self initWithCaptureInput:captureDeviceInput];
}

- (NSObject<_IAFCaptureDevice> * _Nullable)device {
  return nil;
}
@end

@implementation IAFPreviewView {
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
@end

@implementation IAFPreviewControllerProxy {
  UIView *_view;
}

- (instancetype)initWithCaptureSession:(IAFCaptureSessionProxy *)captureSession {
  UIView *view = [[IAFPreviewView alloc] initWithCaptureSession:captureSession.captureSession];
  return [self initWithView:view];
}

- (instancetype)initWithView:(UIView *)view {
  self = [super init];
  if (self) {
    _view = view;
  }
  return self;
}

- (UIView *)view {
  return _view;
}

- (NSObject<_IAFCaptureSession> * _Nullable)captureSession {
  return nil;
}
@end

@implementation IAFCaptureOutputProxy
- (instancetype)initWithCaptureOutput:(AVCaptureOutput *)captureOutput {
  self = [super init];
  if (self) {
    _captureOutput = captureOutput;
  }
  return self;
}
@end

@implementation IAFCapturePhotoOutputProxy
- (instancetype)init {
  return [self initWithCapturePhotoOutput:[AVCapturePhotoOutput new]];
}

- (instancetype)initWithCapturePhotoOutput:(AVCapturePhotoOutput *)capturePhotoOutput {
  return [self initWithCaptureOutput:capturePhotoOutput];
}

- (NSObject *)capturePhoto:(IAFCapturePhotoSettingsProxy *_Nullable)settings
                  delegate:(IAFCapturePhotoCaptureDelegateProxy *_Nullable)delegate {
  [((AVCapturePhotoOutput *)self.captureOutput) capturePhotoWithSettings:settings.capturePhotoSettings delegate:delegate];
  return nil;
}
- (id _Nullable)capturePhotoWithSettings:(IAFCapturePhotoSettingsProxy *)settings
                                delegate:(IAFCapturePhotoCaptureDelegateProxy *)delegate {
  [((AVCapturePhotoOutput *)self.captureOutput) capturePhotoWithSettings:settings.capturePhotoSettings delegate:delegate];
  return nil;
}

@end

@implementation IAFCapturePhotoSettingsProxy
- (instancetype)initwithProcessedFormat:(NSDictionary<NSString *,NSObject *> *)format {
  AVCapturePhotoSettings *settings = [AVCapturePhotoSettings photoSettingsWithFormat:format];
  return [self initWithCapturePhotoSettings:settings];
}

- (instancetype)initWithCapturePhotoSettings:(AVCapturePhotoSettings *)capturePhotoSettings {
  self = [self init];
  if (self) {
    _capturePhotoSettings = capturePhotoSettings;
  }
  return self;
}

- (NSDictionary<NSString *,NSObject *> * _Nullable)processedFormat {
  return nil;
}
@end

@implementation IAFCapturePhotoCaptureDelegateProxy {
  _IAFFinishProcessingPhotoCallback _callback;
  IAFLibraryImplementations *_implementations;
}

- (instancetype)initWithCallback:(_IAFFinishProcessingPhotoCallback)callback
                 implementations:(IAFLibraryImplementations *)implementations {
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
  _callback([[IAFCapturePhotoProxy alloc] initWithCapturePhoto:photo implementations:_implementations]);
}
@end

@implementation IAFCapturePhotoProxy
- (instancetype)initWithCapturePhoto:(AVCapturePhoto *)capturePhoto
                     implementations:(IAFLibraryImplementations *)implementations {
  self = [self init];
  if (self) {
    _capturePhoto = capturePhoto;
  }
  [implementations.channelCapturePhoto __create:self
                                         _owner:false
                         fileDataRepresentation:capturePhoto.fileDataRepresentation
                                     completion:^(REFPairedInstance *instance, NSError * error) {}];
  return self;
}
@end

@implementation IAFCaptureDeviceDiscoverySessionProxy
+ (IAFCaptureDeviceDiscoverySessionProxy *)discoverySessionWithDeviceTypes:(NSArray<NSString *> *)deviceTypes
                                                                 mediaType:(NSString *)mediaType
                                                                  position:(NSNumber *)position
                                                           implementations:(IAFLibraryImplementations *)implementations {
  AVCaptureDeviceDiscoverySession *captureDeviceDiscovertySession = [AVCaptureDeviceDiscoverySession
                                                                     discoverySessionWithDeviceTypes:deviceTypes
                                                                     mediaType:mediaType
                                                                     position:position.intValue];
  return [[IAFCaptureDeviceDiscoverySessionProxy alloc] initWithCaptureDeviceDiscoverySession:captureDeviceDiscovertySession
                                                                              implementations:implementations];
}

- (instancetype)initWithCaptureDeviceDiscoverySession:(AVCaptureDeviceDiscoverySession *)captureDeviceDiscoverySession
                                      implementations:(IAFLibraryImplementations *)implementations {
  self = [self init];
  if (self) {
    _captureDeviceDiscoverySession = captureDeviceDiscoverySession;
  }
  
  NSArray<IAFCaptureDeviceProxy *> *devices = [IAFCaptureDeviceProxy asProxyList:captureDeviceDiscoverySession.devices
                                                                implementations:implementations];
  NSMutableArray<NSArray<IAFCaptureDeviceProxy *> *> *supportedMultiCamDeviceSets = [NSMutableArray array];
  if (@available(iOS 13.0, *)) {
    for (NSSet<AVCaptureDevice *> *deviceSet in captureDeviceDiscoverySession.supportedMultiCamDeviceSets) {
      NSArray<IAFCaptureDeviceProxy *> *deviceProxies = [IAFCaptureDeviceProxy asProxyList:deviceSet.allObjects
                                                                          implementations:implementations];
      [supportedMultiCamDeviceSets addObject:deviceProxies];
    }
  }
  [implementations.channelCaptureDeviceDiscoverySession __create:self
                                                          _owner:NO
                                                         devices:devices
                                     supportedMultiCamDeviceSets:supportedMultiCamDeviceSets
                                                      completion:^(REFPairedInstance * instance, NSError *error) {
  }];
  return self;
}
@end

@implementation IAFCaptureFileOutputProxy
- (instancetype)initWithCaptureFileOutput:(AVCaptureFileOutput *)captureFileOutput {
  return [self initWithCaptureOutput:captureFileOutput];
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
                                     delegate:(NSObject<_IAFCaptureFileOutputRecordingDelegate> *)delegate {
  AVCaptureFileOutput *captureFileOuput = (AVCaptureFileOutput *) [self captureOutput];
  [captureFileOuput startRecordingToOutputFileURL:[NSURL URLWithString:outputFileURL]
                                recordingDelegate:(IAFCaptureFileOutputRecordingDelegateProxy *)delegate];
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

@implementation IAFCaptureMovieFileOutputProxy
- (instancetype)init {
  return [self initWithCaptureMovieFileOutput:[[AVCaptureMovieFileOutput alloc] init]];
}

- (instancetype)initWithCaptureMovieFileOutput:(AVCaptureMovieFileOutput *)captureMovieFileOutput {
  return [self initWithCaptureFileOutput:captureMovieFileOutput];
}

- (NSArray<NSString *> *)availableVideoCodecTypes {
  AVCaptureMovieFileOutput *captureMovieFileOutput = (AVCaptureMovieFileOutput *) [self captureOutput];
  return [captureMovieFileOutput availableVideoCodecTypes];
}
@end

@implementation IAFCaptureFileOutputRecordingDelegateProxy
- (void)captureOutput:(nonnull AVCaptureFileOutput *)output
didFinishRecordingToOutputFileAtURL:(nonnull NSURL *)outputFileURL
      fromConnections:(nonnull NSArray<AVCaptureConnection *> *)connections
                error:(nullable NSError *)error {
  // TODO:
  NSLog(@"FINISHED RECORDING TO FILE");
}
@end
