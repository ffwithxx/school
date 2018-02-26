//
//  ScheduleCell.m
//  Teacher
//
//  Created by 冯丽 on 2017/12/21.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "ScheduleCell.h"

@implementation ScheduleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)showModel {
    
    
    self.signBth.clipsToBounds = YES;
    self.signBth.layer.cornerRadius = 5.f;
    self.signBth.layer.borderColor = [UIColor colorWithRed:86/255.0 green:38/255.0 blue:99/255.0 alpha:1.0].CGColor;
    self.signBth.layer.borderWidth = 1.f;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
