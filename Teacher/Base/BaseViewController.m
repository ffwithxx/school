//
//  BaseViewController.m
//  Teacher
//
//  Created by 冯丽 on 2017/12/18.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"
#import "SVProgressHUD.h"
#import "BGControl.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatBlackButton];
    // Do any additional setup after loading the view.
}
#pragma mark -- 创建黑色button
- (void)creatBlackButton{
    self.blackOneButton = [BGControl creatButtonWithFrame:self.view.frame target:self sel:@selector(blackButtonClick) tag:0 image:nil isBackgroundImage:NO title:nil isLayer:NO cornerRadius:0];
    self.blackOneButton.backgroundColor = [UIColor blackColor];
    self.blackOneButton.alpha = 0.3f;
    self.blackOneButton.hidden = YES;
    [self.view addSubview:self.blackOneButton];
    
}
- (void)blackButtonClick {

}

-(void)show {
    self.blackOneButton.hidden = NO;
    [SVProgressHUD setBackgroundColor:KTabBarColor];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeNone];
    
}
- (void)dismiss
{
     self.blackOneButton.hidden = YES;
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
