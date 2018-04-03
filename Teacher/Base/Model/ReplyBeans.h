//
//  ReplyBeans.h
//  Teacher
//
//  Created by 冯丽 on 2018/3/16.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "BaseModel.h"

@interface ReplyBeans : BaseModel
@property (nonatomic)NSString *teacherName;
@property (nonatomic)NSString *id;
@property (nonatomic)NSString *content;
@property (nonatomic)NSString *studentName;
@property (nonatomic)NSString *feedbackId;
@end
