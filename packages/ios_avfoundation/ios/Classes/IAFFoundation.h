#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#import "ReferencePlugin.h"
#import "IAFChannelLibrary_Internal.h"
#import "IAFChannelRegistrar.h"

@class IAFLibraryImplementations;

NS_ASSUME_NONNULL_BEGIN

@interface IAFCaptureDeviceProxy : NSObject<_IAFCaptureDevice>
@property (readonly) AVCaptureDevice *captureDevice;
+ (NSArray<IAFCaptureDeviceProxy*> *)devicesWithMediaType:(NSString *)mediaType
                                          implementations:(IAFLibraryImplementations *)implementations;
- (instancetype)initWithCaptureDevice:(AVCaptureDevice *)captureDevice
                      implementations:(IAFLibraryImplementations *)implementations;
@end

@interface IAFCaptureInputProxy : NSObject<_IAFCaptureInput>
@property (readonly) AVCaptureInput *captureInput;
- (instancetype)initWithCaptureInput:(AVCaptureInput *)captureInput;
@end

@interface IAFCaptureDeviceInputProxy : IAFCaptureInputProxy<_IAFCaptureDeviceInput, _IAFCaptureInput>
- (instancetype)initWithDevice:(IAFCaptureDeviceProxy *)device;
@end

@interface IAFCaptureSessionProxy : NSObject<_IAFCaptureSession>
@property (readonly) AVCaptureSession *captureSession;
@property (readonly) NSNumber *number;
- (instancetype)initWithCaptureSession:(AVCaptureSession *)captureSession;
@end

@interface IAFPreviewControllerProxy : NSObject<_IAFPreviewController, FlutterPlatformView>
- (instancetype)initWithCaptureSession:(IAFCaptureSessionProxy *)captureSession;
- (instancetype)initWithView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END

