
/* 14-12-8:创建
 *
 */

#import "QTHomeC.h"
#import "UIImageView+WebCache.h"
#import "QTDepartmentC.h"
#import "QTDataCenter.h"
#import "QTHospitalD.h"
#import "QTDepartmentD.h"
#import "QTHospitalC.h"
#import "QTUserC.h"

@implementation QTHomeC {
    NSMutableArray *_btns;
    NSMutableArray *_hsptDatas;
    NSMutableArray *_deptDatas;
    NSMutableArray *_rcmdHosps;
    NSMutableArray *_rcmdDepts;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[self view]setBackgroundColor:[UIColor redColor]];
    

#pragma mark 导航栏
    self.navigationController.navigationBarHidden = YES;
    UIImageView *bkg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 320, 40)];
    bkg.image = [UIImage imageNamed:@"home_title_bg"];
    [bkg setUserInteractionEnabled:YES];
    [self.view addSubview:bkg];
    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    logo.image = [UIImage imageNamed:@"icon_home_title"];
    [bkg addSubview:logo];
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 80, 40)];
    name.text = @"健康南京";
    name.textAlignment = NSTextAlignmentLeft;
    name.textColor = [UIColor whiteColor];
    name.font = [UIFont systemFontOfSize:16];
    [bkg addSubview:name];
    UIButton *head = [UIButton buttonWithType:UIButtonTypeCustom];
    head.frame = CGRectMake(40+80+120, 0, 40, 40);
    [head setImage:[UIImage imageNamed:@"reservation_icon"] forState:UIControlStateNormal];
    [head setImage:[UIImage imageNamed:@"reservation_icon_down"] forState:UIControlStateSelected];
    [head addTarget:self action:@selector(reserveRecord) forControlEvents:UIControlEventTouchUpInside];
    [bkg addSubview:head];
    UIButton *menu = [[UIButton alloc]initWithFrame:CGRectMake(40+80+120+40, 0, 40, 40)];
    [menu setImage:[UIImage imageNamed:@"icon_menu"] forState:UIControlStateNormal];
    [bkg addSubview:menu];
#pragma mark 选择医院
    UIImageView *bkg2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20+40, 320, 150)];
    bkg2.image = [UIImage imageNamed:@"home_banner_bg"];
    [bkg2 setUserInteractionEnabled:YES];
    [self.view addSubview:bkg2];
    UIButton *hsp = [[UIButton alloc]initWithFrame:CGRectMake(110, 5, 100, 100)];
    [hsp setImage:[UIImage imageNamed:@"icon_bespeak"] forState:UIControlStateNormal];
    [hsp setImage:[UIImage imageNamed:@"icon_bespeak_down"] forState:UIControlStateSelected];
    [hsp addTarget:self action:@selector(selectHospital:) forControlEvents:UIControlEventTouchUpInside];
    [bkg2 addSubview:hsp];
    UILabel *tip =[[UILabel alloc]initWithFrame:CGRectMake(100, 100+5, 120, 30)];
    tip.text = @"请选择就诊医院";
    tip.textColor = [UIColor whiteColor];
    tip.textAlignment = NSTextAlignmentCenter;
    tip.font = [UIFont systemFontOfSize:16];
    [bkg2 addSubview:tip];
    UIImageView *rec = [[UIImageView alloc]initWithFrame:CGRectMake(5, 100+5+20, 80, 25)];
    rec.image = [UIImage imageNamed:@"icon_hospital_recommend"];
    rec.contentMode = UIViewContentModeScaleAspectFit;
    [bkg2 addSubview:rec];
