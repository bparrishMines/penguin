#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import penguin_camera;

@interface PCMCaptureDeviceInputTests : XCTestCase

@end

@implementation PCMCaptureDeviceInputTests
- (void)testInitWithDevice {
  id mockCaptureDevice = OCMClassMock([AVCaptureDevice class]);
  PCMCaptureDevice *captureDevice = [[PCMCaptureDevice alloc] initWithCaptureDevice:mockCaptureDevice messenger:nil];
  
  id mockDeviceInput = OCMClassMock([AVCaptureDeviceInput class]);
  OCMStub([mockDeviceInput alloc]).andReturn(mockDeviceInput);
  OCMStub([mockDeviceInput initWithDevice:mockCaptureDevice
                                    error:((NSError __autoreleasing **)[OCMArg anyPointer])]).andReturn(mockDeviceInput);

  XCTAssertEqualObjects(mockDeviceInput,
                        [[[PCMCaptureDeviceInput alloc] initWithDevice:captureDevice] captureDeviceInput]);
}
@end
