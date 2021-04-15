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
  [implementations.captureDeviceChannel createNewInstancePair:self
                                                        owner:NO
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

- (NSObject * _Nullable)addInput:(NSObject<_IAFCaptureInput> * _Nullable)input {
  IAFCaptureInputProxy *inputProxy = (IAFCaptureInputProxy *)input;
  [_captureSession addInput:inputProxy.captureInput];
  return nil;
}
@end

@implementation IAFCaptureInputProxy
- (instancetype)initWithCaptureInput:(AVCaptureInput *)captureInput {
  self = [self init];
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
  if (error) NSLog(@"Error creating AVCaptureDeviceInput: %@: %@", error.domain, error.description);
  return [self initWithCaptureInput:captureDeviceInput];
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

