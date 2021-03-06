#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#import "ReferencePlugin.h"
#import "IAFChannelLibrary_Internal.h"
#import "IAFChannelRegistrar.h"

@class IAFLibraryImplementations;

NS_ASSUME_NONNULL_BEGIN

@interface IAFCaptureDeviceProxy : NSObject<_IAFCaptureDevice>
@property (readonly) AVCaptureDevice *captureDevice;
+ (NSArray<IAFCaptureDeviceProxy*> *)asProxyList:(NSArray<AVCaptureDevice *> *)captureDevices
                                 implementations:(IAFLibraryImplementations *)implementations;
+ (IAFCaptureDeviceProxy *_Nullable)defaultDeviceWithMediaType:(NSString *)mediaType
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
- (instancetype)initWithCaptureSession:(AVCaptureSession *)captureSession;
@end

@interface IAFPreviewControllerProxy : NSObject<_IAFPreviewController, FlutterPlatformView>
- (instancetype)initWithCaptureSession:(IAFCaptureSessionProxy *)captureSession;
- (instancetype)initWithView:(UIView *)view;
@end

@interface IAFCaptureOutputProxy : NSObject<_IAFCaptureOutput>
@property (readonly) AVCaptureOutput *captureOutput;
- (instancetype)initWithCaptureOutput:(AVCaptureOutput *)captureOutput;
@end

API_AVAILABLE(ios(10.0))
@interface IAFCapturePhotoOutputProxy : IAFCaptureOutputProxy<_IAFCapturePhotoOutput>
- (instancetype)initWithCapturePhotoOutput:(AVCapturePhotoOutput *)capturePhotoOutput;
@end

API_AVAILABLE(ios(10.0))
@interface IAFCapturePhotoSettingsProxy : NSObject<_IAFCapturePhotoSettings>
@property (readonly) AVCapturePhotoSettings *capturePhotoSettings;
- (instancetype)initWithFormat:(NSDictionary<NSString *, NSObject *> *)format;
- (instancetype)initWithCapturePhotoSettings:(AVCapturePhotoSettings *)capturePhotoSettings;
@end

API_AVAILABLE(ios(10.0))
@interface IAFCapturePhotoCaptureDelegateProxy : NSObject<_IAFCapturePhotoCaptureDelegate, AVCapturePhotoCaptureDelegate>
- (instancetype)initWithCallback:(_IAFFinishProcessingPhotoCallback)callback
                 implementations:(IAFLibraryImplementations *)implementations;
@end

API_AVAILABLE(ios(11.0))
@interface IAFCapturePhotoProxy : NSObject<_IAFCapturePhoto>
@property (readonly) AVCapturePhoto *capturePhoto;
- (instancetype)initWithCapturePhoto:(AVCapturePhoto *)capturePhoto
                     implementations:(IAFLibraryImplementations *)implementations;
@end

@interface IAFCaptureDeviceDiscoverySessionProxy : NSObject<_IAFCaptureDeviceDiscoverySession>
@property (readonly) AVCaptureDeviceDiscoverySession *captureDeviceDiscoverySession;
+ (IAFCaptureDeviceDiscoverySessionProxy *)discoverySessionWithDeviceTypes:(NSArray<NSString *> *)deviceTypes
                                                                 mediaType:(NSString *_Nullable)mediaType
                                                                  position:(NSNumber *)position
                                                           implementations:(IAFLibraryImplementations *)implementations;
- (instancetype)initWithCaptureDeviceDiscoverySession:(AVCaptureDeviceDiscoverySession *)captureDeviceDiscoverySession
                                      implementations:(IAFLibraryImplementations *)implementations;
@end

@interface IAFCaptureFileOutputProxy : IAFCaptureOutputProxy<_IAFCaptureFileOutput>
- (instancetype)initWithCaptureFileOutput:(AVCaptureFileOutput *)captureFileOutput;
@end

@interface IAFCaptureMovieFileOutputProxy : IAFCaptureFileOutputProxy<_IAFCaptureMovieFileOutput>
- (instancetype)init;
- (instancetype)initWithCaptureMovieFileOutput:(AVCaptureMovieFileOutput *)captureMovieFileOutput;
@end

@interface IAFCaptureFileOutputRecordingDelegateProxy : NSObject<_IAFCaptureFileOutputRecordingDelegate, AVCaptureFileOutputRecordingDelegate>
@end

@interface IAFCaptureInputPortProxy : NSObject<_IAFCaptureInputPort>
@property (readonly) AVCaptureInputPort *captureInputPort;
+ (NSArray<IAFCaptureInputPortProxy *> *)asProxyList:(NSArray<AVCaptureInputPort *> *)captureInputPorts
                                     implementations:(IAFLibraryImplementations *)implementations;
- (instancetype)initWithCaptureInputPort:(AVCaptureInputPort *)captureInputPort
                         implementations:(IAFLibraryImplementations *)implementations;
@end

@interface IAFCaptureConnectionProxy : NSObject<_IAFCaptureConnection>
@property (readonly) AVCaptureConnection *captureConnection;
- (instancetype)initWithInputPorts:(NSArray<IAFCaptureInputPortProxy *> *)ports
                            output:(IAFCaptureOutputProxy *)output;
- (instancetype)initWithCaptureConnection:(AVCaptureConnection *)captureConnection;
@end
NS_ASSUME_NONNULL_END

