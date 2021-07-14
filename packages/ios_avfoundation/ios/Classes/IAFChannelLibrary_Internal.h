// GENERATED CODE - DO NOT MODIFY BY HAND

#import <Foundation/Foundation.h>
#import "REFMethodChannel.h"

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

NS_ASSUME_NONNULL_BEGIN



@protocol _IAFCapturePhotoOutput;

@protocol _IAFCapturePhotoSettings;

@protocol _IAFCapturePhotoCaptureDelegate;

@protocol _IAFCaptureOutput;

@protocol _IAFCapturePhoto;

@protocol _IAFCaptureDeviceInput;

@protocol _IAFCaptureInput;

@protocol _IAFCaptureSession;

@protocol _IAFCaptureDevice;

@protocol _IAFCaptureDeviceDiscoverySession;

@protocol _IAFPreviewController;

@protocol _IAFCaptureFileOutput;

@protocol _IAFCaptureMovieFileOutput;

@protocol _IAFCaptureFileOutputRecordingDelegate;


@class _IAFLibraryImplementations;


typedef NSObject *_Nullable (^_IAFFinishProcessingPhotoCallback) (NSObject<_IAFCapturePhoto> * _Nullable photo);



@interface _IAFFinishProcessingPhotoCallbackChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;
- (void)__create:(_IAFFinishProcessingPhotoCallback)_instance
          _owner:(BOOL)_owner
      completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;
@end



@interface _IAFFinishProcessingPhotoCallbackHandler : NSObject<REFTypeChannelHandler>
@property (readonly) _IAFLibraryImplementations *implementations;
-(instancetype)initWithImplementations:(_IAFLibraryImplementations *)implementations;
@end



@protocol _IAFCapturePhotoOutput <NSObject>


- (id _Nullable)capturePhotoWithSettings
                                :(NSObject<_IAFCapturePhotoSettings> * _Nullable)settings


     delegate:(NSObject<_IAFCapturePhotoCaptureDelegate> * _Nullable)delegate

;



- (id _Nullable)supportedFlashModes

;


@end

@protocol _IAFCapturePhotoSettings <NSObject>


- (id _Nullable)uniqueID

;



- (id _Nullable)setFlashMode
                                :(NSNumber * _Nullable)mode


;


@end

@protocol _IAFCapturePhotoCaptureDelegate <NSObject>

@end

@protocol _IAFCaptureOutput <NSObject>

@end

@protocol _IAFCapturePhoto <NSObject>

@end

@protocol _IAFCaptureDeviceInput <NSObject>

@end

@protocol _IAFCaptureInput <NSObject>

@end

@protocol _IAFCaptureSession <NSObject>


- (id _Nullable)addInput
                                :(NSObject<_IAFCaptureInput> * _Nullable)input


;



- (id _Nullable)addOutput
                                :(NSObject<_IAFCaptureOutput> * _Nullable)output


;



- (id _Nullable)startRunning

;



- (id _Nullable)stopRunning

;



- (id _Nullable)setSessionPreset
                                :(NSString * _Nullable)preset


;



- (id _Nullable)canSetSessionPresets
                                :(NSArray<NSString *> * _Nullable)presets


;


@end

@protocol _IAFCaptureDevice <NSObject>


- (id _Nullable)lockForConfiguration

;



- (id _Nullable)unlockForConfiguration

;



- (id _Nullable)supportsCaptureSessionPresets
                                :(NSArray<NSString *> * _Nullable)presets


;



- (id _Nullable)isAdjustingExposure

;



- (id _Nullable)setExposureMode
                                :(NSNumber * _Nullable)mode


;



- (id _Nullable)exposureModesSupported
                                :(NSArray<NSNumber *> * _Nullable)modes


;



- (id _Nullable)setFocusMode
                                :(NSNumber * _Nullable)mode


;



- (id _Nullable)focusModesSupported
                                :(NSArray<NSNumber *> * _Nullable)modes


;



- (id _Nullable)isAdjustingFocus

;



- (id _Nullable)setSmoothAutoFocusEnabled
                                :(NSNumber * _Nullable)enabled


;



- (id _Nullable)isFlashAvailable

;



- (id _Nullable)setVideoZoomFactor
                                :(NSNumber * _Nullable)factor


;



- (id _Nullable)minAvailableVideoZoomFactor

;



- (id _Nullable)maxAvailableVideoZoomFactor

;



