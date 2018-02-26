//
//  MessageDetailVC.h
//  Teacher
//
//  Created by 冯丽 on 2018/1/10.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "JJBaseController.h"

@interface MessageDetailVC : JJBaseController

@property (strong, nonatomic) IBOutlet UIView *naView;
@property (strong, nonatomic) IBOutlet UIScrollView *bigScrollview;
@property (strong, nonatomic) IBOutlet UIView *oneView;
@property (strong, nonatomic) IBOutlet UILabel *DetailTitleLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UIView *lineView;
@property (strong, nonatomic) IBOutlet UIView *twoView;
@property (strong, nonatomic) IBOutlet UILabel *detailLab;
@property (strong, nonatomic) IBOutlet UIView *threeView;
@property (strong, nonatomic) IBOutlet UILabel *downNameLab;
@property (strong, nonatomic) NSDictionary *dataDict;
@end
