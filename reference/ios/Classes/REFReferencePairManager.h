#import <Foundation/Foundation.h>
#import "REFCollections_Internal.h"
#import "REFReference.h"

NS_ASSUME_NONNULL_BEGIN

@class REFReferenceChannelManager;

@protocol REFReferenceChannelHandler <NSObject>
- (NSArray *)getCreationArguments:(REFReferenceChannelManager *)manager instance:(NSObject *)instance;
- (id)createInstance:(REFReferenceChannelManager *)manager arguments:(NSArray *)arguments;
- (id _Nullable)invokeStaticMethod:(REFReferenceChannelManager *)manager
                        methodName:(NSString *)methodName
                         arguments:(NSArray *)arguments;
- (id _Nullable)invokeMethod:(REFReferenceChannelManager *)manager
                    instance:(NSObject *)instance
                  methodName:(NSString *)methodName
                   arguments:(NSArray *)arguments;
- (void)onInstanceDisposed:(REFReferenceChannelManager *)manager
                  instance:(NSObject *)instance;
@end

@interface REFReferenceChannel<ObjectType> : NSObject
@property(readonly) REFReferenceChannelManager *manager;
@property(readonly) NSString *channelName;
- (instancetype)initWithManager:(REFReferenceChannelManager *)manager
                    channelName:(NSString *)channelName;
- (void)registerHandler:(NSObject<REFReferenceChannelHandler> *)handler;
- (void)createNewPair:(ObjectType)instance
           completion:(void (^)(REFRemoteReference *_Nullable, NSError *_Nullable))completion;
- (void)invokeStaticMethod:(NSString *)methodName
                 arguments:(NSArray<id> *)arguments
                completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
- (void)invokeMethod:(ObjectType)instance
          methodName:(NSString *)methodName
           arguments:(NSArray<id> *)arguments
          completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
- (void)invokeMethodOnUnpairedReference:(ObjectType)obj
                             methodName:(NSString *)methodName
                              arguments:(NSArray<id> *)arguments
                             completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
- (void)disposePair:(ObjectType)instance
         completion:(void (^)(NSError *_Nullable))completion;
@end

@protocol REFReferenceChannelMessenger
- (void)sendCreateNewPair:(NSString *)handlerChannel
          remoteReference:(REFRemoteReference *)remoteReference
                arguments:(NSArray<id> *)arguments
               completion:(void (^)(NSError *_Nullable))completion;

- (void)sendInvokeStaticMethod:(NSString *)handlerChannel
                    methodName:(NSString *)methodName
                     arguments:(NSArray<id> *)arguments
                    completion:(void (^)(id _Nullable, NSError *_Nullable))completion;

- (void)sendInvokeMethod:(NSString *)handlerChannel
         remoteReference:(REFRemoteReference *)remoteReference
              methodName:(NSString *)methodName
               arguments:(NSArray<id> *)arguments
              completion:(void (^)(id _Nullable, NSError *_Nullable))completion;

- (void)sendInvokeMethodOnUnpairedReference:(REFUnpairedReference *)unpairedReference
                                 methodName:(NSString *)methodName
                                  arguments:(NSArray<id> *)arguments
                                 completion:(void (^)(id _Nullable, NSError *_Nullable))completion;

- (void)sendDisposePair:(NSString *)handlerChannel
        remoteReference:(REFRemoteReference *)remoteReference
             completion:(void (^)(NSError *_Nullable))completion;
@end

@protocol REFReferenceConverter <NSObject>
- (id _Nullable)convertReferencesForRemoteManager:(REFReferenceChannelManager *)manager
                                              obj:(id _Nullable)obj;
- (id _Nullable)convertReferencesForLocalManager:(REFReferenceChannelManager *)manager
                                             obj:(id _Nullable)obj;
@end

@interface REFStandardReferenceConverter : NSObject <REFReferenceConverter>
@end

@protocol REFReferencable
- (REFReferenceChannel *)referenceChannel;
@end

