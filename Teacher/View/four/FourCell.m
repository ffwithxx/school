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
#import <SDWebImage/UIImageView+WebCache.h>
@implementation FourCell{
    NSArray *imgArr;
    NSArray *downFileArr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)downClick:(UIButton *)sender {
}
- (void)showModelWithIndex:(NSInteger)index withModel:(feedBackModel *)model{
    
    for (UIView *view in [self.picView subviews]) {
        if (view.tag ==500) {
            [view removeFromSuperview];
        }
    }
    
   
    
    self.titleLab.numberOfLines = 0;
    
    self.titleLab.text= model.title;
    self.detailLab.text = model.content;
    self.countLab.text = [NSString stringWithFormat:@"%@",model.replycount];
    self.tishiLab.clipsToBounds = YES;
    self.tishiLab.layer.cornerRadius = 3.f;
    
    if ([model.replycount integerValue] > 0) {
        self.tishiLab.hidden = NO;
        self.countLab.hidden = NO;
    }else {
        self.tishiLab.hidden = YES;
        self.countLab.hidden = YES;
    }
    NSInteger typeCount = [model.type integerValue];
    if (typeCount == 0) {
        self.typeLab.text = @"分类：在校表现";
    }else if (typeCount == 1) {
        self.typeLab.text = @"分类：奖惩记录";
    }else if (typeCount == 2) {
        self.typeLab.text = @"分类：活动记录";
    }
    self.nameLab.text = [NSString stringWithFormat:@"%@",model.sname];
    
    NSArray *arr = [NSArray array];
    CGFloat margin = 10;
    CGFloat oneWidth = (kScreenSize.width-30-margin*2)/3;
    UIView *bigView = [[UIView alloc] init];
    bigView.tag = 500;
    [self.picView addSubview:bigView];
    for (UIView *view in [bigView subviews]) {
       
            [view removeFromSuperview];
       
    }
    if (![BGControl isNULLOfString:model.img]) {
      arr =  [model.img componentsSeparatedByString:@";"];
    }
    imgArr = arr;
    for (int i = 0; i < arr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.tag = 200+i;
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",arr[i]]] placeholderImage:[UIImage imageNamed:@"icon_moren(1).png"]];
        imageView.frame = CGRectMake((margin+oneWidth)*(i%3), (margin+oneWidth)*(i/3), oneWidth, oneWidth);
        UIButton *button = [BGControl creatButtonWithFrame:imageView.frame target:self sel:@selector(ImgClick:) tag:100+i image:nil isBackgroundImage:NO title:nil isLayer:NO cornerRadius:0];
        [bigView addSubview:imageView];
        [bigView addSubview:button];
    }
    for (UIView *view in [self.fileView subviews]) {
        
        [view removeFromSuperview];
        
    }
    NSArray *txtArr = [NSArray array];
    if (![BGControl isNULLOfString:model.txt]) {
         txtArr = [model.txt componentsSeparatedByString:@";"];
    }
    downFileArr = txtArr;
    for (int i =0; i < txtArr.count; i++) {
        NSArray *fileArr = [txtArr[i] componentsSeparatedByString:@"◆"];
        if (fileArr.count >1) {
            UIView *downView = [[UIView alloc] init];
            downView.frame = CGRectMake(0, 55*i, kScreenSize.width-30, 50);
            downView.backgroundColor = KBgColor;
            downView.clipsToBounds = YES;
            downView.layer.cornerRadius = 5.f;
            [self.fileView addSubview:downView];
            UIImageView *fileImgView = [[UIImageView alloc] init];
            fileImgView.image = [UIImage imageNamed:@"cont_icon_folder.png"];
            fileImgView.frame = CGRectMake(10, 17, 20, 15);
            [downView addSubview:fileImgView];
            UIImageView *downImgView = [[UIImageView alloc] init];
            downImgView.frame = CGRectMake(CGRectGetMaxX(downView.frame)-8-18, 18, 18, 18);
            downImgView.image = [UIImage imageNamed:@"cont_icon_downl.png"];
            [downView addSubview:downImgView];
            UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, CGRectGetWidth(downView.frame) - 69, 50)];
            titleLab.textColor = KTextgrayColor;
            titleLab.font = [UIFont systemFontOfSize:15];
            [downView  addSubview:titleLab];
            titleLab.text = fileArr[1];
            
            UIButton *button = [BGControl creatButtonWithFrame:CGRectMake(0, 0, CGRectGetWidth(downView.frame), 50) target:self sel:@selector(downFile:) tag:200+i image:nil isBackgroundImage:NO title:nil isLayer:NO cornerRadius:0];
            [downView addSubview:button];
        }
        


    }
    
    CGFloat titleHei = [BGControl heightForRow:self.titleLab.text font:[UIFont systemFontOfSize:17] labelSize:CGSizeMake(kScreenSize.width - 95, MAXFLOAT)];
    self.titleLab.frame = CGRectMake(15, 8, kScreenSize.width-95, titleHei);
    
    CGFloat detailHei = [BGControl heightForRow:self.detailLab.text font:[UIFont systemFontOfSize:15] labelSize:(CGSize)CGSizeMake(kScreenSize.width-30, MAXFLOAT)];
    self.detailLab.frame = CGRectMake(15, CGRectGetMaxY(self.titleLab.frame)+7, kScreenSize.width-30, detailHei);
    
    //计算图片所占高度
    CGFloat hei = (arr.count/3+1)*(margin+oneWidth)-margin;
    if (arr.count <1) {
        hei = 0;
    }
    bigView.frame = CGRectMake(0, 0, kScreenSize.width-30, hei);
    self.picView.frame = CGRectMake(15, CGRectGetMaxY(self.detailLab.frame)+10, kScreenSize.width-30, hei);
    self.fileView.frame = CGRectMake(15, CGRectGetMaxY(self.picView.frame)+10, kScreenSize.width-30, 55*txtArr.count);
//        self.fileView.frame = CGRectMake(15, CGRectGetMaxY(self.picView.frame)+10, kScreenSize.width-30, 50);
    self.typeLab.frame = CGRectMake(15, CGRectGetMaxY(self.fileView.frame)+10, (kScreenSize.width-30)/2, 20);
    self.nameLab.frame = CGRectMake(15+(kScreenSize.width-30)/2, CGRectGetMaxY(self.fileView.frame)+10, (kScreenSize.width-30)/2, 20);
    if (_delegate &&[_delegate respondsToSelector:@selector(getMaxHei:withIndex:)]) {
        [_delegate getMaxHei:CGRectGetMaxY(self.typeLab.frame)+10  withIndex:index];
    }
    
    
}
- (void)downFile:(UIButton *)button {
    if (_downDelegate && [_downDelegate respondsToSelector:@selector(downImg:withDownArr:)]) {
        [_downDelegate downImg:button.tag withDownArr:downFileArr];
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

