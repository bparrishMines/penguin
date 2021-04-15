#import <Foundation/Foundation.h>

#import "IAFChannelLibrary_Internal.h"
#import "REFTypeChannel.h"
#import "IAFFoundation.h"

@class IAFCaptureSessionProxy;
@class IAFCaptureDeviceProxy;
@class IAFCaptureDeviceInputProxy;
@class IAFPreviewControllerProxy;
@class IAFCaptureInputProxy;

NS_ASSUME_NONNULL_BEGIN

@interface IAFChannelRegistrar : _IAFChannelRegistrar
@end

@interface IAFLibraryImplementations : NSObject<_IAFLibraryImplementations>
-(instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;
@end

@interface IAFCaptureDeviceInputChannel : _IAFCaptureDeviceInputChannel
@end

@interface IAFCaptureSessionChannel : _IAFCaptureSessionChannel
@end

@interface IAFCaptureDeviceChannel : _IAFCaptureDeviceChannel
@end

@interface IAFPreviewControllerChannel : _IAFPreviewControllerChannel
@end

@interface IAFCaptureInputChannel : _IAFCaptureInputChannel
@end

@interface IAFCaptureDeviceInputHandler : _IAFCaptureDeviceInputHandler
@end

@interface IAFCaptureDeviceHandler : _IAFCaptureDeviceHandler
- (instancetype)initWithImplementations:(IAFLibraryImplementations *)implementations;
@end

@interface IAFCaptureSessionHandler : _IAFCaptureSessionHandler
@end

@interface IAFPreviewControllerHandler : _IAFPreviewControllerHandler
@end

@interface IAFCaptureInputHandler : _IAFCaptureInputHandler
@end

NS_ASSUME_NONNULL_END
