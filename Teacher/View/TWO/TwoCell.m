//
//  TwoCell.m
//  Teacher
//
//  Created by 冯丽 on 2018/1/8.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "TwoCell.h"

@implementation TwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (_attendanceDelegate && [_attendanceDelegate respondsToSelector:@selector(postTagStr:)]) {
        [_attendanceDelegate postTagStr:[NSString stringWithFormat:@"%ld",sender.tag]];
    }
}
- (void)showModel {
    self.signBth.layer.cornerRadius = 5.f;
    self.signBth.clipsToBounds = YES;
    self.signBth.layer.borderColor = KTabBarColor.CGColor;
    self.signBth.layer.borderWidth = 1.f;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
