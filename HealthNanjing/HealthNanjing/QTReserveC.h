
/* 14-12-11:创建
 *
 */

#import <UIKit/UIKit.h>

@interface QTReserveC :UIViewController <UITextFieldDelegate>

@property (nonatomic, copy) NSString *docname;
@property (nonatomic, copy) NSString *depname;
@property (nonatomic, copy) NSString *hosname;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *money;

@end
