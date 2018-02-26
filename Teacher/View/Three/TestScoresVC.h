//
//  TestScoresVC.h
//  Teacher
//
//  Created by 冯丽 on 2018/1/10.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "JJBaseController.h"

@interface TestScoresVC : JJBaseController
@property (strong, nonatomic) IBOutlet UIView *naVie;
@property (strong, nonatomic) IBOutlet UIScrollView *bigScrollView;
@property (strong, nonatomic) IBOutlet UIView *bigView;
@property (strong, nonatomic) IBOutlet UILabel *xuenianLab;
@property (strong, nonatomic) IBOutlet UILabel *xueqiLab;
@property (strong, nonatomic) IBOutlet UILabel *xiaoquLab;
@property (strong, nonatomic) IBOutlet UILabel *xaingmuLab;
@property (strong, nonatomic) IBOutlet UILabel *nianjiLab;
@property (strong, nonatomic) IBOutlet UILabel *banjiLab;
@property (strong, nonatomic) IBOutlet UILabel *kechengLab;
@property (strong, nonatomic) IBOutlet UILabel *typeLab;
@property (strong, nonatomic) IBOutlet UILabel *kaoshiName;
@property (strong, nonatomic) IBOutlet UIButton *cancleBth;
@property (strong, nonatomic) IBOutlet UIButton *searchBth;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UILabel *titleNameLab;
@property (strong, nonatomic) IBOutlet UILabel *banjiOneLab;
@property (strong, nonatomic) IBOutlet UITableView *bigTableView;
@property (strong, nonatomic)  NSMutableArray *dataArr;
@property (strong, nonatomic)  NSString *titleStr;
@property (strong, nonatomic)  NSString *niajiStr;
@end
