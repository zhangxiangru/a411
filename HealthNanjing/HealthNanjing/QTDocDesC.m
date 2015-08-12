
/* 14-12-10:创建
 *
 */

#import "QTDocDesC.h"
#import "QTDepartmentD.h"

@implementation QTDocDesC
- (void)viewDidLoad {
    [super viewDidLoad];
    [[self view]setBackgroundColor:[UIColor cyanColor]];
    UITextView *lab = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, QTScreenWidth, QTScreenHeight-(20+40+40))];
    [lab setText:[_depSel[0] depintro]];
    [lab setEditable:NO];
    [lab setFont:[UIFont systemFontOfSize:18]];
    [[self view]addSubview:lab];
}
@end