#pragma mark 名院推荐
    
    //医院名称
    NSArray *names = @[@"南京鼓楼医院",
                       @"南京市妇幼保健院",
                       @"江苏省中医院",
                       @"江苏省中西医结合医院",
                       @"南医大二附院",
                       @"南京市口腔医院"];
    
    //医院地址
    NSArray *adrss = @[@"南京市中山路321号",
                       @"南京市莫愁路天妃巷123号",
                       @"南京市汉中路155号",
                       @"南京市红山路十字街100号",
                       @"南京市姜家园121号",
                       @"南京市中央路30号"];
    
    //医院图标
    NSArray *icons = @[@"http://scnc.wfeature.com/uploadDir/file_service/Focus/20131231/151612752.jpg",
                       @"http://scnc.wfeature.com/uploadDir/file_service/Focus/20131231/145936709.jpg",
                       @"http://scnc.wfeature.com/uploadDir/file_service/Focus/20131231/151835988.jpg",
                       @"http://scnc.wfeature.com/uploadDir/file_service/Focus/20131231/151852403.jpg",
                       @"http://scnc.wfeature.com/uploadDir/file_service/Focus/20131231/151735685.jpg",
                       @"http://scnc.wfeature.com/uploadDir/file_service/Focus/20131231/145835711.jpg"];
    
    
    UIScrollView *bkg3 = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20+40+150, 320, 480-(20+40+150))];
    bkg3.tag = 13;
    bkg3.backgroundColor = [UIColor grayColor];
//    bkg3.userInteractionEnabled = YES;
    bkg3.bounces = NO;
    [self.view addSubview:bkg3];
    
    NSInteger i=0;
    while (i<[names count]) {
        
        //背景颜色
        UIButton *bkg = [[UIButton alloc]initWithFrame:CGRectMake(0, (80+0.5)*i, 320, 80)];
        bkg.backgroundColor = [UIColor redColor];
        [bkg addTarget:self action:@selector(hspClick:) forControlEvents:UIControlEventTouchUpInside];
        bkg.tag = 100+i;
        [bkg3 addSubview:bkg];
        
        //图片医院
        UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 70, 70)];
        [icon setImageWithURL:[NSURL URLWithString:icons[i]]];
        icon.layer.cornerRadius = 10;
        icon.layer.masksToBounds = YES;
        [bkg addSubview:icon];
        
        //医院名称
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(80+10, 5, 200, 40)];
        name.text = names[i];
        name.textColor = [UIColor colorWithRed:0 green:0.67 blue:0.89 alpha:1];
        [bkg addSubview:name];
        
        //医院地址
        UILabel *adrs = [[UILabel alloc]initWithFrame:CGRectMake(80+10, 5+40, 200, 30)];
        adrs.text = adrss[i];
        adrs.font = [UIFont systemFontOfSize:16];
        [bkg addSubview:adrs];
        [_btns addObject:bkg];
        i++;
    }
    bkg3.contentSize = CGSizeMake(320, (80+0.5)*i);
    
    
    //等待显示
    UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [act setColor:[UIColor greenColor]];
    [act setBackgroundColor:[UIColor blackColor]];
    [act setAlpha:0.5];
    [act setFrame:[[self view]bounds]];
//    [act setHidesWhenStopped:YES];
    [act startAnimating];
    [[self view]addSubview:act];
    [self performSelector:@selector(dataReqsTimeout) withObject:nil afterDelay:3];
