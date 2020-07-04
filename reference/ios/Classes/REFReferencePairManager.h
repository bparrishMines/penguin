#import <Foundation/Foundation.h>
#import "REFReference.h"
#import "REFCollections_Internal.h"

NS_ASSUME_NONNULL_BEGIN

@class REFReferencePairManager;

@protocol REFRemoteReferenceCommunicationHandler
@required
-(NSArray<id> *)getCreationArguments:(id<REFLocalReference>)localReference;

-(void)create:(REFRemoteReference *)remoteReference
      classID:(NSUInteger)classID
    arguments:(NSArray<id> *)arguments
   completion:(void (^)(NSError *_Nullable))completion;

-(void)invokeMethod:(REFRemoteReference *)remoteReference
         methodName:(NSString *)methodName
          arguments:(NSArray<id> *)arguments
         completion:(void (^)(id _Nullable, NSError *_Nullable))completion;

-(void)invokeMethodOnUnpairedReference:(REFUnpairedReference *)unpairedReference
                            methodName:(NSString *)methodName
                             arguments:(NSArray<id> *)arguments
                            completion:(void (^)(id _Nullable, NSError *_Nullable))completion;

-(void)dispose:(REFRemoteReference *)remoteReference
    completion:(void (^)(NSError *_Nullable))completion;
@end

@protocol REFLocalReferenceCommunicationHandler
@required
-(id<REFLocalReference>)create:(REFReferencePairManager *)referencePairManager
                referenceClass:(Class)referenceClass
                     arguments:(NSArray<id> *)arguments;

-(id _Nullable)invokeMethod:(REFReferencePairManager *)referencePairManager
             localReference:(id<REFLocalReference>)localReference
                 methodName:(NSString *)methodName
                  arguments:(NSArray<id> *)arguments;

@optional
-(void)dispose:(REFReferencePairManager *)referencePairManager
localReference:(id<REFLocalReference>)localReference;
@end

@protocol REFReferenceConverter <NSObject>
-(id _Nullable)convertReferencesForRemoteManager:(REFReferencePairManager *)manager obj:(id _Nullable)obj;
-(id _Nullable)convertReferencesForLocalManager:(REFReferencePairManager *)manager obj:(id _Nullable)obj;
@end

@interface REFStandardReferenceConverter : NSObject<REFReferenceConverter>
@end

@interface REFReferencePairManager : NSObject
@property (readonly) NSArray<REFClass *> *supportedClasses;
-(instancetype)initWithSupportedClasses:(NSArray<REFClass *> *)supportedClasses;
-(id<REFRemoteReferenceCommunicationHandler>)remoteHandler;
-(id<REFLocalReferenceCommunicationHandler>)localHandler;
-(id<REFReferenceConverter>)converter;
-(void)initialize;
-(NSUInteger)getClassID:(REFClass *)clazz;
-(REFClass *_Nullable)getReferenceClass:(NSUInteger)classID;
-(REFRemoteReference *_Nullable)getPairedRemoteReference:(id<REFLocalReference>)localReference;
-(id<REFLocalReference> _Nullable)getPairedLocalReference:(REFRemoteReference *)remoteReference;
-(id<REFLocalReference>)pairWithNewLocalReference:(REFRemoteReference *)remoteReference
                                          classID:(NSUInteger)classID;
-(id<REFLocalReference>)pairWithNewLocalReference:(REFRemoteReference *)remoteReference
                                          classID:(NSUInteger)classID
                                        arguments:(NSArray<id> *)arguments;

-(id _Nullable)invokeLocalMethod:(id<REFLocalReference>)localReference
                      methodName:(NSString *)methodName;
-(id _Nullable)invokeLocalMethod:(id<REFLocalReference>)localReference
                      methodName:(NSString *)methodName
                       arguments:(NSArray<id> *)arguments;

-(id _Nullable)invokeLocalMethodOnUnpairedReference:(REFUnpairedReference *)unpairedReference
                                         methodName:(NSString *)methodName;
-(id _Nullable)invokeLocalMethodOnUnpairedReference:(REFUnpairedReference *)unpairedReference
                                         methodName:(NSString *)methodName
                                          arguments:(NSArray<id> *)arguments;

-(void)disposePairWithRemoteReference:(REFRemoteReference *)remoteReference;

-(void)pairWithNewRemoteReference:(id<REFLocalReference>)localReference
                       completion:(void (^)(REFRemoteReference *_Nullable, NSError *_Nullable))completion;

-(void)invokeRemoteMethod:(REFRemoteReference *)remoteReference
               methodName:(NSString *)methodName
               completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
-(void)invokeRemoteMethod:(REFRemoteReference *)remoteReference
               methodName:(NSString *)methodName
                arguments:(NSArray<id> *)arguments
               completion:(void (^)(id _Nullable, NSError *_Nullable))completion;

-(void)invokeRemoteMethodOnUnpairedReference:(id<REFLocalReference>)localReference
                                  methodName:(NSString *)methodName
                                  completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
-(void)invokeRemoteMethodOnUnpairedReference:(id<REFLocalReference>)localReference
                                  methodName:(NSString *)methodName
                                   arguments:(NSArray<id> *)arguments
                                  completion:(void (^)(id _Nullable, NSError *_Nullable))completion;

-(void)disposePairWithLocalReference:(id<REFLocalReference>)localReference
                          completion:(void (^)(NSError *_Nullable))completion;
@end

NS_ASSUME_NONNULL_END
