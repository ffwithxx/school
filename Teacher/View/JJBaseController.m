//
//  JJBaseController.m
//  Teacher
//
//  Created by 冯丽 on 2017/12/28.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "JJBaseController.h"
#import "AppDelegate.h"
#import "BGControl.h"
#import "SVProgressHUD.h"
@interface JJBaseController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JJBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatBlackButton];
//    self.navigationController.navigationBar.hidden = YES;
   
   
    [self first];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}
- (void)first {

}
- (void)Alert:(NSString *)AlertStr{
    
    [LYMessageToast toastWithText:AlertStr backgroundColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] fontColor:[UIColor whiteColor] duration:2.f inView:[[UIApplication sharedApplication].windows lastObject]];
    
}
#pragma mark -- 创建黑色button
- (void)creatBlackButton{
    self.blackButton = [BGControl creatButtonWithFrame:self.view.frame target:self sel:@selector(blackButtonClick) tag:0 image:nil isBackgroundImage:NO title:nil isLayer:NO cornerRadius:0];
    self.blackButton.backgroundColor = [UIColor blackColor];
    self.blackButton.alpha = 0.3f;
    self.blackButton.hidden = YES;
    [self.view addSubview:self.blackButton];
    
    self.blackOneButton = [BGControl creatButtonWithFrame:self.view.frame target:self sel:@selector(blackOneButtonClick) tag:0 image:nil isBackgroundImage:NO title:nil isLayer:NO cornerRadius:0];
    self.blackOneButton.backgroundColor = [UIColor blackColor];
    self.blackOneButton.alpha = 0.3f;
    self.blackOneButton.hidden = YES;
    [self.view addSubview:self.blackOneButton];
}

- (void)blackButtonClick {
    self.blackButton.hidden = YES;
}
- (void)blackOneButtonClick {
    self.blackButton.hidden = YES;
}
#pragma mark --- 左侧页面滑出
- (void)leftClick:(UIButton *)bth {
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
}

#pragma mark --- 右侧页面滑出
- (void)rightClick:(UIButton *)bth {
    NSLog(@"1230");
    
}

-(void)click:(UIButton *)bth {
    
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
