//
//  feedBackModel.h
//  Teacher
//
//  Created by 冯丽 on 2018/3/16.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "BaseModel.h"

@interface feedBackModel : BaseModel
@property (nonatomic)NSString  *id;

@property (nonatomic)NSArray *replyBeans;

@property (nonatomic)NSString *schoolPid;
@property (nonatomic)NSString *replycount;
@property (nonatomic)NSString *schoolId;
@property (nonatomic)NSString *tname;
@property(nonatomic)NSString  *img;
@property (nonatomic)NSString *title;
@property(nonatomic)NSString *type;

@property (nonatomic)NSString *sid;
@property (nonatomic)NSString *txt;
@property (nonatomic)NSString *created;
@property (nonatomic)NSString *sname;
@property(nonatomic)NSString  *tid;
@property (nonatomic)NSString *content;
@property(nonatomic)NSString *gradeName;

@end
