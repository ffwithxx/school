//
//  TwoViewController.m
//  Teacher
//
//  Created by 冯丽 on 2017/12/28.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "TwoViewController.h"
#import "TwoCell.h"
#define kCellName @"TwoCell"
#import "sign.h"
@interface TwoViewController ()<UITableViewDelegate,UITableViewDataSource,attendanceDelegate,choiceDelegate,UITextViewDelegate>{
    TwoCell *_cell;
    sign *signView;
    NSString *typeStr;
    NSString *remarkString;
  
}

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    typeStr = @"301";
    self.topView.frame = CGRectMake(0, 0, kScreenSize.width, 130);
    [self.bigTableView setTableHeaderView:self.topView];
    self.bigTableView.showsVerticalScrollIndicator = NO;
    self.bigTableView.separatorStyle = UITableViewCellSelectionStyleNone;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

/**
 topview点击

 @param sender
 */
- (IBAction)buttonClick:(UIButton *)sender {
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:kCellName];
    if (!_cell) {
        _cell = [[TwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
    }
    //    XyModel *model = self.dataArray[indexPath.row];
    
    CGRect cellFrame = _cell.contentView.frame;
    cellFrame.size.width = kScreenSize.width;
    _cell.attendanceDelegate = self;
    [_cell.contentView setFrame:cellFrame];
    [_cell showModel];
    return _cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

#pragma  点击事件代理

- (void)postTagStr:(NSString *)tagStr {
    if ([tagStr isEqualToString:@"301"]) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"sign" owner:self options:nil];
        signView = [nib firstObject];
        self.blackButton.hidden = NO;
        signView.choiceDelegate =self;
        [self.view addSubview:signView];
        signView.center = self.view.center;
        signView.clipsToBounds = YES;
        signView.layer.cornerRadius = 10.f;
        signView.remarkTextView.delegate = self;
        
        [self changeTwo:signView];
    }
}

- (void)postChoiceStr:(NSString *)choiceStr withRemarkStr:(NSString *)remarkStr withtypeStr:(NSString *)type {
    
    if ([choiceStr isEqualToString:@"305"]) {
        signView.hidden = YES;
        self.blackButton.hidden = YES;
      
    }else if ([choiceStr isEqualToString:@"306"]){
        typeStr = type;
        remarkString = remarkStr;
        signView.hidden = YES;
        self.blackButton.hidden = YES;
        [self show];
        [[AFClient shareInstance] updateAttendance:@"480" withStatus:@"1" progressBlock:^(NSProgress *progress) {
            
        } success:^(id responseBody) {
            if ([[responseBody valueForKey:@"code"] integerValue] == 0) {
                
                
            }else{
                [self Alert:responseBody[@"msg"]];
            }
            [self dismiss];
        } failure:^(NSError *error) {
            [self dismiss];
        }];
    }
}