@interface REFReferenceChannelManager : NSObject
@property(readonly) id<REFReferenceChannelMessenger> messenger;
- (instancetype)initWithMessenger:(id<REFReferenceChannelMessenger>)messenger;
- (BOOL)isPaired:(NSObject *)instance;
- (void)registerHandler:(NSString *)channelName handler:(NSObject<REFReferenceChannelHandler> *)handler;
- (NSObject<REFReferenceChannelHandler> *_Nullable)getChannelHandler:(NSString *)channelName;
- (id<REFReferenceConverter>)converter;
- (REFUnpairedReference *_Nullable)createUnpairedReference:(NSString *)handlerChannel obj:(id)obj;
- (id)onReceiveCreateNewPair:(NSString *)handlerChannel
             remoteReference:(REFRemoteReference *)remoteReference
                   arguments:(NSArray<id> *)arguments;
- (id _Nullable)onReceiveInvokeStaticMethod:(NSString *)handlerChannel
                                 methodName:(NSString *)methodName
                                  arguments:(NSArray<id> *)arguments;
- (id _Nullable)onReceiveInvokeMethod:(NSString *)handlerChannel
                      remoteReference:(REFRemoteReference *)remoteReference
                           methodName:(NSString *)methodName
                            arguments:(NSArray<id> *)arguments;
- (id _Nullable)onReceiveInvokeMethodOnUnpairedReference:(REFUnpairedReference *)unpairedReference
                                              methodName:(NSString *)methodName
                                               arguments:(NSArray<id> *)arguments;
- (void)onReceiveDisposePair:(NSString *)handlerChannel
             remoteReference:(REFRemoteReference *)remoteReference;
- (NSString *)getNewReferenceId;
@end

