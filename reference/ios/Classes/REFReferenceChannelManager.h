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

NS_ASSUME_NONNULL_END
