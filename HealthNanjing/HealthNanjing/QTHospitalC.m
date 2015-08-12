
/* 14-12-8:创建
 *
 */

#import "QTHospitalC.h"
#import "QTNavigationBarV.h"
#import "QTHospitalD.h"
#import "QTHospitalV.h"
#import "UIImageView+WebCache.h"
#import "QTDepartmentC.h"
#import "QTDepartmentD.h"


@implementation QTHospitalC {
    BOOL _isRefresh;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[self view]setBackgroundColor:[UIColor purpleColor]];
#pragma mark 导航栏视图
    QTNavigationBarV *nvgt = [[QTNavigationBarV alloc]initWithTitle:@"请选择医院"];
    [[self view]addSubview:nvgt];
    [[nvgt back]addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [[nvgt home]addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
#pragma mark 医院列表视图
    UITableView *tabv = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [tabv setTag:111];
    [tabv setFrame:CGRectMake(0, 20+40, QTScreenWidth, QTScreenHeight-(20+40))];
    [self.view addSubview:tabv];
    [tabv setDataSource:self];
    [tabv setDelegate:self];
    [tabv setRowHeight:80.0];
    [tabv setBounces:NO];
    
    EGORefreshTableHeaderView *ego = [[EGORefreshTableHeaderView alloc]initWithFrame:CGRectMake(0, -tabv.bounds.size.height, tabv.bounds.size.width, tabv.bounds.size.height)];
    ego.delegate = self;
    [self.view addSubview:ego];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dataOk) name:@"dataOk" object:nil];
}
#pragma mark 数据更新
- (void)dataOk {
    UITableView *tabv = (UITableView *)[[self view]viewWithTag:111];
    [tabv reloadData];
}
#pragma mark 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_hspts count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"cellid";
    QTHospitalV *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[QTHospitalV alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    QTHospitalD *data = _hspts[[indexPath row]];
    [[cell imgurl]setImageWithURL:[NSURL URLWithString:[data imgurl]]];
    [[cell hosname]setText:[data hosname]];
    [[cell hosTraffic]setText:[data hosTraffic]];
    [[cell hosPhone]setText:[data hosPhone]];
    if ([[data hoslevel]integerValue] == 3) {
        [[cell hoslevel]setImage:[UIImage imageNamed:@"sanjia_icon"]];
    } else {
        [[cell hoslevel]setImage:nil];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QTDepartmentC *dept = [[QTDepartmentC alloc]initWithType:QTHospitalDep];
    QTHospitalD *hspt = _hspts[[indexPath row]];
    [dept setHosname:[hspt hosname]];
    [dept setHoscode:[hspt hoscode]];
    NSMutableArray *deps = [[NSMutableArray alloc]init];
    for (QTDepartmentD *dep in _depts) {
        if ([dep hoscode] == [hspt hoscode]) {
            [deps addObject:dep];
        }
    }
    NSMutableArray *hoss = [[NSMutableArray alloc]init];
    [hoss addObject:hspt];
    [dept setDepts:deps];
    [dept setHoss:hoss];
    [[self navigationController]pushViewController:dept animated:YES];
}
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view {
    _isRefresh = YES;
    [((UITableView *)[self.view viewWithTag:111])reloadData];
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view {
    return _isRefresh;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view.subviews[2] egoRefreshScrollViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.view.subviews[2] egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mar 导航栏事件
- (void)back {
    [[self navigationController]popViewControllerAnimated:YES];
}
- (void)home {
    [[self navigationController]popToRootViewControllerAnimated:YES];
}
@end
