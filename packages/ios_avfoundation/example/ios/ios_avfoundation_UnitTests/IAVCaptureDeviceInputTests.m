#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import ios_avfoundation;

@interface IAVCaptureDeviceInputTests : XCTestCase

@end

@implementation IAVCaptureDeviceInputTests
- (void)testInitWithDevice {
  id mockCaptureDevice = OCMClassMock([AVCaptureDevice class]);
  IAVCaptureDeviceProxy *captureDevice = [[IAVCaptureDeviceProxy alloc] initWithCaptureDevice:mockCaptureDevice channels:nil];
  
  id mockDeviceInput = OCMClassMock([AVCaptureDeviceInput class]);
  OCMStub([mockDeviceInput alloc]).andReturn(mockDeviceInput);
  OCMStub([mockDeviceInput initWithDevice:mockCaptureDevice
                                    error:((NSError __autoreleasing **)[OCMArg anyPointer])]).andReturn(mockDeviceInput);

  XCTAssertEqualObjects(mockDeviceInput,
                        [[[IAVCaptureDeviceInputProxy alloc] initWithDevice:captureDevice] captureDeviceInput]);
}
@end
