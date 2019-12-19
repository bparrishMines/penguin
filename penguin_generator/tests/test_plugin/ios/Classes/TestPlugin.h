#import <Flutter/Flutter.h>

@interface TestPlugin : NSObject<FlutterPlugin>
@end

@protocol TestProtocol
@required
- (void)callbackMethod;
@end

@interface TestClass2 : NSObject
@end

@interface GenericClass<T> : NSObject
- (void)add:(T _Nonnull)object;
- (T _Nullable)get;
@end

@interface TestClass1 : NSObject
- (instancetype _Nonnull)initNamedConstructor:(NSString *_Nonnull)supported
                                    primitive:(int)primitive
                                      wrapper:(TestClass2 *_Nonnull)wrapper;
@property NSNumber *_Nonnull intField;
@property NSString *_Nonnull stringField;
@property NSNumber *_Nonnull doubleField;
@property NSNumber *_Nonnull boolField;
@property NSNumber *_Nonnull mutableField;
+ (NSArray<NSNumber *> *_Nonnull)staticField;
+ (void)staticMethod;
- (void)parameterMethod:(NSString *_Nonnull)supported
              primitive:(int)primitive
                wrapper:(TestClass2 *_Nonnull)wrapper
                aStruct:(CGRect)aStruct;
- (void)returnVoid;
- (NSObject *_Nonnull)returnObject;
- (NSObject *_Nonnull)returnDynamic;
- (NSString *_Nonnull)returnString;
- (NSNumber *_Nonnull)returnInt;
- (int)returnInt32;
- (NSNumber *_Nonnull)returnDouble;
- (NSNumber *_Nonnull)returnBool;
- (NSArray *_Nonnull)returnList;
- (NSDictionary *_Nonnull)returnMap;
@end
