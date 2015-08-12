
/* 14-12-8:创建
 *
 */

#import <Foundation/Foundation.h>

@interface QTNavigationBarV :UIImageView
@property (nonatomic, strong) UIButton *back;
@property (nonatomic, strong) UIButton *home;
@property (nonatomic, strong) UILabel *title;
- (id)initWithTitle:(NSString *)title;
@end
