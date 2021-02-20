#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import ios_avfoundation;

@interface IAVCaptureSessionTests : XCTestCase
@end

@implementation IAVCaptureSessionTests
- (void)testSetInputs {
  id mockCaptureDeviceInput = OCMClassMock([AVCaptureDeviceInput class]);
  id mockIAVCaptureDeviceInput = OCMClassMock([IAVCaptureDeviceInputProxy class]);
  OCMStub([mockIAVCaptureDeviceInput captureDeviceInput]).andReturn(mockCaptureDeviceInput);
  
  id mockCaptureSession = OCMClassMock([AVCaptureSession class]);
  IAVCaptureSessionProxy *captureSession = [[IAVCaptureSessionProxy alloc] initWithCaptureSession:mockCaptureSession];
  [captureSession setInputs:@[mockIAVCaptureDeviceInput]];
  
  OCMVerify([mockCaptureSession addInput:mockCaptureDeviceInput]);
}
@end
