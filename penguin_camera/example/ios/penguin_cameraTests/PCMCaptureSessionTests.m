#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import penguin_camera;

@interface PCMCaptureSessionTests : XCTestCase

@end

@implementation PCMCaptureSessionTests
- (void)testSetInputs {
  id mockCaptureDeviceInput = OCMClassMock([AVCaptureDeviceInput class]);
  id mockPcmCaptureDeviceInput = OCMClassMock([PCMCaptureDeviceInput class]);
  OCMStub([mockPcmCaptureDeviceInput captureDeviceInput]).andReturn(mockCaptureDeviceInput);
  
  id mockCaptureSession = OCMClassMock([AVCaptureSession class]);
  PCMCaptureSession *captureSession = [[PCMCaptureSession alloc] initWithCaptureSession:mockCaptureSession];
  [captureSession setInputs:@[mockPcmCaptureDeviceInput]];
  
  OCMVerify([mockCaptureSession addInput:mockCaptureDeviceInput]);
}
@end
