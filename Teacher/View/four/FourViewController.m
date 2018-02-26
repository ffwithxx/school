//
//  FourViewController.m
//  Teacher
//
//  Created by 冯丽 on 2017/12/28.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "FourViewController.h"
#import "FourCell.h"
#import "addVC.h"
#import "kantuViewController.h"
#import "ManagementVC.h"
#define kCellName @"FourCell"
@interface FourViewController ()<UITableViewDelegate,UITableViewDataSource,maxHeiDelegate,checkDelegate> {
    FourCell *_cell;
    NSInteger maxXHei;
}

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (IBAction)addcLICK:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    addVC *add = [storyboard instantiateViewControllerWithIdentifier:@"addVC"];
    [self.navigationController pushViewController:add animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
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
    _cell.checkDelegate = self;
    [_cell.contentView setFrame:cellFrame];
    [_cell showModelWithIndex:indexPath.row];
  
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
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ManagementVC *manage = [storyboard instantiateViewControllerWithIdentifier:@"ManagementVC"];
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
