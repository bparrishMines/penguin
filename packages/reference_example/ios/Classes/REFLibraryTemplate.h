// GENERATED CODE - DO NOT MODIFY BY HAND

#import "REFMethodChannel.h"

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

NS_ASSUME_NONNULL_BEGIN

/*replace :from='__prefix__' prefix*/
/*iterate classes class*/
@protocol __prefix____class_name__;
/**/

/*iterate classes class*/
@protocol __prefix____class_name__ <NSObject>
@end
/**/

/*iterate classes class*/
@interface __prefix____class_name__Channel : REFTypeChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger;
- (void)_create:(NSObject<__prefix____class_name__> *)_instance
         _owner:(BOOL)_owner
/*iterate fields field*/
 __field_name__:(/*replace field_type*/NSNumber/**/ *_Nullable)__field_name__
/**/
     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion;

/*iterate staticMethods staticMethod*/
- (void)___staticMethod_name__:
/*if hasParameters*/
/*iterate :end=1 parameters parameter*/
(/*replace parameter_type*/NSString/**/ *_Nullable)__parameter_name__
/**//**/
/*iterate :start=1 parameters followingParameter*/
   __followingParameter_name__:(/*replace followingParameter_type*/NSString/**/ *_Nullable)__followingParameter_name__
/**/
/*if hasParameters*/completion:/**/(void (^)(id _Nullable, NSError *_Nullable))completion;
/**/

/*iterate methods method*/
- (void)___method_name__:(NSObject<__prefix____class_name__> *)_instance
/*iterate parameters parameter*/
  __parameter_name__:(/*replace parameter_type*/NSString/**/ *_Nullable)__parameter_name__
/**/
                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion;
/**/
@end
/**/

/*iterate classes class*/
@interface __prefix____class_name__Handler : NSObject<REFTypeChannelHandler>
- (NSObject<__prefix____class_name__> *)_create:(REFTypeChannelMessenger *)messenger
/*iterate fields field*/
                                 __field_name__:(/*replace field_type*/NSNumber/**/ *)__field_name__
/**/;
/*iterate staticMethods staticMethod*/
- (NSObject *_Nullable)___staticMethod_name__:(REFTypeChannelMessenger *)messenger
/*iterate parameters parameter*/
                           __parameter_name__:(/*replace parameter_type*/NSString/**/ *_Nullable)__parameter_name__
/**/;
/**/

/*iterate methods method*/
- (NSObject *_Nullable)___method_name__:(NSObject<__prefix____class_name__> *)_instance
/*iterate parameters parameter*/
  __parameter_name__:(/*replace parameter_type*/NSString/**/ *_Nullable)__parameter_name__
/**/;
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
@end

@interface __prefix__ChannelRegistrar : NSObject
@property (readonly) __prefix__LibraryImplementations *implementations;
- (instancetype)initWithImplementation:(__prefix__LibraryImplementations *)implementations;
- (void)registerHandlers;
- (void)unregisterHandlers;
@end
/**/
NS_ASSUME_NONNULL_END
