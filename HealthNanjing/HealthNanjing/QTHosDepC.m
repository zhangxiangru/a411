
/* 14-12-9:创建
 *
 */

#import "QTHosDepC.h"
#import "QTDepartmentD.h"
#import "QTDepartmentC.h"

@implementation QTHosDepC
- (void)loadView {
    _scr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20+40+40, QTScreenWidth, QTScreenHeight-(20+40+40))];
    [self setView:_scr];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[self view]setBackgroundColor:[UIColor grayColor]];
#pragma mark 科室查询
    _btns = [[NSMutableArray alloc]init];
    NSInteger i = 0;
    while (i<[_deps count]) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, (40+0.5)*i, QTScreenWidth, 40)];
        [[self view]addSubview:btn];
        [btn setTitle:[_deps[i] depname] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTag:100+i];
        [btn addTarget:self action:@selector(toDoc:) forControlEvents:UIControlEventTouchUpInside];
        [_btns addObject:btn];
        i++;
    }
    [_scr setContentSize:CGSizeMake(QTScreenWidth, (40+0.5)*i)];
    [_scr setBounces:NO];
    [_scr setUserInteractionEnabled:YES];
}
- (void)toDoc:(UIButton *)btn {
    NSInteger idx = [btn tag]-100;
    QTDepartmentC *dep = [[QTDepartmentC alloc]initWithType:QTHospitalDoc];
//    QTDepartmentC *dep = [[QTDepartmentC alloc]init];
    [dep setDepname:[_deps[idx] depname]];
    [dep setDepcode:[_deps[idx] depcode]];
    [dep setDepid:[_deps[idx] depid]];
//    [dep setHoscode:[_deps[idx] hoscode]];
    [dep setDepSel:@[_deps[idx]]];
    [dep setHoscode:_hoscode];
    [dep setHosname:_hosname];
    _push(dep);
}
@end
