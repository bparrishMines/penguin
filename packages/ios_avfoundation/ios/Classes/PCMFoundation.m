/*
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
  REFTypeChannelMessenger *_messenger;
  AVCaptureDevice *_captureDevice;
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

- (instancetype)initWithUniqueID:(NSString *)uniqueID messenger:(REFTypeChannelMessenger *)messenger {
  return [self initWithCaptureDevice:[AVCaptureDevice deviceWithUniqueID:uniqueID] messenger:messenger];
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
  NSArray<PCMCaptureDeviceInput *> *_inputs;
  AVCaptureSession *_captureSession;
}

+ (void)setupChannel:(REFTypeChannelMessenger *)messenger {
  PCM_CaptureSessionChannel *channel = [[PCM_CaptureSessionChannel alloc] initWithMessenger:messenger];
  [channel setHandler:[[PCMCaptureSessionHandler alloc] init]];
}

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

- (void)setInputs:(NSArray<PCMCaptureDeviceInput *> *)inputs {
  NSAssert(!_inputs, @"Inputs should only be set once.");
  _inputs = inputs;
  for (PCMCaptureDeviceInput *input in inputs) {
    [_captureSession addInput:input.captureDeviceInput];
  }
}

- (NSObject * _Nullable)startRunning {
  [_captureSession startRunning];
  return nil;
}

- (NSObject * _Nullable)stopRunning {
  [_captureSession stopRunning];
  return nil;
}

- (AVCaptureSession *)captureSession {
  return _captureSession;
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

- (instancetype)initWithDevice:(PCMCaptureDevice *)device {
  NSError *error;
  AVCaptureDeviceInput *captureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:device.captureDevice
                                                                                    error:&error];
  if (error) NSLog(@"Error creating AVCaptureDeviceInput: %@: %@", error.domain, error.description);
  self = [[PCMCaptureDeviceInput alloc] initWithCaptureDeviceInput:captureDeviceInput];
  if (self) {
    _device = device;
  }
  return self;
}

- (instancetype)initWithCaptureDeviceInput:(AVCaptureDeviceInput *)captureDeviceInput {
  self = [super init];
  if (self) {
    _captureDeviceInput = captureDeviceInput;
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
  UIView *_view;
}

+ (void)setupChannel:(REFTypeChannelMessenger *)messenger {
  PCM_PreviewControllerChannel *channel = [[PCM_PreviewControllerChannel alloc]
                                           initWithMessenger:messenger];
  [channel setHandler:[[PCMPreviewControllerHandler alloc] init]];
}

- (instancetype)initWithCaptureSession:(PCMCaptureSession *)captureSession {
  UIView *view = [[PCMPreviewView alloc] initWithCaptureSession:captureSession.captureSession];
  self = [self initWithView:view];
  if (self) {
    _captureSession = captureSession;
  }
  return self;
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
@end

@implementation PCMCaptureDeviceHandler
- (PCMCaptureDevice *)onCreate:(REFTypeChannelMessenger *)messenger
                          args:(PCM_CaptureDeviceCreationArgs *)args {
  return [[PCMCaptureDevice alloc] initWithUniqueID:args.uniqueId messenger:messenger];
}

- (NSArray<PCMCaptureDevice *> *)on_devicesWithMediaType:(REFTypeChannelMessenger *)messenger
                                               mediaType:(NSString *_Nullable)mediaType {
  return [PCMCaptureDevice devicesWithMediaType:mediaType messenger:messenger];
}
@end

@implementation PCMCaptureDeviceInputHandler
- (PCMCaptureDeviceInput *)onCreate:(REFTypeChannelMessenger *)messenger
                               args:(PCM_CaptureDeviceInputCreationArgs *)args {
  return [[PCMCaptureDeviceInput alloc] initWithDevice:args.device];
}
@end

@implementation PCMCaptureSessionHandler
- (PCMCaptureSession *)onCreate:(REFTypeChannelMessenger *)messenger
                           args:(PCM_CaptureSessionCreationArgs *)args {
  PCMCaptureSession *captureSession = [[PCMCaptureSession alloc] init];
  captureSession.inputs = args.inputs;
  return captureSession;
}
@end

@implementation PCMPreviewControllerHandler
- (PCMPreviewController *)onCreate:(REFTypeChannelMessenger *)messenger
                              args:(PCM_PreviewControllerCreationArgs *)args {
  return [[PCMPreviewController alloc] initWithCaptureSession:args.captureSession];
}
@end
*/
