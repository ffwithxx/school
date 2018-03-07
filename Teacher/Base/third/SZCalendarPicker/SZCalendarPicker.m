//
//  SZCalendarPicker.m
//  SZCalendarPicker
//
//  Created by Stephen Zhuang on 14/12/1.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "SZCalendarPicker.h"
#import "SZCalendarCell.h"
#import "UIColor+ZXLazy.h"
#import "BGControl.h"

NSString *const SZCalendarCellIdentifier = @"cell";

@interface SZCalendarPicker ()
@property (nonatomic , weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic , weak) IBOutlet UILabel *monthLabel;
@property (nonatomic , weak) IBOutlet UIButton *previousButton;
@property (nonatomic , weak) IBOutlet UIButton *nextButton;
@property (nonatomic , strong) NSArray *weekDayArray;
@property (nonatomic , strong) UIView *mask;
@property (strong, nonatomic) IBOutlet UIButton *subMitBth;
@end

@implementation SZCalendarPicker


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self addTap];
    [self addSwipe];
    [self show];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [_collectionView registerClass:[SZCalendarCell class] forCellWithReuseIdentifier:SZCalendarCellIdentifier];
     _weekDayArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
}

- (void)customInterface
{
    CGFloat itemWidth = _collectionView.frame.size.width / 7;
    CGFloat itemHeight = _collectionView.frame.size.height / 7;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    [_collectionView setCollectionViewLayout:layout animated:YES];
    
    
}

- (void)setDate:(NSDate *)date
{
    _date = date;
  
//
    [_collectionView reloadData];
}

#pragma mark - date

- (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}


- (NSInteger)month:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}

- (NSInteger)year:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}


- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

- (NSInteger)totaldaysInThisMonth:(NSDate *)date{
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return totaldaysInMonth.length;
}

- (NSInteger)totaldaysInMonth:(NSDate *)date{
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInLastMonth.length;
}

- (NSDate *)lastMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

- (NSDate*)nextMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    NSString *dateStr = [BGControl changeNsdate:newDate];
    NSArray *dateArr = [dateStr componentsSeparatedByString:@"-"];
    NSString *str = [NSString stringWithFormat:@"%@-%@",dateArr[0],dateArr[1]];
     [_monthLabel setText:str];
    return newDate;
}

