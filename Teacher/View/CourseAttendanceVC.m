//
//  CourseAttendanceVC.m
//  Teacher
//
//  Created by 冯丽 on 2018/1/10.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "CourseAttendanceVC.h"
#import "CourseAttendanceCell.h"
#import "BGControl.h"
#import "AFClient.h"
#import "CourseAttendanceModel.h"
#define kCellName @"CourseAttendanceCell"
@interface CourseAttendanceVC ()<UITableViewDelegate,UITableViewDataSource,maxHeiDelegate,openDelegate> {
    CourseAttendanceCell *_cell;
}

@end

@implementation CourseAttendanceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [[NSMutableArray alloc] init];
    self.topView.frame = CGRectMake(0, 0, kScreenSize.width, 130);
    if (kiPhoneX) {
        self.naView.frame = CGRectMake(0, 0, kScreenSize.width, kNavHeight);
        self.bigTableView.frame = CGRectMake(0, kNavHeight, kScreenSize.width, kScreenSize.height-kNavHeight-50);
    }
    [self.bigTableView setTableHeaderView:self.topView];
    self.bigTableView.showsVerticalScrollIndicator = NO;
    self.bigTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self getData];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"课程考勤";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.hidden = NO;
    self.oneLab.layer.cornerRadius = 5.f;
    self.twoLab.layer.cornerRadius = 5.f;
    self.threeLab.layer.cornerRadius = 5.f;
    self.fourLab.layer.cornerRadius = 5.f;
    self.fiveLab.layer.cornerRadius = 5.f;
    self.oneLab.clipsToBounds = YES;
    self.twoLab.clipsToBounds = YES;
    self.threeLab.clipsToBounds = YES;
    self.fourLab.clipsToBounds = YES;
    self.fiveLab.clipsToBounds = YES;
    
}
- (void)getData{
    [self show];
    [[AFClient shareInstance] attendance:self.scheduleIdStr progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([[responseBody valueForKey:@"code"] integerValue] == 0) {
            NSArray *arr = [responseBody valueForKey:@"data"];
            for (int i = 0 ; i < arr.count; i++) {
                NSDictionary *dict = arr[i];
                CourseAttendanceModel *model = [CourseAttendanceModel new];
                model.maxHei = 55;
                model.index = i;
                model.open = 0;
                [model setValuesForKeysWithDictionary:dict]
                ;
                [self.dataArray addObject:model];
            }
        }else{
            [self Alert:responseBody[@"msg"]];
        }
        [self.bigTableView reloadData];
        [self dismiss];
    } failure:^(NSError *error) {
         [self dismiss];
    }];
}
- (IBAction)buttonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     CourseAttendanceModel *model = self.dataArray[indexPath.row];
    if (model.open == 1) {
        return  model.maxHei;
    }else{
        return 55;
    }
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:kCellName];
    if (!_cell) {
        _cell = [[CourseAttendanceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
    }
    CourseAttendanceModel *model = self.dataArray[indexPath.row];
    
    
    CGRect cellFrame = _cell.contentView.frame;
    cellFrame.size.width = kScreenSize.width;
    [_cell.contentView setFrame:cellFrame];
    _cell.delegate = self;
    _cell.openDelegate = self;
    [_cell showModel:model];
    return _cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
}
- (void)getMaxHei:(CGFloat)maxHei withIndex:(NSInteger)index {
    CourseAttendanceModel *model = self.dataArray[index];
    model.maxHei = maxHei;
    [self.dataArray replaceObjectAtIndex:index withObject:model];
}
- (void)postWithIndex:(NSInteger)index {
    CourseAttendanceModel *model = self.dataArray[index];
    if (model.open == 1) {
        model.open = 0;
    }else{
        model.open = 1;
    }
    [self.dataArray replaceObjectAtIndex:index withObject:model];
    [self.bigTableView reloadData];
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
