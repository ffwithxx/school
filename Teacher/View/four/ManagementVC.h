//
//  ManagementVC.h
//  Teacher
//
//  Created by 冯丽 on 2018/1/11.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "JJBaseController.h"
#import "feedBackModel.h"

@interface ManagementVC : JJBaseController
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *oneView;
@property (strong, nonatomic) IBOutlet UILabel *titleOneLab;
@property (strong, nonatomic) IBOutlet UIView *fgView;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UILabel *detailLab;
@property (strong, nonatomic) IBOutlet UIView *picView;
@property (strong, nonatomic) IBOutlet UILabel *typeLab;
@property (strong, nonatomic) IBOutlet UIView *naView;
@property (strong, nonatomic) IBOutlet UIView *fileView;

@property (strong, nonatomic) IBOutlet UITableView *bigTableView;
@property (strong, nonatomic)  feedBackModel *model;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UIView *tanView;
@property (strong, nonatomic) IBOutlet UITextView *bigTextView;
@property (strong, nonatomic) IBOutlet UIButton *sendBth;
@end
