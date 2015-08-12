
/* 14-12-9:创建
 *
 */

#import "QTHospitalV.h"

@implementation QTHospitalV
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgurl = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 70, 70)];
        [[_imgurl layer]setCornerRadius:10];
        [[_imgurl layer]setMasksToBounds:YES];
        [_imgurl setContentMode:UIViewContentModeScaleAspectFill];
        [[self contentView]addSubview:_imgurl];
        _hosname = [[UILabel alloc]initWithFrame:CGRectMake(10+70+5, 5, 160, 30)];
        [_hosname setFont:[UIFont systemFontOfSize:16]];
        [_hosname setTextColor:[UIColor colorWithRed:0 green:0.67 blue:0.89 alpha:1]];
        [[self contentView]addSubview:_hosname];
        _trafic = [[UIImageView alloc]initWithFrame:CGRectMake(10+70+5, 5+30+5, 15, 15)];
        [_trafic setImage:[UIImage imageNamed:@"address_icon_n"]];
        [[self contentView]addSubview:_trafic];
        _hosTraffic = [[UILabel alloc]initWithFrame:CGRectMake(10+70+20+5, 5+30, 200, 20)];
        [_hosTraffic setFont:[UIFont systemFontOfSize:14]];
        [_hosTraffic setTextColor:[UIColor blackColor]];
        [[self contentView]addSubview:_hosTraffic];
        _phone = [[UIImageView alloc]initWithFrame:CGRectMake(10+70+5, 5+30+20+3, 15, 15)];
        [_phone setImage:[UIImage imageNamed:@"tel_icon_n"]];
        [[self contentView]addSubview:_phone];
        _hosPhone = [[UILabel alloc]initWithFrame:CGRectMake(10+70+20+5, 5+30+20, 150, 20)];
        [_hosPhone setFont:[UIFont systemFontOfSize:14]];
        [_hosPhone setTextColor:[UIColor blackColor]];
        [[self contentView]addSubview:_hosPhone];
        _hoslevel = [[UIImageView alloc]initWithFrame:CGRectMake(QTScreenWidth-70, 10, 60, 20)];
//        [_hoslevel setImage:[UIImage imageNamed:@"sanjia_icon"]];
        [[self contentView]addSubview:_hoslevel];
    }
    return self;
}
@end
