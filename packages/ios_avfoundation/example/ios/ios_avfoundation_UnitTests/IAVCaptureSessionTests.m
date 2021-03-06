#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import ios_avfoundation;

@interface IAVCaptureSessionTests : XCTestCase
@end

@implementation IAVCaptureSessionTests {
  AVCaptureSession *_mockCaptureSession;
  IAFCaptureSessionProxy *_testCaptureSessionProxy;
  REFTypeChannelMessenger *_mockTypeChannelMessenger;
}

- (void)setUp {
  _mockCaptureSession = OCMClassMock([AVCaptureSession class]);
  _mockTypeChannelMessenger = OCMClassMock([REFTypeChannelMessenger class]);
  _testCaptureSessionProxy = [[IAFCaptureSessionProxy alloc] initWithCaptureSession:_mockCaptureSession];
}

- (void)testCreateCaptureSession {
  IAFLibraryImplementations *implementations = [[IAFLibraryImplementations alloc]
                                                initWithMessenger:_mockTypeChannelMessenger];

  IAFCaptureSessionProxy *captureSessionProxy = (IAFCaptureSessionProxy *) [implementations.handlerCaptureSession _create_:_mockTypeChannelMessenger];
  
  XCTAssertNotNil(captureSessionProxy);
  XCTAssertNotNil(captureSessionProxy.captureSession);
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

- (void)testAddOutput {
  id mockCaptureOutput = OCMClassMock([AVCaptureOutput class]);
  IAFCaptureOutputProxy *testCaptureOutputProxy = [[IAFCaptureOutputProxy alloc]
                                                  initWithCaptureOutput:mockCaptureOutput];
  
  [_testCaptureSessionProxy addOutput:testCaptureOutputProxy];
  OCMVerify([_mockCaptureSession addOutput:mockCaptureOutput]);
}

- (void)testSetSessionPreset {
  [_testCaptureSessionProxy setSessionPreset:AVCaptureSessionPresetMedium];
  OCMVerify([_mockCaptureSession setSessionPreset:AVCaptureSessionPresetMedium]);
}

- (void)testCanSetSessionPreset {
  OCMStub([_mockCaptureSession canSetSessionPreset:AVCaptureSessionPresetMedium]).andReturn(YES);
  OCMStub([_mockCaptureSession canSetSessionPreset:AVCaptureSessionPresetLow]).andReturn(NO);

  NSArray<NSString *> *validPresets = [_testCaptureSessionProxy canSetSessionPresets:@[AVCaptureSessionPresetMedium, AVCaptureSessionPresetLow]];
  XCTAssertEqualObjects(validPresets, @[AVCaptureSessionPresetMedium]);
}
@end
