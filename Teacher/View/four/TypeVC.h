//
//  TypeVC.h
//  Teacher
//
//  Created by 冯丽 on 2018/3/7.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "JJBaseController.h"
@protocol postTypeDelegate <NSObject>

@optional

-(void)postType:(NSString *)typeStr;
@end


@interface TypeVC : JJBaseController
@property (strong, nonatomic) IBOutlet UITableView *bigTableView;
@property (strong, nonatomic) IBOutlet UIView *naVie;
@property(nonatomic,weak) id<postTypeDelegate> delegate;

@end
