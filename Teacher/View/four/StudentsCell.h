//
//  StudentsCell.h
//  Teacher
//
//  Created by 冯丽 on 2018/3/7.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
-(void)showWithDict:(NSDictionary *)dict;
@end