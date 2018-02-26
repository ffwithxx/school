//
//  OneViewController.m
//  Teacher
//
//  Created by 冯丽 on 2017/12/28.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "OneViewController.h"
#import "OneCell.h"
#import "TeacherScheduleModel.h"
#define kCellName @"OneCell"
#import "CourseAttendanceVC.h"
@interface OneViewController ()<UITableViewDelegate,UITableViewDataSource,siginDelegate>{
      OneCell *_cell;
    NSString *today;
    NSInteger selectIndex;
    NSMutableArray *oneArr;
    NSMutableArray *twoArr;
    NSMutableArray *threeArr;
    NSMutableArray *fourArr;
    NSMutableArray *fiveArr;
    NSMutableArray *sixArr;
    NSMutableArray *sevenArr;
    NSMutableDictionary *dataDict;
}

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     oneArr = [NSMutableArray array];
     twoArr = [NSMutableArray array];
     threeArr = [NSMutableArray array];
     fourArr = [NSMutableArray array];
     fiveArr = [NSMutableArray array];
     sixArr = [NSMutableArray array];
     sevenArr = [NSMutableArray array];
    self.bigTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self createTimeView];
    [self getData];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)createTimeView {
    NSArray *weekArr = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    CGFloat weekLabWidth = kScreenSize.width/7;
  
    
    NSArray *dateOneArr = [self getCurrentWeek];
    NSArray *arr = [[NSArray alloc] init];
    arr = [today componentsSeparatedByString:@"-"];
    NSString *todayDayStr = arr[2];
    for (int i =0; i < weekArr.count; i++) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(weekLabWidth*i, 0, weekLabWidth, 40)];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = weekArr[i];
        lab.textColor = [UIColor colorWithRed:164/255.0 green:174/255.0 blue:190/255.0 alpha:1.0];
        lab.font = [UIFont systemFontOfSize:15];
        [self.timeView addSubview:lab];
        UIButton *bthLab =  [[UIButton alloc] initWithFrame:CGRectMake(weekLabWidth*i + (weekLabWidth-30)/2, 45, 30, 30)];
        bthLab.titleLabel.textAlignment = NSTextAlignmentCenter;
        [bthLab addTarget:self action:@selector(dateClick:) forControlEvents:UIControlEventTouchUpInside];
        
        NSArray *timeArr = [dateOneArr[i] componentsSeparatedByString:@"-"];
        [bthLab setTitle:timeArr[1] forState:UIControlStateNormal] ;
        bthLab.tag = 500+i;
        if ([todayDayStr intValue] == [timeArr[1]intValue]) {
            [bthLab setBackgroundColor:KTabBarColor];
            bthLab.titleLabel.textColor = [UIColor whiteColor];
            bthLab.clipsToBounds = YES;
            bthLab.layer.cornerRadius = 15.f;
            selectIndex = bthLab.tag;
        }else{
            
            [bthLab setBackgroundColor:[UIColor whiteColor]];
          [bthLab setTitleColor:KTextBlackColor forState:UIControlStateNormal];
            
        }
        [self.timeView addSubview:bthLab];
    }
}

