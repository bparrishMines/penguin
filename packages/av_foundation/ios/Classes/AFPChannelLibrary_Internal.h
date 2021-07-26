// GENERATED CODE - DO NOT MODIFY BY HAND

#import <Foundation/Foundation.h>
#import "REFMethodChannel.h"



// **************************************************************************
// ReferenceGenerator
// **************************************************************************

NS_ASSUME_NONNULL_BEGIN



@protocol _AFPCapturePhotoOutput;

@protocol _AFPCapturePhotoSettings;

@protocol _AFPCapturePhotoCaptureDelegate;

@protocol _AFPCaptureOutput;

@protocol _AFPCapturePhoto;

@protocol _AFPCaptureDeviceInput;

@protocol _AFPCaptureInput;

@protocol _AFPCaptureSession;

@protocol _AFPCaptureDevice;

@protocol _AFPCaptureDeviceDiscoverySession;

@protocol _AFPPreviewController;

@protocol _AFPCaptureFileOutput;

@protocol _AFPCaptureMovieFileOutput;

@protocol _AFPCaptureFileOutputRecordingDelegate;

@protocol _AFPCaptureConnection;

@protocol _AFPCaptureInputPort;


@class _AFPLibraryImplementations;


typedef NSObject *_Nullable (^_AFPFinishProcessingPhotoCallback) (NSObject<_AFPCapturePhoto> * _Nullable photo);



@interface _AFPFinishProcessingPhotoCallbackChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;
- (void)__create:(_AFPFinishProcessingPhotoCallback)_instance
          _owner:(BOOL)_owner
      completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;
@end



@interface _AFPFinishProcessingPhotoCallbackHandler : NSObject<REFTypeChannelHandler>
@property (readonly) _AFPLibraryImplementations *implementations;
-(instancetype)initWithImplementations:(_AFPLibraryImplementations *)implementations;
@end



@protocol _AFPCapturePhotoOutput <NSObject>


- (id _Nullable)capturePhotoWithSettings
                                :(NSObject<_AFPCapturePhotoSettings> * _Nullable)settings


     delegate:(NSObject<_AFPCapturePhotoCaptureDelegate> * _Nullable)delegate

;



- (id _Nullable)supportedFlashModes

;


@end

@protocol _AFPCapturePhotoSettings <NSObject>


- (id _Nullable)uniqueID

;



- (id _Nullable)setFlashMode
                                :(NSNumber * _Nullable)mode


;


@end

@protocol _AFPCapturePhotoCaptureDelegate <NSObject>

@end

@protocol _AFPCaptureOutput <NSObject>


- (id _Nullable)connectionWithMediaType
                                :(NSString * _Nullable)mediaType


;


@end

@protocol _AFPCapturePhoto <NSObject>

@end

@protocol _AFPCaptureDeviceInput <NSObject>

@end

@protocol _AFPCaptureInput <NSObject>

@end

@protocol _AFPCaptureSession <NSObject>


- (id _Nullable)addInput
                                :(NSObject<_AFPCaptureInput> * _Nullable)input


;



- (id _Nullable)addOutput
                                :(NSObject<_AFPCaptureOutput> * _Nullable)output


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



- (id _Nullable)canAddInput
                                :(NSObject<_AFPCaptureInput> * _Nullable)input


;



- (id _Nullable)removeInput
                                :(NSObject<_AFPCaptureInput> * _Nullable)input


;



- (id _Nullable)canAddOutput
                                :(NSObject<_AFPCaptureOutput> * _Nullable)output


;



- (id _Nullable)removeOutput
                                :(NSObject<_AFPCaptureOutput> * _Nullable)output


;



- (id _Nullable)isRunning

;



- (id _Nullable)isInterrupted

;


@end

@protocol _AFPCaptureDevice <NSObject>


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



- (id _Nullable)isTorchAvailable

;



- (id _Nullable)isTorchActive

;



- (id _Nullable)torchLevel

;



