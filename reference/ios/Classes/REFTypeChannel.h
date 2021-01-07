#import <Foundation/Foundation.h>
#import "REFCollections_Internal.h"
#import "REFInstance.h"

NS_ASSUME_NONNULL_BEGIN

@class REFTypeChannelManager;

@protocol REFTypeChannelHandler <NSObject>
- (NSArray *)getCreationArguments:(REFTypeChannelManager *)manager instance:(NSObject *)instance;
- (id)createInstance:(REFTypeChannelManager *)manager arguments:(NSArray *)arguments;
- (id _Nullable)invokeStaticMethod:(REFTypeChannelManager *)manager
                        methodName:(NSString *)methodName
                         arguments:(NSArray *)arguments;
- (id _Nullable)invokeMethod:(REFTypeChannelManager *)manager
                    instance:(NSObject *)instance
                  methodName:(NSString *)methodName
                   arguments:(NSArray *)arguments;
- (void)onInstanceDisposed:(REFTypeChannelManager *)manager
                  instance:(NSObject *)instance;
@end

@interface REFTypeChannel<ObjectType> : NSObject
@property(readonly) REFTypeChannelManager *manager;
@property(readonly) NSString *name;
- (instancetype)initWithManager:(REFTypeChannelManager *)manager
                    name:(NSString *)name;
- (void)setHandler:(NSObject<REFTypeChannelHandler> *)handler;
- (REFNewUnpairedInstance *_Nullable)createUnpairedInstance:(ObjectType)instance;
- (void)createNewInstancePair:(ObjectType)instance
                completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;
- (void)invokeStaticMethod:(NSString *)methodName
                 arguments:(NSArray<id> *)arguments
                completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
- (void)invokeMethod:(ObjectType)instance
          methodName:(NSString *)methodName
           arguments:(NSArray<id> *)arguments
          completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
- (void)disposePair:(ObjectType)instance
         completion:(void (^)(NSError *_Nullable))completion;
@end

@protocol REFTypeChannelMessenger
- (void)sendCreateNewInstancePair:(NSString *)channelName
          pairedInstance:(REFPairedInstance *)pairedInstance
                arguments:(NSArray<id> *)arguments
               completion:(void (^)(NSError *_Nullable))completion;

- (void)sendInvokeStaticMethod:(NSString *)channelName
                    methodName:(NSString *)methodName
                     arguments:(NSArray<id> *)arguments
                    completion:(void (^)(id _Nullable, NSError *_Nullable))completion;

- (void)sendInvokeMethod:(NSString *)channelName
         pairedInstance:(REFPairedInstance *)pairedInstance
              methodName:(NSString *)methodName
               arguments:(NSArray<id> *)arguments
              completion:(void (^)(id _Nullable, NSError *_Nullable))completion;

- (void)sendInvokeMethodOnUnpairedReference:(REFNewUnpairedInstance *)unpairedReference
                                 methodName:(NSString *)methodName
                                  arguments:(NSArray<id> *)arguments
                                 completion:(void (^)(id _Nullable, NSError *_Nullable))completion;

- (void)sendDisposePair:(NSString *)channelName
        pairedInstance:(REFPairedInstance *)pairedInstance
             completion:(void (^)(NSError *_Nullable))completion;
@end

@protocol REFInstanceConverter <NSObject>
- (id _Nullable)convertForRemoteManager:(REFTypeChannelManager *)manager
                                              obj:(id _Nullable)obj;
- (id _Nullable)convertForLocalManager:(REFTypeChannelManager *)manager
                                             obj:(id _Nullable)obj;
@end

@interface REFStandardInstanceConverter : NSObject <REFInstanceConverter>
@end

@protocol REFPairableInstance
- (REFTypeChannel *)typeChannel;
@end

@interface REFTypeChannelManager : NSObject
@property(readonly) id<REFTypeChannelMessenger> messenger;
- (instancetype)initWithMessenger:(id<REFTypeChannelMessenger>)messenger;
- (BOOL)isPaired:(NSObject *)instance;
- (void)registerHandler:(NSString *)channelName handler:(NSObject<REFTypeChannelHandler> *)handler;
- (NSObject<REFTypeChannelHandler> *_Nullable)getChannelHandler:(NSString *)channelName;
- (id<REFInstanceConverter>)converter;
- (REFNewUnpairedInstance *_Nullable)createUnpairedInstance:(NSString *)channelName obj:(id)obj;
- (id)onReceiveCreateNewInstancePair:(NSString *)channelName
             pairedInstance:(REFPairedInstance *)pairedInstance
                   arguments:(NSArray<id> *)arguments;
- (id _Nullable)onReceiveInvokeStaticMethod:(NSString *)channelName
                                 methodName:(NSString *)methodName
                                  arguments:(NSArray<id> *)arguments;
- (id _Nullable)onReceiveInvokeMethod:(NSString *)channelName
                       pairedInstance:(REFPairedInstance *)pairedInstance
                           methodName:(NSString *)methodName
                            arguments:(NSArray<id> *)arguments;
- (id _Nullable)onReceiveInvokeMethodOnUnpairedInstance:(REFNewUnpairedInstance *)unpairedInstance
                                              methodName:(NSString *)methodName
                                               arguments:(NSArray<id> *)arguments;
- (void)onReceiveDisposePair:(NSString *)channelName
             pairedInstance:(REFPairedInstance *)pairedInstance;
- (NSString *)generateUniqueInstanceId;
@end

NS_ASSUME_NONNULL_END