- (void)getData {
    [self show];
    [[AFClient shareInstance] TeacherScheduleByTeacherId:@"str" progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([[responseBody valueForKey:@"code"] integerValue] == 0) {
          
            NSArray *arr = responseBody[@"data"];
            for (int i = 0; i < arr.count; i++) {
                NSDictionary *dict = arr[i];
                TeacherScheduleModel *model = [TeacherScheduleModel new];
                [model setValuesForKeysWithDictionary:dict];
                if ([[dict valueForKey:@"weekDay"] integerValue] == 1) {
                    [oneArr addObject:model];
                }else if ([[dict valueForKey:@"weekDay"] integerValue] == 2) {
                     [twoArr addObject:model];
                }else if ([[dict valueForKey:@"weekDay"] integerValue] == 3) {
                    [threeArr addObject:model];
                }else if ([[dict valueForKey:@"weekDay"] integerValue] == 4) {
                    [fourArr addObject:model];
                }else if ([[dict valueForKey:@"weekDay"] integerValue] == 5) {
                    [fiveArr addObject:model];
                }else if ([[dict valueForKey:@"weekDay"] integerValue] == 6) {
                    [sixArr addObject:model];
                }else if ([[dict valueForKey:@"weekDay"] integerValue] == 7) {
                    [sevenArr addObject:model];
                }
            }
            [self.bigTableView reloadData];
            [self dismiss];
        }else{
            [self dismiss];
            [self Alert:responseBody[@"msg"]];
        }
        
        [self dismiss];
    } failure:^(NSError *error) {
         [self dismiss];
    }];
}
- (void)dateClick:(UIButton *)bth {
    UIButton *find_bth = (UIButton *)[self.view viewWithTag:selectIndex];
    
    [find_bth setBackgroundColor:[UIColor whiteColor]];
    find_bth.titleLabel.textColor = KTextBlackColor;
    UIButton *select_bth = (UIButton *)[self.view viewWithTag:bth.tag];
    [select_bth setBackgroundColor:KTabBarColor];
    [select_bth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    select_bth.clipsToBounds = YES;
    select_bth.layer.cornerRadius = 15.f;
    selectIndex = bth.tag;
    selectIndex = bth.tag;
    [self.bigTableView reloadData];
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:kCellName];
    if (!_cell) {
        _cell = [[OneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
    }
    //    XyModel *model = self.dataArray[indexPath.row];
    
    CGRect cellFrame = _cell.contentView.frame;
    cellFrame.size.width = kScreenSize.width;
    [_cell.contentView setFrame:cellFrame];
    _cell.signDelegate = self;
    TeacherScheduleModel *model = [TeacherScheduleModel new];
    if (selectIndex == 500) {
        model = sevenArr[indexPath.row];
    }else if (selectIndex == 501){
        model = oneArr[indexPath.row];
    }else if (selectIndex == 502){
         model = twoArr[indexPath.row];
    }else if (selectIndex == 503){
         model = threeArr[indexPath.row];
    }else if (selectIndex == 504){
         model = fourArr[indexPath.row];
    }else if (selectIndex == 505){
         model = fiveArr[indexPath.row];
    }else if (selectIndex == 506){
         model = sixArr[indexPath.row];
    }
    [_cell showModelWith:model];
    return _cell;
    
    
}
- (void)postStr:(NSString *)Str {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CourseAttendanceVC *detail = [storyboard instantiateViewControllerWithIdentifier:@"CourseAttendanceVC"];
    detail.scheduleIdStr = Str;
    [self.navigationController pushViewController:detail animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 50 ;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (selectIndex == 500) {
        return sevenArr.count;
    }else if (selectIndex == 501){
        return oneArr.count;
    }else if (selectIndex == 502){
        return twoArr.count;
    }else if (selectIndex == 503){
        return threeArr.count;
    }else if (selectIndex == 504){
        return fourArr.count;
    }else if (selectIndex == 505){
        return fiveArr.count;
    }else if (selectIndex == 506){
        return sixArr.count;
    }
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
/**
 *  获取当前时间所在一周的第一天和最后一天
 */
- (NSArray *)getCurrentWeek
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday
                                         fromDate:now];
    // 得到星期几
    // 1(星期天) 2(星期二) 3(星期三) 4(星期四) 5(星期五) 6(星期六) 7(星期天)
    NSInteger weekDay = [comp weekday];
    // 得到几号
    NSInteger day = [comp day];
    
    NSLog(@"weekDay:%ld  day:%ld",weekDay,day);
    
    // 计算当前日期和这周的星期一和星期天差的天数
    long firstDiff,lastDiff;
    if (weekDay == 1) {
        firstDiff = 1;
        lastDiff = 0;
    }else{
        firstDiff = [calendar firstWeekday] - weekDay;
        lastDiff = 7 - weekDay;
    }
    
    NSArray *currentWeeks = [self getCurrentWeeksWithFirstDiff:firstDiff lastDiff:lastDiff];
    
    NSLog(@"firstDiff:%ld   lastDiff:%ld",firstDiff,lastDiff);
    
    // 在当前日期(去掉了时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];
    
    NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek= [calendar dateFromComponents:lastDayComp];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    today = [formater stringFromDate:now];
    NSLog(@"一周开始 %@",[formater stringFromDate:firstDayOfWeek]);
    NSLog(@"当前 %@",[formater stringFromDate:now]);
    NSLog(@"一周结束 %@",[formater stringFromDate:lastDayOfWeek]);
    
    NSLog(@"%@",currentWeeks);
    return currentWeeks;
}

//获取一周时间 数组
- (NSMutableArray *)getCurrentWeeksWithFirstDiff:(NSInteger)first lastDiff:(NSInteger)last{
    NSMutableArray *eightArr = [[NSMutableArray alloc] init];
    for (NSInteger i = first; i < last + 1; i ++) {
        //从现在开始的24小时
        NSTimeInterval secondsPerDay = i * 24*60*60;
        NSDate *curDate = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"M-d"];
        NSString *dateStr = [dateFormatter stringFromDate:curDate];//几月几号
        //        NSString *dateStr = @"5月31日";
        NSDateFormatter *weekFormatter = [[NSDateFormatter alloc] init];
        [weekFormatter setDateFormat:@"EEEE"];//星期几 @"HH:mm 'on' EEEE MMMM d"];
        NSString *weekStr = [weekFormatter stringFromDate:curDate];
        //组合时间
        NSString *strTime = [NSString stringWithFormat:@"%@",dateStr];
        [eightArr addObject:strTime];
    }
    return eightArr;
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
