//
//  MainViewController.m
//  Teacher
//
//  Created by 冯丽 on 2017/12/18.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "ScheduleCell.h"

#define kCellName @"ScheduleCell"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    ScheduleCell *_cell;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self first];
    [self createTimeView];
   
}

- (void)first {
    [self.leftButton addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    self.leftImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navi_icon_han.png"]];
    self.rightImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navi_icon_news.png"]];
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.text = @"HI!LILY";
    self.titleLab.textColor = [UIColor whiteColor];
    self.titleLab.font = [UIFont systemFontOfSize:18];
    CGRect leftImgFrame = self.leftImg.frame;
    leftImgFrame.origin.y = 35;
    leftImgFrame.origin.x = 20;
    leftImgFrame.size.width = 20;
    leftImgFrame.size.height = 17;
    
    CGRect rightImgFrame = self.rightImg.frame;
    rightImgFrame.origin.y = 41;
    rightImgFrame.origin.x = kScreenSize.width-40;
    rightImgFrame.size.height = 5;
    rightImgFrame.size.width = 20;
   
    CGRect titleFrame = self.titleLab.frame;
    titleFrame.origin.y = 35;
    titleFrame.origin.x = 45;
    titleFrame.size.width = 140;
    titleFrame.size.height = 20;
   
    
    if (kiPhoneX == YES) {
        leftImgFrame.origin.y = 44                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ;
         rightImgFrame.origin.y = 50;
         titleFrame.origin.y = 44;
    }
    [self.leftImg setFrame:leftImgFrame];
     [self.rightImg setFrame:rightImgFrame];
     [self.titleLab setFrame:titleFrame];
    [self.view addSubview:self.leftImg];
    [self.view addSubview:self.rightImg];
    [self.view addSubview:self.titleLab];
}

- (void)createTimeView {
    NSArray *weekArr = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    CGFloat weekLabWidth = kScreenSize.width/7;
    for (int i =0; i < weekArr.count; i++) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(weekLabWidth*i, 0, weekLabWidth, 40)];
        lab.textAlignment = NSTextAlignmentCenter;
        
        lab.text = weekArr[i];
        lab.textColor = [UIColor colorWithRed:164/255.0 green:174/255.0 blue:190/255.0 alpha:1.0];
        lab.font = [UIFont systemFontOfSize:15];
        [self.timeView addSubview:lab];

    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];

    //去掉导航栏底部的黑线

    self.navigationController.navigationBar.shadowImage = [UIImage new];
  //self.edgesForExtendedLayout = UIRectEdgeNone;
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
/**
 点击事件
 
 @param sender 201课表管理
 202 考勤管理
 203 成绩查询
 204 在校管理
 */
- (IBAction)buttonClick:(UIButton *)sender {
    CGRect lineFrame = self.lineView.frame;
    CGFloat oneWidth = kScreenSize.width/4;
    
    if (sender.tag == 201) {
        lineFrame.origin.x = 20;
        lineFrame.size.width = oneWidth - 20*2;
    }else if (sender.tag == 202) {
        lineFrame.origin.x = 20 +oneWidth;
        lineFrame.size.width = oneWidth - 20*2;
    }else if (sender.tag == 203) {
        lineFrame.origin.x = 20 +oneWidth*2;
        lineFrame.size.width = oneWidth - 20*2;
    }else if (sender.tag == 204) {
        lineFrame.origin.x = 20 +oneWidth*3;
        lineFrame.size.width = oneWidth - 20*2;
    }
    [self.lineView setFrame:lineFrame];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:kCellName];
    if (!_cell) {
        _cell = [[ScheduleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
    }
    //    XyModel *model = self.dataArray[indexPath.row];
   
    CGRect cellFrame = _cell.contentView.frame;
    cellFrame.size.width = kScreenSize.width;
    [_cell.contentView setFrame:cellFrame];
    [_cell showModel];
    return _cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    
    return 50 ;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
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
