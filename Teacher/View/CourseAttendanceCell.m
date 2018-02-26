//
//  CourseAttendanceCell.m
//  Teacher
//
//  Created by 冯丽 on 2018/1/10.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "CourseAttendanceCell.h"
#import "BGControl.h"
@implementation CourseAttendanceCell{
    CourseAttendanceModel *modelOne;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (_openDelegate &&[_openDelegate respondsToSelector:@selector(postWithIndex:)]) {
        [_openDelegate postWithIndex:modelOne.index];
    }
}
- (void)showModel:(CourseAttendanceModel *)model {
    modelOne = model;
    self.nameLab.text = model.studentName;
    self.remarkLab.text = model.note;
    self.typeBth.layer.cornerRadius = 5.f;
    if ([model.status isEqualToString:@"0"]) {
        [self.typeBth setTitle:@"上课" forState:UIControlStateNormal];
        [self.typeBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.typeBth setBackgroundColor:KTabBarColor];
    }else if ([model.status isEqualToString:@"1"]) {
         [self.typeBth setTitle:@"迟到" forState:UIControlStateNormal];
        [self.typeBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.typeBth setBackgroundColor:[UIColor colorWithRed:229/255.0 green:83/255.0 blue:51/255.0 alpha:1.0]];
    }else if ([model.status isEqualToString:@"2"]) {
        [self.typeBth setTitle:@"请假" forState:UIControlStateNormal];
        [self.typeBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.typeBth setBackgroundColor:KYellowColor];
    }else if ([model.status isEqualToString:@"3"]) {
        [self.typeBth setTitle:@"早退" forState:UIControlStateNormal];
        [self.typeBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.typeBth setBackgroundColor:[UIColor colorWithRed:51/255.0 green:180/255.0 blue:184/255.0 alpha:1.0]];
    }else if ([model.status isEqualToString:@"4"]) {
        [self.typeBth setTitle:@"旷课" forState:UIControlStateNormal];
        [self.typeBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.typeBth setBackgroundColor:[UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:1.0]];
    }
    CGFloat hei = 0;
    if (![BGControl isNULLOfString:self.remarkLab.text]) {
        CGFloat detailHei = [BGControl getSpaceLabelHeight:self.remarkLab.text withFont:[UIFont systemFontOfSize:15] withWidth:kScreenSize.width - 60];
        
        if (detailHei < 25) {
            hei = 25;
        }else {
            hei = detailHei;
        }
    }
    
    self.remarkTitleLab.frame = CGRectMake(15, 5, 50, hei);
    self.remarkLab.frame = CGRectMake(65, 5, kScreenSize.width-65-15, hei);
    self.noteView.frame = CGRectMake(0, 55, kScreenSize.width, hei +15);
    if (model.open == 1) {
        self.noteView.hidden = NO;
    }else{
        self.noteView.hidden = YES;
    }
    if (_delegate &&[_delegate respondsToSelector:@selector(getMaxHei:withIndex:)]) {
        [_delegate getMaxHei:70+hei  withIndex:model.index];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
