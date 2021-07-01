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


- (id _Nullable)capturePhoto
                                :(NSObject<_IAFCapturePhotoSettings> * _Nullable)settings


     delegate:(NSObject<_IAFCapturePhotoCaptureDelegate> * _Nullable)delegate

;


@end

@protocol _IAFCapturePhotoSettings <NSObject>

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


@end

@protocol _IAFCaptureDevice <NSObject>

@end

@protocol _IAFCaptureDeviceDiscoverySession <NSObject>

@end

@protocol _IAFPreviewController <NSObject>

@end



@interface _IAFCapturePhotoOutputChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;
- (void)__create:(NSObject<_IAFCapturePhotoOutput> *)_instance
          _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;






@end

@interface _IAFCapturePhotoSettingsChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;
- (void)__create:(NSObject<_IAFCapturePhotoSettings> *)_instance
          _owner:(BOOL)_owner

 processedFormat:(NSDictionary<NSString *, NSObject *> * _Nullable)processedFormat

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;




@end

@interface _IAFCapturePhotoCaptureDelegateChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;
- (void)__create:(NSObject<_IAFCapturePhotoCaptureDelegate> *)_instance
          _owner:(BOOL)_owner

 didFinishProcessingPhoto:(_IAFFinishProcessingPhotoCallback _Nullable)didFinishProcessingPhoto

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;




@end

@interface _IAFCaptureOutputChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;
- (void)__create:(NSObject<_IAFCaptureOutput> *)_instance
          _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;




@end

@interface _IAFCapturePhotoChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;
- (void)__create:(NSObject<_IAFCapturePhoto> *)_instance
          _owner:(BOOL)_owner

 fileDataRepresentation:(NSData * _Nullable)fileDataRepresentation

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;




@end

@interface _IAFCaptureDeviceInputChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;
- (void)__create:(NSObject<_IAFCaptureDeviceInput> *)_instance
          _owner:(BOOL)_owner

 device:(NSObject<_IAFCaptureDevice> * _Nullable)device

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;




@end

@interface _IAFCaptureInputChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;
- (void)__create:(NSObject<_IAFCaptureInput> *)_instance
          _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;




@end

@interface _IAFCaptureSessionChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;
- (void)__create:(NSObject<_IAFCaptureSession> *)_instance
          _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;












@end

@interface _IAFCaptureDeviceChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;
- (void)__create:(NSObject<_IAFCaptureDevice> *)_instance
          _owner:(BOOL)_owner

 uniqueId:(NSString * _Nullable)uniqueId

 position:(NSNumber * _Nullable)position

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;






@end

@interface _IAFCaptureDeviceDiscoverySessionChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;
- (void)__create:(NSObject<_IAFCaptureDeviceDiscoverySession> *)_instance
          _owner:(BOOL)_owner

 devices:(NSArray<NSObject<_IAFCaptureDevice> *> * _Nullable)devices

 supportedMultiCamDeviceSets:(NSArray<NSArray<NSObject<_IAFCaptureDevice> *> *> * _Nullable)supportedMultiCamDeviceSets

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;






@end

@interface _IAFPreviewControllerChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;
- (void)__create:(NSObject<_IAFPreviewController> *)_instance
          _owner:(BOOL)_owner

 captureSession:(NSObject<_IAFCaptureSession> * _Nullable)captureSession

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;




@end



@interface _IAFCapturePhotoOutputHandler : NSObject<REFTypeChannelHandler>
- (NSObject<_IAFCapturePhotoOutput> *)__create:(REFTypeChannelMessenger *)messenger
;




- (id _Nullable)_capturePhoto:(NSObject<_IAFCapturePhotoOutput> *)_instance

  settings:(NSObject<_IAFCapturePhotoSettings> * _Nullable)settings

  delegate:(NSObject<_IAFCapturePhotoCaptureDelegate> * _Nullable)delegate
;


@end

@interface _IAFCapturePhotoSettingsHandler : NSObject<REFTypeChannelHandler>
- (NSObject<_IAFCapturePhotoSettings> *)__create:(REFTypeChannelMessenger *)messenger

                                  processedFormat:(NSDictionary<NSString *, NSObject *> * _Nullable)processedFormat
;



@end

@interface _IAFCapturePhotoCaptureDelegateHandler : NSObject<REFTypeChannelHandler>
- (NSObject<_IAFCapturePhotoCaptureDelegate> *)__create:(REFTypeChannelMessenger *)messenger

                                  didFinishProcessingPhoto:(_IAFFinishProcessingPhotoCallback _Nullable)didFinishProcessingPhoto
;



@end

@interface _IAFCaptureOutputHandler : NSObject<REFTypeChannelHandler>
- (NSObject<_IAFCaptureOutput> *)__create:(REFTypeChannelMessenger *)messenger
;



@end

@interface _IAFCapturePhotoHandler : NSObject<REFTypeChannelHandler>
- (NSObject<_IAFCapturePhoto> *)__create:(REFTypeChannelMessenger *)messenger

                                  fileDataRepresentation:(NSData * _Nullable)fileDataRepresentation
;



@end

@interface _IAFCaptureDeviceInputHandler : NSObject<REFTypeChannelHandler>
- (NSObject<_IAFCaptureDeviceInput> *)__create:(REFTypeChannelMessenger *)messenger

                                  device:(NSObject<_IAFCaptureDevice> * _Nullable)device
;



@end

@interface _IAFCaptureInputHandler : NSObject<REFTypeChannelHandler>
- (NSObject<_IAFCaptureInput> *)__create:(REFTypeChannelMessenger *)messenger
;



@end

@interface _IAFCaptureSessionHandler : NSObject<REFTypeChannelHandler>
- (NSObject<_IAFCaptureSession> *)__create:(REFTypeChannelMessenger *)messenger
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


@end

@interface _IAFCaptureDeviceHandler : NSObject<REFTypeChannelHandler>
- (NSObject<_IAFCaptureDevice> *)__create:(REFTypeChannelMessenger *)messenger

                                  uniqueId:(NSString * _Nullable)uniqueId

                                  position:(NSNumber * _Nullable)position
;


- (id _Nullable)_devicesWithMediaType:(REFTypeChannelMessenger *)messenger

                           mediaType:(NSString * _Nullable)mediaType
;




@end

@interface _IAFCaptureDeviceDiscoverySessionHandler : NSObject<REFTypeChannelHandler>
- (NSObject<_IAFCaptureDeviceDiscoverySession> *)__create:(REFTypeChannelMessenger *)messenger

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
- (NSObject<_IAFPreviewController> *)__create:(REFTypeChannelMessenger *)messenger

                                  captureSession:(NSObject<_IAFCaptureSession> * _Nullable)captureSession
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
