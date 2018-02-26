//
//  LoginViewController.h
//  Teacher
//
//  Created by 冯丽 on 2017/12/22.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIView *bigView;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UIView *twoView;
@property (strong, nonatomic) IBOutlet UIButton *loginBth;
@property (strong, nonatomic) IBOutlet UIView *userView;
@property (strong, nonatomic) IBOutlet UITextField *userTextFile;
@property (strong, nonatomic) IBOutlet UIView *pswView;
@property (strong, nonatomic) IBOutlet UITextField *pswTextFile;
@property (strong, nonatomic) IBOutlet UIImageView *pswImgView;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;

@end
