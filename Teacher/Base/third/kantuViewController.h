//
//  ViewController.h
//  TestScrollViewImage
//
//  Created by raykle on 12-8-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@protocol postArrDelegate <NSObject>

@optional
- (void)postTageArr:(NSArray *)arr;

@end

@interface kantuViewController : UIViewController<UIScrollViewDelegate>{
    CGFloat offset;
}

@property (nonatomic, retain) UIScrollView *imageScrollView;

@property (nonatomic,strong) NSMutableArray *IMGArray;
@property (nonatomic,strong) NSString *IMGNum;
@property (nonatomic,strong)id <postArrDelegate>delegate;
@property (nonatomic,strong) NSString *imageContent;
//@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *typestr;
-(CGRect)zoomRectForScale:(float)scale inView:(UIScrollView*)scrollView withCenter:(CGPoint)center;
//-(CGRect)resizeImageSize:(UIImage*)image;
@end
