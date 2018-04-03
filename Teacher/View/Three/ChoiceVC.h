//
//  ChoiceVC.h
//  Teacher
//
//  Created by 冯丽 on 2018/1/30.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "JJBaseController.h"
@protocol postValueDelegate <NSObject>

@optional

-(void)postValue:(NSString *)valueStr withId:(NSInteger)idNum  withTag:(NSInteger )tag;
@end

@interface ChoiceVC : JJBaseController
@property (strong, nonatomic) IBOutlet UIView *navView;
@property (strong, nonatomic) IBOutlet UITableView *bigTableView;
@property(assign) NSInteger tag;

@property(nonatomic, strong) NSString  *schoolYearId;//学年
@property(nonatomic, strong) NSString  *projectId;//项目Id
@property(nonatomic, strong) NSString  *schoolId;//项目Id
@property(nonatomic, strong) NSString  *gradeId;//年级Id
@property(nonatomic, strong) NSString  *examTypeId;//考试类型Id
@property(nonatomic, strong) NSString  *examId;//学期Id
@property(nonatomic,weak) id<postValueDelegate> delegate;
@end