- (id _Nullable)rampToVideoZoomFactor
                                :(NSNumber * _Nullable)factor


     rate:(NSNumber * _Nullable)rate

;



- (id _Nullable)isRampingVideoZoom

;



- (id _Nullable)cancelVideoZoomRamp

;


@end

@protocol _IAFCaptureDeviceDiscoverySession <NSObject>

@end

@protocol _IAFPreviewController <NSObject>

@end

@protocol _IAFCaptureFileOutput <NSObject>


- (id _Nullable)outputFileURL

;



- (id _Nullable)setMaxRecordedFileSize
                                :(NSNumber * _Nullable)fileSize


;



- (id _Nullable)isRecording

;



- (id _Nullable)startRecordingToOutputFileURL
                                :(NSString * _Nullable)outputFileURL


     delegate:(NSObject<_IAFCaptureFileOutputRecordingDelegate> * _Nullable)delegate

;



- (id _Nullable)stopRecording

;


@end

@protocol _IAFCaptureMovieFileOutput <NSObject>


- (id _Nullable)availableVideoCodecTypes

;


@end

@protocol _IAFCaptureFileOutputRecordingDelegate <NSObject>

@end



@interface _IAFCapturePhotoOutputChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)_create_:(NSObject<_IAFCapturePhotoOutput> *)_instance
          _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;









@end

@interface _IAFCapturePhotoSettingsChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)_create_:(NSObject<_IAFCapturePhotoSettings> *)_instance
          _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;

- (void)_create_photoSettingsWithFormat:(NSObject<_IAFCapturePhotoSettings> *)_instance
          _owner:(BOOL)_owner

 format:(NSDictionary<NSString *, NSObject *> * _Nullable)format

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;









@end

@interface _IAFCapturePhotoCaptureDelegateChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)_create_:(NSObject<_IAFCapturePhotoCaptureDelegate> *)_instance
          _owner:(BOOL)_owner

 didFinishProcessingPhoto:(_IAFFinishProcessingPhotoCallback _Nullable)didFinishProcessingPhoto

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;





@end

@interface _IAFCaptureOutputChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)_create_:(NSObject<_IAFCaptureOutput> *)_instance
          _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;





@end

@interface _IAFCapturePhotoChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)_create_:(NSObject<_IAFCapturePhoto> *)_instance
          _owner:(BOOL)_owner

 fileDataRepresentation:(NSData * _Nullable)fileDataRepresentation

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;





@end

@interface _IAFCaptureDeviceInputChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)_create_:(NSObject<_IAFCaptureDeviceInput> *)_instance
          _owner:(BOOL)_owner

 device:(NSObject<_IAFCaptureDevice> * _Nullable)device

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;





@end

@interface _IAFCaptureInputChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)_create_:(NSObject<_IAFCaptureInput> *)_instance
          _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;





@end

@interface _IAFCaptureSessionChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)_create_:(NSObject<_IAFCaptureSession> *)_instance
          _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;

















@end

@interface _IAFCaptureDeviceChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)_create_:(NSObject<_IAFCaptureDevice> *)_instance
          _owner:(BOOL)_owner

 uniqueId:(NSString * _Nullable)uniqueId

 position:(NSNumber * _Nullable)position

 isSmoothAutoFocusSupported:(NSNumber * _Nullable)isSmoothAutoFocusSupported

 hasFlash:(NSNumber * _Nullable)hasFlash

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;









































@end

@interface _IAFCaptureDeviceDiscoverySessionChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)_create_:(NSObject<_IAFCaptureDeviceDiscoverySession> *)_instance
          _owner:(BOOL)_owner

 devices:(NSArray<NSObject<_IAFCaptureDevice> *> * _Nullable)devices

 supportedMultiCamDeviceSets:(NSArray<NSArray<NSObject<_IAFCaptureDevice> *> *> * _Nullable)supportedMultiCamDeviceSets

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;







@end

@interface _IAFPreviewControllerChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)_create_:(NSObject<_IAFPreviewController> *)_instance
          _owner:(BOOL)_owner

 captureSession:(NSObject<_IAFCaptureSession> * _Nullable)captureSession

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;





@end

@interface _IAFCaptureFileOutputChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)_create_:(NSObject<_IAFCaptureFileOutput> *)_instance
          _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;















@end

@interface _IAFCaptureMovieFileOutputChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)_create_:(NSObject<_IAFCaptureMovieFileOutput> *)_instance
          _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;







@end