- (id _Nullable)setTorchMode
                                :(NSNumber * _Nullable)mode


;



- (id _Nullable)torchModesSupported
                                :(NSArray<NSNumber *> * _Nullable)modes


;



- (id _Nullable)setTorchModeOnWithLevel
                                :(NSNumber * _Nullable)torchLevel


;


@end

@protocol _AFPCaptureDeviceDiscoverySession <NSObject>

@end

@protocol _AFPPreviewController <NSObject>

@end

@protocol _AFPCaptureFileOutput <NSObject>


- (id _Nullable)outputFileURL

;



- (id _Nullable)setMaxRecordedFileSize
                                :(NSNumber * _Nullable)fileSize


;



- (id _Nullable)isRecording

;



- (id _Nullable)startRecordingToOutputFileURL
                                :(NSString * _Nullable)outputFileURL


     delegate:(NSObject<_AFPCaptureFileOutputRecordingDelegate> * _Nullable)delegate

;



- (id _Nullable)stopRecording

;


@end

@protocol _AFPCaptureMovieFileOutput <NSObject>


- (id _Nullable)availableVideoCodecTypes

;


@end

@protocol _AFPCaptureFileOutputRecordingDelegate <NSObject>

@end

@protocol _AFPCaptureConnection <NSObject>


- (id _Nullable)setVideoOrientation
                                :(NSNumber * _Nullable)orientation


;



- (id _Nullable)isVideoOrientationSupported

;



- (id _Nullable)setAutomaticallyAdjustsVideoMirroring
                                :(NSNumber * _Nullable)adjust


;



- (id _Nullable)setVideoMirrored
                                :(NSNumber * _Nullable)mirrored


;



- (id _Nullable)isVideoMirroringSupported

;


@end

@protocol _AFPCaptureInputPort <NSObject>


- (id _Nullable)setEnabled
                                :(NSNumber * _Nullable)enabled


;


@end



@interface _AFPCapturePhotoOutputChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)_create_:(NSObject<_AFPCapturePhotoOutput> *)_instance
          _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;









@end

@interface _AFPCapturePhotoSettingsChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)_create_:(NSObject<_AFPCapturePhotoSettings> *)_instance
          _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;

- (void)_create_photoSettingsWithFormat:(NSObject<_AFPCapturePhotoSettings> *)_instance
          _owner:(BOOL)_owner

 format:(NSDictionary<NSString *, NSObject *> * _Nullable)format

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;









@end

@interface _AFPCapturePhotoCaptureDelegateChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)_create_:(NSObject<_AFPCapturePhotoCaptureDelegate> *)_instance
          _owner:(BOOL)_owner

 didFinishProcessingPhoto:(_AFPFinishProcessingPhotoCallback _Nullable)didFinishProcessingPhoto

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;





@end

@interface _AFPCaptureOutputChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)_create_:(NSObject<_AFPCaptureOutput> *)_instance
          _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;







@end

@interface _AFPCapturePhotoChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)_create_:(NSObject<_AFPCapturePhoto> *)_instance
          _owner:(BOOL)_owner

 fileDataRepresentation:(NSData * _Nullable)fileDataRepresentation

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;





@end

@interface _AFPCaptureDeviceInputChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)_create_:(NSObject<_AFPCaptureDeviceInput> *)_instance
          _owner:(BOOL)_owner

 device:(NSObject<_AFPCaptureDevice> * _Nullable)device

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;





@end

@interface _AFPCaptureInputChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)_create_:(NSObject<_AFPCaptureInput> *)_instance
          _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;





@end

@interface _AFPCaptureSessionChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)_create_:(NSObject<_AFPCaptureSession> *)_instance
          _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;





























@end

