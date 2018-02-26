//
//  MessageCenterVC.m
//  Teacher
//
//  Created by 冯丽 on 2018/1/9.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "MessageCenterVC.h"
#import "MessageCenterCell.h"
#import "MessageDetailVC.h"
#import "BGControl.h"
#define  kCellName @"MessageCenterCell"

@interface MessageCenterVC ()<UITableViewDataSource,UITableViewDelegate,maxHeiDelegate> {
    MessageCenterCell *_cell;
    
}

@end

@implementation MessageCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [[NSMutableArray alloc] init];
    self.bigTableView.showsVerticalScrollIndicator = NO;
    self.bigTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    if (kiPhoneX) {
        self.naVIew.frame = CGRectMake(0, 0, kScreenSize.width, kNavHeight);
        self.bigTableView.frame = CGRectMake(0, kNavHeight, kScreenSize.width, kScreenSize.height-kNavHeight);
    }
    [self first];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"消息中心";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.hidden = NO;
}

-(void)first {
    NSString *schoolPid = [[NSUserDefaults standardUserDefaults] valueForKey:@"schoolPid"];
    [self show];
    [[AFClient shareInstance] noticeWithId:schoolPid progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([[responseBody valueForKey:@"code"] integerValue] == 0) {
            self.dataArray = [responseBody valueForKey:@"data"];
            
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
        _cell = [[MessageCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
    }
    CGRect cellFrame = _cell.contentView.frame;
    cellFrame.size.width = kScreenSize.width;
    [_cell.contentView setFrame:cellFrame];
     _cell.delegate = self;
    NSDictionary *dict = self.dataArray[indexPath.section];
    [_cell showModelWith:dict withIndext:indexPath.section];
    
    return _cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     NSDictionary *dict = self.dataArray[indexPath.section];
    if ([BGControl isNULLOfString:[dict valueForKey:@"maxHei"]]) {
        return 150;
    }else{
        CGFloat hei = [[dict valueForKey:@"maxHei"] floatValue];
          return hei;
    }
  
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MessageDetailVC *detail = [storyboard instantiateViewControllerWithIdentifier:@"MessageDetailVC"];
    detail.dataDict = self.dataArray[indexPath.section];
    [self.navigationController pushViewController:detail animated:YES];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
    
}
-(void)getMaxHei:(CGFloat)maxHei withIndex:(NSInteger)index {
    NSDictionary *dict = self.dataArray[index];
    
    [dict setValue:[NSString stringWithFormat:@"%f",maxHei] forKey:@"maxHei"];
    [self.dataArray replaceObjectAtIndex:index withObject:dict];
    //    [self.bigtableView reloadData];
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
