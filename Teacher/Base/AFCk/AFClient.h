//
//  AFClient.h
//  noteMan
//
//  Created by 周博 on 16/12/12.
//  Copyright © 2016年 BogoZhou. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kHttpHeader @"http://101.231.72.22:8080/rest/"
#define KHeader @"2DD8F2D2-4C62-4593-B745-AE4254BCBE4C"
@interface AFClient : NSObject

typedef void(^ProgressBlock)(NSProgress *progress);
typedef void(^SuccessBlock)(id responseBody);
typedef void(^FailureBlcok)(NSError *error);

@property (nonatomic,strong)ProgressBlock progressBolck;
@property (nonatomic,strong)SuccessBlock successBlock;
@property (nonatomic,strong)FailureBlcok failureBlock;


+(instancetype)shareInstance;
//1.教师课表查询接口
- (void)TeacherScheduleByTeacherId:(NSString *)teacherId progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;

- (void)loginWithUserName:(NSString *)userName passWord:(NSString *)passWord   progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
//2.教师个人资料接口
- (void)infoByStr:(NSString*)str progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
//3.教师考勤管理接口
- (void)attendance:(NSString*)str progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
//5.教师修改个人密码
- (void)UpdatePasswordwithDict:(NSDictionary *)dataDict progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
//6.app查询消息公告
- (void)noticeWithId:(NSString  *)idStr  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
//成绩查询接口
- (void)getResultwithUrlStr:(NSString *)urlStr withDict:(NSDictionary *)dict progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
//10.App查询详细成绩
- (void)getResultWithDict:(NSDictionary *)dict progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
@end
