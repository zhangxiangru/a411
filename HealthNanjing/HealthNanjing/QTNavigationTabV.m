
/* 14-12-9:创建
 *
 */

#import "QTNavigationTabV.h"

@implementation QTNavigationTabV
- (id)initWithTitles:(NSArray *)titles {
    self = [super init];
    if (self) {
        [self setFrame:CGRectMake(0, 20+40, QTScreenWidth, 40)];
        NSInteger i = 0;
        while (i<[titles count]) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(QTScreenWidth/[titles count]*i, 0, QTScreenWidth/[titles count], 40)];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor whiteColor]];
            [btn setImage:[UIImage imageNamed:@"rb01_noselected_hd"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"rb01_selected_hd"] forState:UIControlStateSelected];
            [self addSubview:btn];
            if (i == 0) {
                [btn setSelected:YES];
                _hosdept = btn;
            } else {
                _hosdesc = btn;
            }
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, QTScreenWidth/[titles count], 40)];
            [lab setBackgroundColor:[UIColor clearColor]];
            [lab setTextAlignment:NSTextAlignmentCenter];
            [lab setText:titles[i]];
            [btn addSubview:lab];
            i++;
        }
    }
    return self;
}
@end
