//
//  MessageCenterCell.m
//  Teacher
//
//  Created by 冯丽 on 2018/1/9.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "MessageCenterCell.h"
#import "BGControl.h"

@implementation MessageCenterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)showModelWith:(NSDictionary *)dict withIndext:(NSInteger)index{
    self.detailView.layer.cornerRadius = 5.f;
    self.detailLaB.numberOfLines = 3;
    self.titleLab.numberOfLines = 0;
    
    self.timeLab.text = [BGControl updateTimeForRow:[[dict valueForKey:@"createAt"] integerValue]];
    self.titleLab.text = [dict valueForKey:@"title"] ;
    self.detailLaB.text = [dict valueForKey:@"content"];
    
     CGFloat titleHei = [BGControl getSpaceLabelHeight:self.titleLab.text withFont:[UIFont systemFontOfSize:17] withWidth:kScreenSize.width - 60];
    self.titleLab.frame = CGRectMake(15, 10, kScreenSize.width-60, titleHei);
    CGFloat detailHei = [BGControl getSpaceLabelHeight:self.detailLaB.text withFont:[UIFont systemFontOfSize:15] withWidth:kScreenSize.width - 60];
    
    CGFloat hei = 0;
    if (detailHei < 55) {
        hei = detailHei;
    }else {
        hei = 55;
    }
    self.detailLaB.frame = CGRectMake(15, titleHei+15, kScreenSize.width-60, hei);
    CGFloat detailViewHei = CGRectGetMaxY(self.detailLaB.frame)+10;
    self.detailView.frame = CGRectMake(15, 40, kScreenSize.width-30, detailViewHei);
    
    if (_delegate &&[_delegate respondsToSelector:@selector(getMaxHei:withIndex:)]) {
        [_delegate getMaxHei:detailViewHei +50  withIndex:index];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
