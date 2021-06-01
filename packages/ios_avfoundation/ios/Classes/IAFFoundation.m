#import "IAFFoundation.h"

@interface IAFPreviewView : UIView
@end

@implementation IAFCaptureDeviceProxy
+ (NSArray<IAFCaptureDeviceProxy*> *)devicesWithMediaType:(NSString *)mediaType
                                          implementations:(IAFLibraryImplementations *)implementations {
  NSArray<AVCaptureDevice *> *devices = [AVCaptureDevice devicesWithMediaType:mediaType];
  
  NSMutableArray<IAFCaptureDeviceProxy *> *deviceProxies = [NSMutableArray arrayWithCapacity:devices.count];
  for (AVCaptureDevice *device in devices) {
    [deviceProxies addObject:[[IAFCaptureDeviceProxy alloc] initWithCaptureDevice:device implementations:implementations]];
  }
  return deviceProxies;
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

- (NSObject * _Nullable)startRunning {
  [_captureSession startRunning];
  return nil;
}

- (NSObject * _Nullable)stopRunning {
  [_captureSession stopRunning];
  return nil;
}

- (NSObject *_Nullable)addInput:(NSObject<_IAFCaptureInput> * _Nullable)input {
  IAFCaptureInputProxy *inputProxy = (IAFCaptureInputProxy *)input;
  [_captureSession addInput:inputProxy.captureInput];
  return nil;
}

- (id)addOutput:(NSObject<_IAFCaptureOutput> * _Nullable)output {
  IAFCaptureOutputProxy *outputProxy = (IAFCaptureOutputProxy *)output;
  [_captureSession addOutput:outputProxy.captureOutput];
  return nil;
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
  IAFLibraryImplementations *_implementations;
}

- (instancetype)initWithImplementations:(IAFLibraryImplementations *)implementations {
  self = [self init];
  if (self) {
    _implementations = implementations;
  }
  return self;
}

- (NSObject *)didFinishProcessingPhoto:(IAFCapturePhotoProxy *_Nullable)photo  API_AVAILABLE(ios(11.0)){
  [_implementations.channelCapturePhotoCaptureDelegate _didFinishProcessingPhoto:self
                                                                           photo:photo
                                                                      completion:^(id result, NSError *error) {}];
  return nil;
}

- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo
                error:(NSError *)error  API_AVAILABLE(ios(11.0)) {
  [self didFinishProcessingPhoto:[[IAFCapturePhotoProxy alloc] initWithCapturePhoto:photo implementations:_implementations]];
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
