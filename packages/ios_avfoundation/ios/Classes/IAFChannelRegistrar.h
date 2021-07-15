#import <Foundation/Foundation.h>

#import "IAFChannelLibrary_Internal.h"
#import "REFTypeChannel.h"
#import "IAFFoundation.h"

NS_ASSUME_NONNULL_BEGIN

@interface IAFChannelRegistrar : _IAFChannelRegistrar
@end

@interface IAFLibraryImplementations : _IAFLibraryImplementations
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

@interface IAFCapturePhotoCaptureDelegateHandler : _IAFCapturePhotoCaptureDelegateHandler
- (instancetype)initWithImplementations:(IAFLibraryImplementations *)implementations;
@end

@interface IAFCapturePhotoSettingsHandler : _IAFCapturePhotoSettingsHandler
@end

@interface IAFCapturePhotoOutputHandler : _IAFCapturePhotoOutputHandler
@end

@interface IAFCaptureDeviceDiscoverySessionHandler : _IAFCaptureDeviceDiscoverySessionHandler
- (instancetype)initWithImplementations:(IAFLibraryImplementations *)implementations;
@end

@interface IAFCaptureMovieFileOutputHandler : _IAFCaptureMovieFileOutputHandler
@end

@interface IAFCaptureFileOutputRecordingDelegateHandler : _IAFCaptureFileOutputRecordingDelegateHandler
@end

@interface IAFCaptureConnectionHandler : _IAFCaptureConnectionHandler
@end
NS_ASSUME_NONNULL_END
