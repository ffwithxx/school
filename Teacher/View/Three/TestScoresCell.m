//
//  TestScoresCell.m
//  Teacher
//
//  Created by 冯丽 on 2018/1/10.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "TestScoresCell.h"

@implementation TestScoresCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)showModelWithDict:(NSDictionary *)dict {
    self.nameLab.text = [dict valueForKey:@"studentName"];
    self.scoreLab.text = [NSString stringWithFormat:@"%@",[dict valueForKey:@"score"]];
    self.levelLab.text = [dict valueForKey:@"achievement"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
