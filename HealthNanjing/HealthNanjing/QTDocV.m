
/* 14-12-10:创建
 *
 */

#import "QTDocV.h"
#import "UIImageView+WebCache.h"
#import "QTWorkD.h"


@implementation QTDocV
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 50, 70)];
        [[_icon layer]setCornerRadius:5];
        [[_icon layer]setMasksToBounds:YES];
        [[self contentView]addSubview:_icon];
        _name = [[UILabel alloc]initWithFrame:CGRectMake(10+50+5, 5, 100, 30)];
        [[self contentView]addSubview:_name];
        _desc = [[UILabel alloc]initWithFrame:CGRectMake(10+50+5, 5+30, QTScreenWidth-(10+50+5+5), 40)];
        [_desc setFont:[UIFont systemFontOfSize:14]];
        [_desc setNumberOfLines:0];
        [[self contentView]addSubview:_desc];
        _level = [[UILabel alloc]initWithFrame:CGRectMake(QTScreenWidth-80, 5, 80, 30)];
        [_level setFont:[UIFont systemFontOfSize:14]];
        [[self contentView]addSubview:_level];
        _work = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 100, QTScreenWidth, 100)];
        [[self contentView]addSubview:_work];
    }
    return self;
}
- (void)setData:(QTDocD *)data {
    [_icon setImageWithURL:[NSURL URLWithString:[data docimage]]placeholderImage:[UIImage imageNamed:@"Doctor_doctorHeadImage"]];
    [_name setText:[data docname]];
    [_desc setText:[data docintro]];
    [_level setText:[data doclevel]];
    
}
- (void)setWorkData:(NSArray *)data {
    NSInteger i = 0;
    while (i<[data count]) {
        QTWorkD *com = data[i];
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(16+(10+QTScreenWidth/2.3)*(i%2), 10+(10+20)*(i/2), QTScreenWidth/2.3, 20)];
        [_work addSubview:btn];
        UIImageView *img = [[UIImageView alloc]initWithFrame:btn.bounds];
        [img setImage:[UIImage imageNamed:@"Doctor_selectBgen"]];
        [btn addSubview:img];
        UILabel *lab = [[UILabel alloc]initWithFrame:btn.bounds];
        [lab setText:[NSString stringWithFormat:@"%@%@", [com workdate], [com worktime]]];
        [lab setTextAlignment:NSTextAlignmentCenter];
        [btn addSubview:lab];
        [btn addTarget:self action:@selector(clickToReserve:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTag:100+i];
        i++;
    }
    [_work setContentSize:CGSizeMake(QTScreenWidth, 10+(10+20)*(i/2))];
}
- (void)clickToReserve:(UIButton *)btn {
    if ([_target respondsToSelector:_action]) {
        [_target performSelector:_action withObject:btn];
    }
}
@end
