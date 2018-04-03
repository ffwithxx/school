//
//  ViewController.m
//  TestScrollViewImage
//
//  Created by raykle on 12-8-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "kantuViewController.h"
#import "BGControl.h"
#import "AppDelegate.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "kantuViewController.h"
#define kScreenSize [UIScreen mainScreen].bounds.size
#define PHOTONUMBERS  self.IMGArray.count //照片数量
@interface kantuViewController ()
{
    BOOL _isShow;
    BOOL chu ;
    CGFloat startContentOffsetX;
    CGFloat willEndContentOffsetX;
    CGFloat endContentOffsetX;
    NSInteger bthTag;
    UILabel *pageNumLabel;
}
@property float scale_;
//@property (nonatomic,strong) UIScrollView *imageScrollView;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) UIView *underView;
@end

@implementation kantuViewController

@synthesize imageScrollView;
@synthesize scale_;

#pragma mark -

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    _isShow = YES;
    bthTag = [self.IMGNum integerValue]+1;
    chu = NO;
    self.view.backgroundColor = [UIColor blackColor];
    [self setSrc];
//    self.view.alpha = 0.8;
   }

-(void)setSrc {
    offset = 0.0;
    scale_ = 1.0;
    
    self.imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, self.view.frame.size.height)];
    self.imageScrollView.backgroundColor = [UIColor clearColor];
    self.imageScrollView.scrollEnabled = YES;
    self.imageScrollView.pagingEnabled = YES;
    self.imageScrollView.delegate = self;
    self.imageScrollView.contentSize = CGSizeMake(kScreenSize.width*PHOTONUMBERS, 0);
    
    [self.view addSubview:self.imageScrollView];
    
    for (int i = 0; i<PHOTONUMBERS; i++){
        UIScrollView *s = [[UIScrollView alloc] init];
        s.frame=CGRectMake(kScreenSize.width*i, 0, kScreenSize.width, self.view.frame.size.height);
        
        
        
        s.backgroundColor = [UIColor clearColor];
        s.contentSize = CGSizeMake(kScreenSize.width, kScreenSize.height);
        s.showsHorizontalScrollIndicator = NO;
        s.showsVerticalScrollIndicator = NO;
        s.delegate = self;
        s.minimumZoomScale = 1.0;
        s.maximumZoomScale = 3.0;
        s.tag = i+1;
        [s setZoomScale:1.0];
        CGRect frame = s.frame;
        frame.origin.y=0;
        [s setFrame:frame];
        UIImageView *imageview = [[UIImageView alloc] init];
        NSString *picUrl = [[NSUserDefaults standardUserDefaults] valueForKey:@"fileCenterUrl"];
        
               [imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.IMGArray[i]]] placeholderImage:[UIImage imageNamed:@"icon_moren(1).png"]];
       
        [imageview setContentMode:UIViewContentModeScaleAspectFit];
        imageview.frame = CGRectMake(0, 0, kScreenSize.width, self.view.frame.size.height);
        imageview.userInteractionEnabled = YES;
        imageview.tag = 100 + i;
        
     
        
     
        
               //[self.underView addSubview:button];
