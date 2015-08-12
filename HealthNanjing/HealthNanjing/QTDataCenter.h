
/* 14-12-8:创建
 *
 */

#import <Foundation/Foundation.h>

@interface QTDataCenter :NSObject
+ (id)sharedDataCenter;
- (void)dataFromUrl:(NSString *)url success:(void(^)(NSData *))success;
- (void)insertDataFromArray:(NSArray *)array;
@end
