//
//  FourCell.m
//  Teacher
//
//  Created by 冯丽 on 2018/1/11.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "FourCell.h"
#import "BGControl.h"
#import "AFClient.h"
@implementation FourCell{
    NSArray *imgArr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)downClick:(UIButton *)sender {
}
- (void)showModelWithIndex:(NSInteger)index{
    self.titleLab.numberOfLines = 0;
    
    //    self.titleLab.text= @"2018年开年大吉，红红火火过大年，哈哈哈哈哈哈哈哈";
    //        self.detailLab.text = @"2018年开年大吉，红红火火过大年，哈哈哈哈哈哈哈哈2018年开年大吉，红红火火过大年，哈哈哈哈哈哈哈哈2018年开年大吉，红红火火过大年，哈哈哈哈哈哈哈哈2018年开年大吉，红红火火过大年，哈哈哈哈哈哈哈哈2018年开年大吉，红红火火过大年，哈哈哈哈哈哈哈哈2018年开年大吉，红红火火过大年，哈哈哈哈哈哈哈哈";
    NSArray *arr = [NSArray arrayWithObjects:@"one.png",@"two.png",@"three.png",@"four.png", nil];
    CGFloat margin = 10;
    CGFloat oneWidth = (kScreenSize.width-30-margin*2)/3;
    UIView *bigView = [[UIView alloc] init];
    bigView.tag = 500;
    [self.picView addSubview:bigView];
    imgArr = arr;
    for (int i = 0; i < arr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.tag = 200+i;
        imageView.image= [UIImage imageNamed:arr[i]];
        imageView.frame = CGRectMake((margin+oneWidth)*(i%3), (margin+oneWidth)*(i/3), oneWidth, oneWidth);
        UIButton *button = [BGControl creatButtonWithFrame:imageView.frame target:self sel:@selector(ImgClick:) tag:100+i image:nil isBackgroundImage:NO title:nil isLayer:NO cornerRadius:0];
        [bigView addSubview:imageView];
        [bigView addSubview:button];
    }
    CGFloat titleHei = [BGControl heightForRow:self.titleLab.text font:[UIFont systemFontOfSize:17] labelSize:CGSizeMake(kScreenSize.width - 95, MAXFLOAT)];
    self.titleLab.frame = CGRectMake(15, 8, kScreenSize.width-95, titleHei);
    
    CGFloat detailHei = [BGControl heightForRow:self.detailLab.text font:[UIFont systemFontOfSize:15] labelSize:(CGSize)CGSizeMake(kScreenSize.width-30, MAXFLOAT)];
    self.detailLab.frame = CGRectMake(15, CGRectGetMaxY(self.titleLab.frame)+7, kScreenSize.width-30, detailHei);
    
    //计算图片所占高度
    CGFloat hei = (arr.count/3+1)*(margin+oneWidth)-margin;
    bigView.frame = CGRectMake(0, 0, kScreenSize.width-30, hei);
    self.picView.frame = CGRectMake(15, CGRectGetMaxY(self.detailLab.frame)+10, kScreenSize.width-30, hei);
    self.downView.frame = CGRectMake(15, CGRectGetMaxY(self.picView.frame)+10, kScreenSize.width-30, 50);
    self.typeLab.frame = CGRectMake(15, CGRectGetMaxY(self.downView.frame)+10, (kScreenSize.width-30)/2, 20);
    self.nameLab.frame = CGRectMake(15+(kScreenSize.width-30)/2, CGRectGetMaxY(self.downView.frame)+10, (kScreenSize.width-30)/2, 20);
    if (_delegate &&[_delegate respondsToSelector:@selector(getMaxHei:withIndex:)]) {
        [_delegate getMaxHei:CGRectGetMaxY(self.typeLab.frame)+10  withIndex:index];
    }
}
-(void)ImgClick:(UIButton *)button{
    if (_checkDelegate &&[_checkDelegate respondsToSelector:@selector(checkImg:withImgArr:)]) {
        [_checkDelegate checkImg:button.tag withImgArr:imgArr];
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

