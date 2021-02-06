#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import penguin_camera;

@interface TestAVCaptureDevice : NSObject
@end

@implementation TestAVCaptureDevice
- (instancetype)init {
  return self = [super init];
}

- (AVCaptureDevicePosition)position {
  return 2;
}

- (NSString *)uniqueID {
  return @"test_uniqueID";
}
@end

@interface PCMCaptureDeviceTests : XCTestCase
@end

@implementation PCMCaptureDeviceTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
  
}

- (void)testDevicesWithMediaType {
  id mockCaptureDevice = OCMClassMock([AVCaptureDevice class]);

  TestAVCaptureDevice *testAVCaptureDevice = [[TestAVCaptureDevice alloc] init];
  OCMStub(ClassMethod([mockCaptureDevice devicesWithMediaType:@"apple"])).andReturn(@[testAVCaptureDevice]);
  
  NSArray<PCMCaptureDevice *> *devices = [PCMCaptureDevice devicesWithMediaType:@"apple" messenger:nil];
  XCTAssertEqual(devices.count, 1);
  
  PCMCaptureDevice *device = devices[0];
  XCTAssertEqualObjects(device.uniqueId, @"test_uniqueID");
  XCTAssertEqualObjects(device.position, @(2));
}

- (void)testCameraDevicePosition {
  XCTAssertEqual(AVCaptureDevicePositionUnspecified, 0);
  XCTAssertEqual(AVCaptureDevicePositionBack, 1);
  XCTAssertEqual(AVCaptureDevicePositionFront, 2);
}
@end