//        self.topView = [BGControl creatViewWithFrame:CGRectMake(0, 0, kScreenSize.width, 60) backgroundColor:kBlackColor isLayer:NO cornerRadius:0];
//        self.topView.alpha = 1.0f;
//        self.topView.tag =300 + i;
//        UIImageView *closeImage = [BGControl creatImageViewWithFrame:CGRectMake(20, 20, 21, 19) image:@"右箭头" isWebImage:NO holdOnImage:nil isLayer:NO cornerRadius:0];
//        [self.topView addSubview:closeImage];
//        
//        UIButton *backbutton = [BGControl creatButtonWithFrame:CGRectMake(0, 0, 60, 60) target:self sel:@selector(backButtonClick:) tag:101 image:nil isBackgroundImage:NO title:@"" isLayer:NO cornerRadius:0];
//        self.topView.backgroundColor = [UIColor colorWithHue:80/255.0 saturation:80/255.0 brightness:80/255.0 alpha:1.0];
//        [self.topView addSubview:backbutton];
//        
//        UIImageView *xuanImage = [BGControl creatImageViewWithFrame:CGRectMake(kScreenSize.width-32, 16,5, 27) image:@"椭圆-3-副本-2" isWebImage:NO holdOnImage:nil isLayer:NO cornerRadius:0];
//        [self.topView addSubview:xuanImage];
//        
//        UIButton *xuanbutton = [BGControl creatButtonWithFrame:CGRectMake(kScreenSize.width-60, 0,60, 60) target:self sel:@selector(shanClick:) tag:200+i image:nil isBackgroundImage:NO title:@"" isLayer:NO cornerRadius:0];
//        self.topView.backgroundColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0f];
//        
//        [self.topView addSubview:xuanbutton];
//        [imageview addSubview:self.topView];
//
        [s addSubview:imageview];
        
        [self.imageScrollView addSubview:s];
        
        //        [doubleTap release];
        //        [imageview release];
        //        [s release];
    }
    
    if (![BGControl isNULLOfString:self.IMGNum]) {
        self.imageScrollView.contentOffset = CGPointMake(kScreenSize.width * (self.IMGNum.integerValue), 0);
    }
    [self creatTopView];
}
- (void)creatTopView{
    self.topView = [BGControl creatViewWithFrame:CGRectMake(0, 0, kScreenSize.width, kTabBarHeight) backgroundColor:[UIColor blackColor] isLayer:NO cornerRadius:0];
    self.topView.alpha = 1.0f;
    
    UIImageView *closeImage = [BGControl creatImageViewWithFrame:CGRectMake(20, 20, 23, 19) image:@"goBack.png" isWebImage:NO holdOnImage:nil isLayer:NO cornerRadius:0];
    closeImage.image = [UIImage imageNamed:@"navi_icon_back@2x"];
   
    [self.topView addSubview:closeImage];
    
    UIButton *backbutton = [BGControl creatButtonWithFrame:CGRectMake(0, 0, 60, 60) target:self sel:@selector(backButtonClick:) tag:101 image:nil isBackgroundImage:NO title:@"" isLayer:NO cornerRadius:0];
    self.topView.backgroundColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0f];
    [self.topView addSubview:backbutton];
    
//    UIImageView *xuanImage = [BGControl creatImageViewWithFrame:CGRectMake(kScreenSize.width-32, 16,5, 27) image:@"椭圆-3-副本-2" isWebImage:NO holdOnImage:nil isLayer:NO cornerRadius:0];
//    [self.topView addSubview:xuanImage];
    if (![self.typestr isEqualToString:@"kan"]) {
        UIButton *xuanbutton = [BGControl creatButtonWithFrame:CGRectMake(kScreenSize.width-60, 0,60, 60) target:self sel:@selector(shanClick:) tag:0 image:nil isBackgroundImage:NO title:@"删除" isLayer:NO cornerRadius:0];
        [xuanbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
        [self.topView addSubview:xuanbutton];
    }
   
    //显示页码
           pageNumLabel = [BGControl creatLabelWithFrame:CGRectMake((kScreenSize.width-100)/2, 20, 100, 20) text:[NSString stringWithFormat:@"%d/%d",bthTag,PHOTONUMBERS] font:[UIFont systemFontOfSize:15] numberOfLine:1 isLayer:NO cornerRadius:0 backgroundColor:[UIColor clearColor]];
            pageNumLabel.textAlignment = NSTextAlignmentCenter;
            pageNumLabel.textColor = [UIColor whiteColor];
            [self.topView addSubview:pageNumLabel];
    [self.view addSubview:self.topView];
}


/**
 *  返回上级页面
 */
- (void)backButtonClick:(UIButton *)button{
    if (_delegate&&[_delegate respondsToSelector:@selector(postTageArr:)]) {
        [_delegate postTageArr:self.IMGArray];
    }

        [self.navigationController popViewControllerAnimated:NO];
    
}
-(void)shanClick:(UIButton *)button{
    NSMutableArray *arr = [NSMutableArray new];
    for (int i = 0; i<self.IMGArray.count; i++) {
        NSDictionary *dict = self.IMGArray[i];
        if (i != bthTag-1) {
            [arr addObject:dict];
        }
    }
    self.IMGArray = [NSMutableArray new];
    self.IMGArray = [NSMutableArray arrayWithArray:arr];
    
    
    if (self.IMGArray.count<1){
        [self.imageScrollView removeFromSuperview];
        if (_delegate&&[_delegate respondsToSelector:@selector(postTageArr:)]) {
            [_delegate postTageArr:self.IMGArray];
        }

        [self.navigationController popViewControllerAnimated:YES];
    }

   else if (bthTag==1) {
        self.IMGNum = @"0";
       bthTag=1;
        [self.imageScrollView removeFromSuperview];
       chu=YES;
        [self setSrc];
    }else if (bthTag>0){
        if (_delegate&&[_delegate respondsToSelector:@selector(postTageArr:)]) {
            [_delegate postTageArr:self.IMGArray];
        }

        self.IMGNum=[NSString stringWithFormat:@"%ld",[self.IMGNum integerValue]-1];
        bthTag =bthTag-1;
         [self.imageScrollView removeFromSuperview];
        chu=YES;
          [self setSrc];
    }
    pageNumLabel.text =[NSString stringWithFormat:@"%d/%d",bthTag,PHOTONUMBERS];
}
-(void)changeCenter:(id)sender{

}

