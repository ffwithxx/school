//
//  MessageCenterCell.h
//  Teacher
//
//  Created by 冯丽 on 2018/1/9.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol maxHeiDelegate <NSObject>

@optional

-(void)getMaxHei:(CGFloat)maxHei  withIndex:(NSInteger)index;
@end
@interface MessageCenterCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *bigView;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UILabel *iconLab;
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *detailLaB;

@property(nonatomic,weak) id<maxHeiDelegate> delegate;
-(void)showModelWith:(NSDictionary *)dict withIndext:(NSInteger)index;
@end
