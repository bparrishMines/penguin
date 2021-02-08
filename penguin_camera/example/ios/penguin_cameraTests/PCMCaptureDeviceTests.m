#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import penguin_camera;

@interface TestCaptureDevice : NSObject
@end

@implementation TestCaptureDevice
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

@implementation PCMCaptureDeviceTests {
  TestCaptureDevice *_testCaptureDevice;
}

- (void)setUp {
  _testCaptureDevice = [[TestCaptureDevice alloc] init];
}

- (void)testDevicesWithMediaType {
  id mockCaptureDevice = OCMClassMock([AVCaptureDevice class]);

  OCMStub(ClassMethod([mockCaptureDevice devicesWithMediaType:@"apple"])).andReturn(@[_testCaptureDevice]);
  
  NSArray<PCMCaptureDevice *> *devices = [PCMCaptureDevice devicesWithMediaType:@"apple" messenger:nil];
  XCTAssertEqual(devices.count, 1);
  
  PCMCaptureDevice *device = devices[0];
  XCTAssertEqualObjects(device.uniqueId, @"test_uniqueID");
  XCTAssertEqualObjects(device.position, @(2));
}

-(void)testInitWithUniqueID {
  id mockCaptureDevice = OCMClassMock([AVCaptureDevice class]);

  OCMStub(ClassMethod([mockCaptureDevice deviceWithUniqueID:@"test_id"])).andReturn(_testCaptureDevice);
  
  PCMCaptureDevice *captureDevice = [[PCMCaptureDevice alloc] initWithCaptureDevice:_testCaptureDevice
                                                                          messenger:nil];
  XCTAssertEqualObjects(_testCaptureDevice, captureDevice.captureDevice);
}
@end