//@class REFReferencePairManager;
//
//@protocol REFRemoteReferenceCommunicationHandler
//@required
//- (NSArray<id> *)getCreationArguments:(id<REFLocalReference>)localReference;
//
//- (void)create:(REFRemoteReference *)remoteReference
//       classID:(NSUInteger)classID
//     arguments:(NSArray<id> *)arguments
//    completion:(void (^)(NSError *_Nullable))completion;
//
//- (void)invokeStaticMethod:(NSUInteger)classID
//                methodName:(NSString *)methodName
//                 arguments:(NSArray<id> *)arguments
//                completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
//
//- (void)invokeMethod:(REFRemoteReference *)remoteReference
//          methodName:(NSString *)methodName
//           arguments:(NSArray<id> *)arguments
//          completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
//
//- (void)invokeMethodOnUnpairedReference:(REFUnpairedReference *)unpairedReference
//                             methodName:(NSString *)methodName
//                              arguments:(NSArray<id> *)arguments
//                             completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
//
//- (void)dispose:(REFRemoteReference *)remoteReference
//     completion:(void (^)(NSError *_Nullable))completion;
//@end
//
//@protocol REFLocalReferenceCommunicationHandler
//@required
//- (id<REFLocalReference>)create:(REFReferencePairManager *)referencePairManager
//                 referenceClass:(Class)referenceClass
//                      arguments:(NSArray<id> *)arguments;
//
//- (id _Nullable)invokeStaticMethod:(REFReferencePairManager *)referencePairManager
//                    referenceClass:(Class)referenceClass
//                        methodName:(NSString *)methodName
//                         arguments:(NSArray<id> *)arguments;
//
//- (id _Nullable)invokeMethod:(REFReferencePairManager *)referencePairManager
//              localReference:(id<REFLocalReference>)localReference
//                  methodName:(NSString *)methodName
//                   arguments:(NSArray<id> *)arguments;
//
//@optional
//- (void)dispose:(REFReferencePairManager *)referencePairManager
//    localReference:(id<REFLocalReference>)localReference;
//@end
//
//@protocol REFReferenceConverter <NSObject>
//- (id _Nullable)convertReferencesForRemoteManager:(REFReferencePairManager *)manager
//                                              obj:(id _Nullable)obj;
//- (id _Nullable)convertReferencesForLocalManager:(REFReferencePairManager *)manager
//                                             obj:(id _Nullable)obj;
//@end
//
//@interface REFStandardReferenceConverter : NSObject <REFReferenceConverter>
//@end
//
//@interface REFReferencePairManager : NSObject
//@property(readonly) NSArray<REFClass *> *supportedClasses;
//- (instancetype)initWithSupportedClasses:(NSArray<REFClass *> *)supportedClasses;
//- (id<REFRemoteReferenceCommunicationHandler>)remoteHandler;
//- (id<REFLocalReferenceCommunicationHandler>)localHandler;
//- (id<REFReferenceConverter>)converter;
//- (void)initialize;
//- (NSUInteger)getClassID:(REFClass *)clazz;
//- (REFClass *_Nullable)getReferenceClass:(NSUInteger)classID;
//- (REFRemoteReference *_Nullable)getPairedRemoteReference:(id<REFLocalReference>)localReference;
//- (id<REFLocalReference> _Nullable)getPairedLocalReference:(REFRemoteReference *)remoteReference;
//- (id<REFLocalReference> _Nullable)pairWithNewLocalReference:(REFRemoteReference *)remoteReference
//                                                     classID:(NSUInteger)classID;
//- (id<REFLocalReference>)pairWithNewLocalReference:(REFRemoteReference *)remoteReference
//                                           classID:(NSUInteger)classID
//                                         arguments:(NSArray<id> *)arguments;
//
//- (id _Nullable)invokeLocalStaticMethod:(Class)referenceClass methodName:(NSString *)methodName;
//- (id _Nullable)invokeLocalStaticMethod:(Class)referenceClass
//                             methodName:(NSString *)methodName
//                              arguments:(NSArray<id> *)arguments;
//
//- (id _Nullable)invokeLocalMethod:(id<REFLocalReference>)localReference
//                       methodName:(NSString *)methodName;
//- (id _Nullable)invokeLocalMethod:(id<REFLocalReference>)localReference
//                       methodName:(NSString *)methodName
//                        arguments:(NSArray<id> *)arguments;
//
//- (id _Nullable)invokeLocalMethodOnUnpairedReference:(REFUnpairedReference *)unpairedReference
//                                          methodName:(NSString *)methodName;
//- (id _Nullable)invokeLocalMethodOnUnpairedReference:(REFUnpairedReference *)unpairedReference
//                                          methodName:(NSString *)methodName
//                                           arguments:(NSArray<id> *)arguments;
//
//- (void)disposePairWithRemoteReference:(REFRemoteReference *)remoteReference;
//
//- (void)pairWithNewRemoteReference:(id<REFLocalReference>)localReference
//                        completion:
//                            (void (^)(REFRemoteReference *_Nullable, NSError *_Nullable))completion;
//
//- (void)invokeRemoteStaticMethod:(Class)referenceClass
//                      methodName:(NSString *)methodName
//                      completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
//- (void)invokeRemoteStaticMethod:(Class)referenceClass
//                      methodName:(NSString *)methodName
//                       arguments:(NSArray<id> *)arguments
//                      completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
//
//- (void)invokeRemoteMethod:(REFRemoteReference *)remoteReference
//                methodName:(NSString *)methodName
//                completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
//- (void)invokeRemoteMethod:(REFRemoteReference *)remoteReference
//                methodName:(NSString *)methodName
//                 arguments:(NSArray<id> *)arguments
//                completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
//
//- (void)invokeRemoteMethodOnUnpairedReference:(id<REFLocalReference>)localReference
//                                   methodName:(NSString *)methodName
//                                   completion:
//                                       (void (^)(id _Nullable, NSError *_Nullable))completion;
//- (void)invokeRemoteMethodOnUnpairedReference:(id<REFLocalReference>)localReference
//                                   methodName:(NSString *)methodName
//                                    arguments:(NSArray<id> *)arguments
//                                   completion:
//                                       (void (^)(id _Nullable, NSError *_Nullable))completion;
//
//- (void)disposePairWithLocalReference:(id<REFLocalReference>)localReference
//                           completion:(void (^)(NSError *_Nullable))completion;
//@end

NS_ASSUME_NONNULL_END
