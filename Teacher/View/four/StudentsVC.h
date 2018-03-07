//
//  StudentsVC.h
//  Teacher
//
//  Created by 冯丽 on 2018/3/7.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "JJBaseController.h"
@protocol postStudentDelegate <NSObject>

@optional

-(void)postStudent:(NSDictionary *)studentDict withclassId:(NSString *)classId;
@end
@interface StudentsVC : JJBaseController
@property (strong, nonatomic) IBOutlet UITableView *bigTableView;
@property (strong, nonatomic) IBOutlet UIView *naVie;
@property(nonatomic,weak) id<postStudentDelegate> delegate;
@end
