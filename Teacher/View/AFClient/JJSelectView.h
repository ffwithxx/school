//
//  JJSelectView.h
//  JJPageController
//
//  Created by 十月 on 2017/12/21.
//  Copyright © 2017年 October. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JJSelectView;

@protocol JJSelectViewDelegate <NSObject>
- (void)jjSelectView:(JJSelectView *)view switchIndex:(NSInteger)index;
@end

@interface JJSelectView : UIView

@property (nonatomic, weak) id<JJSelectViewDelegate>delegate;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, assign) CGPoint offset;

@property (weak, nonatomic) IBOutlet UIButton *ABTn;
@property (weak, nonatomic) IBOutlet UIButton *BBtn;
@property (weak, nonatomic) IBOutlet UIButton *CBtn;
@property (weak, nonatomic) IBOutlet UIButton *DBtn;
@property (weak, nonatomic) IBOutlet UIView *aLine;
@property (weak, nonatomic) IBOutlet UIView *bLine;
@property (weak, nonatomic) IBOutlet UIView *cLine;
@property (weak, nonatomic) IBOutlet UIView *dLine;
@property (strong, nonatomic) IBOutlet UIButton *leftButton;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic)  IBOutlet UIImageView *leftImg;
@property (strong, nonatomic) IBOutlet UIImageView *rightImg;
//+ (instancetype)jjSelectView;

@end
