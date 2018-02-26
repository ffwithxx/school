//
//  MessageDetailVC.m
//  Teacher
//
//  Created by 冯丽 on 2018/1/10.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "MessageDetailVC.h"
#import "BGControl.h"

@interface MessageDetailVC ()

@end

@implementation MessageDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (kiPhoneX) {
        self.naView.frame = CGRectMake(0, 0, kScreenSize.width, kNavHeight);
        self.bigScrollview.frame = CGRectMake(0, kNavHeight, kScreenSize.width, kScreenSize.height-kNavHeight);
       
    }
     [self setData];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"消息详情";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.hidden = NO;
    
}
- (void)setData {
    
  self.DetailTitleLab.text = [self.dataDict valueForKey:@"title"];
    NSString *timeLab = [BGControl updateTimeForRow:[[self.dataDict valueForKey:@"createAt"] integerValue]];
    NSString *fabu = [self.dataDict valueForKey:@"postByName"];
    self.timeLab.text  = [NSString stringWithFormat:@"%@    %@",timeLab,fabu];
    self.detailLab.text = [self.dataDict valueForKey:@"content"];
    self.downNameLab.text =[self.dataDict valueForKey:@"title"];
    CGFloat titleHei = [BGControl getSpaceLabelHeight:self.DetailTitleLab.text withFont:[UIFont systemFontOfSize:17] withWidth:kScreenSize.width - 30];
    self.DetailTitleLab.frame = CGRectMake(15, 20, kScreenSize.width-30, titleHei);
    self.timeLab.frame = CGRectMake(15, titleHei+30, kScreenSize.width-30, 25);
    self.oneView.frame = CGRectMake(0, 0, kScreenSize.width, titleHei+65);
    CGFloat detailHei = [BGControl getSpaceLabelHeight:self.detailLab.text withFont:[UIFont systemFontOfSize:15] withWidth:kScreenSize.width - 30];
    self.detailLab.frame = CGRectMake(15, 15, kScreenSize.width-30, detailHei);
    self.threeView.frame = CGRectMake(15, detailHei+25, kScreenSize.width-30, 50);
    self.twoView.frame = CGRectMake(0,  titleHei+65, kScreenSize.width, 85+detailHei);
    self.bigScrollview.contentSize = CGSizeMake(kScreenSize.width,CGRectGetMaxY(self.twoView.frame));
    
}
- (IBAction)backClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)downClick:(UIButton *)sender {
    [self downloadFile];
}
- (void)downloadFile{
    
    NSString *urlStr = [self.dataDict valueForKey:@"tcheAttchment"];
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            
            NSError *saveError;
            
            NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            
            NSString *savePath = [cachePath stringByAppendingPathComponent:@"ceshi.mp3"];
            
            NSURL *saveUrl = [NSURL fileURLWithPath:savePath];
            
            //把下载的内容从cache复制到document下
            
            [[NSFileManager defaultManager] copyItemAtURL:location toURL:saveUrl error:&saveError];
            
            if (!saveError) {
                
                NSLog(@"save success");
                
            }else{
                
                NSLog(@"save error:%@",saveError.localizedDescription);
                
            }
            
        }else{
            
            NSLog(@"download error:%@",error.localizedDescription);
            
        }
        
    }];
    
    [downloadTask resume];
    
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
