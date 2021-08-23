// GENERATED CODE - DO NOT MODIFY BY HAND

#import <Foundation/Foundation.h>
#import "REFMethodChannel.h"

/*iterate imports import*/
/*replace value*/
#import "EXPChannelRegistrar.h"
/**/
/**/

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

NS_ASSUME_NONNULL_BEGIN

/*replace :from='__prefix__' prefix*/
/*iterate classes class*/
@class __class_name__;
/**/

@class __prefix__LibraryImplementations;

/*iterate functions function*/
typedef void (^__function_name__) (/*iterate :join=',' parameters parameter*//*replace parameter_type*/NSString */**/ _Nullable __parameter_name__/**/);
/**/

/*iterate functions function*/
@interface __function_name__Channel : REFTypeChannel<__function_name__>
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;
- (void)_create:(__function_name__)_instance
         _owner:(BOOL)_owner
     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;
@end
/**/

/*iterate functions function*/
@interface __function_name__Handler : NSObject<REFTypeChannelHandler>
@property (readonly) __prefix__LibraryImplementations *implementations;
-(instancetype)initWithImplementations:(__prefix__LibraryImplementations *)implementations;
@end
/**/

/*iterate classes class*/
@interface __class_name__Channel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;
/*iterate constructors constructor*/
- (void)_create___constructor_name__:(__class_name__ *)_instance
                              _owner:(BOOL)_owner
/*iterate parameters parameter*/
                  __parameter_name__:(/*replace parameter_type*/NSNumber */**/ _Nullable)__parameter_name__
/**/
                          completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;
/**/

/*iterate staticMethods staticMethod*/
/*if! returnsFuture*/
- (void)___staticMethod_name__
/*iterate parameters parameter*/
/*if! first*//*erase*////**/__parameter_name__/**/
:(/*replace parameter_type*/NSString */**/ _Nullable)__parameter_name__
/**/

/*if hasParameters*/completion/**/:(void (^)(/*replace staticMethod_returnType*/NSNumber */**/_Nullable,
                                             NSError *_Nullable))completion;
/**/
/**/

/*iterate methods method*/
/*if! returnsFuture*/
- (void)___method_name__:(__class_name__ *)_instance
/*iterate parameters parameter*/
    __parameter_name__:(/*replace parameter_type*/NSString */**/ _Nullable)__parameter_name__
/**/
completion:(void (^)(/*replace method_returnType*/NSString */**/_Nullable, NSError *_Nullable))completion;
/**/
/**/
@end
/**/

/*iterate classes class*/
@interface __class_name__Handler : NSObject<REFTypeChannelHandler>
@property (readonly, weak) __prefix__LibraryImplementations *implemntations;
-(instancetype)initWithImplementations:(__prefix__LibraryImplementations *)implementations;
/*iterate constructors constructor*/
- (__class_name__ *)_create___constructor_name__
/*iterate parameters parameter*/
/*if! first*//*erase*////**/__parameter_name__/**/
:(/*replace parameter_type*/NSNumber */**/_Nullable)__parameter_name__/**/;
/**/


/*iterate staticMethods staticMethod*/
/*if returnsFuture*/
- (/*replace staticMethod_returnType*/NSNumber */**/_Nullable)___staticMethod_name__
/*iterate parameters parameter*/
/*if! first*//*erase*////**/__parameter_name__/**/
:(/*replace parameter_type*/NSString */**/_Nullable)__parameter_name__/**/
/**/;
/**/
/**/

/*iterate methods method*/
/*if returnsFuture*/
- (/*replace method_returnType*/NSString */**/_Nullable)___method_name__:(__class_name__ *)_instance
/*iterate parameters parameter*/
__parameter_name__:(/*replace parameter_type*/NSString */**/ _Nullable)__parameter_name__
/**/;
/**/
/**/
@end
/**/

@interface __prefix__LibraryImplementations : NSObject
@property (readonly) REFTypeChannelMessenger *messenger;
/*iterate classes class*/
@property __class_name__Channel *channel__class_name__;
@property __class_name__Handler *handler__class_name__;
/**/
/*iterate functions function*/
@property __function_name__Channel *channel__function_name__;
@property __function_name__Handler *handler__function_name__;
/**/
-(instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;
@end

@interface __prefix__ChannelRegistrar : NSObject
@property (readonly) __prefix__LibraryImplementations *implementations;
- (instancetype)initWithImplementation:(__prefix__LibraryImplementations *)implementations;
- (void)registerHandlers;
- (void)unregisterHandlers;
@end
/**/
NS_ASSUME_NONNULL_END
