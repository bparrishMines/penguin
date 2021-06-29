#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import ios_avfoundation;

@interface IAFCapturePhotoSettingsTests : XCTestCase

@end

@implementation IAFCapturePhotoSettingsTests {
  IAFLibraryImplementations *_mockImplementations;
  REFTypeChannelMessenger *_mockTypeChannelMessenger;
}

- (void)setUp {
  _mockImplementations = OCMClassMock([IAFLibraryImplementations class]);
  _mockTypeChannelMessenger = OCMClassMock([REFTypeChannelMessenger class]);
}

- (void)testCreateCapturePhotoSettings {
  IAFLibraryImplementations *implementations = [[IAFLibraryImplementations alloc]
                                                initWithMessenger:_mockTypeChannelMessenger];

  IAFCapturePhotoSettingsProxy *settingsProxy = (IAFCapturePhotoSettingsProxy *) [implementations.handlerCapturePhotoSettings __create:_mockTypeChannelMessenger processedFormat:@{@"AVVideoCodecKey": @"jpeg"}];
  
  XCTAssertNotNil(settingsProxy);
  XCTAssertEqualObjects(settingsProxy.capturePhotoSettings.format, @{@"AVVideoCodecKey": @"jpeg"});
}
@end
