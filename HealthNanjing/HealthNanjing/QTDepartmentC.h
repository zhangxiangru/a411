
/* 14-12-8:创建
 *
 */

#import <Foundation/Foundation.h>

enum QTHospitalType {
    QTHospitalDep,
    QTHospitalDoc
};
typedef enum QTHospitalType QTHospitalType;
@interface QTDepartmentC :UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
{
    UIPageViewController *_pagc;
    NSMutableArray *_cs;
    QTHospitalType _type;
    NSMutableArray *_btns;
}
@property (nonatomic, copy) NSString *hoscode;
@property (nonatomic, copy) NSString *hosname;
@property (nonatomic, copy) NSString *depcode;
@property (nonatomic, copy) NSString *depid;
@property (nonatomic, copy) NSString *depname;
@property (nonatomic, strong) NSArray *depts;
@property (nonatomic, strong) NSArray *hoss;
@property (nonatomic, strong) NSArray *depSel;

- (id)initWithType:(QTHospitalType)type;
@end
