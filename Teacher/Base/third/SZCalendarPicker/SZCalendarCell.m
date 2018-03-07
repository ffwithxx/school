//
//  SZCalendarCell.m
//  SZCalendarPicker
//
//  Created by Stephen Zhuang on 14/12/1.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "SZCalendarCell.h"

@implementation SZCalendarCell
- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.bounds.size.width-10, self.bounds.size.height-10)];
        [_dateLabel setTextAlignment:NSTextAlignmentCenter];
        [_dateLabel setFont:[UIFont systemFontOfSize:15]];
        _dateLabel.clipsToBounds = YES;
        _dateLabel.layer.cornerRadius = (self.bounds.size.width-10)/2;
        _dateLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_dateLabel];
    }
    return _dateLabel;
}
@end
