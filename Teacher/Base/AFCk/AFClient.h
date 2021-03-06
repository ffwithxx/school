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
- (void)attendance:(NSString*)sid withStime:(NSString *)stime progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
//5.教师修改个人密码
- (void)UpdatePasswordwithDict:(NSDictionary *)dataDict progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
//6.app查询消息公告
- (void)noticeWithId:(NSString  *)idStr witnPage:(NSString *)page withLimit:(NSString *)limit  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
//成绩查询接口
- (void)getResultwithUrlStr:(NSString *)urlStr withDict:(NSDictionary *)dict progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
//10.App查询详细成绩
- (void)getResultWithDict:(NSDictionary *)dict progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
//5.根据教师查询学生
- (void)getStudents:(NSString *)teacherId progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
- (void)postFile:(NSString *)file  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
//3.1 修改考勤(状态)接口
- (void)updateAttendance:(NSString *)studentId withStatus:(NSString *)status progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
//4.查询发布
- (void)feedbackWithTeacherId:(NSString *)teacherId withType:(NSString *)type progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;

//5.根据教师查询学生
- (void)techerFeedBackWithStudentId:(NSString *)StudentId withContent:(NSString *)content withFeedbackId:(NSString *)feedbackId progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;

//1.新增发布
- (void)createBackWithDict:(NSDictionary *)dict progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
//4.1查询回复发布详情
-(void)FeedbackWithDetailWithDict:(NSDictionary *)dict progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;

- (void)attendanceByTeacher:(NSString *)teacherId progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:(ProgressBlock)progress
                              success:(SuccessBlock)success
                              failure:(FailureBlcok)failure;

- (void)postOneFileNameone:(NSData* )data withFileName:(NSString *)fileName progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;

@end
