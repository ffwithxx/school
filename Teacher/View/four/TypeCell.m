//
//  TypeCell.m
//  Teacher
//
//  Created by 冯丽 on 2018/3/7.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "TypeCell.h"

@implementation TypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)showWithStr:(NSString *)typeStr {
    self.nameLab.text = typeStr;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
