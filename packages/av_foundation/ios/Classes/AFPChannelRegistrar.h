#import <Foundation/Foundation.h>

#import "AFPChannelLibrary_Internal.h"
#import "REFTypeChannel.h"
#import "AFPFoundation.h"

NS_ASSUME_NONNULL_BEGIN

@interface AFPChannelRegistrar : _AFPChannelRegistrar
@end

@interface AFPLibraryImplementations : _AFPLibraryImplementations
@end

@interface AFPCaptureDeviceInputHandler : _AFPCaptureDeviceInputHandler
@end

@interface AFPCaptureDeviceHandler : _AFPCaptureDeviceHandler
- (instancetype)initWithImplementations:(AFPLibraryImplementations *)implementations;
@end

@interface AFPCaptureSessionHandler : _AFPCaptureSessionHandler
@end

@interface AFPPreviewControllerHandler : _AFPPreviewControllerHandler
@end

@interface AFPCapturePhotoCaptureDelegateHandler : _AFPCapturePhotoCaptureDelegateHandler
- (instancetype)initWithImplementations:(AFPLibraryImplementations *)implementations;
@end

@interface AFPCapturePhotoSettingsHandler : _AFPCapturePhotoSettingsHandler
@end

@interface AFPCapturePhotoOutputHandler : _AFPCapturePhotoOutputHandler
- (instancetype)initWithImplementations:(AFPLibraryImplementations *)implementations;
@end

@interface AFPCaptureDeviceDiscoverySessionHandler : _AFPCaptureDeviceDiscoverySessionHandler
- (instancetype)initWithImplementations:(AFPLibraryImplementations *)implementations;
@end

@interface AFPCaptureMovieFileOutputHandler : _AFPCaptureMovieFileOutputHandler
- (instancetype)initWithImplementations:(AFPLibraryImplementations *)implementations;
@end

@interface AFPCaptureFileOutputRecordingDelegateHandler : _AFPCaptureFileOutputRecordingDelegateHandler
@end

@interface AFPCaptureConnectionHandler : _AFPCaptureConnectionHandler
@end
NS_ASSUME_NONNULL_END
