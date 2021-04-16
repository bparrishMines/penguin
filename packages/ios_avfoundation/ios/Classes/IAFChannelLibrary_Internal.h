// GENERATED CODE - DO NOT MODIFY BY HAND

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
@protocol _IAFPreviewController;

@protocol _IAFCapturePhotoOutput <NSObject>

- (NSObject *_Nullable)capturePhoto:(NSObject<_IAFCapturePhotoSettings> *_Nullable)settings delegate:(NSObject<_IAFCapturePhotoCaptureDelegate> *_Nullable)delegate;
@end
@protocol _IAFCapturePhotoSettings <NSObject>
- (NSDictionary<NSString *,NSObject *> *_Nullable)processedFormat;

@end
@protocol _IAFCapturePhotoCaptureDelegate <NSObject>

- (NSObject *_Nullable)didFinishProcessingPhoto:(NSObject<_IAFCapturePhoto> *_Nullable)photo ;
@end
@protocol _IAFCaptureOutput <NSObject>


@end
@protocol _IAFCapturePhoto <NSObject>
- (Uint8List? *_Nullable)fileDataRepresentation;

@end
@protocol _IAFCaptureDeviceInput <NSObject>
- (NSObject<_IAFCaptureDevice> *_Nullable)device;

@end
@protocol _IAFCaptureInput <NSObject>


@end
@protocol _IAFCaptureSession <NSObject>

- (NSObject *_Nullable)addInput:(NSObject<_IAFCaptureInput> *_Nullable)input ;
- (NSObject *_Nullable)addOutput:(NSObject<_IAFCaptureOutput> *_Nullable)output ;
- (NSObject *_Nullable)startRunning ;
- (NSObject *_Nullable)stopRunning ;
@end
@protocol _IAFCaptureDevice <NSObject>
- (NSString *_Nullable)uniqueId;
- (NSNumber *_Nullable)position;

@end
@protocol _IAFPreviewController <NSObject>
- (NSObject<_IAFCaptureSession> *_Nullable)captureSession;

@end

@interface _IAFCapturePhotoOutputCreationArgs : NSObject

@end
@interface _IAFCapturePhotoSettingsCreationArgs : NSObject
@property NSDictionary<NSString *,NSObject *> *_Nullable processedFormat;
@end
@interface _IAFCapturePhotoCaptureDelegateCreationArgs : NSObject

@end
@interface _IAFCaptureOutputCreationArgs : NSObject

@end
@interface _IAFCapturePhotoCreationArgs : NSObject
@property Uint8List? *_Nullable fileDataRepresentation;
@end
@interface _IAFCaptureDeviceInputCreationArgs : NSObject
@property NSObject<_IAFCaptureDevice> *_Nullable device;
@end
@interface _IAFCaptureInputCreationArgs : NSObject

@end
@interface _IAFCaptureSessionCreationArgs : NSObject

@end
@interface _IAFCaptureDeviceCreationArgs : NSObject
@property NSString *_Nullable uniqueId;
@property NSNumber *_Nullable position;
@end
@interface _IAFPreviewControllerCreationArgs : NSObject
@property NSObject<_IAFCaptureSession> *_Nullable captureSession;
@end

@interface _IAFCapturePhotoOutputChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)invoke_capturePhoto:(NSObject<_IAFCapturePhotoOutput> *)instance
            settings:(NSObject<_IAFCapturePhotoSettings> *_Nullable)settings
delegate:(NSObject<_IAFCapturePhotoCaptureDelegate> *_Nullable)delegate
                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
@end
@interface _IAFCapturePhotoSettingsChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;


@end
@interface _IAFCapturePhotoCaptureDelegateChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)invoke_didFinishProcessingPhoto:(NSObject<_IAFCapturePhotoCaptureDelegate> *)instance
            photo:(NSObject<_IAFCapturePhoto> *_Nullable)photo
                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
@end
@interface _IAFCaptureOutputChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;


@end
@interface _IAFCapturePhotoChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;


@end
@interface _IAFCaptureDeviceInputChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;


@end
@interface _IAFCaptureInputChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;


@end
@interface _IAFCaptureSessionChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)invoke_addInput:(NSObject<_IAFCaptureSession> *)instance
            input:(NSObject<_IAFCaptureInput> *_Nullable)input
                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
- (void)invoke_addOutput:(NSObject<_IAFCaptureSession> *)instance
            output:(NSObject<_IAFCaptureOutput> *_Nullable)output
                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
- (void)invoke_startRunning:(NSObject<_IAFCaptureSession> *)instance
            
                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
- (void)invoke_stopRunning:(NSObject<_IAFCaptureSession> *)instance
            
                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
