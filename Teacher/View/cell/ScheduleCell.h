//
//  ScheduleCell.h
//  Teacher
//
//  Created by 冯丽 on 2017/12/21.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UILabel *kemuLab;
@property (strong, nonatomic) IBOutlet UIButton *signBth;
-(void)showModel;
@end
