//
//  MainPageViewController.m
//  Teacher
//
//  Created by 冯丽 on 2017/12/28.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "MainPageViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "JJSelectView.h"
#import "AppDelegate.h"
#import "MessageCenterVC.h"
#import "BGControl.h"
@interface MainPageViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,JJSelectViewDelegate>
@property (nonatomic, strong) NSArray *controllers;
@property (nonatomic, assign) NSInteger contronIndex;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) JJSelectView *selectcView;
@property (nonatomic, strong) NSString *ishua;
@property (nonatomic, assign) NSInteger indexNum;
@end

@implementation MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _indexNum = 0;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    OneViewController *oneController = [storyboard instantiateViewControllerWithIdentifier:@"OneViewController"];
    TwoViewController *twoController = [storyboard instantiateViewControllerWithIdentifier:@"TwoViewController"];;
    ThreeViewController *threeController = [storyboard instantiateViewControllerWithIdentifier:@"ThreeViewController"];;
    FourViewController *fourController = [storyboard instantiateViewControllerWithIdentifier:@"FourViewController"];;
    self.delegate = self;
    self.dataSource = self;
    self.controllers = @[oneController,twoController,threeController,fourController];
    [self setViewControllers:@[oneController] direction:UIPageViewControllerNavigationDirectionForward animated:false completion:nil];
    
    _selectcView = [[[NSBundle mainBundle] loadNibNamed:@"JJSelectView" owner:nil options:nil] lastObject];
    _selectcView.frame = CGRectMake(0, 0, self.view.frame.size.width, 135);
    
    //    _selectcView = [[JJView alloc] initWithFrame: CGRectMake(0, 64, self.view.frame.size.width, 50)];
    _selectcView.delegate = self;
   
    [self selectView];
    [self addScrollViewObserver];
}

