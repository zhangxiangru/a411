
/* 14-12-10:创建
 *
 */

#import <UIKit/UIKit.h>

@interface QTDocC :UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) NSString *hoscode;
@property (nonatomic, copy) NSString *hosname;
@property (nonatomic, copy) NSString *depid;
@property (nonatomic, copy) NSString *depcode;
@property (nonatomic, copy) NSString *depname;
@property (nonatomic, strong) NSArray *deps;
@property (nonatomic, strong) NSMutableArray *docs;
@property (nonatomic, strong) NSMutableArray *woks;
@property (nonatomic, strong) NSMutableArray *coms;
@property (nonatomic, assign) BOOL hide;
@property (nonatomic, assign) BOOL dochide;
@property (nonatomic, strong) NSIndexPath *docidx;
@property (nonatomic, copy) void(^push)(UIViewController *);
@end
