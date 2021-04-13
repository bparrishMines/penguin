// GENERATED CODE - DO NOT MODIFY BY HAND

#import "REFMethodChannel.h"

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

NS_ASSUME_NONNULL_BEGIN

@protocol _IAFCaptureDeviceInput;
@protocol _IAFCaptureInput;
@protocol _IAFCaptureSession;
@protocol _IAFCaptureDevice;
@protocol _IAFPreviewController;

@protocol _IAFCaptureDeviceInput <NSObject>
- (NSObject<_IAFCaptureDevice> *_Nullable)device;

@end
@protocol _IAFCaptureInput <NSObject>


@end
@protocol _IAFCaptureSession <NSObject>

- (NSObject *_Nullable)addInput:(NSObject<_IAFCaptureInput> *_Nullable)input ;
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
-(captureDeviceInputChannel *)CaptureDeviceInputChannel;
-(captureInputChannel *)CaptureInputChannel;
-(captureSessionChannel *)CaptureSessionChannel;
-(captureDeviceChannel *)CaptureDeviceChannel;
-(previewControllerChannel *)PreviewControllerChannel;
-(captureDeviceInputHandler *)CaptureDeviceInputHandler;
-(captureInputHandler *)CaptureInputHandler;
-(captureSessionHandler *)CaptureSessionHandler;
-(captureDeviceHandler *)CaptureDeviceHandler;
-(previewControllerHandler *)PreviewControllerHandler;
@end

@interface _IAFChannelRegistrar : NSObject
@property (readonly) id<REFLibraryImplementations> implementations;
- (instancetype)initWithImplementation:(id<REFLibraryImplementations>)implementations;
-(void)registerHandlers;
-(void)unregisterHandlers;
@end

NS_ASSUME_NONNULL_END
