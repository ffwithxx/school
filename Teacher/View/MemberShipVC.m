//
//  MemberShipVC.m
//  Teacher
//
//  Created by 冯丽 on 2018/1/4.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "MemberShipVC.h"
#import "AFClient.h"
#import "BGControl.h"
#import "AppDelegate.h"

@interface MemberShipVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MemberShipVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topView.frame = CGRectMake(0, 0, kScreenSize.width, 850);
    [self.bigTableView setTableHeaderView:self.topView];
    if (kiPhoneX) {
        self.navView.frame = CGRectMake(0, 0, kScreenSize.width, kNavHeight);
        self.bigTableView.frame = CGRectMake(0, kNavHeight, kScreenSize.width, kScreenSize.height-kNavHeight);
    }
    self.bigTableView.showsVerticalScrollIndicator = NO;
    self.bigTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
        self.navigationItem.title = @"修改密码";
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)first {
         NSString *jsonString = [[NSUserDefaults standardUserDefaults]valueForKey:@"loginData"];
            NSDictionary *dict = [[BGControl dictionaryWithJsonString:jsonString] valueForKey:@"userInfo"];
   
        self.nameLab.text = [BGControl textIsNull: [dict valueForKey:@"nameCn"]];
            self.eNameLab.text =  [BGControl textIsNull: [dict valueForKey:@"nameEn"]];
            self.sexLab.text = [BGControl textIsNull:[dict valueForKey:@"sex"]] ;
            self.guojiLab.text =[BGControl textIsNull:[dict valueForKey:@"country"]] ;
            self.birthdayLab.text = [BGControl textIsNull:[dict valueForKey:@"birthday"]];
            self.ageLab.text =[BGControl textIsNull:[dict valueForKey:@"age"]];
            self.shenfenLab.text = [BGControl textIsNull:[dict valueForKey:@"idCard"]] ;
            self.passportLab.text =[BGControl textIsNull:[NSString stringWithFormat:@"%@",[dict valueForKey:@"passport"]]] ;
    
               self.phoneLab.text =[BGControl textIsNull:[NSString stringWithFormat:@"%@",[dict valueForKey:@"phone"]]] ;
//              self.gonghaoLab.text = [dict valueForKey:@"jobId"];
             self.gonghaoLab.text =[BGControl textIsNull:[NSString stringWithFormat:@"%@",[dict valueForKey:@"jobCode"]]] ;
               self.zhiweiLab.text =[BGControl textIsNull: [dict valueForKey:@"jobName"]];;
    
              self.typeLab.text =[BGControl textIsNull: [NSString stringWithFormat:@"%@",[dict valueForKey:@"jobTypeId"]]] ;
            self.xiaoquLab.text =[BGControl textIsNull: [dict valueForKey:@"schoolName"]] ;;
               self.ruzhiDateLab.text =[BGControl textIsNull: [dict valueForKey:@"entryDate"]];
            self.jiaoshouLab.text =[BGControl textIsNull:[dict valueForKey:@"teach_subjects "]] ;
            self.zhuangtaiLab.text = [BGControl textIsNull:[dict valueForKey:@"status"]];
            
    
}




- (IBAction)backClick:(UIButton *)sender {
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC openLeftView];//关闭左侧抽屉
    [self .navigationController popViewControllerAnimated:YES];
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetifider];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    
    return cell;
}
- (void)Alert:(NSString *)AlertStr{
    
    [LYMessageToast toastWithText:AlertStr backgroundColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] fontColor:[UIColor whiteColor] duration:2.f inView:[[UIApplication sharedApplication].windows lastObject]];
    
}
- (IBAction)buttonClick:(UIButton *)sender {
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
