//
//  ManagementCell.m
//  Teacher
//
//  Created by 冯丽 on 2018/1/11.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "ManagementCell.h"
#import "BGControl.h"

@implementation ManagementCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)showWithDict:(NSDictionary *)dict withTeacher:(NSString *)teacher withIndex:(NSInteger)index{
    NSString *tName = [dict valueForKey:@"teacherName"];
    NSString *sName =  [dict valueForKey:@"studentName"];
    NSString *timeStr = [BGControl zhuanjixiaoshiqianStr:[dict valueForKey:@"date"]];
    self.timeLab.text = timeStr;
    self.detailLab.text = [dict valueForKey:@"content"];
    if ([BGControl isNULLOfString:tName]) {
        self.titleLab.text = [NSString stringWithFormat:@"%@%@%@",sName,@"回复",teacher];
    }else {
         self.titleLab.text = [NSString stringWithFormat:@"%@%@%@",tName,@"回复",sName];
    }
    CGFloat detailHei = [BGControl heightForRow:self.detailLab.text font:[UIFont systemFontOfSize:15] labelSize:(CGSize)CGSizeMake(kScreenSize.width-30, MAXFLOAT)];
    self.detailLab.frame = CGRectMake(45, CGRectGetMaxY(self.titleLab.frame)+10, kScreenSize.width-60, detailHei);
    self.lineView.frame = CGRectMake(0, CGRectGetMaxY(self.titleLab.frame)+20+detailHei, kScreenSize.width, 1);
    
    if (_maxdelegate &&[_maxdelegate respondsToSelector:@selector(getHei:withIndex:)]) {
        [_maxdelegate getHei:CGRectGetMaxY(self.lineView.frame) withIndex:index];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
