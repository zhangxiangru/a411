
/* 14-12-12:创建
 *
 */

#import "QTUserC.h"
#import "QTNavigationBarV.h"

@implementation QTUserC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
#pragma mark 导航栏
    QTNavigationBarV *nvgb = [[QTNavigationBarV alloc]initWithTitle:@"预约记录"];
    [[self view]addSubview:nvgb];
    
    
    [[nvgb back]addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [[nvgb home]addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
    
   
#pragma mark 标题栏
    UIView *bkg = [[UIView alloc]initWithFrame:CGRectMake(0, 20+40, QTScreenWidth, QTScreenHeight-(20+40))];
    [bkg setBackgroundColor:[UIColor whiteColor]];
    [bkg setTag:100];
    [[self view]addSubview:bkg];
    UIScrollView *scr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, QTScreenWidth, [bkg bounds].size.height-40)];
    [bkg addSubview:scr];
    [scr setContentSize:CGSizeMake(QTScreenWidth*4, 1000)];
    [scr setPagingEnabled:YES];
    [scr setContentOffset:CGPointZero];
    [scr setTag:110];
    [scr setBounces:NO];
    
    NSArray *title = @[@"待就诊", @"已就诊", @"已取消", @"已违约"];
    NSArray *color = @[[UIColor cyanColor], [UIColor orangeColor], [UIColor magentaColor], [UIColor purpleColor]];
    
    NSInteger i = 0;
    while (i < [title count]) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0+QTScreenWidth/4*i, 0, QTScreenWidth/4, 40)];
        [bkg addSubview:btn];
        [btn setBackgroundImage:[UIImage imageNamed:@"rb01_noselected_hd"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"rb01_selected_hd"] forState:UIControlStateSelected];
        [btn setTitle:title[i] forState:UIControlStateNormal];
        [btn setTitle:title[i] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:0 green:0.67 blue:0.89 alpha:1] forState:UIControlStateSelected];
        [[btn titleLabel]setText:title[i]];
        [[btn titleLabel]setTextColor:[UIColor blackColor]];
        [[btn titleLabel]setFont:[UIFont systemFontOfSize:16]];
        [btn setHighlighted:NO];
//        [btn setShowsTouchWhenHighlighted:YES];
        [btn setTag:10+i];
        [btn addTarget:self action:@selector(reserveRecord:) forControlEvents:UIControlEventTouchUpInside];
        UIView *bkg = [[UIView alloc]initWithFrame:CGRectMake(0+QTScreenWidth*i, 40, QTScreenWidth, 40)];
//        [bkg setBackgroundColor:color[i]];
        [scr addSubview:bkg];
        if (!i) {
            [btn setSelected:YES];
        }
        i++;
    }
    
}
#pragma mar 导航栏事件

//返回上一页
- (void)back
{
    [[self navigationController]popViewControllerAnimated:YES];
}

//返回首页
 - (void)home
{
    [[self navigationController]popToRootViewControllerAnimated:YES];
}


- (void)reserveRecord:(UIButton *)button {
    
    UIScrollView *scr = (UIScrollView *)[[self view]viewWithTag:110];
    [scr setContentOffset:CGPointMake(QTScreenWidth*([button tag]-10), 0) animated:YES];
    UIView *viw = [[self view]viewWithTag:100];
    for (UIView *view in [viw subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            [(UIButton *)view setSelected:NO];
        }
    }
    [button setSelected:YES];
}

@end
