 //
//  AFClient.m
//  noteMan
//
//  Created by 周博 on 16/12/12.
//  Copyright © 2016年 BogoZhou. All rights reserved.
//

#import "AFClient.h"
#import "BGControl.h"
#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import <AVFoundation/AVFoundation.h>
@interface AFClient ()
{
    NSString *_url;
    NSDictionary *_dict;
    NSString *idStr;
    NSURL  *_filePathURL;
    NSString * _fileName;
    NSProgress *_progressone;
    NSString *token;
    NSString *jobCode;
    NSDictionary *userInfoDict;
   
  
}
@end

@implementation AFClient


+(instancetype)shareInstance{
    static AFClient *defineAFClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defineAFClient = [[AFClient alloc] init];
    });
    return defineAFClient;
}

- (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize
{
    //先调整分辨率
    CGSize newSize = CGSizeMake(source_image.size.width, source_image.size.height);
    
    CGFloat tempHeight = newSize.height / 1024;
    CGFloat tempWidth = newSize.width / 1024;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(source_image.size.width / tempWidth, source_image.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(source_image.size.width / tempHeight, source_image.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [source_image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    NSUInteger sizeOrigin = [imageData length];
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
    if (sizeOriginKB > maxSize) {
        NSData *finallImageData = UIImageJPEGRepresentation(newImage,0.50);
        return finallImageData;
    }
    
    return imageData;
}

- (AFHTTPSessionManager *)creatManager{
    AFHTTPSessionManager* mgr = [AFHTTPSessionManager manager];
    token = [[NSUserDefaults standardUserDefaults] valueForKey:@"token"];
    jobCode =  [[NSUserDefaults standardUserDefaults] valueForKey:@"jobCode"];
    NSString *jsonString = [[NSUserDefaults standardUserDefaults]valueForKey:@"loginData"];
    userInfoDict = [[BGControl dictionaryWithJsonString:jsonString] valueForKey:@"userInfo"];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    mgr.securityPolicy  = securityPolicy;
    mgr.requestSerializer=[AFHTTPRequestSerializer serializer];
    mgr.responseSerializer=[AFHTTPResponseSerializer serializer];
    mgr.requestSerializer.timeoutInterval = 20.f;
    return mgr;
}
- (void)loginWithUserName:(NSString *)userName passWord:(NSString *)passWord   progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
    _url = [NSString stringWithFormat:@"%@%@",kHttpHeader,@"sysuser/login"];
    _dict = [NSDictionary dictionaryWithObjectsAndKeys:userName,@"username",passWord,@"password", nil];
    AFHTTPSessionManager *manager = [self creatManager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/xml", @"text/xml",@"text/html",@"text/plain",@"application/json", nil];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_dict options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    AFURLSessionManager *manager1 = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:_url parameters:nil error:nil];
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [[manager1 dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
        if (!error) { NSLog(@"Reply JSON: %@", responseObject);
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                if (success) {
                    success(responseObject);
                    NSLog(@"%@",responseObject);
                }
       
            }
        } else {
        
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            if (failure) {
                failure(error);
            }
            
        } }] resume];

}
//1.教师课表查询接口
- (void)TeacherScheduleByTeacherId:(NSString *)teacherId progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
    _url = [NSString stringWithFormat:@"%@%@",kHttpHeader,@"TeacherSchedule/get"];
    _dict = [NSDictionary dictionaryWithObjectsAndKeys:[userInfoDict valueForKey:@"id"],@"teacherId", nil];
    AFHTTPSessionManager *manager = [self creatManager];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    
    [manager POST:_url parameters:_dict progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (success) {
            //             获取所有数据报头信息
            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)task.response;
            NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
            NSLog(@"fields = %@", [fields description]);
            success(dict);
            
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
//2.教师个人资料接口
- (void)infoByStr:(NSString*)str  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure{
    _url = [NSString stringWithFormat:@"%@%@",kHttpHeader,@"login"];
    _dict = [NSDictionary dictionaryWithObjectsAndKeys:jobCode,@"jobCode", nil];
    AFHTTPSessionManager *manager = [self creatManager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/xml", @"text/xml",@"text/html",@"text/plain",@"application/json", nil];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_dict options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    AFURLSessionManager *manager1 = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
     NSDictionary  *hear = [NSDictionary dictionaryWithObjectsAndKeys:token,@"Authorization", nil];
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:_url parameters:nil error:nil];
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
     [req setAllHTTPHeaderFields:hear];
    [[manager1 dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
        if (!error) { NSLog(@"Reply JSON: %@", responseObject);
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                if (success) {
                    success(responseObject);
                    NSLog(@"%@",responseObject);
                }
                
            }
        } else {
            
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            if (failure) {
                failure(error);
            }
            
        } }] resume];

}
//3.教师考勤管理接口
- (void)attendance:(NSString*)str progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure{
    _url = [NSString stringWithFormat:@"%@%@",kHttpHeader,@"attendance/schedule/get"];
    _dict = [NSDictionary dictionaryWithObjectsAndKeys:str,@"scheduleId", nil];
    AFHTTPSessionManager *manager = [self creatManager];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    
    [manager POST:_url parameters:_dict progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (success) {
            //             获取所有数据报头信息
            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)task.response;
            NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
            NSLog(@"fields = %@", [fields description]);
            success(dict);
            
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)UpdatePasswordwithDict:(NSDictionary *)dataDict progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure{
    _url = [NSString stringWithFormat:@"%@%@",kHttpHeader,@"sysuser/updatePassword"];
   
    AFHTTPSessionManager *manager = [self creatManager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/xml", @"text/xml",@"text/html",@"text/plain",@"application/json", nil];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataDict options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    AFURLSessionManager *manager1 = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSDictionary  *hear = [NSDictionary dictionaryWithObjectsAndKeys:token,@"Authorization", nil];
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:_url parameters:nil error:nil];
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [req setAllHTTPHeaderFields:hear];
    [[manager1 dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
        if (!error) { NSLog(@"Reply JSON: %@", responseObject);
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                if (success) {
                    success(responseObject);
                    NSLog(@"%@",responseObject);
                }
                
            }
        } else {
            
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            if (failure) {
                failure(error);
            }
            
        } }] resume];

}
//6.app查询消息公告
- (void)noticeWithId:(NSString  *)idStr witnPage:(NSString *)page withLimit:(NSString *)limit  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
    _url = [NSString stringWithFormat:@"%@%@",kHttpHeader,@"notice/get"];
    _dict = [NSDictionary dictionaryWithObjectsAndKeys:idStr,@"schoolPid",page,@"page",limit,@"limit", nil];
    AFHTTPSessionManager *manager = [self creatManager];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];

    [manager POST:_url parameters:_dict progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (success) {
            //             获取所有数据报头信息
            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)task.response;
            NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
            NSLog(@"fields = %@", [fields description]);
            success(dict);
            
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

//成绩查询接口
- (void)getResultwithUrlStr:(NSString *)urlStr withDict:(NSDictionary *)dict progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
    _url = [NSString stringWithFormat:@"%@%@",kHttpHeader,urlStr];
   
    AFHTTPSessionManager *manager = [self creatManager];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    
    [manager POST:_url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (success) {
            //             获取所有数据报头信息
            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)task.response;
            NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
            NSLog(@"fields = %@", [fields description]);
            success(dict);
            
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
//10.App查询详细成绩
- (void)getResultWithDict:(NSDictionary *)dict progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
    _url = [NSString stringWithFormat:@"%@%@",kHttpHeader,@"Achievementstudentss/get"];
    
    AFHTTPSessionManager *manager = [self creatManager];
   [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    
    [manager POST:_url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (success) {
            //             获取所有数据报头信息
            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)task.response;
            NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
            NSLog(@"fields = %@", [fields description]);
            success(dict);
            
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
//5.根据教师查询学生
- (void)getStudents:(NSString *)teacherId progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
    _url = [NSString stringWithFormat:@"%@%@",kHttpHeader,@"Teacerstudent/get"];
    
    AFHTTPSessionManager *manager = [self creatManager];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    _dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:teacherId,@"teacherId", nil];
    [manager GET:_url parameters:_dict progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (success) {
            //             获取所有数据报头信息
            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)task.response;
            NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
            NSLog(@"fields = %@", [fields description]);
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            success(dict);
            
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
- (void)postFile:(NSString *)file  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
    _url =[NSString stringWithFormat:@"%@%@",kHttpHeader,@"uploads"];
    
    UIImage *img = [UIImage imageWithContentsOfFile:file];
    AFHTTPSessionManager *manager = [self creatManager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 20.f;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
     [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    [manager POST:_url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:[self resetSizeOfImageData:img maxSize:50] name:@"file" fileName:fileName mimeType:@"image/jpg"];
        NSLog(@"123");
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (success) {
            NSLog(@"%@",_url);
            NSLog(@"%@",dict[@"data"]);
            success(dict);
            //             获取所有数据报头信息
            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)task.response;
            NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
            NSLog(@"fields = %@", [fields description]);
            // 获取cookie方法1
            NSString *cookieString = [[HTTPResponse allHeaderFields] valueForKey:@"Set-Cookie"];
            if (![BGControl isNULLOfString:cookieString]) {
                [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"cook"];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];;
}
//3.1 修改考勤(状态)接口
- (void)updateAttendance:(NSString *)studentId withStatus:(NSString *)status progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
    _url = [NSString stringWithFormat:@"%@%@",kHttpHeader,@"attendance/update"];
    
    AFHTTPSessionManager *manager = [self creatManager];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    _dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:studentId,@"studentId",status,@"status", nil];
    [manager POST:_url parameters:_dict progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (success) {
            //             获取所有数据报头信息
            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)task.response;
            NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
            NSLog(@"fields = %@", [fields description]);
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            success(dict);
            
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
