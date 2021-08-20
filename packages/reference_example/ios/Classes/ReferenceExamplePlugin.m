#import "ReferenceExamplePlugin.h"

// For testing the function.
@interface EXP__class_name__Handler : __class_name__Handler
@end

@implementation ReferenceExamplePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  REFTypeChannelMessenger *messenger = [ReferencePlugin getMessengerInstance:registrar.messenger];
  
  __prefix__LibraryImplementations *implementations = [[__prefix__LibraryImplementations alloc] initWithMessenger:messenger];
  __prefix__ChannelRegistrar *libraryRegistrar = [[__prefix__ChannelRegistrar alloc]
                                                  initWithImplementation:implementations];
  libraryRegistrar.implementations.handler__class_name__ = [[EXP__class_name__Handler alloc] initWithImplementations:implementations];
  [libraryRegistrar registerHandlers];
}
@end

@implementation EXP__class_name__Handler
- (id)invokeMethod:(REFTypeChannelMessenger *)messenger
          instance:(NSObject *)instance
        methodName:(NSString *)methodName
         arguments:(NSArray *)arguments {
  if ([@"callbackTest" isEqualToString:methodName]) {
    __prefix____function_name__ callback = (__prefix____function_name__) arguments[0];
    callback(@"Eureka!");
    return nil;
  }
  return [super invokeMethod:messenger instance:instance methodName:methodName arguments:arguments];
}
@end
