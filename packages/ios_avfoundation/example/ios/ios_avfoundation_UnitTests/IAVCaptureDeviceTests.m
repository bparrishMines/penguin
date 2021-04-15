#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import ios_avfoundation;

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

@interface IAVCaptureDeviceTests : XCTestCase
@end

@implementation IAVCaptureDeviceTests {
  TestCaptureDevice *_testCaptureDevice;
  IAFLibraryImplementations *_mockImplementations;
}

- (void)setUp {
  _testCaptureDevice = [[TestCaptureDevice alloc] init];
  _mockImplementations = OCMClassMock([IAFLibraryImplementations class]);
}

- (void)testDevicesWithMediaType {
  id mockCaptureDevice = OCMClassMock([AVCaptureDevice class]);
  
  OCMStub(ClassMethod([mockCaptureDevice devicesWithMediaType:@"apple"])).andReturn(@[_testCaptureDevice]);
  
  NSArray<IAFCaptureDeviceProxy *> *devices = [IAFCaptureDeviceProxy devicesWithMediaType:@"apple"
                                                                          implementations:_mockImplementations];
  XCTAssertEqual(devices.count, 1);
  
  IAFCaptureDeviceProxy *device = devices[0];
  XCTAssertEqualObjects(device.uniqueId, @"test_uniqueID");
  XCTAssertEqualObjects(device.position, @(2));
}
@end
