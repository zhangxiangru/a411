
/* 14-12-10:创建
 *
 */

#import "QTExpertV.h"
#import "QTWorkD.h"

@implementation QTExpertV
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _scr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, QTScreenWidth, 100)];
        [[self contentView]addSubview:_scr];
    }
    return self;
}
- (void)setData:(NSArray *)data {
    NSInteger i = 0;
    while (i<[data count]) {
        QTWorkD *com = data[i];
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(16+(10+QTScreenWidth/2.3)*(i%2), 10+(10+20)*(i/2), QTScreenWidth/2.3, 20)];
        [_scr addSubview:btn];
        UIImageView *img = [[UIImageView alloc]initWithFrame:btn.bounds];
        [img setImage:[UIImage imageNamed:@"Doctor_selectBgen"]];
        [btn addSubview:img];
        UILabel *lab = [[UILabel alloc]initWithFrame:btn.bounds];
        [lab setText:[NSString stringWithFormat:@"%@%@", [com workdate], [com worktime]]];
        [lab setTextAlignment:NSTextAlignmentCenter];
        [btn addSubview:lab];
        i++;
    }
    [_scr setContentSize:CGSizeMake(QTScreenWidth, 10+(10+20)*(i/2))];
}

@end