@interface _IAFCaptureFileOutputRecordingDelegateChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)_create_:(NSObject<_IAFCaptureFileOutputRecordingDelegate> *)_instance
          _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;





@end



@interface _IAFCapturePhotoOutputHandler : NSObject<REFTypeChannelHandler>

- (NSObject<_IAFCapturePhotoOutput> *)_create_:(REFTypeChannelMessenger *)messenger
;





- (id _Nullable)_capturePhotoWithSettings:(NSObject<_IAFCapturePhotoOutput> *)_instance

  settings:(NSObject<_IAFCapturePhotoSettings> * _Nullable)settings

  delegate:(NSObject<_IAFCapturePhotoCaptureDelegate> * _Nullable)delegate
;



- (id _Nullable)_supportedFlashModes:(NSObject<_IAFCapturePhotoOutput> *)_instance
;


@end

@interface _IAFCapturePhotoSettingsHandler : NSObject<REFTypeChannelHandler>

- (NSObject<_IAFCapturePhotoSettings> *)_create_:(REFTypeChannelMessenger *)messenger
;

- (NSObject<_IAFCapturePhotoSettings> *)_create_photoSettingsWithFormat:(REFTypeChannelMessenger *)messenger

                                  format:(NSDictionary<NSString *, NSObject *> * _Nullable)format
;





- (id _Nullable)_uniqueID:(NSObject<_IAFCapturePhotoSettings> *)_instance
;



- (id _Nullable)_setFlashMode:(NSObject<_IAFCapturePhotoSettings> *)_instance

  mode:(NSNumber * _Nullable)mode
;


@end

@interface _IAFCapturePhotoCaptureDelegateHandler : NSObject<REFTypeChannelHandler>

- (NSObject<_IAFCapturePhotoCaptureDelegate> *)_create_:(REFTypeChannelMessenger *)messenger

                                  didFinishProcessingPhoto:(_IAFFinishProcessingPhotoCallback _Nullable)didFinishProcessingPhoto
;




@end

@interface _IAFCaptureOutputHandler : NSObject<REFTypeChannelHandler>

- (NSObject<_IAFCaptureOutput> *)_create_:(REFTypeChannelMessenger *)messenger
;




@end

@interface _IAFCapturePhotoHandler : NSObject<REFTypeChannelHandler>

- (NSObject<_IAFCapturePhoto> *)_create_:(REFTypeChannelMessenger *)messenger

                                  fileDataRepresentation:(NSData * _Nullable)fileDataRepresentation
;




@end

@interface _IAFCaptureDeviceInputHandler : NSObject<REFTypeChannelHandler>

- (NSObject<_IAFCaptureDeviceInput> *)_create_:(REFTypeChannelMessenger *)messenger

                                  device:(NSObject<_IAFCaptureDevice> * _Nullable)device
;




@end

@interface _IAFCaptureInputHandler : NSObject<REFTypeChannelHandler>

- (NSObject<_IAFCaptureInput> *)_create_:(REFTypeChannelMessenger *)messenger
;




@end

@interface _IAFCaptureSessionHandler : NSObject<REFTypeChannelHandler>

- (NSObject<_IAFCaptureSession> *)_create_:(REFTypeChannelMessenger *)messenger
;





- (id _Nullable)_addInput:(NSObject<_IAFCaptureSession> *)_instance

  input:(NSObject<_IAFCaptureInput> * _Nullable)input
;



- (id _Nullable)_addOutput:(NSObject<_IAFCaptureSession> *)_instance

  output:(NSObject<_IAFCaptureOutput> * _Nullable)output
;



- (id _Nullable)_startRunning:(NSObject<_IAFCaptureSession> *)_instance
;



- (id _Nullable)_stopRunning:(NSObject<_IAFCaptureSession> *)_instance
;



- (id _Nullable)_setSessionPreset:(NSObject<_IAFCaptureSession> *)_instance

  preset:(NSString * _Nullable)preset
;



- (id _Nullable)_canSetSessionPresets:(NSObject<_IAFCaptureSession> *)_instance

  presets:(NSArray<NSString *> * _Nullable)presets
;


@end

@interface _IAFCaptureDeviceHandler : NSObject<REFTypeChannelHandler>

- (NSObject<_IAFCaptureDevice> *)_create_:(REFTypeChannelMessenger *)messenger

                                  uniqueId:(NSString * _Nullable)uniqueId

                                  position:(NSNumber * _Nullable)position

                                  isSmoothAutoFocusSupported:(NSNumber * _Nullable)isSmoothAutoFocusSupported

                                  hasFlash:(NSNumber * _Nullable)hasFlash