@interface _AFPCaptureDeviceChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)_create_:(NSObject<_AFPCaptureDevice> *)_instance
          _owner:(BOOL)_owner

 uniqueId:(NSString * _Nullable)uniqueId

 position:(NSNumber * _Nullable)position

 isSmoothAutoFocusSupported:(NSNumber * _Nullable)isSmoothAutoFocusSupported

 hasFlash:(NSNumber * _Nullable)hasFlash

 hasTorch:(NSNumber * _Nullable)hasTorch

 maxAvailableTorchLevel:(NSNumber * _Nullable)maxAvailableTorchLevel

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;





















































@end

@interface _AFPCaptureDeviceDiscoverySessionChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)_create_:(NSObject<_AFPCaptureDeviceDiscoverySession> *)_instance
          _owner:(BOOL)_owner

 devices:(NSArray<NSObject<_AFPCaptureDevice> *> * _Nullable)devices

 supportedMultiCamDeviceSets:(NSArray<NSArray<NSObject<_AFPCaptureDevice> *> *> * _Nullable)supportedMultiCamDeviceSets

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;







@end

@interface _AFPPreviewControllerChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)_create_:(NSObject<_AFPPreviewController> *)_instance
          _owner:(BOOL)_owner

 captureSession:(NSObject<_AFPCaptureSession> * _Nullable)captureSession

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;





@end

@interface _AFPCaptureFileOutputChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)_create_:(NSObject<_AFPCaptureFileOutput> *)_instance
          _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;















@end

@interface _AFPCaptureMovieFileOutputChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)_create_:(NSObject<_AFPCaptureMovieFileOutput> *)_instance
          _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;







@end

@interface _AFPCaptureFileOutputRecordingDelegateChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)_create_:(NSObject<_AFPCaptureFileOutputRecordingDelegate> *)_instance
          _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;





@end

@interface _AFPCaptureConnectionChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)_create_:(NSObject<_AFPCaptureConnection> *)_instance
          _owner:(BOOL)_owner

 inputPorts:(NSArray<NSObject<_AFPCaptureInputPort> *> * _Nullable)inputPorts

 output:(NSObject<_AFPCaptureOutput> * _Nullable)output

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;















@end

@interface _AFPCaptureInputPortChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)_create_:(NSObject<_AFPCaptureInputPort> *)_instance
          _owner:(BOOL)_owner

 mediaType:(NSString * _Nullable)mediaType

 sourceDeviceType:(NSString * _Nullable)sourceDeviceType

 sourceDevicePosition:(NSNumber * _Nullable)sourceDevicePosition

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;







@end



@interface _AFPCapturePhotoOutputHandler : NSObject<REFTypeChannelHandler>

- (NSObject<_AFPCapturePhotoOutput> *)_create_:(REFTypeChannelMessenger *)messenger
;





- (id _Nullable)_capturePhotoWithSettings:(NSObject<_AFPCapturePhotoOutput> *)_instance

  settings:(NSObject<_AFPCapturePhotoSettings> * _Nullable)settings

  delegate:(NSObject<_AFPCapturePhotoCaptureDelegate> * _Nullable)delegate
;



- (id _Nullable)_supportedFlashModes:(NSObject<_AFPCapturePhotoOutput> *)_instance
;


@end

@interface _AFPCapturePhotoSettingsHandler : NSObject<REFTypeChannelHandler>

- (NSObject<_AFPCapturePhotoSettings> *)_create_:(REFTypeChannelMessenger *)messenger
;

- (NSObject<_AFPCapturePhotoSettings> *)_create_photoSettingsWithFormat:(REFTypeChannelMessenger *)messenger

                                  format:(NSDictionary<NSString *, NSObject *> * _Nullable)format
;





- (id _Nullable)_uniqueID:(NSObject<_AFPCapturePhotoSettings> *)_instance
;



- (id _Nullable)_setFlashMode:(NSObject<_AFPCapturePhotoSettings> *)_instance

  mode:(NSNumber * _Nullable)mode
;


@end

@interface _AFPCapturePhotoCaptureDelegateHandler : NSObject<REFTypeChannelHandler>