- (void)selectView {
    [_selectcView.leftButton addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
    [_selectcView.rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    _selectcView.leftImg.image = [UIImage imageNamed:@"navi_icon_han.png"] ;
    _selectcView.rightImg.image =[UIImage imageNamed:@"navi_icon_news.png"];

    NSString *jsonString = [[NSUserDefaults standardUserDefaults]valueForKey:@"loginData"];
    NSDictionary *userInfoDict = [[BGControl dictionaryWithJsonString:jsonString] valueForKey:@"userInfo"];
    _selectcView.titleLab.text =[NSString stringWithFormat:@"%@ %@",@"HI",[userInfoDict valueForKey:@"nameCn"]];
    _selectcView.titleLab.textColor = [UIColor whiteColor];
    _selectcView.titleLab.font = [UIFont systemFontOfSize:18];
    CGRect leftImgFrame = _selectcView.leftImg.frame;
    leftImgFrame.origin.y = 35;
    leftImgFrame.origin.x = 20;
    leftImgFrame.size.width = 20;
    leftImgFrame.size.height = 17;
    
    CGRect leftBthFrame = _selectcView.leftButton.frame;
    leftBthFrame.origin.y = 15;
    leftBthFrame.origin.x = 0;
    leftBthFrame.size.width = 60;
    leftBthFrame.size.height = 60;
    
    
    
    CGRect rightImgFrame = _selectcView.rightImg.frame;
    rightImgFrame.origin.y = 41;
    rightImgFrame.origin.x = kScreenSize.width-40;
    rightImgFrame.size.height = 5;
    rightImgFrame.size.width = 20;
    
    CGRect rightBthFrame = _selectcView.rightButton.frame;
    rightBthFrame.origin.y = 15;
    rightBthFrame.origin.x = kScreenSize.width-60;
    rightBthFrame.size.width = 60;
    rightBthFrame.size.height = 60;
    
    CGRect titleFrame = _selectcView.titleLab.frame;
    titleFrame.origin.y = 35;
    titleFrame.origin.x = 45;
    titleFrame.size.width = 140;
    titleFrame.size.height = 20;
    
    
    if (kiPhoneX == YES) {
        leftImgFrame.origin.y = 44;
        rightImgFrame.origin.y = 50;
        titleFrame.origin.y = 44;
        leftBthFrame.origin.y = 25;
        rightBthFrame.origin.y = 25;
    }
    
    _selectcView.leftImg.frame = CGRectMake(leftImgFrame.origin.x, leftImgFrame.origin.y, leftImgFrame.size.width, leftImgFrame.size.height);
    _selectcView.leftButton.frame = CGRectMake(leftBthFrame.origin.x, leftBthFrame.origin.y, leftBthFrame.size.width, leftBthFrame.size.height);
    _selectcView.rightImg.frame = CGRectMake(rightImgFrame.origin.x, rightImgFrame.origin.y, rightImgFrame.size.width, rightImgFrame.size.height);
    _selectcView.rightButton.frame = CGRectMake(rightBthFrame.origin.x, rightBthFrame.origin.y, rightBthFrame.size.width, rightBthFrame.size.height);
    _selectcView.titleLab.frame = CGRectMake(titleFrame.origin.x, titleFrame.origin.y, titleFrame.size.width, titleFrame.size.height);
     [self.view addSubview:_selectcView];
   
}

#pragma mark --- 左侧页面滑出
- (void)leftClick:(UIButton *)bth {
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
}

#pragma mark --- 右侧页面滑出
- (void)rightClick:(UIButton *)bth {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MessageCenterVC *message = [storyboard instantiateViewControllerWithIdentifier:@"MessageCenterVC"];
    [self.navigationController pushViewController:message animated:YES];
}
- (void)addScrollViewObserver {
    
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            self.scrollView = (UIScrollView *)view;
            [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
            break;
        }
    }
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([_ishua isEqualToString:@"2"]) {
        
    }else{
        if ([keyPath isEqualToString:@"contentOffset"]) {
            CGPoint offset = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
            self.selectcView.offset = offset;
            //        CGFloat withR = self.view.frame.size.width + self.view.frame.size.width/2;
            //        CGFloat withR = offset.x;
            CGFloat contentWidth = self.view.frame.size.width * 4;
            //        CGFloat withL = self.view.frame.size.width / 2;
            //        if (offset.x > withR) {
            //            self.selectcView.selectIndex = 1;
            //        }else if(offset.x < withL){
            //            self.selectcView.selectIndex = 0;
            //        }
            //        NSLog(@"%@",NSStringFromCGPoint(offset));
            self.selectcView.selectIndex = (int)(self.selectcView.offset.x /contentWidth + self.selectcView.selectIndex);
            NSLog(@"%f  %ld",self.selectcView.offset.x,(long)self.selectcView.selectIndex);
            
        }
    }
    
}

#pragma mark -<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self.controllers indexOfObject:viewController];
    index --;
    _indexNum = index;
    _ishua = @"1";
    if (index < 0 || index >= self.controllers.count) {
        _ishua = @"2";
        return nil;
    }
    return self.controllers[index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self.controllers indexOfObject:viewController];
    index ++;
      _indexNum = index;
    _ishua = @"1";
    if (index < 0 || index >= self.controllers.count) {
        _ishua = @"2";
        return nil;
    }
    return self.controllers[index];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    _contronIndex = [self.controllers indexOfObject:self.viewControllers.firstObject];
    self.selectcView.selectIndex = _contronIndex;
}
#pragma mark - JJSwitchViewDelegate
- (void)jjSelectView:(JJSelectView *)view switchIndex:(NSInteger)index {
    //- (void)jjSelectView:(JJView *)view switchIndex:(NSInteger)index {
    
    [self setViewControllers:@[self.controllers[index]] direction:0 < index ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse animated:false completion:nil];
    self.selectcView.selectIndex = index;
}

- (void)dealloc {
    
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
