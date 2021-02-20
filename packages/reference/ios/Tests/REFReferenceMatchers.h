@import reference;
@import OCHamcrest;

@class REFTestMessenger;
@class REFTestClass;
@class REFTestHandler;
@class REFTestMessenger;

@interface REFTestMessenger : REFTypeChannelMessenger
@property (readonly) REFTestHandler *_Nonnull testHandler;
@end

@interface REFTestHandler : NSObject<REFTypeChannelHandler>
@property (readonly) REFTestClass *_Nonnull testClassInstance;
-(instancetype _Nonnull)initWithMessenger:(REFTypeChannelMessenger *_Nonnull)messenger;
@end

@interface REFTestClass : NSObject<REFReferenceType>
@property (readonly) REFTypeChannelMessenger *_Nonnull testMessenger;
-(instancetype _Nonnull)initWithMessenger:(REFTypeChannelMessenger *_Nonnull)messenger;
@end

@interface REFTestMessageDispatcher : NSObject<REFTypeChannelMessageDispatcher>
@end

@interface IsUnpairedInstance : HCBaseMatcher
@property(readonly) NSString *_Nonnull channelName;
@property(readonly) id _Nonnull creationArguments;
- (instancetype _Nonnull)initWithChannelName:(NSString *_Nonnull)channelName
                           creationArguments:(id _Nonnull)creationArguments;
@end

FOUNDATION_EXPORT id _Nonnull isUnpairedInstance(NSString *_Nonnull channelName, id _Nonnull creationArguments);
