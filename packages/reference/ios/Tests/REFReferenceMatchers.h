#import <OCHamcrest/OCHamcrest.h>

@import reference;

@class REFTestMessenger;
@class REFTestClass;
@class REFTestHandler;
@class REFTestMessenger;

@interface REFTestMessenger : REFTypeChannelMessenger
@property (readonly) REFTestHandler *_Nonnull testHandler;
@end

@interface REFTestHandler : NSObject<REFTypeChannelHandler>
@property (readonly) REFTestClass *_Nonnull testClassInstance;
@end

@interface REFTestClass : NSObject
@end

@interface REFTestMessageDispatcher : NSObject<REFTypeChannelMessageDispatcher>
@end

@interface REFTestInstanceManager : REFInstanceManager
@end
