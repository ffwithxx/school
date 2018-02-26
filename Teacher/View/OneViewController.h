//
//  OneViewController.h
//  Teacher
//
//  Created by 冯丽 on 2017/12/28.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "JJBaseController.h"

@interface OneViewController : JJBaseController
@property (strong, nonatomic) IBOutlet UIView *timeView;
@property (strong, nonatomic) IBOutlet UITableView *bigTableView;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UILabel *shoukeDateLab;
@property (strong, nonatomic) IBOutlet UILabel *addressLab;
@property (strong, nonatomic) IBOutlet UILabel *classLab;

@end
