/*
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#import "PCM_CameraChannelLibrary.h"

NS_ASSUME_NONNULL_BEGIN

@interface PCMCaptureDevice : NSObject<PCM_CaptureDevice, REFReferenceType>
@property (readonly) NSNumber *position;
@property (readonly) NSString *uniqueId;
+ (void)setupChannel:(REFTypeChannelMessenger *)messenger;
+ (NSArray<PCMCaptureDevice*> *)devicesWithMediaType:(NSString *)mediaType
                                           messenger:(REFTypeChannelMessenger *)messenger;
- (instancetype)initWithUniqueID:(NSString *)uniqueID messenger:(REFTypeChannelMessenger *)messenger;
- (instancetype)initWithCaptureDevice:(AVCaptureDevice *)captureDevice
                            messenger:(REFTypeChannelMessenger *)messenger;
- (AVCaptureDevice *)captureDevice;
@end

@interface PCMCaptureDeviceInput : NSObject<PCM_CaptureDeviceInput>
@property (readonly) PCMCaptureDevice *device;
+ (void)setupChannel:(REFTypeChannelMessenger *)messenger;
- (instancetype)initWithDevice:(PCMCaptureDevice *)device;
- (instancetype)initWithCaptureDeviceInput:(AVCaptureDeviceInput *)captureDeviceInput;
- (AVCaptureDeviceInput *)captureDeviceInput;
@end

@interface PCMCaptureSession : NSObject
@property (nonatomic) NSArray<PCMCaptureDeviceInput *> *inputs;
+ (void)setupChannel:(REFTypeChannelMessenger *)messenger;
- (instancetype)initWithCaptureSession:(AVCaptureSession *)captureSession;
- (AVCaptureSession *)captureSession;
@end

@interface PCMPreviewController : NSObject<PCM_PreviewController, FlutterPlatformView>
@property (readonly) PCMCaptureSession *captureSession;
+ (void)setupChannel:(REFTypeChannelMessenger *)messenger;
- (instancetype)initWithCaptureSession:(PCMCaptureSession *)captureSession;
- (instancetype)initWithView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
*/
