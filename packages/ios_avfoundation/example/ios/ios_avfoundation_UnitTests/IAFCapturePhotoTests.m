#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import ios_avfoundation;

@interface IAFCapturePhotoTests : XCTestCase

@end

@implementation IAFCapturePhotoTests {
  IAFLibraryImplementations *_mockImplementations;
  _IAFCapturePhotoChannel *_mockCapturePhotoChannel;
}

- (void)setUp {
  _mockImplementations = OCMClassMock([IAFLibraryImplementations class]);
  _mockCapturePhotoChannel = OCMClassMock([_IAFCapturePhotoChannel class]);
  OCMStub([_mockImplementations channelCapturePhoto]).andReturn(_mockCapturePhotoChannel);
}

- (void)testCreateCapturePhoto {
  AVCapturePhoto *mockCapturePhoto = OCMClassMock([AVCapturePhoto class]);
  NSData *mockData = OCMClassMock([NSData class]);
  OCMStub([mockCapturePhoto fileDataRepresentation]).andReturn(mockData);
  
  IAFCapturePhotoProxy *capturePhotoProxy = [[IAFCapturePhotoProxy alloc] initWithCapturePhoto:mockCapturePhoto
                                                                               implementations:_mockImplementations];
  OCMVerify([_mockCapturePhotoChannel __create:capturePhotoProxy _owner:NO fileDataRepresentation:mockData completion:OCMOCK_ANY]);
}
@end
