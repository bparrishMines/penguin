// GENERATED CODE - DO NOT MODIFY BY HAND

#import <Foundation/Foundation.h>
#import "REFMethodChannel.h"

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

NS_ASSUME_NONNULL_BEGIN

/*replace :from='__prefix__' prefix*/
/*iterate classes class*/
@protocol __prefix____class_name__;
/**/

@class __prefix__LibraryImplementations;

/*iterate functions function*/
typedef NSObject *_Nullable (^__prefix____function_name__) (/*iterate :join=',' parameters parameter*//*replace parameter_type*/NSString */**/ _Nullable __parameter_name__/**/);
/**/

/*iterate functions function*/
@interface __prefix____function_name__Channel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;
- (void)__create:(__prefix____function_name__)_instance
          _owner:(BOOL)_owner
      completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;
@end
/**/

/*iterate functions function*/
@interface __prefix____function_name__Handler : NSObject<REFTypeChannelHandler>
@property (readonly) __prefix__LibraryImplementations *implementations;
-(instancetype)initWithImplementations:(__prefix__LibraryImplementations *)implementations;
@end
/**/

/*iterate classes class*/
@protocol __prefix____class_name__ <NSObject>
/*iterate methods method*/
/*if returnsFuture*/
- (id _Nullable)__method_name__/*iterate :end=1 parameters parameter*/
                                :(/*replace parameter_type*/NSString */**/ _Nullable)__parameter_name__
/**/
/*iterate :start=1 parameters followingParameter*/
     __followingParameter_name__:(/*replace followingParameter_type*/NSString */**/ _Nullable)__followingParameter_name__
/**/
;
/**/
/**/
@end
/**/

/*iterate classes class*/
@interface __prefix____class_name__Channel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;
/*iterate constructors constructor*/
- (void)_create___constructor_name__:(NSObject<__prefix____class_name__> *)_instance
          _owner:(BOOL)_owner
/*iterate parameters parameter*/
 __parameter_name__:(/*replace parameter_type*/NSNumber */**/ _Nullable)__parameter_name__
/**/
     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;
/**/

/*iterate staticMethods staticMethod*/
/*if! returnsFuture*/
- (void)___staticMethod_name__:
/*if hasParameters*/
/*iterate :end=1 parameters parameter*/
(/*replace parameter_type*/NSString */**/ _Nullable)__parameter_name__
/**//**/
/*iterate :start=1 parameters followingParameter*/
   __followingParameter_name__:(/*replace followingParameter_type*/NSString */**/ _Nullable)__followingParameter_name__
/**/
/*if hasParameters*/completion:/**/(void (^)(id _Nullable, NSError *_Nullable))completion;
/**/
/**/

/*iterate methods method*/
/*if! returnsFuture*/
- (void)___method_name__:(NSObject<__prefix____class_name__> *)_instance
/*iterate parameters parameter*/
  __parameter_name__:(/*replace parameter_type*/NSString */**/ _Nullable)__parameter_name__
/**/
                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
/**/
/**/
@end
/**/

/*iterate classes class*/
@interface __prefix____class_name__Handler : NSObject<REFTypeChannelHandler>
/*iterate constructors constructor*/
- (NSObject<__prefix____class_name__> *)_create___constructor_name__:(REFTypeChannelMessenger *)messenger
/*iterate parameters parameter*/
                                  __parameter_name__:(/*replace parameter_type*/NSNumber */**/ _Nullable)__parameter_name__
/**/;
/**/
/*iterate staticMethods staticMethod*/
/*if returnsFuture*/
- (id _Nullable)___staticMethod_name__:(REFTypeChannelMessenger *)messenger
/*iterate parameters parameter*/
                           __parameter_name__:(/*replace parameter_type*/NSString */**/ _Nullable)__parameter_name__
/**/;
/**/
/**/

/*iterate methods method*/
/*if returnsFuture*/
- (id _Nullable)___method_name__:(NSObject<__prefix____class_name__> *)_instance
/*iterate parameters parameter*/
  __parameter_name__:(/*replace parameter_type*/NSString */**/ _Nullable)__parameter_name__
/**/;
/**/
/**/
@end
/**/

@interface __prefix__LibraryImplementations : NSObject
@property (readonly) REFTypeChannelMessenger *messenger;
-(instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;
/*iterate classes class*/
-(__prefix____class_name__Channel *)channel__class_name__;
-(__prefix____class_name__Handler *)handler__class_name__;
/**/

/*iterate functions function*/
- (__prefix____function_name__Channel *)channel__function_name__;
- (__prefix____function_name__Handler *)handler__function_name__;
/**/
@end

@interface __prefix__ChannelRegistrar : NSObject
@property (readonly) __prefix__LibraryImplementations *implementations;
- (instancetype)initWithImplementation:(__prefix__LibraryImplementations *)implementations;
- (void)registerHandlers;
- (void)unregisterHandlers;
@end
/**/
NS_ASSUME_NONNULL_END