- (NSObject<_AFPCapturePhotoCaptureDelegate> *)_create_:(REFTypeChannelMessenger *)messenger

                                  didFinishProcessingPhoto:(_AFPFinishProcessingPhotoCallback _Nullable)didFinishProcessingPhoto
;




@end

@interface _AFPCaptureOutputHandler : NSObject<REFTypeChannelHandler>

- (NSObject<_AFPCaptureOutput> *)_create_:(REFTypeChannelMessenger *)messenger
;





- (id _Nullable)_connectionWithMediaType:(NSObject<_AFPCaptureOutput> *)_instance

  mediaType:(NSString * _Nullable)mediaType
;


@end

@interface _AFPCapturePhotoHandler : NSObject<REFTypeChannelHandler>

- (NSObject<_AFPCapturePhoto> *)_create_:(REFTypeChannelMessenger *)messenger

                                  fileDataRepresentation:(NSData * _Nullable)fileDataRepresentation
;




@end

@interface _AFPCaptureDeviceInputHandler : NSObject<REFTypeChannelHandler>

- (NSObject<_AFPCaptureDeviceInput> *)_create_:(REFTypeChannelMessenger *)messenger

                                  device:(NSObject<_AFPCaptureDevice> * _Nullable)device
;




@end

@interface _AFPCaptureInputHandler : NSObject<REFTypeChannelHandler>

- (NSObject<_AFPCaptureInput> *)_create_:(REFTypeChannelMessenger *)messenger
;




@end

@interface _AFPCaptureSessionHandler : NSObject<REFTypeChannelHandler>

- (NSObject<_AFPCaptureSession> *)_create_:(REFTypeChannelMessenger *)messenger
;





- (id _Nullable)_addInput:(NSObject<_AFPCaptureSession> *)_instance

  input:(NSObject<_AFPCaptureInput> * _Nullable)input
;



- (id _Nullable)_addOutput:(NSObject<_AFPCaptureSession> *)_instance

  output:(NSObject<_AFPCaptureOutput> * _Nullable)output
;



- (id _Nullable)_startRunning:(NSObject<_AFPCaptureSession> *)_instance
;



- (id _Nullable)_stopRunning:(NSObject<_AFPCaptureSession> *)_instance
;



- (id _Nullable)_setSessionPreset:(NSObject<_AFPCaptureSession> *)_instance

  preset:(NSString * _Nullable)preset
;



- (id _Nullable)_canSetSessionPresets:(NSObject<_AFPCaptureSession> *)_instance

  presets:(NSArray<NSString *> * _Nullable)presets
;



- (id _Nullable)_canAddInput:(NSObject<_AFPCaptureSession> *)_instance

  input:(NSObject<_AFPCaptureInput> * _Nullable)input
;



- (id _Nullable)_removeInput:(NSObject<_AFPCaptureSession> *)_instance

  input:(NSObject<_AFPCaptureInput> * _Nullable)input
;



- (id _Nullable)_canAddOutput:(NSObject<_AFPCaptureSession> *)_instance

  output:(NSObject<_AFPCaptureOutput> * _Nullable)output
;



- (id _Nullable)_removeOutput:(NSObject<_AFPCaptureSession> *)_instance

  output:(NSObject<_AFPCaptureOutput> * _Nullable)output
;



- (id _Nullable)_isRunning:(NSObject<_AFPCaptureSession> *)_instance
;



- (id _Nullable)_isInterrupted:(NSObject<_AFPCaptureSession> *)_instance
;


@end

@interface _AFPCaptureDeviceHandler : NSObject<REFTypeChannelHandler>

- (NSObject<_AFPCaptureDevice> *)_create_:(REFTypeChannelMessenger *)messenger

                                  uniqueId:(NSString * _Nullable)uniqueId

                                  position:(NSNumber * _Nullable)position

                                  isSmoothAutoFocusSupported:(NSNumber * _Nullable)isSmoothAutoFocusSupported

                                  hasFlash:(NSNumber * _Nullable)hasFlash

                                  hasTorch:(NSNumber * _Nullable)hasTorch

                                  maxAvailableTorchLevel:(NSNumber * _Nullable)maxAvailableTorchLevel
