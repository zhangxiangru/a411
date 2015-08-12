
/* 14-12-9:创建
 *
 */

#import "QTHosDesC.h"
#import "UIImageView+WebCache.h"
#import "QTHospitalD.h"

@implementation QTHosDesC
- (void)loadView {
    _scr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20+40+40, QTScreenWidth, QTScreenHeight-(20+40+40))];
    [self setView:_scr];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[self view]setBackgroundColor:[UIColor grayColor]];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, QTScreenWidth, 160)];
    [[self view]addSubview:image];
    [image setImageWithURL:[NSURL URLWithString:[_hoss[0] imgurl]]];
    UIButton *addressBkg = [[UIButton alloc]initWithFrame:CGRectMake(0, 160, QTScreenWidth, 30)];
    [addressBkg setBackgroundColor:[UIColor whiteColor]];
    [[self view]addSubview:addressBkg];
    UIImageView *addressIco = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
    [addressBkg addSubview:addressIco];
    [addressIco setImage:[UIImage imageNamed:@"address_icon_n"]];
    UILabel *addressNam = [[UILabel alloc]initWithFrame:CGRectMake(10+20+5, 0, 200, 30)];
    [addressBkg addSubview:addressNam];
    [addressNam setText:[_hoss[0] hosTraffic]];
    UIButton *phoneBkg = [[UIButton alloc]initWithFrame:CGRectMake(0, 160+30+0.5, QTScreenWidth, 30)];
    [phoneBkg setBackgroundColor:[UIColor whiteColor]];
    [[self view]addSubview:phoneBkg];
    UIImageView *phoneIco = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
    [phoneBkg addSubview:phoneIco];
    [phoneIco setImage:[UIImage imageNamed:@"tel_icon_n"]];
    UILabel *phoneNam = [[UILabel alloc]initWithFrame:CGRectMake(10+20+5, 0, 200, 30)];
    [phoneBkg addSubview:phoneNam];
    [phoneNam setText:[_hoss[0] hosPhone]];
    UILabel *desc = [[UILabel alloc]initWithFrame:CGRectMake(0, 160+30+0.5+30+0.5, QTScreenWidth, 100)];
    [desc setFont:[UIFont systemFontOfSize:14]];
    CGSize size = [[_hoss[0] hosintro] boundingRectWithSize:CGSizeMake(QTScreenWidth, 9999) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [desc font]} context:nil].size;
    [desc setFrame:CGRectMake(0, 160+30+0.5+30+0.5, size.width, size.height)];
    [desc setText:[_hoss[0] hosintro]];
    [desc setNumberOfLines:-1];
    [desc setBackgroundColor:[UIColor whiteColor]];
    [[self view] addSubview:desc];
    [_scr setContentSize:CGSizeMake(QTScreenWidth, 160+30+30+desc.bounds.size.height)];
    [_scr setBounces:NO];
}
@end
