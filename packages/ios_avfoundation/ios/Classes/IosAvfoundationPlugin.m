#import "IosAvfoundationPlugin.h"

@interface MyViewFactory : NSObject<FlutterPlatformViewFactory>
@end

@implementation MyViewFactory {
  REFTypeChannelMessenger *_messenger;
}

- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  self = [super init];
  if (self) {
    _messenger = messenger;
  }
  return self;
}

- (nonnull NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame
                                            viewIdentifier:(int64_t)viewId
                                                 arguments:(id _Nullable)args {
  REFPairedInstance *pairedInstance = (REFPairedInstance *) args;
  NSObject<FlutterPlatformView> *view = [_messenger getPairedObject:pairedInstance];
  return view;
}

- (NSObject<FlutterMessageCodec>*)createArgsCodec {
  return [FlutterStandardMessageCodec codecWithReaderWriter:[[REFReferenceReaderWriter alloc] init]];
}
@end

@implementation IosAvfoundationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  REFTypeChannelMessenger *messenger = [ReferencePlugin getMessengerInstance:registrar.messenger];
  
  IAFLibraryImplementations *implementations = [[IAFLibraryImplementations alloc] initWithMessenger:messenger];
  IAFChannelRegistrar *channels = [[IAFChannelRegistrar alloc] initWithImplementation:implementations];
  [channels registerHandlers];
  
  [registrar registerViewFactory:[[MyViewFactory alloc] initWithMessenger:messenger]
                          withId:@"ios_avfoundation/Preview"];
  
}
@end
