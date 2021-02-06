#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import penguin_camera;

@interface PCMCaptureDeviceInputTests : XCTestCase

@end

@implementation PCMCaptureDeviceInputTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

// TODO: Test constructor by using the defined handler
- (void)testCaptureDeviceInputConstructor {
  id mockDeviceInput = OCMClassMock([AVCaptureDeviceInput class]);
  OCMStub([mockDeviceInput alloc]).andReturn(mockDeviceInput);
  
  id mockDevice = OCMClassMock([AVCaptureDevice class]);
  PCMCaptureDevice *device = [[PCMCaptureDevice alloc] initWithCaptureDevice:mockDevice messenger:nil];
  OCMStub([mockDeviceInput initWithDevice:mockDevice
                                    error:((NSError __autoreleasing **)[OCMArg anyPointer])]).andReturn(mockDeviceInput);

  XCTAssertEqualObjects(mockDeviceInput, [[[PCMCaptureDeviceInput alloc] initWithDevice:device] captureDeviceInput]);
}
@end
