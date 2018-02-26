//
//  JJBaseController.h
//  Teacher
//
//  Created by 冯丽 on 2017/12/28.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYMessageToast.h"
#import "AFClient.h"
static NSString *cellIdetifider = @"JJBaseCell";
@interface JJBaseController : UIViewController
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *leftButton;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic)  UILabel *titleLab;
@property (strong, nonatomic)  UIImageView *leftImg;
@property (strong, nonatomic)  UIImageView *rightImg;
@property (nonatomic, strong) UIButton *blackButton;
@property (nonatomic, strong) UIButton *blackOneButton;
@property (nonatomic)NSMutableArray *dataArray;
- (void)show ;
- (void)dismiss;
/**
 *  自动弹出警告框  1.5s消失
 */
- (void)Alert:(NSString *)AlertStr;
-(void)blackButtonClick;
@end
