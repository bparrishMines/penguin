#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import ios_avfoundation;

@interface IAFPreviewControllerTests : XCTestCase

@end

@implementation IAFPreviewControllerTests {
  AVCaptureSession *_mockCaptureSession;
  IAFCaptureSessionProxy *_testCaptureSessionProxy;
  REFTypeChannelMessenger *_mockTypeChannelMessenger;
}

- (void)setUp {
  _mockCaptureSession = OCMClassMock([AVCaptureSession class]);
  _mockTypeChannelMessenger = OCMClassMock([REFTypeChannelMessenger class]);
  _testCaptureSessionProxy = [[IAFCaptureSessionProxy alloc] initWithCaptureSession:_mockCaptureSession];
}

// Throws an exception when adding session to layer.
- (void)testCreatePreviewController {
  IAFLibraryImplementations *implementations = [[IAFLibraryImplementations alloc]
                                                initWithMessenger:_mockTypeChannelMessenger];
  
  XCTAssertNoThrowSpecificNamed([implementations.handlerPreviewController _create_:_mockTypeChannelMessenger
                                                      captureSession:_testCaptureSessionProxy], NSException, @"_IAFUnimplementedException");
}
@end
