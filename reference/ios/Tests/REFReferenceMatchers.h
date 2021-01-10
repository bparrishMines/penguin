@import reference;
@import OCHamcrest;

@class REFTestManager;
@class REFTestClass;
@class REFTestHandler;

@interface REFTestManager : REFTypeChannelManager
@property (readonly) REFTestHandler *_Nonnull testHandler;
@end

@interface REFTestHandler : NSObject<REFTypeChannelHandler>
@property (readonly) REFTestClass *_Nonnull testClassInstance;
-(instancetype _Nonnull)initWithManager:(REFTestManager *_Nonnull)manager;
@end

@interface REFTestClass : NSObject<REFPairableInstance>
@property (readonly) REFTestManager *_Nonnull testManager;
-(instancetype _Nonnull)initWithManager:(REFTestManager *_Nonnull)manager;
@end

@interface IsUnpairedInstance : HCBaseMatcher
@property(readonly) NSString *_Nonnull channelName;
@property(readonly) id _Nonnull creationArguments;
- (instancetype _Nonnull)initWithChannelName:(NSString *_Nonnull)channelName
                       creationArguments:(id _Nonnull)creationArguments;
@end

FOUNDATION_EXPORT id _Nonnull isUnpairedInstance(NSString *_Nonnull channelName, id _Nonnull creationArguments);

//@import OCMockito;
//@import OCHamcrest;
//
//@import reference;
//
//@interface TestClass : NSObject <REFLocalReference, NSCopying>
//+ (TestClass *_Nonnull)testClass;
//@end
//
//@interface TestClass2 : TestClass <REFLocalReference, NSCopying>
//+ (TestClass2 *_Nonnull)testClass2;
//@end
//
//@interface SpyReferenceConverter : REFStandardReferenceConverter
//@property(readonly) id<REFReferenceConverter> _Nonnull mock;
//@end
//
//@interface TestReferencePairManager : REFReferencePairManager
//@property(readonly) SpyReferenceConverter *_Nonnull spyConverter;
//@end
//
//@interface TestPoolableReferencePairManager : REFPoolableReferencePairManager
//- (instancetype _Nonnull)initWithSupportedClasses:(NSArray<REFClass *> *_Nonnull)supportedClasses
//                                           poolID:(NSString *_Nonnull)poolID;
//@end
//
//@interface TestRemoteHandler : REFMethodChannelRemoteHandler
//@end
//
//@interface TestMethodChannelReferencePairManager : REFMethodChannelReferencePairManager
//@end
//
//@interface IsUnpairedReference : HCBaseMatcher
//@property(readonly) NSUInteger classID;
//@property(readonly) id _Nonnull creationArguments;
//@property(readonly) NSString *_Nullable managerPoolID;
//- (instancetype _Nonnull)initWithClassID:(NSUInteger)classID
//                       creationArguments:(id _Nonnull)creationArguments
//                           managerPoolID:(NSString *_Nullable)managerPoolID;
//@end
//
//FOUNDATION_EXPORT id _Nonnull isUnpairedReference(NSUInteger classID, id _Nonnull creationArguments,
//                                                  NSString *_Nullable managerPoolID);
