#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#import "IAVChannelLibrary_Internal.h"

NS_ASSUME_NONNULL_BEGIN

@interface IAVCaptureDeviceInputChannel : GENIAVCaptureDeviceInputChannel
@end

@interface IAVCaptureSessionChannel : GENIAVCaptureSessionChannel
@end

@interface IAVCaptureDeviceChannel : GENIAVCaptureDeviceChannel
@end

@interface IAVPreviewControllerChannel : GENIAVPreviewControllerChannel
@end

@interface IAVCaptureDeviceInputHandler : GENIAVCaptureDeviceInputHandler
@end

@interface IAVCaptureDeviceHandler : GENIAVCaptureDeviceHandler
@end

@interface IAVCaptureSessionHandler : GENIAVCaptureSessionHandler
@end

@interface IAVPreviewControllerHandler : GENIAVPreviewControllerHandler
@end

@interface IAVChannels : NSObject
-(instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;
-(void)initialize;
-(void)dispose;
-(IAVCaptureDeviceInputChannel *)captureDeviceInputChannel;
-(IAVCaptureSessionChannel *)captureSessionChannel;
-(IAVCaptureDeviceChannel *)captureDeviceChannel;
-(IAVPreviewControllerChannel *)previewControllerChannel;
@end

@interface IAVCaptureDeviceProxy : NSObject<GENIAVCaptureDevice>
@property (readonly) NSNumber *position;
@property (readonly) NSString *uniqueId;
+ (NSArray<IAVCaptureDeviceProxy*> *)devicesWithMediaType:(NSString *)mediaType
                                                 channels:(IAVChannels *)channels;
- (instancetype)initWithUniqueID:(NSString *)uniqueID channels:(IAVChannels *)channels;
- (instancetype)initWithCaptureDevice:(AVCaptureDevice *)captureDevice
                             channels:(IAVChannels *)channels;
- (AVCaptureDevice *)captureDevice;
@end

@interface IAVCaptureDeviceInputProxy : NSObject<GENIAVCaptureDeviceInput>
@property (readonly) IAVCaptureDeviceProxy *device;
- (instancetype)initWithDevice:(IAVCaptureDeviceProxy *)device;
- (instancetype)initWithCaptureDeviceInput:(AVCaptureDeviceInput *)captureDeviceInput;
- (AVCaptureDeviceInput *)captureDeviceInput;
@end

@interface IAVCaptureSessionProxy : NSObject
@property (nonatomic) NSArray<IAVCaptureDeviceInputProxy *> *inputs;
- (instancetype)initWithCaptureSession:(AVCaptureSession *)captureSession;
- (AVCaptureSession *)captureSession;
@end

@interface IAVPreviewControllerProxy : NSObject<GENIAVPreviewController, FlutterPlatformView>
@property (readonly) IAVCaptureSessionProxy *captureSession;
- (instancetype)initWithCaptureSession:(IAVCaptureSessionProxy *)captureSession;
- (instancetype)initWithView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END

