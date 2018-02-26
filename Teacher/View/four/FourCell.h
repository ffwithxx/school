//
//  FourCell.h
//  Teacher
//
//  Created by 冯丽 on 2018/1/11.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol maxHeiDelegate <NSObject>

@optional

-(void)getMaxHei:(CGFloat)maxHei  withIndex:(NSInteger)index;
@end

@protocol checkDelegate <NSObject>

@optional

-(void)checkImg:(NSInteger)bthTag  withImgArr:(NSArray *)imgArr;
@end
@interface FourCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *countLab;
@property (strong, nonatomic) IBOutlet UILabel *tishiLab;
@property (strong, nonatomic) IBOutlet UILabel *detailLab;
@property (strong, nonatomic) IBOutlet UIView *picView;
@property (strong, nonatomic) IBOutlet UIView *downView;
@property (strong, nonatomic) IBOutlet UILabel *downTitleLab;
@property (strong, nonatomic) IBOutlet UILabel *typeLab;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property(nonatomic,weak) id<maxHeiDelegate> delegate;
@property(nonatomic,weak) id<checkDelegate> checkDelegate;
- (void)showModelWithIndex:(NSInteger)index;
@end
