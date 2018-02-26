//
//  CourseAttendanceVC.h
//  Teacher
//
//  Created by 冯丽 on 2018/1/10.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "JJBaseController.h"

@interface CourseAttendanceVC : JJBaseController
@property (strong, nonatomic) IBOutlet UIView *naView;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UILabel *kemuLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UILabel *dateLab;
@property (strong, nonatomic) IBOutlet UILabel *placeLab;
@property (strong, nonatomic) IBOutlet UILabel *banjiLab;
@property (strong, nonatomic) IBOutlet UILabel *oneLab;
@property (strong, nonatomic) IBOutlet UILabel *twoLab;
@property (strong, nonatomic) IBOutlet UILabel *threeLab;
@property (strong, nonatomic) IBOutlet UILabel *fourLab;
@property (strong, nonatomic) IBOutlet UILabel *fiveLab;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UITableView *bigTableView;
@property (strong, nonatomic) NSString *scheduleIdStr;

@end
