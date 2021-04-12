#import <Foundation/Foundation.h>
#import "REFCollections_Internal.h"
#import "REFInstance.h"

NS_ASSUME_NONNULL_BEGIN

@class REFTypeChannelMessenger;

@protocol REFTypeChannelHandler <NSObject>
- (NSArray *)getCreationArguments:(REFTypeChannelMessenger *)messenger instance:(NSObject *)instance;
- (id)createInstance:(REFTypeChannelMessenger *)messenger arguments:(NSArray *)arguments;
- (id _Nullable)invokeStaticMethod:(REFTypeChannelMessenger *)messenger
                        methodName:(NSString *)methodName
                         arguments:(NSArray *)arguments;
- (id _Nullable)invokeMethod:(REFTypeChannelMessenger *)messenger
                    instance:(NSObject *)instance
                  methodName:(NSString *)methodName
                   arguments:(NSArray *)arguments;
@end

@interface REFTypeChannel<ObjectType> : NSObject
@property(readonly) REFTypeChannelMessenger *messenger;
@property(readonly) NSString *name;
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger
                             name:(NSString *)name;
- (void)setHandler:(NSObject<REFTypeChannelHandler> *_Nullable)handler;
- (void)removeHandler;
- (void)createNewInstancePair:(ObjectType)instance
                        owner:(BOOL)owner
                   completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;
- (void)invokeStaticMethod:(NSString *)methodName
                 arguments:(NSArray<id> *)arguments
                completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
- (void)invokeMethod:(ObjectType)instance
          methodName:(NSString *)methodName
           arguments:(NSArray<id> *)arguments
          completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
- (void)disposeInstancePair:(ObjectType)instance
                 completion:(void (^)(NSError *_Nullable))completion;
@end

@protocol REFTypeChannelMessageDispatcher
- (void)sendCreateNewInstancePair:(NSString *)channelName
                   pairedInstance:(REFPairedInstance *)pairedInstance
                        arguments:(NSArray<id> *)arguments
                            owner:(BOOL)owner
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

- (void)sendDisposeInstancePair:(REFPairedInstance *)pairedInstance
                     completion:(void (^)(NSError *_Nullable))completion;
@end

@protocol REFInstanceConverter <NSObject>
- (id _Nullable)convertForRemoteMessenger:(REFTypeChannelMessenger *)messenger
                                      obj:(id _Nullable)obj;
- (id _Nullable)convertForLocalMessenger:(REFTypeChannelMessenger *)messenger
                                     obj:(id _Nullable)obj;
@end

@interface REFStandardInstanceConverter : NSObject <REFInstanceConverter>
@end

@interface REFTypeChannelMessenger : NSObject
@property(readonly) id<REFTypeChannelMessageDispatcher> messageDispatcher;
- (instancetype)initWithMessageDispatcher:(id<REFTypeChannelMessageDispatcher>)messageDispatcher;
- (BOOL)isPaired:(NSObject *)instance;
- (REFPairedInstance *_Nullable)getPairedPairedInstance:(NSObject *)object;
- (id _Nullable)getPairedObject:(REFPairedInstance *)pairedInstance;
- (void)registerHandler:(NSString *)channelName handler:(NSObject<REFTypeChannelHandler> *)handler;
- (void)unregisterHandler:(NSString *)channelName;
- (NSObject<REFTypeChannelHandler> *_Nullable)getChannelHandler:(NSString *)channelName;
// TODO: should pass in like dispatcher
- (REFInstancePairManager *)instancePairManager;
- (id<REFInstanceConverter>)converter;
- (void)createNewInstancePair:(NSString *)channelName
                    instance:(NSObject *)instance
                        owner:(BOOL)owner
                   completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;
- (void)sendInvokeStaticMethod:(NSString *)channelName
                    methodName:(NSString *)methodName
                     arguments:(NSArray<id> *)arguments
                    completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
- (void)sendInvokeMethod:(NSString *)channelName
                instance:(NSObject *)instance
              methodName:(NSString *)methodName
               arguments:(NSArray<id> *)arguments
              completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
- (void)disposeInstancePair:(NSObject *)instance
                 completion:(void (^)(NSError *_Nullable))completion;
- (NSObject *_Nullable)onReceiveCreateNewInstancePair:(NSString *)channelName
                                       pairedInstance:(REFPairedInstance *)pairedInstance
                                            arguments:(NSArray *)arguments
                                                owner:(BOOL)owner;
- (id _Nullable)onReceiveInvokeStaticMethod:(NSString *)channelName
                                 methodName:(NSString *)methodName
                                  arguments:(NSArray *)arguments;
- (id _Nullable)onReceiveInvokeMethod:(NSString *)channelName
                       pairedInstance:(REFPairedInstance *)pairedInstance
                           methodName:(NSString *)methodName
                            arguments:(NSArray *)arguments;
- (void)onReceiveDisposeInstancePair:(REFPairedInstance *)pairedInstance;
- (NSString *)generateUniqueInstanceID:(NSObject *)instance;
@end

NS_ASSUME_NONNULL_END
