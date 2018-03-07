//
//  TestScoresVC.m
//  Teacher
//
//  Created by 冯丽 on 2018/1/10.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "TestScoresVC.h"
#import "TestScoresCell.h"
#define  kCellName @"TestScoresCell"
#import "ChoiceVC.h"
#import "BGControl.h"
@interface TestScoresVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,postValueDelegate> {
        TestScoresCell *_cell;
    NSInteger oneId;
    NSUInteger twoId;
    NSInteger threeId;
    NSUInteger fourId;
    NSInteger fiveId;
    NSUInteger sixId;
    NSInteger sevenId;
    NSUInteger eightId;
    NSInteger noneId;
}

@end

@implementation TestScoresVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bigScrollView.hidden = YES;
    if (kiPhoneX) {
        self.naVie.frame = CGRectMake(0, 0, kScreenSize.width, kNavHeight);
        self.bigScrollView.frame = CGRectMake(0, kNavHeight, kScreenSize.width, kScreenSize.height-kNavHeight);
        self.bigTableView.frame = CGRectMake(0, kNavHeight, kScreenSize.width, kScreenSize.height-kNavHeight);
    }
    self.topView.frame = CGRectMake(0, 0, kScreenSize.width, 100);
    [self.bigTableView setTableHeaderView:self.topView];
    self.titleNameLab.text = self.titleStr;
    self.banjiOneLab.text = self.niajiStr;
     self.bigTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"考试成绩";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.hidden = NO;
}
- (IBAction)backClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)buttonClick:(UIButton *)sender {
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if (sender.tag == 310 ||sender.tag == 311) {
        if (sender.tag == 310) {
            [self.bigScrollView removeFromSuperview];
            self.bigScrollView.hidden = YES;
            self.blackButton.hidden = YES;
        }else if (sender.tag == 311) {
            self.titleNameLab.text = [NSString stringWithFormat:@"%@%@",self.xaingmuLab.text,self.kaoshiName.text];
            self.banjiOneLab.text =[NSString stringWithFormat:@"%@%@",self.nianjiLab.text,self.banjiLab.text];
            if ([BGControl isNULLOfString:self.xuenianLab.text]) {
                [self Alert:@"请选择学年"];
            }else if ([BGControl isNULLOfString:self.xueqiLab.text]) {
                [self Alert:@"请选择学期"];
            }else if ([BGControl isNULLOfString:self.xiaoquLab.text]) {
                [self Alert:@"请选择校区"];
            }else if ([BGControl isNULLOfString:self.xaingmuLab.text]) {
                [self Alert:@"请选择项目"];
            }else if ([BGControl isNULLOfString:self.nianjiLab.text]) {
                [self Alert:@"请选择年级"];
            }else if ([BGControl isNULLOfString:self.banjiLab.text]) {
                [self Alert:@"请选择班级"];
            }else if ([BGControl isNULLOfString:self.kechengLab.text]) {
                [self Alert:@"请选择课程"];
            }else if ([BGControl isNULLOfString:self.typeLab.text]) {
                [self Alert:@"请选择考试类型"];
            }else if ([BGControl isNULLOfString:self.kaoshiName.text]) {
                [self Alert:@"请选择考试名称"];
            }else {
                [self.bigScrollView removeFromSuperview];
                self.bigScrollView.hidden = YES;
                self.blackButton.hidden = YES;
            [self show];
            NSNumber *num = [NSNumber numberWithInteger:noneId];
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:num,@"examId", nil];
            [[AFClient shareInstance] getResultWithDict:dict progressBlock:^(NSProgress *progress) {
                
            } success:^(id responseBody) {
                if ([[responseBody valueForKey:@"code"] integerValue] == 0) {
                    NSArray *arr = responseBody[@"data"];
                    [self show];
                    NSNumber *num = [NSNumber numberWithInteger:noneId];
                    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:num,@"examId", nil];
                    [[AFClient shareInstance] getResultWithDict:dict progressBlock:^(NSProgress *progress) {
                        
                    } success:^(id responseBody) {
                        if ([[responseBody valueForKey:@"code"] integerValue] == 0) {
                            NSArray *arr = responseBody[@"data"];
                            [self.dataArr removeAllObjects];
                             self.dataArr = [NSMutableArray arrayWithArray:arr];
                            [self.bigTableView reloadData];
                        }else{
                            [self Alert:responseBody[@"msg"]];
                        }
                        [self dismiss];
                    } failure:^(NSError *error) {
                        [self dismiss];
                    }];
                }else{
                    [self Alert:responseBody[@"msg"]];
                }
                [self dismiss];
            } failure:^(NSError *error) {
                [self dismiss];
            }];
        }
        }
        
    }else{
        
        ChoiceVC *choice = [storyboard instantiateViewControllerWithIdentifier:@"ChoiceVC"];
        choice.tag = sender.tag;
        choice.delegate = self;
        choice.schoolYearId = [NSString stringWithFormat:@"%ld",(long)oneId];
        choice.projectId =  [NSString stringWithFormat:@"%ld",(long)fourId];
        choice.gradeId =  [NSString stringWithFormat:@"%ld",(long)fiveId];
        choice.examTypeId =  [NSString stringWithFormat:@"%ld",(long)eightId];
        [self.navigationController pushViewController:choice animated:YES];
    }
}
- (void)blackButtonClick {
    [self.bigScrollView removeFromSuperview];
    self.bigScrollView.hidden = YES;
    self.blackButton.hidden = YES;
}
#pragma 展示筛选条件
- (IBAction)tiaoClick:(UIButton *)sender {
    self.blackButton.hidden = NO;
    self.bigScrollView.delegate = self;
    self.bigScrollView.showsVerticalScrollIndicator = NO;
    self.bigScrollView.contentSize = CGSizeMake(kScreenSize.width,550);
    self.bigScrollView.scrollEnabled = YES;
    self.bigScrollView.hidden = NO;
    self.cancleBth.layer.cornerRadius = 5.f;
    self.cancleBth.layer.borderColor = KTabBarColor.CGColor;
    self.cancleBth.layer.borderWidth = 1.f;
    self.searchBth.layer.cornerRadius = 5.f;
    [self.view addSubview:self.bigScrollView];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:kCellName];
    if (!_cell) {
        _cell = [[TestScoresCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
    }
    CGRect cellFrame = _cell.contentView.frame;
    cellFrame.size.width = kScreenSize.width;
    [_cell.contentView setFrame:cellFrame];
    //    XyModel *model = self.dataArray[indexPath.row];
    NSDictionary *dict = self.dataArr[indexPath .section];
    [_cell showModelWithDict:dict];
    return _cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 55;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}
-(void)postValue:(NSString *)valueStr withId:(NSInteger)idNum withTag:(NSInteger)tag {
    if (tag == 301) {
        self.xuenianLab.text = valueStr;
        if (oneId != idNum) {
            oneId = idNum;
            self.xueqiLab.text = @"";
            self.xiaoquLab.text = @"";
            self.xaingmuLab.text = @"";
            self.nianjiLab.text = @"";
            self.banjiLab.text = @"";
            self.kechengLab.text = @"";
            self.typeLab.text = @"";
            self.kaoshiName.text = @"";
        }
        
        
    }else if (tag == 302) {
        self.xueqiLab.text = valueStr;
        
        if (twoId != idNum) {
            twoId = idNum;
            self.xiaoquLab.text = @"";
            self.xaingmuLab.text = @"";
            self.nianjiLab.text = @"";
            self.banjiLab.text = @"";
            self.kechengLab.text = @"";
            self.typeLab.text = @"";
            self.kaoshiName.text = @"";
        }
        
    }else if (tag == 303) {
        self.xiaoquLab.text = valueStr;
        if (threeId != idNum) {
            threeId = idNum;
            self.xaingmuLab.text = @"";
            self.nianjiLab.text = @"";
            self.banjiLab.text = @"";
            self.kechengLab.text = @"";
            self.typeLab.text = @"";
            self.kaoshiName.text = @"";
        }
        
    }else if (tag == 304) {
        self.xaingmuLab.text = valueStr;
        if (fourId != idNum) {
            fourId = idNum;
            self.nianjiLab.text = @"";
            self.banjiLab.text = @"";
            self.kechengLab.text = @"";
            self.typeLab.text = @"";
            self.kaoshiName.text = @"";
        }
    }else if (tag == 305) {
        self.nianjiLab.text = valueStr;
        if (fiveId != idNum) {
            fiveId = idNum;
            self.banjiLab.text = @"";
            self.kechengLab.text = @"";
            self.typeLab.text = @"";
            self.kaoshiName.text = @"";
        }
    }else if (tag == 306) {
        self.banjiLab.text = valueStr;
        if (sixId != idNum) {
            self.kechengLab.text = @"";
            self.typeLab.text = @"";
            self.kaoshiName.text = @"";
            sixId = idNum;
        }
    }else if (tag == 307) {
        self.kechengLab.text = valueStr;
        if (sevenId != idNum) {
            sevenId = idNum;
            self.typeLab.text = @"";
            self.kaoshiName.text = @"";
        }
    }else if (tag == 308) {
        self.typeLab.text = valueStr;
        if (eightId != idNum) {
            eightId = idNum;
            self.kaoshiName.text = @"";
        }
    }else if (tag == 309) {
        self.kaoshiName.text = valueStr;
        if (noneId != idNum) {
            noneId = idNum;
        }
    }
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
