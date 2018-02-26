//
//  JJSelectView.m
//  JJPageController
//
//  Created by 十月 on 2017/12/21.
//  Copyright © 2017年 October. All rights reserved.
//

#import "JJSelectView.h"

@implementation JJSelectView

//+ (instancetype)jjSelectView {
//  
//    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
//}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    switch (selectIndex) {
        case 0:
            self.aLine.hidden = NO;
            self.bLine.hidden = !self.aLine.hidden;
            self.cLine.hidden = !self.aLine.hidden;
            self.dLine.hidden = !self.aLine.hidden;
            break;
        case 1:
            self.bLine.hidden = NO;
            self.aLine.hidden = !self.bLine.hidden;
            self.cLine.hidden = !self.bLine.hidden;
            self.dLine.hidden = !self.bLine.hidden;
            break;
        case 2:
            self.cLine.hidden = NO;
            self.bLine.hidden = !self.cLine.hidden;
            self.aLine.hidden = !self.cLine.hidden;
            self.dLine.hidden = !self.cLine.hidden;
            break;
        case 3:
            self.dLine.hidden = NO;
            self.bLine.hidden = !self.dLine.hidden;
            self.cLine.hidden = !self.dLine.hidden;
            self.aLine.hidden = !self.dLine.hidden;
            break;
            
        default:
            break;
    }
}


- (IBAction)touchUpSelectBtn:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            self.aLine.hidden = NO;
            self.bLine.hidden = !self.aLine.hidden;
            self.cLine.hidden = !self.aLine.hidden;
            self.dLine.hidden = !self.aLine.hidden;
            break;
        case 1:
            self.bLine.hidden = NO;
            self.aLine.hidden = !self.bLine.hidden;
            self.cLine.hidden = !self.bLine.hidden;
            self.dLine.hidden = !self.bLine.hidden;
            break;
        case 2:
            self.cLine.hidden = NO;
            self.bLine.hidden = !self.cLine.hidden;
            self.aLine.hidden = !self.cLine.hidden;
            self.dLine.hidden = !self.cLine.hidden;
            break;
        case 3:
            self.dLine.hidden = NO;
            self.bLine.hidden = !self.dLine.hidden;
            self.cLine.hidden = !self.dLine.hidden;
            self.aLine.hidden = !self.dLine.hidden;
            break;
            
        default:
            break;
    }
   
    if ([_delegate respondsToSelector:@selector(jjSelectView:switchIndex:)]) {
        [self.delegate jjSelectView:self switchIndex:sender.tag];
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
}
@end
