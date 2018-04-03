//
//  FourViewController.m
//  Teacher
//
//  Created by 冯丽 on 2017/12/28.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "FourViewController.h"
#import "AFClient.h"
#import "FourCell.h"
#import "addVC.h"
#import "kantuViewController.h"
#import "ManagementVC.h"
#import "feedBackModel.h"
#define kCellName @"FourCell"
@interface FourViewController ()<UITableViewDelegate,UITableViewDataSource,maxHeiDelegate,checkDelegate,downDelegate> {
    FourCell *_cell;
    NSInteger maxXHei;
    NSString *typeStr;
}

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
     typeStr = @"3";
     self.bigTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.dataArray = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
     [self getData];
}

- (void)getData {
    [self show];
    [[AFClient shareInstance]feedbackWithTeacherId:@"str" withType:typeStr progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([[responseBody valueForKey:@"code"] integerValue] == 0) {
            [self.dataArray removeAllObjects];
           NSArray *arr = [responseBody valueForKey:@"data"];
            for (int i = 0; i <arr.count; i++) {
                NSDictionary *dict = arr[i];
                feedBackModel *model = [[feedBackModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [self.dataArray insertObject:model atIndex:0];
                
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

- (IBAction)addcLICK:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    addVC *add = [storyboard instantiateViewControllerWithIdentifier:@"addVC"];
    [self.navigationController pushViewController:add animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return maxXHei;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:kCellName];
    if (!_cell) {
        _cell = [[FourCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
    }
    //    XyModel *model = self.dataArray[indexPath.row];
    
    CGRect cellFrame = _cell.contentView.frame;
    cellFrame.size.width = kScreenSize.width;
    _cell.delegate = self;
    _cell.downDelegate = self;
    _cell.checkDelegate = self;
    feedBackModel *model = self.dataArray[indexPath.section];
    [_cell.contentView setFrame:cellFrame];
    [_cell showModelWithIndex:indexPath.row withModel:model];
  
    return _cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    feedBackModel *model = self.dataArray[indexPath.section];
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ManagementVC *manage = [storyboard instantiateViewControllerWithIdentifier:@"ManagementVC"];
    manage.model = model;
    [self.navigationController pushViewController:manage animated:YES];
}
- (void)Alert:(NSString *)AlertStr{
    
    [LYMessageToast toastWithText:AlertStr backgroundColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] fontColor:[UIColor whiteColor] duration:2.f inView:[[UIApplication sharedApplication].windows lastObject]];
    
}
-(void)getMaxHei:(CGFloat)maxHei withIndex:(NSInteger)index {
    maxXHei = maxHei;
//    NSDictionary *dict = self.dataArray[index];
//
//    [dict setValue:[NSString stringWithFormat:@"%f",maxHei] forKey:@"maxHei"];
//    [self.dataArray replaceObjectAtIndex:index withObject:dict];
    //    [self.bigtableView reloadData];
}
- (void)checkImg:(NSInteger)bthTag withImgArr:(NSArray *)imgArr {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    kantuViewController *picVC = [storyboard instantiateViewControllerWithIdentifier:@"kantuViewController"];
    picVC.IMGArray = [NSMutableArray arrayWithArray:imgArr];
    picVC.typestr = @"kan";
    picVC.IMGNum = [NSString stringWithFormat:@"%d",bthTag-100];
    [self.navigationController pushViewController:picVC animated:YES];
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.tag == 301) {
        typeStr = @"3";
        [self.oneBth setTitleColor:KTabBarColor forState:UIControlStateNormal];
        [self.twoBth setTitleColor:KTextgrayColor forState:UIControlStateNormal];
         [self.threeBth setTitleColor:KTextgrayColor forState:UIControlStateNormal];
         [self.fourBth setTitleColor:KTextgrayColor forState:UIControlStateNormal];
    }else if (sender.tag == 302){
        typeStr = @"0";
        [self.oneBth setTitleColor:KTextgrayColor forState:UIControlStateNormal];
        [self.twoBth setTitleColor:KTabBarColor forState:UIControlStateNormal];
        [self.threeBth setTitleColor:KTextgrayColor forState:UIControlStateNormal];
        [self.fourBth setTitleColor:KTextgrayColor forState:UIControlStateNormal];
    }else if (sender.tag == 303){
        typeStr = @"1";
        [self.oneBth setTitleColor:KTextgrayColor forState:UIControlStateNormal];
        [self.twoBth setTitleColor:KTextgrayColor forState:UIControlStateNormal];
        [self.threeBth setTitleColor:KTabBarColor forState:UIControlStateNormal];
        [self.fourBth setTitleColor:KTextgrayColor forState:UIControlStateNormal];
    }else if (sender.tag == 304){
        typeStr = @"2";
        [self.oneBth setTitleColor:KTextgrayColor forState:UIControlStateNormal];
        [self.twoBth setTitleColor:KTextgrayColor forState:UIControlStateNormal];
        [self.threeBth setTitleColor:KTextgrayColor forState:UIControlStateNormal];
        [self.fourBth setTitleColor:KTabBarColor forState:UIControlStateNormal];
    }
    [self getData];
}
- (void)downImg:(NSInteger)bthTag withDownArr:(NSArray *)downArr {
    [self Alert:@"暂不支持此功能!"];
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
