
/* 14-12-9:创建
 *
 */

#import <UIKit/UIKit.h>

@interface QTHosDepC :UIViewController {
    UIScrollView *_scr;
    NSMutableArray *_btns;
}
@property (nonatomic, strong) NSArray *deps;
@property (nonatomic, copy) NSString *hoscode;
@property (nonatomic, copy) NSString *hosname;
@property (nonatomic, copy) void(^push)(UIViewController *);
@end
