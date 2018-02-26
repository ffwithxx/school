//
//  ThreeViewController.m
//  Teacher
//
//  Created by 冯丽 on 2017/12/28.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "ThreeViewController.h"
#import "TestScoresVC.h"
#import "ChoiceVC.h"
#import "BGControl.h"

@interface ThreeViewController ()<UITableViewDelegate,UITableViewDataSource,postValueDelegate>{
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

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topView.frame = CGRectMake(0, 0, kScreenSize.width, 600);
    [self.bigTableView setTableHeaderView:self.topView];
    self.searchBth.layer.cornerRadius = 8.f;
    self.bigTableView.showsVerticalScrollIndicator = NO;
    self.bigTableView.separatorStyle = UITableViewCellSelectionStyleNone;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
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
- (IBAction)buttonClick:(UIButton *)sender {
      UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if (sender.tag != 310) {
      
        ChoiceVC *choice = [storyboard instantiateViewControllerWithIdentifier:@"ChoiceVC"];
        choice.tag = sender.tag;
        choice.delegate = self;
        choice.schoolYearId = [NSString stringWithFormat:@"%ld",(long)oneId];
        choice.projectId =  [NSString stringWithFormat:@"%ld",(long)fourId];
        choice.gradeId =  [NSString stringWithFormat:@"%ld",(long)fiveId];
        choice.examTypeId =  [NSString stringWithFormat:@"%ld",(long)eightId];
        [self.navigationController pushViewController:choice animated:YES];
    }else{
        if ([BGControl isNULLOfString:self.xuenianLab.text]) {
            [self Alert:@"请选择学年"];
        }else if ([BGControl isNULLOfString:self.xueqiLab.text]) {
            [self Alert:@"请选择学期"];
        }else if ([BGControl isNULLOfString:self.xiaoquLab.text]) {
            [self Alert:@"请选择校区"];
        }else if ([BGControl isNULLOfString:self.xiangmuLab.text]) {
            [self Alert:@"请选择项目"];
        }else if ([BGControl isNULLOfString:self.nianjiLab.text]) {
            [self Alert:@"请选择年级"];
        }else if ([BGControl isNULLOfString:self.banjiLab.text]) {
            [self Alert:@"请选择班级"];
        }else if ([BGControl isNULLOfString:self.kechengLab.text]) {
            [self Alert:@"请选择课程"];
        }else if ([BGControl isNULLOfString:self.typeLab.text]) {
            [self Alert:@"请选择考试类型"];
        }else if ([BGControl isNULLOfString:self.nameLab.text]) {
            [self Alert:@"请选择考试名称"];
        }else {
            [self show];
            NSNumber *num = [NSNumber numberWithInteger:noneId];
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:num,@"examId", nil];
            [[AFClient shareInstance] getResultWithDict:dict progressBlock:^(NSProgress *progress) {
                
            } success:^(id responseBody) {
                if ([[responseBody valueForKey:@"code"] integerValue] == 0) {
                    NSArray *arr = responseBody[@"data"];
                        
                        TestScoresVC *testScore = [storyboard instantiateViewControllerWithIdentifier:@"TestScoresVC"];
                         testScore.dataArr = [NSMutableArray arrayWithArray:arr];
                         testScore.titleStr = [NSString stringWithFormat:@"%@%@",self.xiangmuLab.text,self.nameLab.text];
                         testScore.niajiStr =[NSString stringWithFormat:@"%@%@",self.nianjiLab.text,self.banjiLab.text];
                        [self.navigationController pushViewController:testScore animated:YES];
                }else{
                    [self Alert:responseBody[@"msg"]];
                }
                [self dismiss];
            } failure:^(NSError *error) {
                 [self dismiss];
            }];
        }
    }
   
    
}
- (void)Alert:(NSString *)AlertStr{
    
    [LYMessageToast toastWithText:AlertStr backgroundColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] fontColor:[UIColor whiteColor] duration:2.f inView:[[UIApplication sharedApplication].windows lastObject]];
    
}
-(void)postValue:(NSString *)valueStr withId:(NSInteger)idNum withTag:(NSInteger)tag {
    if (tag == 301) {
        self.xuenianLab.text = valueStr;
        if (oneId != idNum) {
            oneId = idNum;
            self.xueqiLab.text = @"";
            self.xiaoquLab.text = @"";
            self.xiangmuLab.text = @"";
            self.nianjiLab.text = @"";
            self.banjiLab.text = @"";
            self.kechengLab.text = @"";
            self.typeLab.text = @"";
            self.nameLab.text = @"";
        }
        
        
    }else if (tag == 302) {
        self.xueqiLab.text = valueStr;
        
         if (twoId != idNum) {
             twoId = idNum;
        self.xiaoquLab.text = @"";
        self.xiangmuLab.text = @"";
        self.nianjiLab.text = @"";
        self.banjiLab.text = @"";
        self.kechengLab.text = @"";
        self.typeLab.text = @"";
        self.nameLab.text = @"";
        }
        
    }else if (tag == 303) {
        self.xiaoquLab.text = valueStr;
         if (threeId != idNum) {
        threeId = idNum;
        self.xiangmuLab.text = @"";
        self.nianjiLab.text = @"";
        self.banjiLab.text = @"";
        self.kechengLab.text = @"";
        self.typeLab.text = @"";
        self.nameLab.text = @"";
         }
        
    }else if (tag == 304) {
       self.xiangmuLab.text = valueStr;
         if (fourId != idNum) {
          fourId = idNum;
        self.nianjiLab.text = @"";
        self.banjiLab.text = @"";
        self.kechengLab.text = @"";
        self.typeLab.text = @"";
        self.nameLab.text = @"";
         }
    }else if (tag == 305) {
       self.nianjiLab.text = valueStr;
         if (fiveId != idNum) {
        fiveId = idNum;
        self.banjiLab.text = @"";
        self.kechengLab.text = @"";
        self.typeLab.text = @"";
        self.nameLab.text = @"";
         }
    }else if (tag == 306) {
         self.banjiLab.text = valueStr;
         if (sixId != idNum) {
        self.kechengLab.text = @"";
        self.typeLab.text = @"";
        self.nameLab.text = @"";
        sixId = idNum;
         }
    }else if (tag == 307) {
       self.kechengLab.text = valueStr;
         if (sevenId != idNum) {
        sevenId = idNum;
        self.typeLab.text = @"";
        self.nameLab.text = @"";
         }
    }else if (tag == 308) {
       self.typeLab.text = valueStr;
         if (eightId != idNum) {
        eightId = idNum;
         self.nameLab.text = @"";
         }
    }else if (tag == 309) {
       self.nameLab.text = valueStr;
         if (noneId != idNum) {
        noneId = idNum;
         }
    }
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
