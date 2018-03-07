//
//  StudentsCell.m
//  Teacher
//
//  Created by 冯丽 on 2018/3/7.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "StudentsCell.h"

@implementation StudentsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)showWithDict:(NSDictionary *)dict {
    self.nameLab.text = [dict valueForKey:@"sname"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
