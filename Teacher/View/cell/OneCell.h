//
//  OneCell.h
//  Teacher
//
//  Created by 冯丽 on 2017/12/28.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeacherScheduleModel.h"
@protocol siginDelegate <NSObject>
@optional
- (void)postStr:(NSString *)Str;
@end



@interface OneCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UILabel *kemuLab;
@property (strong, nonatomic) IBOutlet UIButton *signBth;
@property (strong, nonatomic) id<siginDelegate> signDelegate;
-(void)showModelWith:(TeacherScheduleModel *)model;
@end