;



- (id _Nullable)_defaultDeviceWithMediaType:(REFTypeChannelMessenger *)messenger

                           mediaType:(NSString * _Nullable)mediaType
;





- (id _Nullable)_lockForConfiguration:(NSObject<_IAFCaptureDevice> *)_instance
;



- (id _Nullable)_unlockForConfiguration:(NSObject<_IAFCaptureDevice> *)_instance
;



- (id _Nullable)_supportsCaptureSessionPresets:(NSObject<_IAFCaptureDevice> *)_instance

  presets:(NSArray<NSString *> * _Nullable)presets
;



- (id _Nullable)_isAdjustingExposure:(NSObject<_IAFCaptureDevice> *)_instance
;



- (id _Nullable)_setExposureMode:(NSObject<_IAFCaptureDevice> *)_instance

  mode:(NSNumber * _Nullable)mode
;



- (id _Nullable)_exposureModesSupported:(NSObject<_IAFCaptureDevice> *)_instance

  modes:(NSArray<NSNumber *> * _Nullable)modes
;



- (id _Nullable)_setFocusMode:(NSObject<_IAFCaptureDevice> *)_instance

  mode:(NSNumber * _Nullable)mode
;



- (id _Nullable)_focusModesSupported:(NSObject<_IAFCaptureDevice> *)_instance

  modes:(NSArray<NSNumber *> * _Nullable)modes
;



- (id _Nullable)_isAdjustingFocus:(NSObject<_IAFCaptureDevice> *)_instance
;



- (id _Nullable)_setSmoothAutoFocusEnabled:(NSObject<_IAFCaptureDevice> *)_instance

  enabled:(NSNumber * _Nullable)enabled
;



- (id _Nullable)_isFlashAvailable:(NSObject<_IAFCaptureDevice> *)_instance
;



- (id _Nullable)_setVideoZoomFactor:(NSObject<_IAFCaptureDevice> *)_instance

  factor:(NSNumber * _Nullable)factor
;



- (id _Nullable)_minAvailableVideoZoomFactor:(NSObject<_IAFCaptureDevice> *)_instance
;



- (id _Nullable)_maxAvailableVideoZoomFactor:(NSObject<_IAFCaptureDevice> *)_instance
;



- (id _Nullable)_rampToVideoZoomFactor:(NSObject<_IAFCaptureDevice> *)_instance

  factor:(NSNumber * _Nullable)factor

  rate:(NSNumber * _Nullable)rate
;



- (id _Nullable)_isRampingVideoZoom:(NSObject<_IAFCaptureDevice> *)_instance
;



- (id _Nullable)_cancelVideoZoomRamp:(NSObject<_IAFCaptureDevice> *)_instance
;


@end

@interface _IAFCaptureDeviceDiscoverySessionHandler : NSObject<REFTypeChannelHandler>

- (NSObject<_IAFCaptureDeviceDiscoverySession> *)_create_:(REFTypeChannelMessenger *)messenger

                                  devices:(NSArray<NSObject<_IAFCaptureDevice> *> * _Nullable)devices

                                  supportedMultiCamDeviceSets:(NSArray<NSArray<NSObject<_IAFCaptureDevice> *> *> * _Nullable)supportedMultiCamDeviceSets
;



- (id _Nullable)_discoverySessionWithDeviceTypes:(REFTypeChannelMessenger *)messenger

                           deviceTypes:(NSArray<NSString *> * _Nullable)deviceTypes

                           mediaType:(NSString * _Nullable)mediaType

                           position:(NSNumber * _Nullable)position
;




@end

@interface _IAFPreviewControllerHandler : NSObject<REFTypeChannelHandler>

- (NSObject<_IAFPreviewController> *)_create_:(REFTypeChannelMessenger *)messenger

                                  captureSession:(NSObject<_IAFCaptureSession> * _Nullable)captureSession
;




@end

@interface _IAFCaptureFileOutputHandler : NSObject<REFTypeChannelHandler>

- (NSObject<_IAFCaptureFileOutput> *)_create_:(REFTypeChannelMessenger *)messenger
;





- (id _Nullable)_outputFileURL:(NSObject<_IAFCaptureFileOutput> *)_instance
;



- (id _Nullable)_setMaxRecordedFileSize:(NSObject<_IAFCaptureFileOutput> *)_instance

  fileSize:(NSNumber * _Nullable)fileSize
