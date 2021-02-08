#import "REFMethodChannel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PCM_CaptureDeviceInput;
@protocol PCM_CaptureSession;
@protocol PCM_CaptureDevice;
@protocol PCM_PreviewController;

@protocol PCM_CaptureDeviceInput <NSObject>
- (NSObject<PCM_CaptureDevice> *_Nullable)device;

@end
@protocol PCM_CaptureSession <NSObject>
- (NSArray<NSObject<PCM_CaptureDeviceInput> *> *_Nullable)inputs;
- (NSObject *_Nullable)startRunning ;
- (NSObject *_Nullable)stopRunning ;
@end
@protocol PCM_CaptureDevice <NSObject>
- (NSString *_Nullable)uniqueId;
- (NSNumber *_Nullable)position;

@end
@protocol PCM_PreviewController <NSObject>
- (NSObject<PCM_CaptureSession> *_Nullable)captureSession;

@end

@interface PCM_CaptureDeviceInputCreationArgs : NSObject
@property NSObject<PCM_CaptureDevice> *_Nullable device;
@end
@interface PCM_CaptureSessionCreationArgs : NSObject
@property NSArray<NSObject<PCM_CaptureDeviceInput> *> *_Nullable inputs;
@end
@interface PCM_CaptureDeviceCreationArgs : NSObject
@property NSString *_Nullable uniqueId;
@property NSNumber *_Nullable position;
@end
@interface PCM_PreviewControllerCreationArgs : NSObject
@property NSObject<PCM_CaptureSession> *_Nullable captureSession;
@end

@interface PCM_CaptureDeviceInputChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;


@end
@interface PCM_CaptureSessionChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;

- (void)invoke_startRunning:(NSObject<PCM_CaptureSession> *)instance
            
                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
- (void)invoke_stopRunning:(NSObject<PCM_CaptureSession> *)instance
            
                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
@end
@interface PCM_CaptureDeviceChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;
- (void)invoke_devicesWithMediaType:(NSString *_Nullable)mediaType

                         completion:(void (^)(id _Nullable, NSError *_Nullable))completion;

@end
@interface PCM_PreviewControllerChannel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;


@end

@interface PCM_CaptureDeviceInputHandler : NSObject<REFTypeChannelHandler>
- (NSObject<PCM_CaptureDeviceInput> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(PCM_CaptureDeviceInputCreationArgs *)args;

@end
@interface PCM_CaptureSessionHandler : NSObject<REFTypeChannelHandler>
- (NSObject<PCM_CaptureSession> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(PCM_CaptureSessionCreationArgs *)args;

@end
@interface PCM_CaptureDeviceHandler : NSObject<REFTypeChannelHandler>
- (NSObject<PCM_CaptureDevice> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(PCM_CaptureDeviceCreationArgs *)args;
- (NSObject *_Nullable)on_devicesWithMediaType:(REFTypeChannelMessenger *)messenger
                             mediaType:(NSString *_Nullable)mediaType;
@end
@interface PCM_PreviewControllerHandler : NSObject<REFTypeChannelHandler>
- (NSObject<PCM_PreviewController> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(PCM_PreviewControllerCreationArgs *)args;

@end

NS_ASSUME_NONNULL_END
