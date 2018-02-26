//
//  sign.m
//  Teacher
//
//  Created by 冯丽 on 2018/1/10.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "sign.h"

@implementation sign
- (IBAction)buttonClick:(UIButton *)sender {
    
    if (sender.tag == 301) {
        [self.oneBth setBackgroundColor:KTabBarColor];
        [self.twoBth setBackgroundColor:[UIColor whiteColor]];
        self.twoBth.layer.cornerRadius = 5.f;
        self.twoBth.layer.borderColor = KTabBarColor.CGColor;
        self.twoBth.layer.borderWidth = 1.f;
        [self.threeBth setBackgroundColor:[UIColor whiteColor]];
        [self.fourBth setBackgroundColor:[UIColor whiteColor]];
        self.threeBth.layer.cornerRadius = 5.f;
        self.threeBth.layer.borderColor = KTabBarColor.CGColor;
        self.threeBth.layer.borderWidth = 1.f;
        [self.twoBth setTitleColor:KTabBarColor forState:UIControlStateNormal];
        [self.oneBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.threeBth setTitleColor:KTabBarColor forState:UIControlStateNormal];
        [self.fourBth setTitleColor:KTabBarColor forState:UIControlStateNormal];
        self.fourBth.layer.cornerRadius = 5.f;
        self.fourBth.layer.borderColor = KTabBarColor.CGColor;
        self.fourBth.layer.borderWidth = 1.f;
        self.oneBth.layer.cornerRadius =5.f;
        self.typeStr = @"301";
    }else if (sender.tag == 302) {
        [self.twoBth setBackgroundColor:KTabBarColor];
        [self.oneBth setBackgroundColor:[UIColor whiteColor]];
        self.oneBth.layer.cornerRadius = 5.f;
        self.oneBth.layer.borderColor = KTabBarColor.CGColor;
        self.oneBth.layer.borderWidth = 1.f;
        [self.threeBth setBackgroundColor:[UIColor whiteColor]];
        [self.fourBth setBackgroundColor:[UIColor whiteColor]];
        self.threeBth.layer.cornerRadius = 5.f;
        self.threeBth.layer.borderColor = KTabBarColor.CGColor;
        self.threeBth.layer.borderWidth = 1.f;
        [self.oneBth setTitleColor:KTabBarColor forState:UIControlStateNormal];
        [self.twoBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.threeBth setTitleColor:KTabBarColor forState:UIControlStateNormal];
        [self.fourBth setTitleColor:KTabBarColor forState:UIControlStateNormal];
        self.fourBth.layer.cornerRadius = 5.f;
        self.fourBth.layer.borderColor = KTabBarColor.CGColor;
        self.fourBth.layer.borderWidth = 1.f;
        self.twoBth.layer.cornerRadius = 5.f;
         self.typeStr = @"302";
    }else if (sender.tag == 303) {
        [self.threeBth setBackgroundColor:KTabBarColor];
        [self.oneBth setBackgroundColor:[UIColor whiteColor]];
        self.oneBth.layer.cornerRadius = 5.f;
        self.oneBth.layer.borderColor = KTabBarColor.CGColor;
        self.oneBth.layer.borderWidth = 1.f;
        [self.twoBth setBackgroundColor:[UIColor whiteColor]];
        [self.fourBth setBackgroundColor:[UIColor whiteColor]];
        self.twoBth.layer.cornerRadius = 5.f;
        self.twoBth.layer.borderColor = KTabBarColor.CGColor;
        self.twoBth.layer.borderWidth = 1.f;
        [self.oneBth setTitleColor:KTabBarColor forState:UIControlStateNormal];
        [self.threeBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.twoBth setTitleColor:KTabBarColor forState:UIControlStateNormal];
        [self.fourBth setTitleColor:KTabBarColor forState:UIControlStateNormal];
        self.fourBth.layer.cornerRadius = 5.f;
        self.fourBth.layer.borderColor = KTabBarColor.CGColor;
        self.fourBth.layer.borderWidth = 1.f;
        self.threeBth.layer.cornerRadius = 5.f;
         self.typeStr = @"303";
    }else if (sender.tag == 304) {
        [self.fourBth setBackgroundColor:KTabBarColor];
        [self.oneBth setBackgroundColor:[UIColor whiteColor]];
        self.oneBth.layer.cornerRadius = 5.f;
        self.oneBth.layer.borderColor = KTabBarColor.CGColor;
        self.oneBth.layer.borderWidth = 1.f;
        [self.threeBth setBackgroundColor:[UIColor whiteColor]];
        [self.twoBth setBackgroundColor:[UIColor whiteColor]];
        self.twoBth.layer.cornerRadius = 5.f;
        self.twoBth.layer.borderColor = KTabBarColor.CGColor;
        self.twoBth.layer.borderWidth = 1.f;
        [self.oneBth setTitleColor:KTabBarColor forState:UIControlStateNormal];
        [self.fourBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.threeBth setTitleColor:KTabBarColor forState:UIControlStateNormal];
        [self.twoBth setTitleColor:KTabBarColor forState:UIControlStateNormal];
        self.threeBth.layer.cornerRadius = 5.f;
        self.threeBth.layer.borderColor = KTabBarColor.CGColor;
        self.threeBth.layer.borderWidth = 1.f;
        self.fourBth.layer.cornerRadius = 5.f;
         self.typeStr = @"304";
    }
    

    
   
}
- (IBAction)signClick:(UIButton *)sender {
 
        if (_choiceDelegate&&[_choiceDelegate respondsToSelector:@selector(postChoiceStr:withRemarkStr:withtypeStr:)]) {
            [_choiceDelegate postChoiceStr:[NSString stringWithFormat:@"%ld",(long)sender.tag] withRemarkStr:self.remarkTextView.text withtypeStr:self.typeStr];
        }

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
