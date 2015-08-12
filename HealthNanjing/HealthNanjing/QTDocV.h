
/* 14-12-10:创建
 *
 */

#import <UIKit/UIKit.h>
#import "QTDocD.h"

@interface QTDocV :UITableViewCell
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *desc;
@property (nonatomic, strong) UILabel *level;
@property (nonatomic, strong) UIScrollView *work;
@property (nonatomic, strong) id target;
@property (nonatomic, assign) SEL action;
- (void)setData:(QTDocD *)data;
- (void)setWorkData:(NSArray *)data;
@end