;



- (id _Nullable)_defaultDeviceWithMediaType:(REFTypeChannelMessenger *)messenger

                           mediaType:(NSString * _Nullable)mediaType
;





- (id _Nullable)_lockForConfiguration:(NSObject<_AFPCaptureDevice> *)_instance
;



- (id _Nullable)_unlockForConfiguration:(NSObject<_AFPCaptureDevice> *)_instance
;



- (id _Nullable)_supportsCaptureSessionPresets:(NSObject<_AFPCaptureDevice> *)_instance

  presets:(NSArray<NSString *> * _Nullable)presets
;



- (id _Nullable)_isAdjustingExposure:(NSObject<_AFPCaptureDevice> *)_instance
;



- (id _Nullable)_setExposureMode:(NSObject<_AFPCaptureDevice> *)_instance

  mode:(NSNumber * _Nullable)mode
;



- (id _Nullable)_exposureModesSupported:(NSObject<_AFPCaptureDevice> *)_instance

  modes:(NSArray<NSNumber *> * _Nullable)modes
;



- (id _Nullable)_setFocusMode:(NSObject<_AFPCaptureDevice> *)_instance

  mode:(NSNumber * _Nullable)mode
;



- (id _Nullable)_focusModesSupported:(NSObject<_AFPCaptureDevice> *)_instance

  modes:(NSArray<NSNumber *> * _Nullable)modes
;



- (id _Nullable)_isAdjustingFocus:(NSObject<_AFPCaptureDevice> *)_instance
;



- (id _Nullable)_setSmoothAutoFocusEnabled:(NSObject<_AFPCaptureDevice> *)_instance

  enabled:(NSNumber * _Nullable)enabled
;



- (id _Nullable)_isFlashAvailable:(NSObject<_AFPCaptureDevice> *)_instance
;



- (id _Nullable)_setVideoZoomFactor:(NSObject<_AFPCaptureDevice> *)_instance

  factor:(NSNumber * _Nullable)factor
;



- (id _Nullable)_minAvailableVideoZoomFactor:(NSObject<_AFPCaptureDevice> *)_instance
;



- (id _Nullable)_maxAvailableVideoZoomFactor:(NSObject<_AFPCaptureDevice> *)_instance
;



- (id _Nullable)_rampToVideoZoomFactor:(NSObject<_AFPCaptureDevice> *)_instance

  factor:(NSNumber * _Nullable)factor

  rate:(NSNumber * _Nullable)rate
;



- (id _Nullable)_isRampingVideoZoom:(NSObject<_AFPCaptureDevice> *)_instance
;



- (id _Nullable)_cancelVideoZoomRamp:(NSObject<_AFPCaptureDevice> *)_instance
;



- (id _Nullable)_isTorchAvailable:(NSObject<_AFPCaptureDevice> *)_instance
;



- (id _Nullable)_isTorchActive:(NSObject<_AFPCaptureDevice> *)_instance
;



- (id _Nullable)_torchLevel:(NSObject<_AFPCaptureDevice> *)_instance
;



- (id _Nullable)_setTorchMode:(NSObject<_AFPCaptureDevice> *)_instance

  mode:(NSNumber * _Nullable)mode
;



- (id _Nullable)_torchModesSupported:(NSObject<_AFPCaptureDevice> *)_instance

  modes:(NSArray<NSNumber *> * _Nullable)modes
;



- (id _Nullable)_setTorchModeOnWithLevel:(NSObject<_AFPCaptureDevice> *)_instance

  torchLevel:(NSNumber * _Nullable)torchLevel
;


@end

@interface _AFPCaptureDeviceDiscoverySessionHandler : NSObject<REFTypeChannelHandler>

