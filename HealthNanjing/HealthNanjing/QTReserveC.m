
/* 14-12-11:创建
 *
 */

#import "QTReserveC.h"
#import "QTNavigationBarV.h"

@implementation QTReserveC {
    UIScrollView *_bkg;
    BOOL _scro;
}
//- (void)loadView {
//    _bkg = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, QTScreenWidth, QTScreenHeight)];
//    [self setView:_bkg];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, QTScreenWidth, QTScreenHeight-20)];
    [view setBackgroundColor:[UIColor whiteColor]];
    [[self view]addSubview:view];
//    [[UIApplication sharedApplication]setStatusBarHidden:YES];
#pragma mark 导航栏
    QTNavigationBarV *nvgb = [[QTNavigationBarV alloc]initWithTitle:@"预约信息"];
    [[self view]addSubview:nvgb];
    [[nvgb back]addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [[nvgb home]addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
    _bkg = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20+40, QTScreenWidth, QTScreenHeight-(20+40))];
    [_bkg setTag:112];
    [[self view]addSubview:_bkg];
#pragma mark 挂号信息
    NSArray *title = @[@"  医师", @"  科室", @"  医院", @"  时间", @"  费用"];
    NSArray *conte = @[_docname, _depname, _hosname, [NSString stringWithFormat:@"%@%@", _date, _time], _money];
    NSInteger i = 0;
    while (i<[title count]) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 30*i, QTScreenWidth, 30)];
        [lab setText:[NSString stringWithFormat:@"%@: %@", title[i], conte[i]]];
        [lab setBackgroundColor:[UIColor whiteColor]];
        [lab setUserInteractionEnabled:NO];
        [_bkg addSubview:lab];
        i++;
    }
#pragma mark 个人信息
    NSArray *title2 =@[@"  姓   名:", @"  身份证:", @"  手机号:"];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, (30*[title count]), QTScreenWidth, 30)];
    [lab setText:@"  请填写预约信息"];
    [lab setBackgroundColor:[UIColor whiteColor]];
    [lab setFont:[UIFont boldSystemFontOfSize:18]];
    [_bkg addSubview:lab];
    i = 0;
    while (i<[title2 count]) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, (30+30*[title count])+30*i, 70, 30)];
        [lab setText:title2[i]];
        [lab setBackgroundColor:[UIColor whiteColor]];
        [_bkg addSubview:lab];
        UITextField *tfd = [[UITextField alloc]initWithFrame:CGRectMake(70, (30+30*[title count])+30*i, QTScreenWidth-70, 30)];
        [tfd setBackgroundColor:[UIColor whiteColor]];
        [tfd setClearButtonMode:UITextFieldViewModeAlways];
        [tfd setDelegate:self];
        [tfd setReturnKeyType:UIReturnKeyNext];
        [tfd setPlaceholder:@"请输入"];
        [tfd setTag:100+i];
//        [tfd setPlaceholder:[NSString stringWithFormat:@"请输入%@", title2[i]]];
        [_bkg addSubview:tfd];
        if (i == 1) {
//            [tfd setKeyboardType:UIKeyboardTypeNumberPad];
            [tfd setReturnKeyType:UIReturnKeyNext];
        }
        i++;
    }
#pragma mark 就诊卡信息
    NSArray *title3 =@[@"  就诊卡号码:", @"  就诊卡密码:"];
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(0, (30+30*[title count]+30*[title2 count]), QTScreenWidth, 30)];
    [lab3 setText:@"  请填写您在该院的就诊卡信息"];
    [lab3 setBackgroundColor:[UIColor whiteColor]];
    [lab3 setFont:[UIFont boldSystemFontOfSize:18]];
    [_bkg addSubview:lab3];
    i = 0;
    while (i<[title3 count]) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, (30+30+30*[title count]+30*[title2 count])+30*i, 110, 30)];
        [lab setText:title3[i]];
        [lab setBackgroundColor:[UIColor whiteColor]];
        [_bkg addSubview:lab];
        UITextField *tfd = [[UITextField alloc]initWithFrame:CGRectMake(110, (30+30+30*[title count]+30*[title2 count])+30*i, QTScreenWidth-110, 30)];
        [tfd setBackgroundColor:[UIColor whiteColor]];
        [tfd setClearButtonMode:UITextFieldViewModeAlways];
        [tfd setDelegate:self];
        [tfd setReturnKeyType:UIReturnKeyNext];
        [tfd setPlaceholder:@"请输入"];
        [tfd setTag:110+i];
//        [tfd setPlaceholder:[NSString stringWithFormat:@"请输入%@", title3[i]]];
        [_bkg addSubview:tfd];
        if (i == 1) {
            [tfd setSecureTextEntry:YES];
        } else {
//            [tfd setKeyboardType:UIKeyboardTypeNumberPad];
        }
        i++;
    }
#pragma mark 预约按钮
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(40, 40+30+30*[title count]+30*[title2 count]+30*[title3 count], QTScreenWidth-40*2, 30)];
    [btn setBackgroundImage:[UIImage imageNamed:@"btn_bespeak"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"btn_bespeak_down"] forState:UIControlStateSelected];
    [btn setTitle:@"预  约" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(reserveCommit) forControlEvents:UIControlEventTouchUpInside];
    [_bkg addSubview:btn];
    [_bkg setContentSize:CGSizeMake(QTScreenWidth, 50+30+30*[title count]+30*[title2 count]+30*[title3 count])];
    [_bkg setBounces:NO];
}
#pragma mar 导航栏事件
- (void)back {
    [[self navigationController]popViewControllerAnimated:YES];
}
- (void)home {
    [[self navigationController]popToRootViewControllerAnimated:YES];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGSize size = _bkg.contentSize;
    if (!_scro) {
        [_bkg setContentSize:CGSizeMake(size.width, size.height+246)];
        _scro = YES;
    }
    for (UIView *view in [[self view]subviews]) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            [UIView animateWithDuration:0.5 animations:^{
//                if ([textField frame].origin.y+30 > [(UIScrollView *)view contentSize].height-216-50) {
//                    return;
//                }
                [(UIScrollView *)view setContentOffset:CGPointMake(0, textField.frame.origin.y-174)];
            }];
        }
    }
}
- (void)reserveCommit {
    for (UIView *view in [_bkg subviews]) {
        if ([view isKindOfClass:[UITextField class]]) {
            if ([[((UITextField *)view) text]isEqualToString:@""]) {
                UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"信息不完整" message:@"您填写的信息不完整,请完善后再预约" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
                [alt show];
                return;
            }
        }
    }
    NSMutableArray *data = [[NSMutableArray alloc]init];
    [data addObject:_docname];
    [data addObject:_depname];
    [data addObject:_hosname];
    [data addObject:_date];
    [data addObject:_time];
    [data addObject:_money];
    for (UIView *view in [_bkg subviews]) {
        if ([view isKindOfClass:[UITextField class]]) {
            [data addObject:[((UITextField *)view) text]];
        }
    }
    NSLog(@"%@", data);
    [[QTDataCenter sharedDataCenter]insertDataFromArray:data];
    UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"预约成功" message:@"请根据预约时间到医院就诊" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alt show];
    for (UIView *view in [_bkg subviews]) {
        if ([view isKindOfClass:[UITextField class]]) {
            [((UITextField *)view) setText:nil];
        }
    }
}
@end
