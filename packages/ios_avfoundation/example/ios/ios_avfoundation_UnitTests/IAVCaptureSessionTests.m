#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import ios_avfoundation;

@interface IAVCaptureSessionTests : XCTestCase
@end

@implementation IAVCaptureSessionTests {
  AVCaptureSession *_mockCaptureSession;
  IAFCaptureSessionProxy *_testCaptureSessionProxy;
}

- (void)setUp {
  _mockCaptureSession = OCMClassMock([AVCaptureSession class]);
  _testCaptureSessionProxy = [[IAFCaptureSessionProxy alloc] initWithCaptureSession:_mockCaptureSession];
}

- (void)testStartRunning {
  [_testCaptureSessionProxy startRunning];
  OCMVerify([_mockCaptureSession startRunning]);
}

- (void)testStopRunning {
  [_testCaptureSessionProxy stopRunning];
  OCMVerify([_mockCaptureSession stopRunning]);
}

- (void)testAddInput {
  id mockCaptureInput = OCMClassMock([AVCaptureInput class]);
  IAFCaptureInputProxy *testCaptureInputProxy = [[IAFCaptureInputProxy alloc] initWithCaptureInput:mockCaptureInput];
  
  [_testCaptureSessionProxy addInput:testCaptureInputProxy];
  OCMVerify([_mockCaptureSession addInput:mockCaptureInput]);
}
@end
