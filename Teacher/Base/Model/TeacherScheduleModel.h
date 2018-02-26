//
//  TeacherScheduleModel.h
//  Teacher
//
//  Created by 冯丽 on 2018/1/30.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "BaseModel.h"

@interface TeacherScheduleModel : BaseModel
@property (nonatomic)NSString *beginDate;
@property (nonatomic)NSString *classroomId;
@property (nonatomic)NSString *classroomName;
@property (nonatomic)NSString *courseId;
@property (nonatomic)NSString *courseName;

@property (nonatomic)NSInteger createAt;
@property (nonatomic)NSString  *endDate;
@property (nonatomic)NSString  *id;

@property (nonatomic)NSArray *scheduleDetailBeans;
@property (nonatomic)NSString *scheduleId;

@property (nonatomic)NSString *status;
@property (nonatomic)NSString *studentId;
@property (nonatomic)NSString *studentName;
@property (nonatomic)NSString *teacherId;
@property(nonatomic)NSString  *teacherName;
@property(nonatomic)NSString  *time;
@property (nonatomic)NSString *updateAt;
@property(nonatomic)NSInteger weekDay;
@end
