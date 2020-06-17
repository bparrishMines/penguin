#import "REFReference.h"

@implementation REFRemoteReference
- (instancetype)initWithReferenceID:(NSString *_Nonnull)referenceID {
  self = [super init];
  if (self) {
    _referenceID = referenceID;
  }
  return self;
}
@end

@implementation REFUnpairedReference
- (instancetype)initWithClassID:(NSUInteger)classID
              creationArguments:(NSArray<id> *)creationArguments
                  managerPoolID:(NSString *_Nullable)managerPoolID {
  self = [super init];
  if (self) {
    _classID = classID;
    _creationArguments = creationArguments.copy;
    _managerPoolID = managerPoolID;
  }
  return self;
}
@end