#pragma -mark collectionView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return _weekDayArray.count;
    } else {
        return 42;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SZCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SZCalendarCellIdentifier forIndexPath:indexPath];
    if (indexPath.section == 0) {
        [cell.dateLabel setText:_weekDayArray[indexPath.row]];
        [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#10cc6e"]];
    } else {
        NSInteger daysInThisMonth = [self totaldaysInMonth:_date];
        NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
        
        NSInteger day = 0;
        NSInteger i = indexPath.row;
        
        if (i < firstWeekday) {
            [cell.dateLabel setText:@""];
            
        }else if (i > firstWeekday + daysInThisMonth - 1){
            [cell.dateLabel setText:@""];
        }else{
            day = i - firstWeekday + 1;
            [cell.dateLabel setText:[NSString stringWithFormat:@"%li",(long)day]];
            [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#24373b"]];
            
            //this month
            if ([_today isEqualToDate:_date]) {
                if (day == [self day:_date]) {
                    [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#24373b"]];
                } else if (day < [self day:_date]) {
                    [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#24373b"]];
                    
                }
            } else if ([_today compare:_date] == NSOrderedDescending) {
                [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#24373b"]];
            }
        }
        
        if (self.day == day &&self.month == [self month:_date] &&self.year == [self year:_date]) {
//            cell.dateLabel.backgroundColor = kTabBarColor;
            [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#ffffff"]];
        }
    }
    
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        NSInteger daysInThisMonth = [self totaldaysInMonth:_date];
        NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
        
        NSInteger day = 0;
        NSInteger i = indexPath.row;
        
        if (i >= firstWeekday && i <= firstWeekday + daysInThisMonth - 1) {
            day = i - firstWeekday + 1;
            
            //this month
//            if ([_today isEqualToDate:_date]) {
//                if (day >= [self day:_date]) {
//                    return YES;
//                }
//            } else if ([_today compare:_date] == NSOrderedAscending) {
//                return YES;
//            }
            return YES;
        }
    }
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //点击选中的效果
    SZCalendarCell *cell = (SZCalendarCell *)[collectionView cellForItemAtIndexPath:indexPath ];
    SZCalendarCell *cellTwo = (SZCalendarCell *)[collectionView cellForItemAtIndexPath: self.selectIndex ];
    cellTwo.dateLabel.backgroundColor = [UIColor clearColor];
      [cellTwo.dateLabel setTextColor:[UIColor colorWithHexString:@"#24373b"]];
    self.selectIndex = indexPath;

    [self updateCollectionViewCellStatus:cell selected:YES];
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
    NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
    
    NSInteger day = 0;
    NSInteger i = indexPath.row;
    day = i - firstWeekday + 1;
//    self.selectesStr = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)[comp year],[comp month],day];
    self.year = [comp year];
    self.month = [comp month];
    self.day = day;
//      [_monthLabel setText:[NSString stringWithFormat:@"%.2ld-%.2ld-%li",(long)day,(long)[comp month],(long)[comp year]]];
}
-(void)updateCollectionViewCellStatus:(SZCalendarCell *)myCollectionCell selected:(BOOL)selected
{
    if (selected == YES) {
//        myCollectionCell.dateLabel.backgroundColor = kTabBarColor;
//        myCollectionCell.dateLabel.textColor = [UIColor whiteColor];
          [myCollectionCell.dateLabel setTextColor:[UIColor colorWithHexString:@"#ffffff"]];
//         [_collectionView reloadData];
    }
   
    
}


- (IBAction)previouseAction:(UIButton *)sender
{
    SZCalendarCell *cellTwo = (SZCalendarCell *)[_collectionView cellForItemAtIndexPath: self.selectIndex ];
    cellTwo.dateLabel.backgroundColor = [UIColor clearColor];

//    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlDown animations:^(void) {
        self.date = [self lastMonth:self.date];
    NSString *dateStr = [BGControl changeNsdate:self.date];
    NSArray *dateArr = [dateStr componentsSeparatedByString:@"-"];
    NSString *str = [NSString stringWithFormat:@"%@-%@",dateArr[0],dateArr[1]];
    [_monthLabel setText:str];
//    } completion:nil];
}

- (IBAction)nexAction:(UIButton *)sender
{
    SZCalendarCell *cellTwo = (SZCalendarCell *)[_collectionView cellForItemAtIndexPath: self.selectIndex ];
    cellTwo.dateLabel.backgroundColor = [UIColor clearColor];

//    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^(void) {
        self.date = [self nextMonth:self.date];
//    } completion:nil];
}

+ (instancetype)showOnView:(UIView *)view
{
    SZCalendarPicker *calendarPicker = [[[NSBundle mainBundle] loadNibNamed:@"SZCalendarPicker" owner:self options:nil] firstObject];
    calendarPicker.mask = [[UIView alloc] initWithFrame:view.bounds];
    calendarPicker.mask.backgroundColor = [UIColor blackColor];
    calendarPicker.mask.alpha = 0.3;
    [view addSubview:calendarPicker.mask];
    [view addSubview:calendarPicker];
    return calendarPicker;
}

- (void)show
{
    //提前布局
    [self customInterface];
     [_monthLabel setText:[NSString stringWithFormat:@"%li-%.2ld",(long)[self year:self.date],(long)[self month:self.date]]];
    self.subMitBth.layer.cornerRadius = 20.f;
    self.transform = CGAffineTransformTranslate(self.transform, 0, -CGRectGetMaxY(self.frame));
    [UIView animateWithDuration:0.5 animations:^(void) {
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL isFinished) {
        [self customInterface];
    }];
}

- (void)hide
{
    [UIView animateWithDuration:0.5 animations:^(void) {
        self.transform = CGAffineTransformTranslate(self.transform, 0, -CGRectGetMaxY(self.frame));
        self.mask.alpha = 0;
    } completion:^(BOOL isFinished) {
        [self.mask removeFromSuperview];
        [self removeFromSuperview];
    }];
}


- (void)addSwipe
{
//    UISwipeGestureRecognizer *swipLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nexAction:)];
//    swipLeft.direction = UISwipeGestureRecognizerDirectionLeft;
//    [self addGestureRecognizer:swipLeft];
//    
//    UISwipeGestureRecognizer *swipRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(previouseAction:)];
//    swipRight.direction = UISwipeGestureRecognizerDirectionRight;
//    [self addGestureRecognizer:swipRight];
}
- (IBAction)subMitClick:(UIButton *)sender {
    if (self.calendarBlock) {
      
        self.calendarBlock(self.day, self.month, self.year);
    }
    
    [self hide];
}
- (IBAction)canCleClick:(UIButton *)sender {
   [self hide];
    if (self.cancleBlock) {
        self.cancleBlock();
    }

}

- (void)addTap
{

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self.mask addGestureRecognizer:tap];
}
@end
