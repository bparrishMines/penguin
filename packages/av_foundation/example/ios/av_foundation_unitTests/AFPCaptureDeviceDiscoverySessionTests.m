#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import av_foundation;

@interface SessionTestCaptureDevice : NSObject
@end

@implementation SessionTestCaptureDevice
- (instancetype)init {
  return self = [super init];
}

- (AVCaptureDevicePosition)position {
  return 2;
}

- (NSString *)uniqueID {
  return @"test_uniqueID";
}

- (BOOL)isSmoothAutoFocusSupported {
  return YES;
}

- (BOOL)hasFlash {
  return NO;
}

- (BOOL)hasTorch {
  return YES;
}
@end

@interface AFPCaptureDeviceDiscoverySessionTests : XCTestCase
@end

@implementation AFPCaptureDeviceDiscoverySessionTests {
  AFPLibraryImplementations *_mockImplementations;
  SessionTestCaptureDevice *_testCaptureDevice;
  id _mockCaptureDeviceDiscoverySessionChannel;
  _AFPCaptureDeviceChannel *_mockCaptureDeviceChannel;
}

- (void)setUp {
  _mockImplementations = OCMClassMock([AFPLibraryImplementations class]);
  _testCaptureDevice = [[SessionTestCaptureDevice alloc] init];

  _mockCaptureDeviceDiscoverySessionChannel = OCMClassMock([_AFPCaptureDeviceDiscoverySessionChannel class]);
  _mockCaptureDeviceChannel = OCMClassMock([_AFPCaptureDeviceChannel class]);

  OCMStub([_mockImplementations channelCaptureDeviceDiscoverySession]).andReturn(_mockCaptureDeviceDiscoverySessionChannel);
  OCMStub([_mockImplementations channelCaptureDevice]).andReturn(_mockCaptureDeviceChannel);
}

- (void)testCreateCaptureDeviceDiscoverySession {
  AVCaptureDeviceDiscoverySession *mockDiscoverySession = OCMClassMock([AVCaptureDeviceDiscoverySession class]);
  OCMStub([mockDiscoverySession devices]).andReturn(@[_testCaptureDevice]);
  NSMutableOrderedSet* deviceSet = [[NSMutableOrderedSet alloc] initWithArray:@[_testCaptureDevice]];
  OCMStub([mockDiscoverySession supportedMultiCamDeviceSets]).andReturn(@[deviceSet]);
  
  __block BOOL blockRan = NO;

  void (^theBlock)(NSInvocation *) = ^(NSInvocation *invocation) {
    blockRan = YES;
    
    NSArray *devices;
    NSArray *supportedMultiCamDeviceSets;

    [invocation getArgument:&devices atIndex:4];
    [invocation getArgument:&supportedMultiCamDeviceSets atIndex:5];

    XCTAssertEqualObjects([devices[0] captureDevice], self->_testCaptureDevice);
    XCTAssertEqualObjects([supportedMultiCamDeviceSets[0][0] captureDevice], self->_testCaptureDevice);
  };
  [[[_mockCaptureDeviceDiscoverySessionChannel stub] andDo:theBlock] _create_:[OCMArg any]
                                                                       _owner:NO
                                                                     devices:[OCMArg isNotNil]
                                                 supportedMultiCamDeviceSets:[OCMArg any] completion:[OCMArg any]];

  AFPCaptureDeviceDiscoverySessionProxy *sessionProxy = [[AFPCaptureDeviceDiscoverySessionProxy alloc]
                                                         initWithCaptureDeviceDiscoverySession:mockDiscoverySession
                                                         implementations:_mockImplementations];
  
  XCTAssertTrue(blockRan);
}
@end
