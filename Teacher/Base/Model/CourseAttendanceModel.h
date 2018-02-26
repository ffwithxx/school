//
//  CourseAttendanceModel.h
//  Teacher
//
//  Created by 冯丽 on 2018/1/30.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "BaseModel.h"

@interface CourseAttendanceModel : BaseModel
@property (nonatomic)NSString *attendanceDate;
@property (nonatomic)NSString *createAt;
@property (nonatomic)NSString *id;
@property (nonatomic)NSString *note;
@property (nonatomic)NSString *scheduleDetailId;
@property (nonatomic)NSString  *scheduleId;
@property (nonatomic)NSArray *schoolPid;
@property (nonatomic)NSString *status;
@property (nonatomic)NSString *studentCode;
@property (nonatomic)NSString *studentId;
@property (nonatomic)NSString *studentName;
@property (nonatomic)NSString *updateAt;
@property (nonatomic)NSInteger maxHei;
@property (nonatomic)NSInteger index;
@property (nonatomic)NSInteger open;
@end
