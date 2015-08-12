
/* 14-12-8:创建
 *
 */

#import <Foundation/Foundation.h>
#import "EGORefreshTableHeaderView.h"

@interface QTHospitalC :UIViewController <UITableViewDataSource, UITableViewDelegate, EGORefreshTableHeaderDelegate>
@property (nonatomic, strong) NSArray *hspts;
@property (nonatomic, strong) NSArray *depts;
@end
