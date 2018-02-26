//
//  LoginViewController.m
//  Teacher
//
//  Created by 冯丽 on 2017/12/22.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "LoginViewController.h"
#import "BGControl.h"
#import "LYMessageToast.h"
#import "AFClient.h"

@interface LoginViewController ()<UITextFieldDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLab.clipsToBounds = YES;
    self.titleLab.layer.cornerRadius = 5.f;
    self.view.backgroundColor = KBgColor;
    [self first];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //导航栏设置为透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //去掉导航栏底部的黑线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    //self.edgesForExtendedLayout = UIRectEdgeNone;
}
#pragma mark --- 初始化view
- (void)first {
    self.userTextFile.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"user"];
    self.pswTextFile.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"psw"];
    self.bottomView.layer.cornerRadius =8.f;
//    self.bottomView.layer.masksToBounds = YES;
    self.bottomView.layer.shadowColor = [UIColor purpleColor].CGColor;//shadowColor阴影颜色
    self.bottomView.layer.shadowOffset = CGSizeMake(5,5);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.bottomView.layer.shadowOpacity = 0.1;//阴影透明度，默认0
    self.bottomView.layer.shadowRadius = 3;//阴影半径，默认3
   
    self.pswImgView.image = [UIImage imageNamed:@"login_icon_key@2x_85"];
    self.twoView.clipsToBounds = YES;
    self.twoView.layer.cornerRadius = 5.f;
    self.twoView.layer.borderColor = KLineColor.CGColor;
    self.twoView.layer.borderWidth = 1.f;
    self.loginBth.layer.cornerRadius = 8.f;
    NSLog(@"%f",kScreenSize.width);
    
  
    
    
    
}
#pragma mark ---- 登入
- (IBAction)loginClick:(UIButton *)sender {
    if ([BGControl isNULLOfString:self.userTextFile.text]) {
        [self Alert:@"请输入账号"];
        return;
    }else if ([BGControl isNULLOfString:self.pswTextFile.text]) {
        [self Alert:@"请输入密码"];
        return;
    }
    [self show];
    [[AFClient shareInstance] loginWithUserName:self.userTextFile.text passWord:self.pswTextFile.text progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([[responseBody valueForKey:@"code"] integerValue] == 0) {
            
            [[NSUserDefaults standardUserDefaults] setObject:[[responseBody valueForKey:@"data"] valueForKey:@"token"] forKey:@"token"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@", [[[responseBody valueForKey:@"data"] valueForKey:@"userInfo"] valueForKey:@"schoolPid"]] forKey:@"schoolPid"];
            
            [[NSUserDefaults standardUserDefaults] setObject:[[[responseBody valueForKey:@"data"] valueForKey:@"userInfo"] valueForKey:@"schoolPid"] forKey:@"jobCode"];
              [[NSUserDefaults standardUserDefaults] setValue:self.pswTextFile.text forKey:@"psw"];
             [[NSUserDefaults standardUserDefaults] setValue:self.userTextFile.text forKey:@"user"];
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[responseBody valueForKey:@"data"] options:0 error:&error];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            [[NSUserDefaults standardUserDefaults] setValue:jsonString forKey:@"loginData"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Main" object:nil];
        }else{
            [self Alert:responseBody[@"msg"]];
        }

          [self dismiss];
    } failure:^(NSError *error) {
          [self dismiss];
    }];
    
}

//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{  [self.userTextFile resignFirstResponder];
    [self.pswTextFile resignFirstResponder];

    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        self.bigView.frame = frame;
    }];
    
}
-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    [self.userTextFile resignFirstResponder];
    [self.pswTextFile resignFirstResponder];

    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        self.bigView.frame = frame;
    }];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    //216
    CGFloat offset = self.bigView.frame.size.height - (280+self.bottomView.frame.origin.y+CGRectGetMaxY(self.twoView.frame));
    if (offset<=0) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.bigView.frame;
            frame.origin.y = offset;
            self.bigView.frame = frame;
        }];
    }
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    return YES;
}

- (void)Alert:(NSString *)AlertStr{
    
    [LYMessageToast toastWithText:AlertStr backgroundColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] fontColor:[UIColor whiteColor] duration:2.f inView:[[UIApplication sharedApplication].windows lastObject]];
    
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
