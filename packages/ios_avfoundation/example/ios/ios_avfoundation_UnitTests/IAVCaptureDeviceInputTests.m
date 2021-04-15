#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import ios_avfoundation;

@interface IAVCaptureDeviceInputTests : XCTestCase
@end

@implementation IAVCaptureDeviceInputTests {
  IAFLibraryImplementations *_mockImplementations;
}

- (void)setUp {
  _mockImplementations = OCMClassMock([IAFLibraryImplementations class]);
}
- (void)testInitWithDevice {
  id mockCaptureDevice = OCMClassMock([AVCaptureDevice class]);
  IAFCaptureDeviceProxy *captureDevice = [[IAFCaptureDeviceProxy alloc] initWithCaptureDevice:mockCaptureDevice
                                                                              implementations:_mockImplementations];
  
  id mockDeviceInput = OCMClassMock([AVCaptureDeviceInput class]);
  OCMStub([mockDeviceInput alloc]).andReturn(mockDeviceInput);
  OCMStub([mockDeviceInput initWithDevice:mockCaptureDevice
                                    error:((NSError __autoreleasing **)[OCMArg anyPointer])]).andReturn(mockDeviceInput);

  XCTAssertEqualObjects(mockDeviceInput,
                        [[IAFCaptureDeviceInputProxy alloc] initWithDevice:captureDevice].captureInput);
}
@end
