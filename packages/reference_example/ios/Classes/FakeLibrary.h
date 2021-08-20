#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClassTemplate : NSObject
@property (readonly) NSInteger fieldTemplate;
-(instancetype)initWithFieldTemplate:(NSInteger)fieldTemplate;
+(double)staticMethodTemplate:(NSString *)parameterTemplate;
-(NSString *)methodTemplate:(NSString *)parameterTemplate;
@end

NS_ASSUME_NONNULL_END
