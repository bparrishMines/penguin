#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import av_foundation;

@interface AFPPreviewControllerTests : XCTestCase

@end

@implementation AFPPreviewControllerTests {
  AVCaptureSession *_mockCaptureSession;
  AFPCaptureSessionProxy *_testCaptureSessionProxy;
  REFTypeChannelMessenger *_mockTypeChannelMessenger;
}

- (void)setUp {
  _mockCaptureSession = OCMClassMock([AVCaptureSession class]);
  _mockTypeChannelMessenger = OCMClassMock([REFTypeChannelMessenger class]);
  _testCaptureSessionProxy = [[AFPCaptureSessionProxy alloc] initWithCaptureSession:_mockCaptureSession];
}

// Throws an exception when adding session to layer.
- (void)testCreatePreviewController {
  AFPLibraryImplementations *implementations = [[AFPLibraryImplementations alloc]
                                                initWithMessenger:_mockTypeChannelMessenger];
  
  XCTAssertNoThrowSpecificNamed([implementations.handlerPreviewController _create_:_mockTypeChannelMessenger
                                                      captureSession:_testCaptureSessionProxy], NSException, @"_AFPUnimplementedException");
}
@end
