//
//  TwoViewController.h
//  Teacher
//
//  Created by 冯丽 on 2017/12/28.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "JJBaseController.h"

@interface TwoViewController : JJBaseController
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UITableView *bigTableView;
@property (strong, nonatomic) IBOutlet UILabel *projectLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UILabel *dateLab;
@property (strong, nonatomic) IBOutlet UILabel *addressLab;

@property (strong, nonatomic) IBOutlet UILabel *classLab;
@end
