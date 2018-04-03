//
//  ChoiceVC.m
//  Teacher
//
//  Created by 冯丽 on 2018/1/30.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "ChoiceVC.h"
#import "BGControl.h"
#import "ChoiceCell.h"
#import "AFClient.h"
#import "BGControl.h"
#define  kCellName @"ChoiceCell"
@interface ChoiceVC ()<UITableViewDelegate,UITableViewDataSource> {
      ChoiceCell *_cell;
}

@end

@implementation ChoiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [[NSMutableArray alloc] init];
    self.bigTableView.showsVerticalScrollIndicator = NO;
    self.bigTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    if (kiPhoneX) {
        self.navView.frame = CGRectMake(0, 0, kScreenSize.width, kNavHeight);
        self.bigTableView.frame = CGRectMake(0, kNavHeight, kScreenSize.width, kScreenSize.height-kNavHeight);
    }
    [self first];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"选择";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)first {
    
    NSString *jsonString = [[NSUserDefaults standardUserDefaults]valueForKey:@"loginData"];
    NSDictionary  *userInfoDict = [[BGControl dictionaryWithJsonString:jsonString] valueForKey:@"userInfo"];
    NSString *url ;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    if (self.tag == 301) {
        url = @"schoolyear/get";
        [dict setObject:[NSString stringWithFormat:@"%@",[userInfoDict valueForKey:@"schoolPid"]] forKey:@"schoolPid"];
    }else if (self.tag == 302) {
        url = @"schoolterm/get";
        if ([BGControl isNULLOfString:self.schoolYearId]) {
            [self Alert:@"请先选择学年"];
            return;
        }
        [dict setValue:self.schoolYearId forKey:@"schoolYearId"];
    }else if (self.tag == 303) {
        url = @"school/get";
     [dict setValue:[NSString stringWithFormat:@"%@",[userInfoDict valueForKey:@"schoolPid"]] forKey:@"parentId"];
    }else if (self.tag == 304) {
        url = @"project/get";
        [dict setValue:[NSString stringWithFormat:@"%@",self.schoolId] forKey:@"schoolId"];
    }else if (self.tag == 305) {
        url = @"grade/get";
        if ([BGControl isNULLOfString:self.projectId]) {
            [self Alert:@"请先选择项目"];
            return;
        }
        [dict setValue:self.projectId forKey:@"projectId"];
    }else if (self.tag == 306) {
        url = @"class/get";
        if ([BGControl isNULLOfString:self.gradeId]) {
            [self Alert:@"请先选择年级"];
            return;
        }
        [dict setValue:self.gradeId forKey:@"gradeId"];
    }else if (self.tag == 307) {
        url = @"course/get";
        if ([BGControl isNULLOfString:self.schoolId]) {
            [self Alert:@"请先选择校区"];
            return;
        }
        [dict setValue:self.schoolId forKey:@"schoolId"];
    }else if (self.tag == 308) {
        url = @"examTypeApp/get";
        if ([BGControl isNULLOfString:self.schoolId]) {
            [self Alert:@"请先选择校区"];
            return;
        }
        [dict setValue:[userInfoDict valueForKey:@"schoolPid"] forKey:@"schoolPid"];
    }else if (self.tag == 309) {
        url = @"exam/get";
        if ([BGControl isNULLOfString:self.examTypeId]) {
            [self Alert:@"请先选择考试类型"];
            return;
        }
        [dict setValue:self.examTypeId forKey:@"examTypeId"];
    }else if (self.tag == 310) {
        url = @"Achievementstudentss/get";
        if ([BGControl isNULLOfString:self.examId]) {
            [self Alert:@"请先选择学期"];
            return;
        }
        [dict setValue:self.examId forKey:@"examId"];
    }
    [self show];
    [[AFClient shareInstance] getResultwithUrlStr:url withDict:dict progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([[responseBody valueForKey:@"code"] integerValue] == 0) {
            [self.dataArray removeAllObjects];
            NSArray *arr = [responseBody valueForKey:@"data"];
            for (int i = 0; i< arr.count; i++) {
                NSDictionary *dict = arr[i];
                [self.dataArray addObject:dict];
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
- (IBAction)backClick:(UIButton *)sender {
      [self.navigationController popViewControllerAnimated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:kCellName];
    if (!_cell) {
        _cell = [[ChoiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
    }
    CGRect cellFrame = _cell.contentView.frame;
    cellFrame.size.width = kScreenSize.width;
    [_cell.contentView setFrame:cellFrame];

    NSDictionary *dict = self.dataArray[indexPath.section];
    NSString *str;
    if (self.tag == 301) {
       str = [NSString stringWithFormat:@"%@-%@",[dict valueForKey:@"startYear"],[dict valueForKey:@"endYear"]];
      
    }else if (self.tag == 302) {
       str = [NSString stringWithFormat:@"%@",[dict valueForKey:@"name"]];
        
    }else if (self.tag == 303) {
        str = [NSString stringWithFormat:@"%@",[dict valueForKey:@"name"]];
     
    }else if (self.tag == 304) {
         str = [NSString stringWithFormat:@"%@",[dict valueForKey:@"name"]];
    }else if (self.tag == 305) {
        str = [NSString stringWithFormat:@"%@",[dict valueForKey:@"name"]];
    }else if (self.tag == 306) {
         str = [NSString stringWithFormat:@"%@",[dict valueForKey:@"name"]];
    }else if (self.tag == 307) {
         str = [NSString stringWithFormat:@"%@",[dict valueForKey:@"name"]];
    }else if (self.tag == 308) {
         str = [NSString stringWithFormat:@"%@",[dict valueForKey:@"name"]];
    }else if (self.tag == 309) {
         str = [NSString stringWithFormat:@"%@",[dict valueForKey:@"name"]];
    }
    _cell.titleLab.text = str;
    return _cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.dataArray[indexPath.section];
    return 45;
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dict = self.dataArray[indexPath.section];
    NSString *str;
    if (self.tag == 301) {
        str = [NSString stringWithFormat:@"%@-%@",[dict valueForKey:@"startYear"],[dict valueForKey:@"endYear"]];
        
    }else if (self.tag == 302) {
        str = [NSString stringWithFormat:@"%@",[dict valueForKey:@"name"]];
        
    }else if (self.tag == 303) {
        str = [NSString stringWithFormat:@"%@",[dict valueForKey:@"name"]];
        
    }else if (self.tag == 304) {
        str = [NSString stringWithFormat:@"%@",[dict valueForKey:@"name"]];
    }else if (self.tag == 305) {
        str = [NSString stringWithFormat:@"%@",[dict valueForKey:@"name"]];
    }else if (self.tag == 306) {
        str = [NSString stringWithFormat:@"%@",[dict valueForKey:@"name"]];
    }else if (self.tag == 307) {
        str = [NSString stringWithFormat:@"%@",[dict valueForKey:@"name"]];
    }else if (self.tag == 308) {
        str = [NSString stringWithFormat:@"%@",[dict valueForKey:@"name"]];
    }else if (self.tag == 309) {
        str = [NSString stringWithFormat:@"%@",[dict valueForKey:@"name"]];
    }
    if (_delegate &&[_delegate respondsToSelector:@selector(postValue:withId:withTag:)]) {
        [_delegate postValue:str withId:[[dict valueForKey:@"id"]integerValue] withTag:self.tag];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
    
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
