#import "IAVFoundation.h"

@interface IAVPreviewView : UIView
@property (readonly) AVCaptureSession *captureSession;
@end

@implementation IAVCaptureDeviceProxy {
  IAVChannels *_channels;
  AVCaptureDevice *_captureDevice;
}

+ (NSArray<IAVCaptureDeviceProxy*> *)devicesWithMediaType:(NSString *)mediaType
                                                 channels:(IAVChannels *)channels {
  NSArray<AVCaptureDevice *> *devices = [AVCaptureDevice devicesWithMediaType:mediaType];
  
  NSMutableArray<IAVCaptureDeviceProxy *> *deviceProxies = [NSMutableArray arrayWithCapacity:devices.count];
  for (AVCaptureDevice *device in devices) {
    [deviceProxies addObject:[[IAVCaptureDeviceProxy alloc] initWithCaptureDevice:device channels:channels]];
  }
  return deviceProxies;
}

- (instancetype)initWithUniqueID:(NSString *)uniqueID channels:(IAVChannels *)channels {
  return [self initWithCaptureDevice:[AVCaptureDevice deviceWithUniqueID:uniqueID] channels:channels];
}

- (instancetype)initWithCaptureDevice:(AVCaptureDevice *)captureDevice
                             channels:(IAVChannels *)channels {
  self = [super init];
  if (self) {
    _captureDevice = captureDevice;
    _uniqueId = captureDevice.uniqueID;
    _position = @(captureDevice.position);
    _channels = channels;
  }
  return self;
}

- (AVCaptureDevice *)captureDevice {
  return _captureDevice;
}

- (nonnull REFTypeChannel *)typeChannel {
  return [_channels captureDeviceChannel];
}
@end

@implementation IAVCaptureSessionProxy {
  NSArray<IAVCaptureDeviceInputProxy *> *_inputs;
  AVCaptureSession *_captureSession;
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

- (void)setInputs:(NSArray<IAVCaptureDeviceInputProxy *> *)inputs {
  NSAssert(!_inputs, @"Inputs should only be set once.");
  _inputs = inputs;
  for (IAVCaptureDeviceInputProxy *input in inputs) {
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

@implementation IAVCaptureDeviceInputProxy {
  AVCaptureDeviceInput *_captureDeviceInput;
}

- (instancetype)initWithDevice:(IAVCaptureDeviceProxy *)device {
  NSError *error;
  AVCaptureDeviceInput *captureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:device.captureDevice
                                                                                    error:&error];
  if (error) NSLog(@"Error creating AVCaptureDeviceInput: %@: %@", error.domain, error.description);
  self = [[IAVCaptureDeviceInputProxy alloc] initWithCaptureDeviceInput:captureDeviceInput];
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

@implementation IAVPreviewView {
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

@implementation IAVPreviewControllerProxy {
  UIView *_view;
}

- (instancetype)initWithCaptureSession:(IAVCaptureSessionProxy *)captureSession {
  UIView *view = [[IAVPreviewView alloc] initWithCaptureSession:captureSession.captureSession];
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

@implementation IAVChannels {
  IAVCaptureDeviceInputChannel *_captureDeviceInputChannel;
  IAVCaptureSessionChannel *_captureSessionChannel;
  IAVCaptureDeviceChannel *_captureDeviceChannel;
  IAVPreviewControllerChannel *_previewControllerChannel;
}

-(instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  self = [super init];
  if (self) {
    _captureDeviceInputChannel = [[IAVCaptureDeviceInputChannel alloc] initWithMessenger:messenger];
    _captureSessionChannel = [[IAVCaptureSessionChannel alloc] initWithMessenger:messenger];
    _captureDeviceChannel = [[IAVCaptureDeviceChannel alloc] initWithMessenger:messenger];
    _previewControllerChannel = [[IAVPreviewControllerChannel alloc] initWithMessenger:messenger];
  }
  return self;
}

-(void)initialize {
  [_captureDeviceInputChannel setHandler:[[IAVCaptureDeviceInputHandler alloc] init]];
  [_captureSessionChannel setHandler:[[IAVCaptureSessionHandler alloc] init]];
  [_captureDeviceChannel setHandler:[[IAVCaptureDeviceHandler alloc] init]];
  [_previewControllerChannel setHandler:[[IAVPreviewControllerHandler alloc] init]];
}

-(void)dispose {
  [_captureDeviceInputChannel setHandler:nil];
  [_captureSessionChannel setHandler:nil];
  [_captureDeviceChannel setHandler:nil];
  [_previewControllerChannel setHandler:nil];
}

-(IAVCaptureDeviceInputChannel *)captureDeviceInputChannel {
  return _captureDeviceInputChannel;
}

-(IAVCaptureSessionChannel *)captureSessionChannel {
  return _captureSessionChannel;
}

-(IAVCaptureDeviceChannel *)captureDeviceChannel {
  return _captureDeviceChannel;
}

-(IAVPreviewControllerChannel *)previewControllerChannel {
  return _previewControllerChannel;
}
@end

@implementation IAVCaptureDeviceInputChannel
@end

@implementation IAVCaptureSessionChannel
@end

@implementation IAVCaptureDeviceChannel
@end

@implementation IAVPreviewControllerChannel
@end

@implementation IAVCaptureDeviceHandler
- (IAVCaptureDeviceProxy *)onCreate:(REFTypeChannelMessenger *)messenger
                          args:(GENIAVCaptureDeviceCreationArgs *)args {
  return [[IAVCaptureDeviceProxy alloc] initWithUniqueID:args.uniqueId
                                                channels:[[IAVChannels alloc] initWithMessenger:messenger]];
}

- (NSArray<IAVCaptureDeviceProxy *> *)on_devicesWithMediaType:(REFTypeChannelMessenger *)messenger
                                               mediaType:(NSString *_Nullable)mediaType {
  return [IAVCaptureDeviceProxy devicesWithMediaType:mediaType channels:[[IAVChannels alloc] initWithMessenger:messenger]];
}
@end

@implementation IAVCaptureDeviceInputHandler
- (IAVCaptureDeviceInputProxy *)onCreate:(REFTypeChannelMessenger *)messenger
                               args:(GENIAVCaptureDeviceInputCreationArgs *)args {
  return [[IAVCaptureDeviceInputProxy alloc] initWithDevice:args.device];
}
@end

@implementation IAVCaptureSessionHandler
- (IAVCaptureSessionProxy *)onCreate:(REFTypeChannelMessenger *)messenger
                           args:(GENIAVCaptureSessionCreationArgs *)args {
  IAVCaptureSessionProxy *captureSession = [[IAVCaptureSessionProxy alloc] init];
  captureSession.inputs = args.inputs;
  return captureSession;
}
@end

@implementation IAVPreviewControllerHandler
- (IAVPreviewControllerProxy *)onCreate:(REFTypeChannelMessenger *)messenger
                              args:(GENIAVPreviewControllerCreationArgs *)args {
  return [[IAVPreviewControllerProxy alloc] initWithCaptureSession:args.captureSession];
}
@end