- (NSObject<_AFPCaptureDeviceDiscoverySession> *)_create_:(REFTypeChannelMessenger *)messenger

                                  devices:(NSArray<NSObject<_AFPCaptureDevice> *> * _Nullable)devices

                                  supportedMultiCamDeviceSets:(NSArray<NSArray<NSObject<_AFPCaptureDevice> *> *> * _Nullable)supportedMultiCamDeviceSets
;



- (id _Nullable)_discoverySessionWithDeviceTypes:(REFTypeChannelMessenger *)messenger

                           deviceTypes:(NSArray<NSString *> * _Nullable)deviceTypes

                           mediaType:(NSString * _Nullable)mediaType

                           position:(NSNumber * _Nullable)position
;




@end

@interface _AFPPreviewControllerHandler : NSObject<REFTypeChannelHandler>

- (NSObject<_AFPPreviewController> *)_create_:(REFTypeChannelMessenger *)messenger

                                  captureSession:(NSObject<_AFPCaptureSession> * _Nullable)captureSession
;




@end

@interface _AFPCaptureFileOutputHandler : NSObject<REFTypeChannelHandler>

- (NSObject<_AFPCaptureFileOutput> *)_create_:(REFTypeChannelMessenger *)messenger
;





- (id _Nullable)_outputFileURL:(NSObject<_AFPCaptureFileOutput> *)_instance
;



- (id _Nullable)_setMaxRecordedFileSize:(NSObject<_AFPCaptureFileOutput> *)_instance

  fileSize:(NSNumber * _Nullable)fileSize
;



- (id _Nullable)_isRecording:(NSObject<_AFPCaptureFileOutput> *)_instance
;



- (id _Nullable)_startRecordingToOutputFileURL:(NSObject<_AFPCaptureFileOutput> *)_instance

  outputFileURL:(NSString * _Nullable)outputFileURL

  delegate:(NSObject<_AFPCaptureFileOutputRecordingDelegate> * _Nullable)delegate
;



- (id _Nullable)_stopRecording:(NSObject<_AFPCaptureFileOutput> *)_instance
;


@end

@interface _AFPCaptureMovieFileOutputHandler : NSObject<REFTypeChannelHandler>

- (NSObject<_AFPCaptureMovieFileOutput> *)_create_:(REFTypeChannelMessenger *)messenger
;





- (id _Nullable)_availableVideoCodecTypes:(NSObject<_AFPCaptureMovieFileOutput> *)_instance
;


@end

@interface _AFPCaptureFileOutputRecordingDelegateHandler : NSObject<REFTypeChannelHandler>

- (NSObject<_AFPCaptureFileOutputRecordingDelegate> *)_create_:(REFTypeChannelMessenger *)messenger
;




@end

@interface _AFPCaptureConnectionHandler : NSObject<REFTypeChannelHandler>

- (NSObject<_AFPCaptureConnection> *)_create_:(REFTypeChannelMessenger *)messenger

                                  inputPorts:(NSArray<NSObject<_AFPCaptureInputPort> *> * _Nullable)inputPorts

                                  output:(NSObject<_AFPCaptureOutput> * _Nullable)output
;





- (id _Nullable)_setVideoOrientation:(NSObject<_AFPCaptureConnection> *)_instance

  orientation:(NSNumber * _Nullable)orientation
;



- (id _Nullable)_isVideoOrientationSupported:(NSObject<_AFPCaptureConnection> *)_instance
;



- (id _Nullable)_setAutomaticallyAdjustsVideoMirroring:(NSObject<_AFPCaptureConnection> *)_instance

  adjust:(NSNumber * _Nullable)adjust
;



- (id _Nullable)_setVideoMirrored:(NSObject<_AFPCaptureConnection> *)_instance

  mirrored:(NSNumber * _Nullable)mirrored
;



- (id _Nullable)_isVideoMirroringSupported:(NSObject<_AFPCaptureConnection> *)_instance
;


@end

@interface _AFPCaptureInputPortHandler : NSObject<REFTypeChannelHandler>