#pragma mark - ScrollView delegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    for (UIView *v in scrollView.subviews){
        return v;
    }
    return nil;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    if (scrollView == self.imageScrollView){
        CGFloat x = scrollView.contentOffset.x;
        if (x==offset){

        }
        else {
            offset = x;
            for (UIScrollView *s in scrollView.subviews){
                if ([s isKindOfClass:[UIScrollView class]]){
                    [s setZoomScale:1.0];
                    UIImageView *image = [[s subviews] objectAtIndex:0];
                    image.frame = CGRectMake(0, 0, kScreenSize.width, kScreenSize.height);
                }
            }
        }
    }
    
    endContentOffsetX = scrollView.contentOffset.x;
    
//    if (endContentOffsetX < willEndContentOffsetX && willEndContentOffsetX < startContentOffsetX) { //画面从右往左移动，前一页
//        bthTag = bthTag-1;
//        NSLog(@"%@",@"前");
//    } else if (endContentOffsetX > willEndContentOffsetX && willEndContentOffsetX > startContentOffsetX) {//画面从左往右移动，后一页
//         bthTag = bthTag+1;
//        NSLog(@"%@",@"hou");
//    }
    NSInteger  inter = endContentOffsetX/(self.view.frame.size.width)+1;
    if (inter ==0) {
        inter=1;
    }
    bthTag = inter;
    self.IMGNum = [NSString stringWithFormat:@"%ld",bthTag-1];
    pageNumLabel.text =[NSString stringWithFormat:@"%d/%d",inter,PHOTONUMBERS];

}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{

}


-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
//    NSLog(@"Did zoom!");
    UIView *v = [scrollView.subviews objectAtIndex:0];
    if ([v isKindOfClass:[UIImageView class]]){
        if (scrollView.zoomScale<1.0){
//         v.center = CGPointMake(scrollView.frame.size.width/2.0, scrollView.frame.size.height/2.0);   
        }
    }
}



#pragma mark - Utility methods

-(CGRect)zoomRectForScale:(float)scale inView:(UIScrollView*)scrollView withCenter:(CGPoint)center {

    CGRect zoomRect;
    
    zoomRect.size.height = [scrollView frame].size.height / scale;
    zoomRect.size.width  = [scrollView frame].size.width  / scale;
    
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);

    return zoomRect;
}

-(CGRect)resizeImageSize:(CGRect)rect{
//    NSLog(@"x:%f y:%f width:%f height:%f ", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    CGRect newRect;
    
    CGSize newSize;
    CGPoint newOri;
    
    CGSize oldSize = rect.size;
    if (oldSize.width>=kScreenSize.width || oldSize.height>=kScreenSize.height){
        float scale = (oldSize.width/kScreenSize.width>oldSize.height/kScreenSize.height?oldSize.width/kScreenSize.width:oldSize.height/kScreenSize.height);
        newSize.width = oldSize.width/scale;
        newSize.height = oldSize.height/scale;
    }
    else {
        newSize = oldSize;
    }
    newOri.x = (kScreenSize.width-newSize.width)/2.0;
    newOri.y = (kScreenSize.height-newSize.height)/2.0;
    
    newRect.size = newSize;
    newRect.origin = newOri;
    
    return newRect;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{    //拖动前的起始坐标
    
    startContentOffsetX = scrollView.contentOffset.x;
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{    //将要停止前的坐标
    
    willEndContentOffsetX = scrollView.contentOffset.x;
    
}


@end
