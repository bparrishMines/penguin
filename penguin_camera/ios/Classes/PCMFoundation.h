#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#import "PCM_CameraChannelLibrary.h"

NS_ASSUME_NONNULL_BEGIN

@interface PCMCaptureDevice : NSObject<PCM_CaptureDevice, REFReferenceType>
@property NSNumber *position;
@property NSString *uniqueId;
+ (void)setupChannel:(REFTypeChannelMessenger *)messenger;
+ (NSArray<PCMCaptureDevice*> *)devicesWithMediaType:(NSString *)mediaType
                                           messenger:(REFTypeChannelMessenger *)messenger;
- (instancetype)initWithCaptureDevice:(AVCaptureDevice *)captureDevice
                            messenger:(REFTypeChannelMessenger *)messenger;
- (AVCaptureDevice *)captureDevice;
@end

@interface PCMCaptureSession : NSObject<PCM_CaptureSession>
// TODO: Make type the impl version
@property (readonly) NSArray<PCM_CaptureDeviceInput *> *inputs;
+ (void)setupChannel:(REFTypeChannelMessenger *)messenger;
- (instancetype)initWithInputs:(NSArray<NSObject<PCM_CaptureDeviceInput> *> *)inputs;
- (AVCaptureSession *)session;
@end

@interface PCMCaptureDeviceInput : NSObject<PCM_CaptureDeviceInput>
// TODO: Make type the impl version
@property (readonly) NSObject<PCM_CaptureDevice> *device;
+ (void)setupChannel:(REFTypeChannelMessenger *)messenger;
- (instancetype)initWithDevice:(NSObject<PCM_CaptureDevice> *)device;
- (AVCaptureDeviceInput *)captureDeviceInput;
@end

@interface PCMPreviewController : NSObject<PCM_PreviewController, FlutterPlatformView>
// TODO: Make type the impl version
@property (readonly) NSObject<PCM_CaptureSession> *captureSession;
+ (void)setupChannel:(REFTypeChannelMessenger *)messenger;
- (instancetype)initWithCaptureSession:(NSObject<PCM_CaptureSession> *)captureSession;
@end

NS_ASSUME_NONNULL_END