;



- (id _Nullable)_isRecording:(NSObject<_IAFCaptureFileOutput> *)_instance
;



- (id _Nullable)_startRecordingToOutputFileURL:(NSObject<_IAFCaptureFileOutput> *)_instance

  outputFileURL:(NSString * _Nullable)outputFileURL

  delegate:(NSObject<_IAFCaptureFileOutputRecordingDelegate> * _Nullable)delegate
;



- (id _Nullable)_stopRecording:(NSObject<_IAFCaptureFileOutput> *)_instance
;


@end

@interface _IAFCaptureMovieFileOutputHandler : NSObject<REFTypeChannelHandler>

- (NSObject<_IAFCaptureMovieFileOutput> *)_create_:(REFTypeChannelMessenger *)messenger
;





- (id _Nullable)_availableVideoCodecTypes:(NSObject<_IAFCaptureMovieFileOutput> *)_instance
;


@end

@interface _IAFCaptureFileOutputRecordingDelegateHandler : NSObject<REFTypeChannelHandler>

- (NSObject<_IAFCaptureFileOutputRecordingDelegate> *)_create_:(REFTypeChannelMessenger *)messenger
;




@end


@interface _IAFLibraryImplementations : NSObject
@property (readonly) REFTypeChannelMessenger *messenger;
-(instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

-(_IAFCapturePhotoOutputChannel *)channelCapturePhotoOutput;
-(_IAFCapturePhotoOutputHandler *)handlerCapturePhotoOutput;

-(_IAFCapturePhotoSettingsChannel *)channelCapturePhotoSettings;
-(_IAFCapturePhotoSettingsHandler *)handlerCapturePhotoSettings;

-(_IAFCapturePhotoCaptureDelegateChannel *)channelCapturePhotoCaptureDelegate;
-(_IAFCapturePhotoCaptureDelegateHandler *)handlerCapturePhotoCaptureDelegate;

-(_IAFCaptureOutputChannel *)channelCaptureOutput;
-(_IAFCaptureOutputHandler *)handlerCaptureOutput;

-(_IAFCapturePhotoChannel *)channelCapturePhoto;
-(_IAFCapturePhotoHandler *)handlerCapturePhoto;

-(_IAFCaptureDeviceInputChannel *)channelCaptureDeviceInput;
-(_IAFCaptureDeviceInputHandler *)handlerCaptureDeviceInput;

-(_IAFCaptureInputChannel *)channelCaptureInput;
-(_IAFCaptureInputHandler *)handlerCaptureInput;

-(_IAFCaptureSessionChannel *)channelCaptureSession;
-(_IAFCaptureSessionHandler *)handlerCaptureSession;

-(_IAFCaptureDeviceChannel *)channelCaptureDevice;
-(_IAFCaptureDeviceHandler *)handlerCaptureDevice;

-(_IAFCaptureDeviceDiscoverySessionChannel *)channelCaptureDeviceDiscoverySession;
-(_IAFCaptureDeviceDiscoverySessionHandler *)handlerCaptureDeviceDiscoverySession;

-(_IAFPreviewControllerChannel *)channelPreviewController;
-(_IAFPreviewControllerHandler *)handlerPreviewController;

-(_IAFCaptureFileOutputChannel *)channelCaptureFileOutput;
-(_IAFCaptureFileOutputHandler *)handlerCaptureFileOutput;

-(_IAFCaptureMovieFileOutputChannel *)channelCaptureMovieFileOutput;
-(_IAFCaptureMovieFileOutputHandler *)handlerCaptureMovieFileOutput;

-(_IAFCaptureFileOutputRecordingDelegateChannel *)channelCaptureFileOutputRecordingDelegate;
-(_IAFCaptureFileOutputRecordingDelegateHandler *)handlerCaptureFileOutputRecordingDelegate;



- (_IAFFinishProcessingPhotoCallbackChannel *)channelFinishProcessingPhotoCallback;
- (_IAFFinishProcessingPhotoCallbackHandler *)handlerFinishProcessingPhotoCallback;

@end

@interface _IAFChannelRegistrar : NSObject
@property (readonly) _IAFLibraryImplementations *implementations;
- (instancetype)initWithImplementation:(_IAFLibraryImplementations *)implementations;
- (void)registerHandlers;
- (void)unregisterHandlers;
@end

NS_ASSUME_NONNULL_END
