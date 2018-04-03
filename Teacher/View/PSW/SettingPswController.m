//
//  SettingPswController.m
//  Teacher
//
//  Created by 冯丽 on 2017/12/29.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "SettingPswController.h"
#import "AppDelegate.h"
#import "BGControl.h"


@interface SettingPswController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *naviView;

@end

@implementation SettingPswController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.oneMorePswText.delegate = self;
    self.oldPSWText.delegate = self;
    self.PSWText.delegate = self;
    self.navigationController.navigationBar.hidden = NO;
    if (kiPhoneX) {
        self.naviView.frame = CGRectMake(0, 0, kScreenSize.width, kNavHeight);
        self.bigView.frame = CGRectMake(0, kNavHeight, kScreenSize.width, kScreenSize.height-kNavHeight);
    }
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"修改密码";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.hidden = NO;
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.tag == 201) {
        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [tempAppDelegate.LeftSlideVC openLeftView];//关闭左侧抽屉
        [self .navigationController popViewControllerAnimated:YES];
    }else{
        
        if ([BGControl isNULLOfString:self.oldPSWText.text]) {
            [self Alert:@"请输入旧密码"];
            return;
        }else if ([BGControl isNULLOfString:self.PSWText.text]){
            [self Alert:@"请输入新密码"];
            return;
        }else if ([BGControl isNULLOfString:self.oneMorePswText.text]){
            [self Alert:@"请再次输入新密码"];
            return;
        }else if (![self.PSWText.text isEqualToString:self.oneMorePswText.text]){
            [self Alert:@"两次新密码输入不同"];
            return;
        }else{
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:self.oldPSWText.text,@"oldPass",self.PSWText.text,@"newPass",nil];
            [self.oldPSWText resignFirstResponder];
            [self.PSWText resignFirstResponder];
            [self.oneMorePswText resignFirstResponder];
            
              [self show];
             [[AFClient shareInstance]UpdatePasswordwithDict:dict progressBlock:^(NSProgress *progress) {
                 
             } success:^(id responseBody) {
                 if ([[responseBody valueForKey:@"code"] integerValue] == 0) {
                     self.oldPSWText.text = @"";
                     self.PSWText.text = @"";
                     self.oneMorePswText.text = @"";
                     [self Alert:@"保存成功!"];
                     [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"psw"];
                     [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"user"];
                      [[NSNotificationCenter defaultCenter] postNotificationName:@"tLogin" object:nil];
                 }else{
                     [self Alert:responseBody[@"msg"]];
                 }
                 [self dismiss];
             } failure:^(NSError *error) {
                 
             }];
           
        }
    }
        
}
- (void)Alert:(NSString *)AlertStr{
    
    [LYMessageToast toastWithText:AlertStr backgroundColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] fontColor:[UIColor whiteColor] duration:2.f inView:self.view];
    
}

//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{  [self.oldPSWText resignFirstResponder];
    [self.PSWText resignFirstResponder];
    [self.oneMorePswText resignFirstResponder];
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    [self.oldPSWText resignFirstResponder];
    [self.PSWText resignFirstResponder];
    [self.oneMorePswText resignFirstResponder];
    return YES;
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
