
/* 14-12-8:创建
 *
 */

#import "QTDepartmentC.h"
#import "QTNavigationBarV.h"
#import "QTNavigationTabV.h"
#import "QTHosDepC.h"
#import "QTHosDesC.h"
#import "QTHospitalD.h"
#import "QTDocC.h"
#import "QTDocDesC.h"

@implementation QTDepartmentC {
    NSUInteger _lastIdx;
}
- (id)initWithType:(QTHospitalType)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
#pragma mark 导航栏
    QTNavigationBarV *nvgb = nil;
    if (_type == QTHospitalDep) {
        nvgb = [[QTNavigationBarV alloc]initWithTitle:_hosname];
    } else {
        nvgb = [[QTNavigationBarV alloc]initWithTitle:_depname];
    }
    [[self view]addSubview:nvgb];
    [[nvgb back]addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [[nvgb home]addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
#pragma mark 标签栏
    NSMutableArray *titles = [[NSMutableArray alloc]init];
    if (_type == QTHospitalDep) {
        [titles addObject:@"医院科室"];
        [titles addObject:@"医院简介"];
    } else {
        [titles addObject:@"科室医生"];
        [titles addObject:@"科室简介"];
    }
    _btns = [[NSMutableArray alloc]init];
    NSInteger i = 0;
    while (i<[titles count]) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(QTScreenWidth/[titles count]*i, 20+40, QTScreenWidth/[titles count], 40)];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setImage:[UIImage imageNamed:@"rb01_noselected_hd"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"rb01_selected_hd"] forState:UIControlStateSelected];
        [[self view] addSubview:btn];
        if (i == 0) {
            [btn setSelected:YES];
        }
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, QTScreenWidth/[titles count], 40)];
        [lab setBackgroundColor:[UIColor clearColor]];
        [lab setTextAlignment:NSTextAlignmentCenter];
        [lab setText:titles[i]];
        [btn addSubview:lab];
        [btn setTag:100+i];
        [btn addTarget:self action:@selector(changec:) forControlEvents:UIControlEventTouchUpInside];
        [_btns addObject:btn];
        i++;
    }
#pragma mark 分页栏
    _cs = [[NSMutableArray alloc]init];
    if (_type == QTHospitalDep) {
        QTHosDepC *hosdept = [[QTHosDepC alloc]init];
        [hosdept setDeps:_depts];
        [hosdept setHoscode:_hoscode];
        [hosdept setHosname:_hosname];
        [hosdept setPush:^(UIViewController *dep){
            [[self navigationController]pushViewController:dep animated:YES];
        }];
        QTHosDesC *hosdesc = [[QTHosDesC alloc]init];
        [hosdesc setHoss:_hoss];
        [_cs addObject:hosdept];
        [_cs addObject:hosdesc];
    } else {
        QTDocC *doc = [[QTDocC alloc]init];
        [doc setDepcode:_depcode];
        [doc setDepid:_depid];
        [doc setHoscode:_hoscode];
        [doc setHosname:_hosname];
        [doc setDepname:_depname];
        [doc setDeps:_depSel];
        [doc setPush:^(UIViewController *rsv) {
            [[self navigationController]pushViewController:rsv animated:YES];
        }];
        NSLog(@"%@", doc);
        QTDocDesC *des = [[QTDocDesC alloc]init];
        [des setDepSel:_depSel];
        [_cs addObject:doc];
        [_cs addObject:des];
    }
    
    _pagc = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    [_pagc setViewControllers:@[_cs[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [_pagc setDataSource:self];
    [_pagc setDelegate:self];
    [[self view]addSubview:[_pagc view]];
    [[_pagc view]setFrame:CGRectMake(0, 20+40+40, QTScreenWidth, QTScreenHeight-(20+40+40))];
    
    
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger idx = [_cs indexOfObject:viewController];
    NSLog(@"%i", idx);
    idx++;
    for (UIButton *btn in _btns) {
        [btn setSelected:NO];
    }
    if (idx == [_cs count]) {
        [_btns[--idx] setSelected:YES];
        return nil;
    } else {
        [_btns[idx] setSelected:YES];
        return _cs[idx];
    }
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger idx = [_cs indexOfObject:viewController];
    NSLog(@"%i", idx);
    idx--;
    for (UIButton *btn in _btns) {
        [btn setSelected:NO];
    }
    if (idx < 0) {
        [_btns[++idx] setSelected:YES];
        return nil;
    } else {
        [_btns[idx] setSelected:YES];
        return _cs[idx];
    }
}
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    NSUInteger idx = [_cs indexOfObject:previousViewControllers[0]];
    if (completed) {
        for (UIButton *btn in _btns) {
            [btn setSelected:NO];
        }
        [_btns[idx] setSelected:YES];
    }
}

#pragma mar 导航栏事件
- (void)back {
    [[self navigationController]popViewControllerAnimated:YES];
}
- (void)home {
    [[self navigationController]popToRootViewControllerAnimated:YES];
}
#pragma mark 标签栏事件
- (void)changec:(UIButton *)btn {
    for (UIButton *btn in _btns) {
        [btn setSelected:NO];
    }
    [btn setSelected:YES];
    NSInteger idx = [btn tag]-100;
    if (idx>_lastIdx) {
        [_pagc setViewControllers:@[_cs[idx]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    } else {
        [_pagc setViewControllers:@[_cs[idx]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    }
    
}
@end
