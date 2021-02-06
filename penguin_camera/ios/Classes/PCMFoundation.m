#import "PCMFoundation.h"

@interface PCMPreviewView : UIView
@property (readonly) AVCaptureSession *captureSession;
@end

@interface PCMCaptureDeviceInputHandler : PCM_CaptureDeviceInputHandler
@end

@interface PCMCaptureDeviceHandler : PCM_CaptureDeviceHandler
@end

@interface PCMCaptureSessionHandler : PCM_CaptureSessionHandler
@end

@interface PCMPreviewControllerHandler : PCM_PreviewControllerHandler
@end

@implementation PCMCaptureDevice {
  AVCaptureDevice *_captureDevice;
  REFTypeChannelMessenger *_messenger;
}

+ (void)setupChannel:(REFTypeChannelMessenger *)messenger {
  PCM_CaptureDeviceChannel *channel = [[PCM_CaptureDeviceChannel alloc] initWithMessenger:messenger];
  [channel setHandler:[[PCMCaptureDeviceHandler alloc] init]];
}

+ (NSArray<PCMCaptureDevice*> *)devicesWithMediaType:(NSString *)mediaType
                                           messenger:(REFTypeChannelMessenger *)messenger {
  NSArray<AVCaptureDevice *> *devices = [AVCaptureDevice devicesWithMediaType:mediaType];
  
  NSMutableArray<PCMCaptureDevice *> *pcmDevices = [NSMutableArray arrayWithCapacity:devices.count];
  for (AVCaptureDevice *device in devices) {
    [pcmDevices addObject:[[PCMCaptureDevice alloc] initWithCaptureDevice:device messenger:messenger]];
  }
  return pcmDevices;
}

- (instancetype)initWithCaptureDevice:(AVCaptureDevice *)captureDevice
                            messenger:(REFTypeChannelMessenger *)messenger {
  self = [super init];
  if (self) {
    _captureDevice = captureDevice;
    _uniqueId = captureDevice.uniqueID;
    _position = @(captureDevice.position);
    _messenger = messenger;
  }
  return self;
}

- (AVCaptureDevice *)captureDevice {
  return _captureDevice;
}

- (nonnull REFTypeChannel *)typeChannel {
  return [[PCM_CaptureDeviceChannel alloc] initWithMessenger:_messenger];
}
@end

@implementation PCMCaptureSession {
  AVCaptureSession *_session;
}

+ (void)setupChannel:(REFTypeChannelMessenger *)messenger {
  PCM_CaptureSessionChannel *channel = [[PCM_CaptureSessionChannel alloc] initWithMessenger:messenger];
  [channel setHandler:[[PCMCaptureSessionHandler alloc] init]];
}

- (instancetype)initWithInputs:(NSArray<PCM_CaptureDeviceInput> *)inputs {
  self = [super init];
  if (self) {
    _inputs = inputs;
    _session = [[AVCaptureSession alloc] init];
    for (PCM_CaptureDeviceInput *input in inputs) {
      PCMCaptureDeviceInput *inputImpl = (PCMCaptureDeviceInput *)input;
      [_session addInput:inputImpl.captureDeviceInput];
    }
  }
  return self;
}

- (NSObject * _Nullable)startRunning {
  [_session startRunning];
  return nil;
}

- (NSObject * _Nullable)stopRunning {
  [_session stopRunning];
  return nil;
}

- (AVCaptureSession *)session {
  return _session;
}
@end

@implementation PCMCaptureDeviceInput {
  AVCaptureDeviceInput *_captureDeviceInput;
}

+ (void)setupChannel:(REFTypeChannelMessenger *)messenger {
  PCM_CaptureDeviceInputChannel *channel = [[PCM_CaptureDeviceInputChannel alloc]
                                            initWithMessenger:messenger];
  [channel setHandler:[[PCMCaptureDeviceInputHandler alloc] init]];
}

- (instancetype)initWithDevice:(NSObject<PCM_CaptureDevice> *)device {
  self = [super init];
  if (self) {
    _device = device;
    
    PCMCaptureDevice *deviceImpl = (PCMCaptureDevice *) _device;
    NSError *error;
    _captureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:deviceImpl.captureDevice error:&error];
    if (error) NSLog(@"Error creating AVCaptureDeviceInput: %@: %@", error.domain, error.description);
  }
  return self;
}

- (AVCaptureDeviceInput *)captureDeviceInput {
  return _captureDeviceInput;
}
@end

@implementation PCMPreviewView {
  AVCaptureVideoPreviewLayer *_layer;
}

-(instancetype)initWithCaptureSession:(AVCaptureSession *)captureSession {
  self = [super initWithFrame:CGRectMake(0, 0, 100, 100)];
  if (self) {
    _captureSession = captureSession;
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

@implementation PCMPreviewController {
  PCMPreviewView *_view;
}

+ (void)setupChannel:(REFTypeChannelMessenger *)messenger {
  PCM_PreviewControllerChannel *channel = [[PCM_PreviewControllerChannel alloc]
                                           initWithMessenger:messenger];
  [channel setHandler:[[PCMPreviewControllerHandler alloc] init]];
}

- (instancetype)initWithCaptureSession:(PCM_CaptureSession *)captureSession {
  self = [super init];
  if (self) {
    _captureSession = captureSession;
    
    PCMCaptureSession *captureSessionImpl = (PCMCaptureSession *)captureSession;
    _view = [[PCMPreviewView alloc] initWithCaptureSession:captureSessionImpl.session];
  }
  return self;
}

- (UIView *)view {
  return _view;
}
@end

@implementation PCMCaptureDeviceHandler
- (NSObject<PCM_CaptureDevice> *)onCreate:(REFTypeChannelMessenger *)messenger
                                     args:(PCM_CaptureDeviceCreationArgs *)args {
  AVCaptureDevice *device = [AVCaptureDevice deviceWithUniqueID:args.uniqueId];
  return [[PCMCaptureDevice alloc] initWithCaptureDevice:device messenger:messenger];
}

- (NSArray<PCMCaptureDevice *> *)on_devicesWithMediaType:(REFTypeChannelMessenger *)messenger
                                               mediaType:(NSString *_Nullable)mediaType {
  return [PCMCaptureDevice devicesWithMediaType:mediaType messenger:messenger];
}
@end

@implementation PCMCaptureDeviceInputHandler
- (NSObject<PCM_CaptureDeviceInput> *)onCreate:(REFTypeChannelMessenger *)messenger
                                          args:(PCM_CaptureDeviceInputCreationArgs *)args {
  return [[PCMCaptureDeviceInput alloc] initWithDevice:args.device];
}
@end

@implementation PCMCaptureSessionHandler
- (NSObject<PCM_CaptureSession> *)onCreate:(REFTypeChannelMessenger *)messenger
                                      args:(PCM_CaptureSessionCreationArgs *)args {
  return [[PCMCaptureSession alloc] initWithInputs:args.inputs];
}
@end

@implementation PCMPreviewControllerHandler
- (NSObject<PCM_PreviewController> *)onCreate:(REFTypeChannelMessenger *)messenger
                                         args:(PCM_PreviewControllerCreationArgs *)args {
  return [[PCMPreviewController alloc] initWithCaptureSession:args.captureSession];
}
@end
