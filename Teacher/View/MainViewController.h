//
//  MainViewController.h
//  Teacher
//
//  Created by 冯丽 on 2017/12/18.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface MainViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIButton *leftButton;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic)  UILabel *titleLab;
@property (strong, nonatomic)  UIImageView *leftImg;
@property (strong, nonatomic)  UIImageView *rightImg;
@property (strong, nonatomic) IBOutlet UIView *timeView;
@property (strong, nonatomic) IBOutlet UIView *lineView;
@property (strong, nonatomic) IBOutlet UITableView *bigTableView;

@end