@end
@interface _IAFCaptureDeviceChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;
- (void)invoke_devicesWithMediaType:(NSString *_Nullable)mediaType

                         completion:(void (^)(id _Nullable, NSError *_Nullable))completion;

@end
@interface _IAFPreviewControllerChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;


@end

@interface _IAFCapturePhotoOutputHandler : NSObject<REFTypeChannelHandler>
- (NSObject<_IAFCapturePhotoOutput> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(_IAFCapturePhotoOutputCreationArgs *)args;

@end
@interface _IAFCapturePhotoSettingsHandler : NSObject<REFTypeChannelHandler>
- (NSObject<_IAFCapturePhotoSettings> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(_IAFCapturePhotoSettingsCreationArgs *)args;

@end
@interface _IAFCapturePhotoCaptureDelegateHandler : NSObject<REFTypeChannelHandler>
- (NSObject<_IAFCapturePhotoCaptureDelegate> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(_IAFCapturePhotoCaptureDelegateCreationArgs *)args;

@end
@interface _IAFCaptureOutputHandler : NSObject<REFTypeChannelHandler>
- (NSObject<_IAFCaptureOutput> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(_IAFCaptureOutputCreationArgs *)args;

@end
@interface _IAFCapturePhotoHandler : NSObject<REFTypeChannelHandler>
- (NSObject<_IAFCapturePhoto> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(_IAFCapturePhotoCreationArgs *)args;

@end
@interface _IAFCaptureDeviceInputHandler : NSObject<REFTypeChannelHandler>
- (NSObject<_IAFCaptureDeviceInput> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(_IAFCaptureDeviceInputCreationArgs *)args;

@end
@interface _IAFCaptureInputHandler : NSObject<REFTypeChannelHandler>
- (NSObject<_IAFCaptureInput> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(_IAFCaptureInputCreationArgs *)args;

@end
@interface _IAFCaptureSessionHandler : NSObject<REFTypeChannelHandler>
- (NSObject<_IAFCaptureSession> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(_IAFCaptureSessionCreationArgs *)args;

@end
@interface _IAFCaptureDeviceHandler : NSObject<REFTypeChannelHandler>
- (NSObject<_IAFCaptureDevice> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(_IAFCaptureDeviceCreationArgs *)args;
- (NSObject *_Nullable)on_devicesWithMediaType:(REFTypeChannelMessenger *)messenger
                             mediaType:(NSString *_Nullable)mediaType;
@end
@interface _IAFPreviewControllerHandler : NSObject<REFTypeChannelHandler>
- (NSObject<_IAFPreviewController> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(_IAFPreviewControllerCreationArgs *)args;

@end

@protocol _IAFLibraryImplementations
-(_IAFCapturePhotoOutputChannel *)capturePhotoOutputChannel;
-(_IAFCapturePhotoSettingsChannel *)capturePhotoSettingsChannel;
-(_IAFCapturePhotoCaptureDelegateChannel *)capturePhotoCaptureDelegateChannel;
-(_IAFCaptureOutputChannel *)captureOutputChannel;
-(_IAFCapturePhotoChannel *)capturePhotoChannel;
-(_IAFCaptureDeviceInputChannel *)captureDeviceInputChannel;
-(_IAFCaptureInputChannel *)captureInputChannel;
-(_IAFCaptureSessionChannel *)captureSessionChannel;
-(_IAFCaptureDeviceChannel *)captureDeviceChannel;
-(_IAFPreviewControllerChannel *)previewControllerChannel;
-(_IAFCapturePhotoOutputHandler *)capturePhotoOutputHandler;
-(_IAFCapturePhotoSettingsHandler *)capturePhotoSettingsHandler;
-(_IAFCapturePhotoCaptureDelegateHandler *)capturePhotoCaptureDelegateHandler;
-(_IAFCaptureOutputHandler *)captureOutputHandler;
-(_IAFCapturePhotoHandler *)capturePhotoHandler;
-(_IAFCaptureDeviceInputHandler *)captureDeviceInputHandler;
-(_IAFCaptureInputHandler *)captureInputHandler;
-(_IAFCaptureSessionHandler *)captureSessionHandler;
-(_IAFCaptureDeviceHandler *)captureDeviceHandler;
-(_IAFPreviewControllerHandler *)previewControllerHandler;
@end

@interface _IAFChannelRegistrar : NSObject
@property (readonly) id<_IAFLibraryImplementations> implementations;
- (instancetype)initWithImplementation:(id<_IAFLibraryImplementations>)implementations;
-(void)registerHandlers;
-(void)unregisterHandlers;
@end

NS_ASSUME_NONNULL_END
