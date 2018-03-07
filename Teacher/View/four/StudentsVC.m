//
//  StudentsVC.m
//  Teacher
//
//  Created by 冯丽 on 2018/3/7.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "StudentsVC.h"
#import "StudentsCell.h"
#import "BGControl.h"
#import "AFClient.h"
#define  kCellName @"StudentsCell"
@interface StudentsVC ()<UITableViewDelegate,UITableViewDataSource> {
    StudentsCell *_cell;
}


@end

@implementation StudentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bigTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     self.dataArray = [[NSMutableArray alloc] init];
    if (kiPhoneX) {
        self.naVie.frame = CGRectMake(0, 0, kScreenSize.width, kNavHeight);
        self.bigTableView.frame = CGRectMake(0, kNavHeight, kScreenSize.width, kScreenSize.height-kNavHeight);
    }
    self.navigationController.navigationBar.hidden = NO;
       [self first];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"选择学生";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];

}
    
- ( void)first{
    NSString *jsonString = [[NSUserDefaults standardUserDefaults]valueForKey:@"loginData"];
    NSDictionary  *userInfoDict = [[BGControl dictionaryWithJsonString:jsonString] valueForKey:@"userInfo"];
    NSLog( @"%@",userInfoDict);
    [self show];
    [[AFClient shareInstance] getStudents:[userInfoDict valueForKey:@"id"] progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([[responseBody valueForKey:@"code"] integerValue] == 0) {
            [self.dataArray removeAllObjects];
            NSArray *arr = [responseBody valueForKey:@"data"];
            self.dataArray = [NSMutableArray arrayWithArray:arr];
            
        }else{
            [self Alert:responseBody[@"msg"]];
        }
        [self.bigTableView reloadData];
        
        [self dismiss];
    } failure:^(NSError *error) {
        [self dismiss];
    }];
}
- (IBAction)backClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:kCellName];
    if (!_cell) {
        _cell = [[StudentsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
    }
    CGRect cellFrame = _cell.contentView.frame;
    cellFrame.size.width = kScreenSize.width;
    [_cell.contentView setFrame:cellFrame];
    
    NSArray *arr = [self.dataArray[indexPath.section] valueForKey:@"classBeans"];
    NSDictionary *dict = arr[indexPath.row];
    [_cell showWithDict:dict];
    return _cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.dataArray[indexPath.section];
    return 55;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *classBeans = [self.dataArray[section] valueForKey:@"classBeans"];

    return classBeans.count;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dict = self.dataArray[indexPath.section];
    NSString *classStr = [dict valueForKey:@"classId"];
    NSDictionary *studentDict = [dict valueForKey:@"classBeans"][indexPath.row];
    NSString *studentStr = [studentDict valueForKey:@"sid"];
    if (_delegate && [_delegate respondsToSelector:@selector(postStudent:withclassId:)]) {
        [_delegate postStudent:studentDict withclassId:classStr];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
    return self.dataArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc]init];
    
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UILabel *label = [[UILabel alloc]init];
    
    label.textColor = [UIColor grayColor];
    
    label.font = [UIFont systemFontOfSize:15];
    
    label.frame = CGRectMake(15, 0, 100, 30);
    
    [headerView addSubview:label];
    NSDictionary *dict = self.dataArray[section];
    label.text = [dict valueForKey:@"className"];
        
  
    
    return headerView;
    
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