- (NSObject<_AFPCaptureInputPort> *)_create_:(REFTypeChannelMessenger *)messenger

                                  mediaType:(NSString * _Nullable)mediaType

                                  sourceDeviceType:(NSString * _Nullable)sourceDeviceType

                                  sourceDevicePosition:(NSNumber * _Nullable)sourceDevicePosition
;





- (id _Nullable)_setEnabled:(NSObject<_AFPCaptureInputPort> *)_instance

  enabled:(NSNumber * _Nullable)enabled
;


@end


@interface _AFPLibraryImplementations : NSObject
@property (readonly) REFTypeChannelMessenger *messenger;
-(instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

-(_AFPCapturePhotoOutputChannel *)channelCapturePhotoOutput;
-(_AFPCapturePhotoOutputHandler *)handlerCapturePhotoOutput;

-(_AFPCapturePhotoSettingsChannel *)channelCapturePhotoSettings;
-(_AFPCapturePhotoSettingsHandler *)handlerCapturePhotoSettings;

-(_AFPCapturePhotoCaptureDelegateChannel *)channelCapturePhotoCaptureDelegate;
-(_AFPCapturePhotoCaptureDelegateHandler *)handlerCapturePhotoCaptureDelegate;

-(_AFPCaptureOutputChannel *)channelCaptureOutput;
-(_AFPCaptureOutputHandler *)handlerCaptureOutput;

-(_AFPCapturePhotoChannel *)channelCapturePhoto;
-(_AFPCapturePhotoHandler *)handlerCapturePhoto;

-(_AFPCaptureDeviceInputChannel *)channelCaptureDeviceInput;
-(_AFPCaptureDeviceInputHandler *)handlerCaptureDeviceInput;

-(_AFPCaptureInputChannel *)channelCaptureInput;
-(_AFPCaptureInputHandler *)handlerCaptureInput;

-(_AFPCaptureSessionChannel *)channelCaptureSession;
-(_AFPCaptureSessionHandler *)handlerCaptureSession;

-(_AFPCaptureDeviceChannel *)channelCaptureDevice;
-(_AFPCaptureDeviceHandler *)handlerCaptureDevice;

-(_AFPCaptureDeviceDiscoverySessionChannel *)channelCaptureDeviceDiscoverySession;
-(_AFPCaptureDeviceDiscoverySessionHandler *)handlerCaptureDeviceDiscoverySession;

-(_AFPPreviewControllerChannel *)channelPreviewController;
-(_AFPPreviewControllerHandler *)handlerPreviewController;

-(_AFPCaptureFileOutputChannel *)channelCaptureFileOutput;
-(_AFPCaptureFileOutputHandler *)handlerCaptureFileOutput;

-(_AFPCaptureMovieFileOutputChannel *)channelCaptureMovieFileOutput;
-(_AFPCaptureMovieFileOutputHandler *)handlerCaptureMovieFileOutput;

-(_AFPCaptureFileOutputRecordingDelegateChannel *)channelCaptureFileOutputRecordingDelegate;
-(_AFPCaptureFileOutputRecordingDelegateHandler *)handlerCaptureFileOutputRecordingDelegate;

-(_AFPCaptureConnectionChannel *)channelCaptureConnection;
-(_AFPCaptureConnectionHandler *)handlerCaptureConnection;

-(_AFPCaptureInputPortChannel *)channelCaptureInputPort;
-(_AFPCaptureInputPortHandler *)handlerCaptureInputPort;



- (_AFPFinishProcessingPhotoCallbackChannel *)channelFinishProcessingPhotoCallback;
- (_AFPFinishProcessingPhotoCallbackHandler *)handlerFinishProcessingPhotoCallback;

@end

@interface _AFPChannelRegistrar : NSObject
@property (readonly) _AFPLibraryImplementations *implementations;
- (instancetype)initWithImplementation:(_AFPLibraryImplementations *)implementations;
- (void)registerHandlers;
- (void)unregisterHandlers;
@end

NS_ASSUME_NONNULL_END
