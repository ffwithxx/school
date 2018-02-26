//
//  sign.h
//  Teacher
//
//  Created by 冯丽 on 2018/1/10.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol choiceDelegate <NSObject>

@optional
- (void)postChoiceStr:(NSString *)choiceStr withRemarkStr:(NSString *)remarkStr withtypeStr:(NSString *)type;
@end

@interface sign : UIView
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UIButton *oneBth;
@property (strong, nonatomic) IBOutlet UIButton *twoBth;
@property (strong, nonatomic) IBOutlet UIButton *threeBth;
@property (strong, nonatomic) IBOutlet UIButton *fourBth;
@property (strong, nonatomic) IBOutlet UIView *bigView;
@property (strong, nonatomic) IBOutlet UILabel *placLab;
@property (strong, nonatomic)  NSString *typeStr;
@property (strong, nonatomic) IBOutlet UITextView *remarkTextView;
@property(nonatomic,weak) id<choiceDelegate> choiceDelegate;
@end
