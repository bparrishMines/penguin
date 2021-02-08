#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import penguin_camera;

@interface PCMCaptureSessionTests : XCTestCase

@end

@implementation PCMCaptureSessionTests

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

- (void)testPerformanceExample {
  id mockCaptureSession = OCMClassMock([AVCaptureSession class]);
  OCMStub([mockCaptureSession alloc]).andReturn(mockCaptureSession);
  OCMStub([mockCaptureSession addInput:OCMOCK_ANY]);
  
  id mockDeviceInput = OCMClassMock([AVCaptureDeviceInput class]);
  id mockPcmDeviceInput = OCMClassMock([PCMCaptureDeviceInput class]);
  [(PCMCaptureDeviceInput*)[[mockPcmDeviceInput stub] andReturnValue:[NSNull null]] captureDeviceInput];
  
  //[[PCMCaptureSession alloc] initWithInputs:@[mockPcmDeviceInput]];
  
  //OCMVerify([mockCaptureSession addInput:mockDeviceInput]);
}

@end
