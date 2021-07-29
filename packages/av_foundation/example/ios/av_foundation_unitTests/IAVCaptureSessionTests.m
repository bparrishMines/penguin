#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import av_foundation;

@interface IAVCaptureSessionTests : XCTestCase
@end

@implementation IAVCaptureSessionTests {
  AVCaptureSession *_mockCaptureSession;
  AFPLibraryImplementations *_mockImplementations;
  AFPCaptureSessionProxy *_testCaptureSessionProxy;
  REFTypeChannelMessenger *_mockTypeChannelMessenger;
}

- (void)setUp {
  _mockImplementations = OCMClassMock([AFPLibraryImplementations class]);
  _mockCaptureSession = OCMClassMock([AVCaptureSession class]);
  _mockTypeChannelMessenger = OCMClassMock([REFTypeChannelMessenger class]);
  _testCaptureSessionProxy = [[AFPCaptureSessionProxy alloc] initWithCaptureSession:_mockCaptureSession];
}

- (void)testCreateCaptureSession {
  AFPLibraryImplementations *implementations = [[AFPLibraryImplementations alloc]
                                                initWithMessenger:_mockTypeChannelMessenger];

  AFPCaptureSessionProxy *captureSessionProxy = (AFPCaptureSessionProxy *) [implementations.handlerCaptureSession _create_:_mockTypeChannelMessenger];
  
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
  AFPCaptureInputProxy *testCaptureInputProxy = [[AFPCaptureInputProxy alloc] initWithCaptureInput:mockCaptureInput];
  
  [_testCaptureSessionProxy addInput:testCaptureInputProxy];
  OCMVerify([_mockCaptureSession addInput:mockCaptureInput]);
}

- (void)testAddOutput {
  id mockCaptureOutput = OCMClassMock([AVCaptureOutput class]);
  AFPCaptureOutputProxy *testCaptureOutputProxy = [[AFPCaptureOutputProxy alloc]
                                                  initWithCaptureOutput:mockCaptureOutput implementations:_mockImplementations];
  
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

- (void)testCanAddInput {
  OCMStub([_mockCaptureSession canAddInput:OCMOCK_ANY]).andReturn(NO);
  XCTAssertEqualObjects([_testCaptureSessionProxy canAddInput:nil], @(NO));
}

- (void)testCanAddOutput {
  OCMStub([_mockCaptureSession canAddOutput:OCMOCK_ANY]).andReturn(YES);
  XCTAssertEqualObjects([_testCaptureSessionProxy canAddOutput:nil], @(YES));
}


- (void)testIsInterrupted {
  OCMStub([_mockCaptureSession isInterrupted]).andReturn(NO);
  XCTAssertEqualObjects([_testCaptureSessionProxy isInterrupted], @(NO));
}


- (void)testIsRunning {
  OCMStub([_mockCaptureSession isRunning]).andReturn(YES);
  XCTAssertEqualObjects([_testCaptureSessionProxy isRunning], @(YES));
}

- (void)testRemoveInput {
  id mockCaptureInput = OCMClassMock([AVCaptureInput class]);
  AFPCaptureInputProxy *testCaptureInputProxy = [[AFPCaptureInputProxy alloc] initWithCaptureInput:mockCaptureInput];

  
  [_testCaptureSessionProxy removeInput:testCaptureInputProxy];
  OCMVerify([_mockCaptureSession removeInput:mockCaptureInput]);
}

- (void)testRemoveOutput {
  id mockCaptureOutput = OCMClassMock([AVCaptureOutput class]);
  AFPCaptureOutputProxy *testCaptureOutputProxy = [[AFPCaptureOutputProxy alloc]
                                                  initWithCaptureOutput:mockCaptureOutput implementations:_mockImplementations];
  
  [_testCaptureSessionProxy removeOutput:testCaptureOutputProxy];
  OCMVerify([_mockCaptureSession removeOutput:mockCaptureOutput]);
}
@end
