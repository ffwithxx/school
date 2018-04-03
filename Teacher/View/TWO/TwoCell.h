//
//  TwoCell.h
//  Teacher
//
//  Created by 冯丽 on 2018/1/8.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol attendanceDelegate <NSObject>
@optional
- (void)postTagStr:(NSString *)tagStr withIdStr:(NSString *)idStr;
@end


@interface TwoCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UIButton *otherBth;//301
@property (strong, nonatomic) IBOutlet UIButton *signBth;
@property (strong, nonatomic) IBOutlet UIImageView *iconImgView;
@property (strong, nonatomic) id<attendanceDelegate> attendanceDelegate;
- (void)showModelWithDict:(NSDictionary *)dict;
@end
