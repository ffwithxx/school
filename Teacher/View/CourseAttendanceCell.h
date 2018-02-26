//
//  CourseAttendanceCell.h
//  Teacher
//
//  Created by 冯丽 on 2018/1/10.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseAttendanceModel.h"

@protocol maxHeiDelegate <NSObject>

@optional

-(void)getMaxHei:(CGFloat)maxHei  withIndex:(NSInteger)index;
@end
@protocol openDelegate <NSObject>

@optional

-(void) postWithIndex:(NSInteger)index;
@end
@interface CourseAttendanceCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UIButton *remarkbTH;

@property (strong, nonatomic) IBOutlet UIButton *typeBth;
@property (strong, nonatomic) IBOutlet UIImageView *iconImgView;
@property (strong, nonatomic) IBOutlet UILabel *remarkTitleLab;
@property (strong, nonatomic) IBOutlet UIView *noteView;
@property (strong, nonatomic) IBOutlet UILabel *remarkLab;
@property(nonatomic,weak) id<maxHeiDelegate> delegate;
@property(nonatomic,weak) id<openDelegate> openDelegate;
- (void)showModel:(CourseAttendanceModel *)model;
@end
