
/* 14-12-10:创建
 *
 */

#import <UIKit/UIKit.h>

@interface QTCommonV :UITableViewCell
@property (nonatomic, strong) UIScrollView *scr;
@property (nonatomic, strong) id target;
@property (nonatomic, assign) SEL action;
- (void)setData:(NSArray *)data;
@end