- (void)changeTwo:(sign *)test{
    
    
    if ([typeStr isEqualToString:@"301"] ) {
        [test.oneBth setBackgroundColor:KTabBarColor];
        [test.twoBth setBackgroundColor:[UIColor whiteColor]];
        test.twoBth.layer.cornerRadius = 5.f;
        test.twoBth.layer.borderColor = KTabBarColor.CGColor;
        test.twoBth.layer.borderWidth = 1.f;
        [test.threeBth setBackgroundColor:[UIColor whiteColor]];
        [test.fourBth setBackgroundColor:[UIColor whiteColor]];
        test.threeBth.layer.cornerRadius = 5.f;
        test.threeBth.layer.borderColor = KTabBarColor.CGColor;
        test.threeBth.layer.borderWidth = 1.f;
        [test.twoBth setTitleColor:KTabBarColor forState:UIControlStateNormal];
        [test.oneBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [test.threeBth setTitleColor:KTabBarColor forState:UIControlStateNormal];
        [test.fourBth setTitleColor:KTabBarColor forState:UIControlStateNormal];
        test.fourBth.layer.cornerRadius = 5.f;
        test.fourBth.layer.borderColor = KTabBarColor.CGColor;
        test.fourBth.layer.borderWidth = 1.f;
        test.oneBth.layer.cornerRadius =5.f;
    }else if ([typeStr isEqualToString:@"302"]) {
        [test.twoBth setBackgroundColor:KTabBarColor];
        [test.oneBth setBackgroundColor:[UIColor whiteColor]];
        test.oneBth.layer.cornerRadius = 5.f;
        test.oneBth.layer.borderColor = KTabBarColor.CGColor;
        test.oneBth.layer.borderWidth = 1.f;
        [test.threeBth setBackgroundColor:[UIColor whiteColor]];
        [test.fourBth setBackgroundColor:[UIColor whiteColor]];
        test.threeBth.layer.cornerRadius = 5.f;
        test.threeBth.layer.borderColor = KTabBarColor.CGColor;
        test.threeBth.layer.borderWidth = 1.f;
        [test.oneBth setTitleColor:KTabBarColor forState:UIControlStateNormal];
        [test.twoBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [test.threeBth setTitleColor:KTabBarColor forState:UIControlStateNormal];
        [test.fourBth setTitleColor:KTabBarColor forState:UIControlStateNormal];
        test.fourBth.layer.cornerRadius = 5.f;
        test.fourBth.layer.borderColor = KTabBarColor.CGColor;
        test.fourBth.layer.borderWidth = 1.f;
        test.twoBth.layer.cornerRadius = 5.f;
        
        
    }else if ([typeStr isEqualToString:@"303"]) {
        [test.threeBth setBackgroundColor:KTabBarColor];
        [test.oneBth setBackgroundColor:[UIColor whiteColor]];
        test.oneBth.layer.cornerRadius = 5.f;
        test.oneBth.layer.borderColor = KTabBarColor.CGColor;
        test.oneBth.layer.borderWidth = 1.f;
        [test.twoBth setBackgroundColor:[UIColor whiteColor]];
        [test.fourBth setBackgroundColor:[UIColor whiteColor]];
        test.twoBth.layer.cornerRadius = 5.f;
        test.twoBth.layer.borderColor = KTabBarColor.CGColor;
        test.twoBth.layer.borderWidth = 1.f;
        [test.oneBth setTitleColor:KTabBarColor forState:UIControlStateNormal];
        [test.threeBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [test.twoBth setTitleColor:KTabBarColor forState:UIControlStateNormal];
        [test.fourBth setTitleColor:KTabBarColor forState:UIControlStateNormal];
        test.fourBth.layer.cornerRadius = 5.f;
        test.fourBth.layer.borderColor = KTabBarColor.CGColor;
        test.fourBth.layer.borderWidth = 1.f;
        test.threeBth.layer.cornerRadius = 5.f;
    }else if ([typeStr isEqualToString:@"304"]) {
        [test.fourBth setBackgroundColor:KTabBarColor];
        [test.oneBth setBackgroundColor:[UIColor whiteColor]];
        test.oneBth.layer.cornerRadius = 5.f;
        test.oneBth.layer.borderColor = KTabBarColor.CGColor;
        test.oneBth.layer.borderWidth = 1.f;
        [test.threeBth setBackgroundColor:[UIColor whiteColor]];
        [test.twoBth setBackgroundColor:[UIColor whiteColor]];
        test.twoBth.layer.cornerRadius = 5.f;
        test.twoBth.layer.borderColor = KTabBarColor.CGColor;
        test.twoBth.layer.borderWidth = 1.f;
        [test.oneBth setTitleColor:KTabBarColor forState:UIControlStateNormal];
        [test.fourBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [test.threeBth setTitleColor:KTabBarColor forState:UIControlStateNormal];
        [test.twoBth setTitleColor:KTabBarColor forState:UIControlStateNormal];
        test.threeBth.layer.cornerRadius = 5.f;
        test.threeBth.layer.borderColor = KTabBarColor.CGColor;
        test.threeBth.layer.borderWidth = 1.f;
        test.fourBth.layer.cornerRadius = 5.f;
    }
    
    
    
}


-(void)blackButtonClick {
    signView.hidden = YES;
    self.blackButton.hidden = YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (!textView.text.length) {
        signView.placLab.alpha = 1;
    }else {
        signView.placLab.alpha = 0;
    }
}
- (void) dismissKeyBoard {
    [signView.remarkTextView resignFirstResponder];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![signView.remarkTextView isExclusiveTouch]) {
        [signView.remarkTextView resignFirstResponder];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
