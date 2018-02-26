//
//  addVC.h
//  Teacher
//
//  Created by 冯丽 on 2018/1/11.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "JJBaseController.h"

@interface addVC : JJBaseController
@property (strong, nonatomic) IBOutlet UIView *naView;
@property (strong, nonatomic) IBOutlet UIView *bigView;
@property (strong, nonatomic) IBOutlet UITextField *studentsFile;
@property (strong, nonatomic) IBOutlet UITextField *titleTextFile;
@property (strong, nonatomic) IBOutlet UILabel *placLab;
@property (strong, nonatomic) IBOutlet UITextView *detailTextView;
@property (strong, nonatomic) IBOutlet UIView *picView;
@property (strong, nonatomic) IBOutlet UIView *fuJianView;
@property (strong, nonatomic) IBOutlet UITextField *typeFile;

@end
