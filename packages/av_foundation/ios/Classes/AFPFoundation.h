#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#import "ReferencePlugin.h"
#import "AFPChannelLibrary_Internal.h"
#import "AFPChannelRegistrar.h"

@class AFPLibraryImplementations;

NS_ASSUME_NONNULL_BEGIN

@interface AFPCaptureDeviceProxy : NSObject<_AFPCaptureDevice>
@property (readonly) AVCaptureDevice *captureDevice;
+ (NSArray<AFPCaptureDeviceProxy*> *)asProxyList:(NSArray<AVCaptureDevice *> *)captureDevices
                                 implementations:(AFPLibraryImplementations *)implementations;
+ (AFPCaptureDeviceProxy *_Nullable)defaultDeviceWithMediaType:(NSString *)mediaType
                                               implementations:(AFPLibraryImplementations *)implementations;
- (instancetype)initWithCaptureDevice:(AVCaptureDevice *)captureDevice
                      implementations:(AFPLibraryImplementations *)implementations;
@end

@interface AFPPreviewView : UIView
-(instancetype)initWithCaptureSession:(AVCaptureSession *)captureSession;
- (AVCaptureConnection *_Nullable)connection;
@end

@interface AFPCaptureInputProxy : NSObject<_AFPCaptureInput>
@property (readonly) AVCaptureInput *captureInput;
- (instancetype)initWithCaptureInput:(AVCaptureInput *)captureInput;
@end

@interface AFPCaptureDeviceInputProxy : AFPCaptureInputProxy<_AFPCaptureDeviceInput, _AFPCaptureInput>
- (instancetype)initWithDevice:(AFPCaptureDeviceProxy *)device;
@end

@interface AFPCaptureSessionProxy : NSObject<_AFPCaptureSession>
@property (readonly) AVCaptureSession *captureSession;
- (instancetype)initWithCaptureSession:(AVCaptureSession *)captureSession;
@end

@interface AFPPreviewControllerProxy : NSObject<_AFPPreviewController, FlutterPlatformView>
- (instancetype)initWithCaptureSession:(AFPCaptureSessionProxy *)captureSession
                       implementations:(AFPLibraryImplementations *)implementations;
- (instancetype)initWithView:(AFPPreviewView *)view implementations:(AFPLibraryImplementations *)implementations;
@end

@interface AFPCaptureOutputProxy : NSObject<_AFPCaptureOutput>
@property (readonly) AVCaptureOutput *captureOutput;
- (instancetype)initWithCaptureOutput:(AVCaptureOutput *)captureOutput
                      implementations:(AFPLibraryImplementations *)implementations;
- (instancetype)initWithCaptureOutputWithoutCreate:(AVCaptureOutput *)captureOutput
                                   implementations:(AFPLibraryImplementations *)implementations;
@end

API_AVAILABLE(ios(10.0))
@interface AFPCapturePhotoOutputProxy : AFPCaptureOutputProxy<_AFPCapturePhotoOutput>
- (instancetype)initWithImplementations:(AFPLibraryImplementations *)implementations;
- (instancetype)initWithCapturePhotoOutput:(AVCapturePhotoOutput *)capturePhotoOutput
                           implementations:(AFPLibraryImplementations *)implementations;
@end

API_AVAILABLE(ios(10.0))
@interface AFPCapturePhotoSettingsProxy : NSObject<_AFPCapturePhotoSettings>
@property (readonly) AVCapturePhotoSettings *capturePhotoSettings;
- (instancetype)initWithFormat:(NSDictionary<NSString *, NSObject *> *)format;
- (instancetype)initWithCapturePhotoSettings:(AVCapturePhotoSettings *)capturePhotoSettings;
@end

API_AVAILABLE(ios(10.0))
@interface AFPCapturePhotoCaptureDelegateProxy : NSObject<_AFPCapturePhotoCaptureDelegate, AVCapturePhotoCaptureDelegate>
- (instancetype)initWithCallback:(_AFPFinishProcessingPhotoCallback)callback
                 implementations:(AFPLibraryImplementations *)implementations;
@end

API_AVAILABLE(ios(11.0))
@interface AFPCapturePhotoProxy : NSObject<_AFPCapturePhoto>
@property (readonly) AVCapturePhoto *capturePhoto;
- (instancetype)initWithCapturePhoto:(AVCapturePhoto *)capturePhoto
                     implementations:(AFPLibraryImplementations *)implementations;
@end

@interface AFPCaptureDeviceDiscoverySessionProxy : NSObject<_AFPCaptureDeviceDiscoverySession>
@property (readonly) AVCaptureDeviceDiscoverySession *captureDeviceDiscoverySession;
+ (AFPCaptureDeviceDiscoverySessionProxy *)discoverySessionWithDeviceTypes:(NSArray<NSString *> *)deviceTypes
                                                                 mediaType:(NSString *_Nullable)mediaType
                                                                  position:(NSNumber *)position
                                                           implementations:(AFPLibraryImplementations *)implementations;
- (instancetype)initWithCaptureDeviceDiscoverySession:(AVCaptureDeviceDiscoverySession *)captureDeviceDiscoverySession
                                      implementations:(AFPLibraryImplementations *)implementations;
@end

@interface AFPCaptureFileOutputProxy : AFPCaptureOutputProxy<_AFPCaptureFileOutput>
- (instancetype)initWithCaptureFileOutput:(AVCaptureFileOutput *)captureFileOutput
                          implementations:(AFPLibraryImplementations *)implementations;
@end

@interface AFPCaptureMovieFileOutputProxy : AFPCaptureFileOutputProxy<_AFPCaptureMovieFileOutput>
- (instancetype)initWithImplementations:(AFPLibraryImplementations *)implementations;
- (instancetype)initWithCaptureMovieFileOutput:(AVCaptureMovieFileOutput *)captureMovieFileOutput
                               implementations:(AFPLibraryImplementations *)implementations;
@end

@interface AFPCaptureFileOutputRecordingDelegateProxy : NSObject<_AFPCaptureFileOutputRecordingDelegate, AVCaptureFileOutputRecordingDelegate>
@end

@interface AFPCaptureInputPortProxy : NSObject<_AFPCaptureInputPort>
@property (readonly) AVCaptureInputPort *captureInputPort;
+ (NSArray<AFPCaptureInputPortProxy *> *)asProxyList:(NSArray<AVCaptureInputPort *> *)captureInputPorts
                                     implementations:(AFPLibraryImplementations *)implementations;
- (instancetype)initWithCaptureInputPort:(AVCaptureInputPort *)captureInputPort
                         implementations:(AFPLibraryImplementations *)implementations;
@end

@interface AFPCaptureConnectionProxy : NSObject<_AFPCaptureConnection>
@property (readonly) AVCaptureConnection *captureConnection;
- (instancetype)initWithInputPorts:(NSArray<AFPCaptureInputPortProxy *> *)ports
                            output:(AFPCaptureOutputProxy *)output;
- (instancetype)initWithCaptureConnection:(AVCaptureConnection *)captureConnection;
- (instancetype)initWithCaptureConnection:(AVCaptureConnection *)captureConnection
                          implementations:(AFPLibraryImplementations *)implementations;
@end
NS_ASSUME_NONNULL_END

