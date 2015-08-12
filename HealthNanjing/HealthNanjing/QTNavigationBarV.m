
/* 14-12-8:创建
 *
 */

#import "QTNavigationBarV.h"

@implementation QTNavigationBarV
- (id)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        self.image = [UIImage imageNamed:@"home_banner_bg"];
        self.userInteractionEnabled = YES;
        [self setFrame:CGRectMake(0, 20, 320, 40)];
        _back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 45, 40)];
        [_back setImage:[UIImage imageNamed:@"hospitalback_n"] forState:UIControlStateNormal];
        [_back setImage:[UIImage imageNamed:@"hospitalback_p"] forState:UIControlStateSelected];
        [self addSubview:_back];
        
        _home = [[UIButton alloc]initWithFrame:CGRectMake(320-40, 0, 40, 40)];
        [_home setImage:[UIImage imageNamed:@"home_n"] forState:UIControlStateNormal];
        [_home setImage:[UIImage imageNamed:@"home_p"] forState:UIControlStateSelected];
        [self addSubview:_home];
        
        _title = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 200, 40)];
        [_title setText:title];
        [_title setTextColor:[UIColor whiteColor]];
        [_title setFont:[UIFont systemFontOfSize:16]];
        [self addSubview:_title];
    }
    return self;
}
@end
