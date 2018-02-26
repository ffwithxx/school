//
//  addVC.m
//  Teacher
//
//  Created by 冯丽 on 2018/1/11.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "addVC.h"

@interface addVC ()

@end

@implementation addVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (kiPhoneX) {
        self.naView.frame = CGRectMake(0, 0, kScreenSize.width, kNavHeight);
        self.bigView.frame = CGRectMake(0, kNavHeight, kScreenSize.width, kScreenSize.height-kNavHeight);
    }
     self.navigationController.navigationBar.hidden = NO;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"新建管理信息";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
   
    self.picView.layer.cornerRadius = 5.f;
    self.picView.layer.borderWidth = 1.f;
    self.picView.layer.borderColor = KLineColor.CGColor;
    self.fuJianView.layer.cornerRadius = 5.f;
    self.fuJianView.layer.borderWidth = 1.f;
    self.fuJianView.layer.borderColor = KLineColor.CGColor;
    
}
- (void)Alert:(NSString *)AlertStr{
    
    [LYMessageToast toastWithText:AlertStr backgroundColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] fontColor:[UIColor whiteColor] duration:2.f inView:[[UIApplication sharedApplication].windows lastObject]];
    
}
- (IBAction)backClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
