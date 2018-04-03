//
//  ManagementVC.m
//  Teacher
//
//  Created by 冯丽 on 2018/1/11.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "ManagementVC.h"
#import "ManagementCell.h"
#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import <AVFoundation/AVFoundation.h>
#import "BGControl.h"
#define kCellName @"ManagementCell"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ManagementVC ()<UITableViewDelegate,UITableViewDataSource,maxHeiDelegate,UITextViewDelegate> {
    ManagementCell *_cell;
    NSInteger maxXHei;
    NSArray *txtArr;
}

@end

@implementation ManagementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bigTextView.delegate = self;
    if (kiPhoneX) {
        self.naView.frame = CGRectMake(0, 0, kScreenSize.width, kNavHeight);
        self.bigTableView.frame = CGRectMake(0, kNavHeight, kScreenSize.width, kScreenSize.height-kNavHeight-70);
    }
  
    self.bigTableView.showsVerticalScrollIndicator = NO;
    self.bigTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self first];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"信息详情";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.hidden = NO;
    
    
}
- (void)first {
    self.titleOneLab.text = self.model.title;
     CGFloat titleHei = [BGControl heightForRow:self.titleOneLab.text font:[UIFont systemFontOfSize:17] labelSize:CGSizeMake(kScreenSize.width - 30, MAXFLOAT)];
    self.titleOneLab.frame = CGRectMake(15, 20, kScreenSize.width-30, titleHei);
    self.timeLab.frame = CGRectMake(15, CGRectGetMaxY(self.titleOneLab.frame)+10, kScreenSize.width-30, 25);
    self.fgView.frame = CGRectMake(0, CGRectGetMaxY(self.timeLab.frame)+10, kScreenSize.width, 1);
    self.oneView.frame = CGRectMake(0, 0, kScreenSize.width, CGRectGetMaxY(self.fgView.frame));
    self.tanView.clipsToBounds = YES;
    self.tanView.layer.cornerRadius = 8.f;
    self.tanView.layer.borderColor = KLineColor.CGColor;
    self.tanView.layer.borderWidth = 1.f;
    
    NSString *timeStr = [NSString stringWithFormat:@"%@%@",@"发布时间:",[BGControl timeStampForDateStringWith:self.model.created]];
    NSString *teacherStr = [NSString stringWithFormat:@"%@%@",@"发布人:",_model.tname];
    self.timeLab.text = [NSString stringWithFormat:@"%@   %@",timeStr,teacherStr];
    NSInteger typeCount = [_model.type integerValue];
    if (typeCount == 0) {
        
        
        self.typeLab.text = [NSString stringWithFormat:@"%@    %@",@"分类：在校表现",self.model.sname];
    }else if (typeCount == 1) {
        self.typeLab.text = [NSString stringWithFormat:@"%@    %@",@"分类：奖惩记录",self.model.sname];
    }else if (typeCount == 2) {
        self.typeLab.text = [NSString stringWithFormat:@"%@    %@",@"分类：活动记录",self.model.sname];
    }
    self.detailLab.text = self.model.content;
     CGFloat detailHei = [BGControl heightForRow:self.detailLab.text font:[UIFont systemFontOfSize:15] labelSize:(CGSize)CGSizeMake(kScreenSize.width-30, MAXFLOAT)];
    self.detailLab.frame = CGRectMake(15, CGRectGetMaxY(self.fgView.frame)+10, kScreenSize.width-30, detailHei);
    NSArray *imgArr = [NSArray array];
    if (![BGControl isNULLOfString:self.model.img]) {
         imgArr = [self.model.img componentsSeparatedByString:@";"];
    }
    for (int i =0; i<imgArr.count; i++) {
        UIImageView *img = [[UIImageView alloc] init];
      [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imgArr[i]]] placeholderImage:[UIImage imageNamed:@"icon_moren(1).png"]];
        img.frame = CGRectMake(15, ((kScreenSize.width-30+10)*0.5)*i, kScreenSize.width-30, (kScreenSize.width-30)*0.5);
        [self.picView addSubview:img];
    }
    self.picView.frame = CGRectMake(0, CGRectGetMaxY(self.detailLab.frame)+15, kScreenSize.width, ((kScreenSize.width-30+10)*0.5)*imgArr.count);
   txtArr = [NSArray array];
    if (![BGControl isNULLOfString:_model.txt]) {
        txtArr = [_model.txt componentsSeparatedByString:@";"];
    }

    for (int i =0; i < txtArr.count; i++) {
        NSArray *fileArr = [txtArr[i] componentsSeparatedByString:@"◆"];
        if (fileArr.count >1) {
            UIView *downView = [[UIView alloc] init];
            downView.frame = CGRectMake(0, 55*i, kScreenSize.width-30, 50);
            downView.backgroundColor = KBgColor;
            downView.clipsToBounds = YES;
            downView.layer.cornerRadius = 5.f;
            [self.fileView addSubview:downView];
            UIImageView *fileImgView = [[UIImageView alloc] init];
            fileImgView.image = [UIImage imageNamed:@"cont_icon_folder.png"];
            fileImgView.frame = CGRectMake(10, 17, 20, 15);
            [downView addSubview:fileImgView];
            UIImageView *downImgView = [[UIImageView alloc] init];
            downImgView.frame = CGRectMake(CGRectGetMaxX(downView.frame)-8-18, 18, 18, 18);
            downImgView.image = [UIImage imageNamed:@"cont_icon_downl.png"];
            [downView addSubview:downImgView];
            UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, CGRectGetWidth(downView.frame) - 69, 50)];
            titleLab.textColor = KTextgrayColor;
            titleLab.font = [UIFont systemFontOfSize:15];
            [downView  addSubview:titleLab];
            titleLab.text = fileArr[1];
            
            UIButton *button = [BGControl creatButtonWithFrame:CGRectMake(0, 0, CGRectGetWidth(downView.frame), 50) target:self sel:@selector(downFile:) tag:200+i image:nil isBackgroundImage:NO title:nil isLayer:NO cornerRadius:0];
            [downView addSubview:button];
        }
        
        
        
    }
    self.fileView.frame = CGRectMake(15, CGRectGetMaxY(self.picView.frame)+5, kScreenSize.width-30, 55*txtArr.count);
    self.typeLab.frame = CGRectMake(15, CGRectGetMaxY(self.fileView.frame), kScreenSize.width-30, 50);
    self.topView.frame = CGRectMake(0, 0, kScreenSize.width, CGRectGetMaxY(self.self.typeLab.frame));
    [self.bigTableView setTableHeaderView:self.topView];

    [self getData];
    
}
-(void)getData {
    NSString *jsonString = [[NSUserDefaults standardUserDefaults]valueForKey:@"loginData"];
    NSDictionary *userInfoDict = [[BGControl dictionaryWithJsonString:jsonString] valueForKey:@"userInfo"];
    NSString *teacherId = [userInfoDict valueForKey:@"id"];
    NSString *sId = self.model.sid;
    NSString *idStr = self.model.id;
    NSDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:teacherId forKey:@"teacherId"];
    [dict setValue:sId forKey:@"studentId"];
    [dict setValue:idStr forKey:@"feedbackId"];
    [self show];
    [[AFClient shareInstance] FeedbackWithDetailWithDict:dict progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        self.dataArray = [[NSMutableArray alloc] init];
        self.dataArray =[responseBody[@"data"][0] valueForKey:@"replyBeans"];
        [self.bigTableView reloadData];
        [self dismiss];
    } failure:^(NSError *error) {
         [self dismiss];
    }];
}
- (IBAction)backClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return maxXHei;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:kCellName];
    if (!_cell) {
        _cell = [[ManagementCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
    }
    //    XyModel *model = self.dataArray[indexPath.row];
    
    CGRect cellFrame = _cell.contentView.frame;
    cellFrame.size.width = kScreenSize.width;
    [_cell.contentView setFrame:cellFrame];
    _cell.maxdelegate = self;
    NSDictionary *dictionary= self.dataArray[indexPath.row];
    [_cell showWithDict:dictionary withTeacher:self.model.tname withIndex:indexPath.row];
    
    return _cell;
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
- (void)Alert:(NSString *)AlertStr{
    
    [LYMessageToast toastWithText:AlertStr backgroundColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] fontColor:[UIColor whiteColor] duration:2.f inView:self.view];
    
}


//-(void)getMaxHei:(CGFloat)maxHei withIndex:(NSInteger)index {
//    maxXHei = maxHei;
//
//}
- (void)getHei:(CGFloat)maxHei withIndex:(NSInteger)index {
     maxXHei = maxHei;
}
- (void)downFile:(UIButton *)button {
    [self Alert:@"暂不支持此功能!"];
//    NSString *txtStr = txtArr[button.tag-200];
////    NSString *url = [txtStr componentsSeparatedByString:@"◆"][0];
//    //1.创建会话管理者
//
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//
//
//
//
//
//    //2.创建请求对象
//     NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/images/minion_13.png"];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//
//    // 创建会话
//    NSURLSession *session = [NSURLSession sharedSession];
//
//    NSURLSessionDownloadTask *downLoadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            [self Alert:@"开始下载"];
//
//
//        });
//
//        if (!error) {
//            // 下载成功
//            // 注意 location是下载后的临时保存路径, 需要将它移动到需要保存的位置
//            NSError *saveError;
//            // 创建一个自定义存储路径
//            NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//            NSString *savePath = [cachePath stringByAppendingPathComponent:[txtStr componentsSeparatedByString:@"◆"][0]];
//            NSURL *saveURL = [NSURL fileURLWithPath:savePath];
//
//            // 文件复制到cache路径中
//            [[NSFileManager defaultManager] copyItemAtURL:location toURL:saveURL error:&saveError];
//            if (!saveError) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//
//                   [self Alert:@"保存成功！"];
//
//
//                });
//
//                NSLog(@"保存成功");
//            } else {
//                dispatch_async(dispatch_get_main_queue(), ^{
//
//                   [self Alert:@"保存失败！"];
//
//
//                });
//
//                NSLog(@"error is %@", saveError.localizedDescription);
//            }
//        } else {
//            dispatch_async(dispatch_get_main_queue(), ^{
//
//              [self Alert:@"保存失败！"];
//
//
//            });
//
//            NSLog(@"error is : %@", error.localizedDescription);
//        }
//    }];
//    // 恢复线程, 启动任务
//    [downLoadTask resume];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{  [self.bigTextView resignFirstResponder];
    
//    [UIView animateWithDuration:0.3 animations:^{
//        CGRect frame = self.view.frame;
//        frame.origin.y = 0;
//        self.bottomView.frame = frame;
//    }];
    
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    CGFloat offset = self.view.frame.size.height - (280+self.bottomView.frame.size.height);
    if (offset>=0) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.bottomView.frame;
            frame.origin.y = offset;
            self.bottomView.frame = frame;
        }];
    }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
      return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [self.bigTextView resignFirstResponder];
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.bottomView.frame;
            frame.origin.y = CGRectGetMaxY(self.view.frame)-70;
            self.bottomView.frame = frame;
        }];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}
- (IBAction)sendClick:(UIButton *)sender {
    [self show];
    [[AFClient shareInstance] techerFeedBackWithStudentId:self.model.sid withContent:self.bigTextView.text withFeedbackId:self.model.id progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([[responseBody valueForKey:@"code"] integerValue] == 0) {
            [self Alert:@"回复成功！"];
            self.bigTextView.text = @"";
            [self getData];
//            [self.bigTextView resignFirstResponder];
            
        }else{
            [self Alert:responseBody[@"msg"]];
        }
        [self.bigTableView reloadData];
        
        [self dismiss];
    } failure:^(NSError *error) {
       [self dismiss];
    }];
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