#pragma mark 数据处理
    _btns = [[NSMutableArray alloc]init];
    _hsptDatas = [[NSMutableArray alloc]init];
    _deptDatas = [[NSMutableArray alloc]init];
    _rcmdHosps = [[NSMutableArray alloc]init];
    _rcmdDepts = [[NSMutableArray alloc]init];
    
    [[QTDataCenter sharedDataCenter]dataFromUrl:@"http://hospital.wfeature.com/base/services/reserve/hospitals" success:^(NSData *data) {
        NSDictionary *dtn = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *rstInfo = dtn[@"rstInfo"];
        NSDictionary *hospitals = rstInfo[@"hospitals"];
        NSArray *hospList = hospitals[@"hospList"];
        for (NSDictionary *hospital in hospList) {
            QTHospitalD *hsptData = [[QTHospitalD alloc]init];
            [hsptData setHoscode:hospital[@"hoscode"]];
            [hsptData setHosintro:hospital[@"hosintro"]];
            [hsptData setHoslevel:hospital[@"hoslevel"]];
            [hsptData setHosname:hospital[@"hosname"]];
            [hsptData setHosPhone:hospital[@"hosPhone"]];
            [hsptData setHosTraffic:hospital[@"hosTraffic"]];
            [hsptData setHostype:hospital[@"hostype"]];
            [hsptData setImgurl:hospital[@"imgurl"]];
            [hsptData setLatitude:hospital[@"latitude"]];
            [hsptData setLongitude:hospital[@"longitude"]];
            [_hsptDatas addObject:hsptData];
            
            NSDictionary *departments = hospital[@"departments"];
            NSArray *departmentsList = departments[@"departmentsList"];
            for (NSDictionary *department in departmentsList) {
                
                QTDepartmentD *deptData = [[QTDepartmentD alloc]init];
                [deptData setHoscode:department[@"hoscode"]];
                [deptData setDepcode:department[@"depcode"]];
                [deptData setDepid:department[@"depid"]];
                [deptData setDepintro:department[@"depintro"]];
                [deptData setDepname:department[@"depname"]];
                [_deptDatas addObject:deptData];
            }
        }
        NSArray *codes = @[@"32010100",
                           @"32010500",
                           @"13102000",
                           @"466002673",
                           @"32000800",
                           @"32010800"];
        NSUInteger i = 0;
        while (i<[codes count]) {
            for (QTHospitalD *hos in _hsptDatas) {
                if ([[hos hoscode]isEqualToString:codes[i]]) {
                    [_rcmdHosps addObject:hos];
                }
            }
            i++;
        }
        i = 0;
        while (i<[codes count]) {
            for (QTDepartmentD *dep in _deptDatas) {
                if ([[dep hoscode]isEqualToString:[_rcmdHosps[i] hoscode]]) {
                    [_rcmdDepts addObject:dep];
                }
            }
            i++;
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:@"dataOk" object:nil];
        [act stopAnimating];
        [[self class]cancelPreviousPerformRequestsWithTarget:self];
    }];
}
- (void)hspClick:(UIButton *)btn {
    
    NSInteger idx = btn.tag-100;
    for (UIButton *btn in _btns) {
        btn.selected = NO;
        btn.backgroundColor = [UIColor whiteColor];
    }
    btn.selected = YES;
    if (btn.selected) {
    }
    QTDepartmentC *dept = [[QTDepartmentC alloc]init];
    
    dept.hoscode = [_rcmdHosps[idx]hoscode];
    dept.hosname = [_rcmdHosps[idx]hosname];
    dept.hoss = @[_rcmdHosps[idx]];
    dept.depts = _rcmdDepts;
//    NSMutableArray *hoss = [[NSMutableArray alloc]init];
//    [hoss addObject:hspt];
//    [dept setDepts:deps];
//    [dept setHoss:hoss];
    [self.navigationController pushViewController:dept animated:YES];
}
#pragma mark 选择医院触摸事件
- (void)selectHospital:(UIButton *)btn {
    QTHospitalC *hspt = [[QTHospitalC alloc]init];
    [hspt setHspts:_hsptDatas];
    [hspt setDepts:_deptDatas];
    [[self navigationController]pushViewController:hspt animated:YES];
}
- (void)dataReqsTimeout {
    UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"网络异常" message:@"您的网络不给力,需要更长等待时间" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:@"退出", nil];
    [alt show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"退出失败" message:@"请按 shift+h" delegate:nil cancelButtonTitle:@"我日" otherButtonTitles:nil];
        [alt show];
    }
}
- (void)reserveRecord {
    QTUserC *user = [[QTUserC alloc]init];
    
    [[self navigationController]pushViewController:user animated:YES];
}
@end
