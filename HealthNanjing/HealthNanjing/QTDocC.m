
/* 14-12-10:创建
 *
 */

#import "QTDocC.h"
#import "QTDepartmentD.h"
#import "QTDocD.h"
#import "QTWorkD.h"
#import "UIImageView+WebCache.h"
#import "QTDocV.h"
#import "QTCommonV.h"
#import "QTReserveC.h"

@implementation QTDocC
- (void)viewDidLoad {
    [super viewDidLoad];
    [[self view]setBackgroundColor:[UIColor orangeColor]];
#pragma mark 界面布局
    UITableView *tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, QTScreenWidth, QTScreenHeight-(20+40+40)) style:UITableViewStyleGrouped];
    [[self view]addSubview:tab];
    [tab setDataSource:self];
    [tab setDelegate:self];
    [tab setBounces:NO];
    [tab setTag:10000];
    [tab setSectionFooterHeight:0];
    
#pragma mark 下载数据
    UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [act setColor:[UIColor greenColor]];
    [act setBackgroundColor:[UIColor blackColor]];
    [act setAlpha:0.5];
    [act setFrame:CGRectMake(0, 0, QTScreenWidth, QTScreenHeight)];
    [act setCenter:CGPointMake([[self view]center].x, [[self view]center].y-100)];
    //    [act setHidesWhenStopped:YES];
    [act startAnimating];
    [[self view]addSubview:act];
    
    _docs = [[NSMutableArray alloc]init];
    _woks = [[NSMutableArray alloc]init];
    _coms = [[NSMutableArray alloc]init];
    NSString *url = [NSString stringWithFormat:@"http://hospital.wfeature.com/base/services/reserve/departments?hoscode=%@&depid=%@&depcode=%@", _hoscode, _depid, _depcode];
    NSLog(@"%@", url);
    [[QTDataCenter sharedDataCenter]dataFromUrl:url success:^(NSData *data) {
        NSDictionary *doc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *rstInfo = doc[@"rstInfo"];
        id departments = rstInfo[@"departments"];
        if ([departments isKindOfClass:[NSString class]]) {
            [act stopAnimating];
            UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"无预约数据" message:@"此科室暂不支持预约" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alt show];
            return;
        }
        NSArray *departments2 = departments[@"department"];
        for (NSDictionary *department in departments2) {
            NSDictionary *schedules = department[@"schedules"];
            NSArray *scheduless = schedules[@"schedule"];
            if (![scheduless isKindOfClass:[NSString class]]) {
                for (NSDictionary *schedule in scheduless) {
                    QTWorkD *com = [[QTWorkD alloc]init];
                    [com setWorkcode:schedule[@"schcode"]];
                    [com setWorkdate:schedule[@"workdate"]];
                    [com setWorktime:schedule[@"worktime"]];
                    [com setType:schedule[@"reservetype"]];
                    [com setMoney:schedule[@"charge"]];
                    [_coms addObject:com];
                }
            } else {
//                UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"无预约数据" message:@"此科室暂不支持预约" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
//                [alt show];
            }
            NSDictionary *doctors = department[@"doctors"];
            id doctors2 = doctors[@"doctor"];
//            NSLog(@"%@", doctors);
            if ([doctors2 isKindOfClass:[NSString class]]) {
                
                continue;
            }
            for (NSDictionary *doctor in doctors2) {
                QTDocD *doc = [[QTDocD alloc]init];
                [doc setDoccode:doctor[@"doccode"]];
                [doc setDocid:doctor[@"docid"]];
                [doc setDocimage:doctor[@"imgUrl"]];
                [doc setDocintro:doctor[@"docintro"]];
                [doc setDoclevel:doctor[@"principalship"]];
                [doc setDocname:doctor[@"docname"]];
                [_docs addObject:doc];
                NSDictionary *schedules = doctor[@"schedules"];
                id schedules2 = schedules[@"schedule"];
                if ([schedules2 isKindOfClass:[NSString class]]) {
                    continue;
                }
                for (NSDictionary *schedule in (NSArray *)schedules2) {
                    QTWorkD *wok = [[QTWorkD alloc]init];
                    [wok setDoccode:doctor[@"doccode"]];
                    [wok setDocid:doctor[@"docid"]];
                    [wok setWorkcode:schedule[@"schcode"]];
                    [wok setWorkdate:schedule[@"workdate"]];
                    [wok setWorktime:schedule[@"worktime"]];
                    [wok setType:schedule[@"reservetype"]];
                    [wok setMoney:schedule[@"charge"]];
                    [_woks addObject:wok];
                }
            }
        }
        [tab reloadData];
        [act stopAnimating];
    }];
    

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        if (_hide) {
            return 0;
        }
        return 1;
    }
    
    return [_docs count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_docidx isEqual:indexPath] && _dochide == YES) {
        return 200;
    }
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, QTScreenWidth, 40)];
//    [btn setBackgroundColor:[UIColor orangeColor]];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
    if (section == 0) {
        [lab setText:@"普通门诊"];
    } else {
        [lab setText:@"专家门诊"];
    }
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(QTScreenWidth-40, 5, 30, 30)];
    [img setImage:[UIImage imageNamed:@"Doctor_ArrowUp"]];
    [btn addSubview:lab];
    [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTag:section];
    return btn;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 1) {
        static NSString *cellid = @"cellid";
        QTDocV *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[QTDocV alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        [cell setTarget:self];
        [cell setAction:@selector(clickToReserve:)];
        QTDocD *data = _docs[[indexPath row]];
        [cell setData:data];
        NSMutableArray *works = [[NSMutableArray alloc]init];
        for (QTWorkD *wok in _woks) {
            if ([[wok doccode] isEqualToString:[data doccode]]) {
                [works addObject:wok];
            }
        }
        [cell setWorkData:works];
        return cell;
    } else {
        QTCommonV *cell = [[QTCommonV alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [cell setData:_coms];
        [cell setTarget:self];
        [cell setAction:@selector(clickToReserve2:)];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _docidx = indexPath;
    if (!_dochide) {
        _dochide = YES;
    } else {
        _dochide = NO;
    }
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
- (void)clickAction:(UIButton *)btn {
    if ([btn tag] == 0) {
        if (_hide == NO) {
            _hide = YES;
        } else {
            _hide = NO;
        }
        UITableView *tab =(UITableView *)[[self view]viewWithTag:10000];
        [tab reloadData];
    }
}
- (void)clickToReserve:(UIButton *)btn {
    QTReserveC *rsv = [[QTReserveC alloc]init];
    [rsv setDocname:[_docs[[_docidx row]]docname]];
    [rsv setDepname:_depname];
    [rsv setHosname:_hosname];
    NSMutableArray *works = [[NSMutableArray alloc]init];
    for (QTWorkD *work in _woks) {
        if ([[work doccode] isEqualToString:[_docs[[_docidx row]]doccode]]) {
            [works addObject:work];
            if ([works indexOfObject:work] == [btn tag]-100) {
                [rsv setMoney:[work money]];
                [rsv setDate:[work workdate]];
                [rsv setTime:[work worktime]];
            }
        }
    }
    _push(rsv);
}
- (void)clickToReserve2:(UIButton *)btn {
    QTReserveC *rsv = [[QTReserveC alloc]init];
    [rsv setDocname:@"普通门诊"];
    [rsv setDepname:_depname];
    [rsv setHosname:_hosname];
    NSMutableArray *works = [[NSMutableArray alloc]init];
    for (QTWorkD *work in _coms) {
        NSLog(@"%@", _coms);
//        if ([[work doccode] isEqualToString:[_docs[[_docidx row]]doccode]]) {
            [works addObject:work];
            if ([works indexOfObject:work] == [btn tag]-100) {
                [rsv setMoney:[work money]];
                [rsv setDate:[work workdate]];
                [rsv setTime:[work worktime]];
            }
//        }
    }
    _push(rsv);
}
@end
