//
//  TwoCell.m
//  Teacher
//
//  Created by 冯丽 on 2018/1/8.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "TwoCell.h"

@implementation TwoCell {
    NSDictionary *modelDict;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (_attendanceDelegate && [_attendanceDelegate respondsToSelector:@selector(postTagStr:withIdStr:)]) {
        [_attendanceDelegate postTagStr:[NSString stringWithFormat:@"%ld",sender.tag] withIdStr:[modelDict valueForKey:@"id"]];
    }
}
- (void)showModelWithDict:(NSDictionary *)dict {
    modelDict = dict;
    self.nameLab.text = [dict valueForKey:@"studentName"];
    NSInteger status = [[dict valueForKey:@"status"] integerValue];
    if (status == 1) {
        self.signBth.layer.cornerRadius = 5.f;
        self.signBth.clipsToBounds = YES;
        self.signBth.layer.borderWidth = 1.f;
        self.signBth.layer.borderColor = [UIColor colorWithRed:229/255.0 green:83/255.0 blue:51/255.0 alpha:1.0].CGColor;
        [self.signBth setTitle:@"迟到" forState:UIControlStateNormal];
        [self.signBth setBackgroundColor:[UIColor colorWithRed:229/255.0 green:83/255.0 blue:51/255.0 alpha:1.0]];
        [self.signBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.otherBth.hidden = YES;
        self.iconImgView.hidden = YES;
    }else if (status == 2) {
        self.signBth.layer.cornerRadius = 5.f;
        self.signBth.clipsToBounds = YES;
        self.signBth.layer.borderWidth = 1.f;
        self.signBth.layer.borderColor = [UIColor colorWithRed:175/255.0 green:137/255.0 blue:79/255.0 alpha:1.0].CGColor;
        [self.signBth setTitle:@"请假" forState:UIControlStateNormal];
        [self.signBth setBackgroundColor:[UIColor colorWithRed:175/255.0 green:137/255.0 blue:79/255.0 alpha:1.0]];
        [self.signBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.otherBth.hidden = YES;
        self.iconImgView.hidden = YES;
    }else if (status == 3) {
        self.signBth.layer.cornerRadius = 5.f;
        self.signBth.clipsToBounds = YES;
        self.signBth.layer.borderWidth = 1.f;
        self.signBth.layer.borderColor = [UIColor colorWithRed:51/255.0 green:180/255.0 blue:184/255.0 alpha:1.0].CGColor;
        [self.signBth setTitle:@"早退" forState:UIControlStateNormal];
        [self.signBth setBackgroundColor:[UIColor colorWithRed:51/255.0 green:180/255.0 blue:184/255.0 alpha:1.0]];
        [self.signBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.otherBth.hidden = YES;
        self.iconImgView.hidden = YES;
    }else if (status == 4) {
        self.signBth.layer.cornerRadius = 5.f;
        self.signBth.clipsToBounds = YES;
        self.signBth.layer.borderWidth = 1.f;
        self.signBth.layer.borderColor = [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:1.0].CGColor;
        [self.signBth setTitle:@"旷课" forState:UIControlStateNormal];
        [self.signBth setBackgroundColor:[UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:1.0]];
        [self.signBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.otherBth.hidden = YES;
        self.iconImgView.hidden = YES;
    }else if (status == 0) {
        self.signBth.layer.cornerRadius = 5.f;
        self.signBth.clipsToBounds = YES;
        self.signBth.layer.borderWidth = 1.f;
        self.signBth.layer.borderColor =KTabBarColor.CGColor;
        [self.signBth setTitle:@"旷课" forState:UIControlStateNormal];
        [self.signBth setBackgroundColor:KTabBarColor];
        [self.signBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.otherBth.hidden = YES;
        self.iconImgView.hidden = YES;
    }
    else{
        self.signBth.layer.cornerRadius = 5.f;
        self.signBth.clipsToBounds = YES;
        self.signBth.layer.borderWidth = 1.f;
        self.signBth.layer.borderColor = KTabBarColor.CGColor;
        self.otherBth.hidden = NO;
        self.iconImgView.hidden = NO;
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
