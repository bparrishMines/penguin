#import "REFMethodChannel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GENIAVCaptureDeviceInput;
@protocol GENIAVCaptureSession;
@protocol GENIAVCaptureDevice;
@protocol GENIAVPreviewController;

@protocol GENIAVCaptureDeviceInput <NSObject>
- (NSObject<GENIAVCaptureDevice> *_Nullable)device;

@end
@protocol GENIAVCaptureSession <NSObject>
- (NSArray<NSObject<GENIAVCaptureDeviceInput> *> *_Nullable)inputs;
- (NSObject *_Nullable)startRunning ;
- (NSObject *_Nullable)stopRunning ;
@end
@protocol GENIAVCaptureDevice <NSObject>
- (NSString *_Nullable)uniqueId;
- (NSNumber *_Nullable)position;

@end
@protocol GENIAVPreviewController <NSObject>
- (NSObject<GENIAVCaptureSession> *_Nullable)captureSession;

@end

@interface GENIAVCaptureDeviceInputCreationArgs : NSObject
@property NSObject<GENIAVCaptureDevice> *_Nullable device;
@end
@interface GENIAVCaptureSessionCreationArgs : NSObject
@property NSArray<NSObject<GENIAVCaptureDeviceInput> *> *_Nullable inputs;
@end
@interface GENIAVCaptureDeviceCreationArgs : NSObject
@property NSString *_Nullable uniqueId;
@property NSNumber *_Nullable position;
@end
@interface GENIAVPreviewControllerCreationArgs : NSObject
@property NSObject<GENIAVCaptureSession> *_Nullable captureSession;
@end

@interface GENIAVCaptureDeviceInputChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;


@end
@interface GENIAVCaptureSessionChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)invoke_startRunning:(NSObject<GENIAVCaptureSession> *)instance
            
                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
- (void)invoke_stopRunning:(NSObject<GENIAVCaptureSession> *)instance
            
                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
@end
@interface GENIAVCaptureDeviceChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;
- (void)invoke_devicesWithMediaType:(NSString *_Nullable)mediaType

                         completion:(void (^)(id _Nullable, NSError *_Nullable))completion;

@end
@interface GENIAVPreviewControllerChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;


@end

@interface GENIAVCaptureDeviceInputHandler : NSObject<REFTypeChannelHandler>
- (NSObject<GENIAVCaptureDeviceInput> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(GENIAVCaptureDeviceInputCreationArgs *)args;

@end
@interface GENIAVCaptureSessionHandler : NSObject<REFTypeChannelHandler>
- (NSObject<GENIAVCaptureSession> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(GENIAVCaptureSessionCreationArgs *)args;

@end
@interface GENIAVCaptureDeviceHandler : NSObject<REFTypeChannelHandler>
- (NSObject<GENIAVCaptureDevice> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(GENIAVCaptureDeviceCreationArgs *)args;
- (NSObject *_Nullable)on_devicesWithMediaType:(REFTypeChannelMessenger *)messenger
                             mediaType:(NSString *_Nullable)mediaType;
@end
@interface GENIAVPreviewControllerHandler : NSObject<REFTypeChannelHandler>
- (NSObject<GENIAVPreviewController> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(GENIAVPreviewControllerCreationArgs *)args;

@end

NS_ASSUME_NONNULL_END
