@import OCMockito;
@import OCHamcrest;

@import reference;

@interface TestClass : NSObject<REFLocalReference, NSCopying>
+(TestClass *_Nonnull)testClass;
@end

@interface SpyReferenceConverter : REFStandardReferenceConverter
@property (readonly) id<REFReferenceConverter> _Nonnull mock;
@end

@interface TestReferencePairManager : REFReferencePairManager
@property (readonly) SpyReferenceConverter *_Nonnull spyConverter;
@end

@interface IsUnpairedReference : HCBaseMatcher
@property (readonly) NSUInteger classID;
@property (readonly) id _Nonnull creationArguments;
@property (readonly) NSString *_Nullable managerPoolID;
- (instancetype _Nonnull)initWithClassID:(NSUInteger)classID
              creationArguments:(id _Nonnull)creationArguments
                  managerPoolID:(NSString *_Nullable)managerPoolID;
@end

FOUNDATION_EXPORT id _Nonnull isUnpairedReference(NSUInteger classID, id _Nonnull creationArguments, NSString *_Nullable managerPoolID);
