#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import av_foundation;

@interface AFPCapturePhotoTests : XCTestCase

@end

@implementation AFPCapturePhotoTests {
  AFPLibraryImplementations *_mockImplementations;
  _AFPCapturePhotoChannel *_mockCapturePhotoChannel;
}

- (void)setUp {
  _mockImplementations = OCMClassMock([AFPLibraryImplementations class]);
  _mockCapturePhotoChannel = OCMClassMock([_AFPCapturePhotoChannel class]);
  OCMStub([_mockImplementations channelCapturePhoto]).andReturn(_mockCapturePhotoChannel);
}

- (void)testCreateCapturePhoto {
  AVCapturePhoto *mockCapturePhoto = OCMClassMock([AVCapturePhoto class]);
  NSData *mockData = OCMClassMock([NSData class]);
  OCMStub([mockCapturePhoto fileDataRepresentation]).andReturn(mockData);
  
  AFPCapturePhotoProxy *capturePhotoProxy = [[AFPCapturePhotoProxy alloc] initWithCapturePhoto:mockCapturePhoto
                                                                               implementations:_mockImplementations];
  OCMVerify([_mockCapturePhotoChannel _create_:capturePhotoProxy _owner:NO fileDataRepresentation:mockData completion:OCMOCK_ANY]);
}
@end
