//
//  addVC.m
//  Teacher
//
//  Created by 冯丽 on 2018/1/11.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "addVC.h"
#import "StudentsVC.h"
#import "TypeVC.h"
#import "SZCalendarPicker.h"
#import "ELCImagePickerHeader.h"
#import "BGControl.h"
#import "AFClient.h"
#import "iCloudManager.h"
@interface addVC ()<postStudentDelegate,UITextViewDelegate,postTypeDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,ELCImagePickerControllerDelegate,UIDocumentPickerDelegate, UIDocumentInteractionControllerDelegate>{
    NSMutableArray *_images;
    NSString *studentIdStr;
    NSString *teacherIdStr;
    NSString *imgStr;
    NSString *txtStr;
    NSString *myTypeStr;
    NSMutableArray *addImgArr;
     NSMutableArray *addtxtArr;
}

@end

@implementation addVC

- (void)viewDidLoad {
    [super viewDidLoad];
    addImgArr = [[NSMutableArray alloc] init];
    addtxtArr = [[NSMutableArray alloc] init];
    _images = [NSMutableArray array];
    self.detailTextView.delegate = self;
    
    if (kiPhoneX) {
        self.naView.frame = CGRectMake(0, 0, kScreenSize.width, kNavHeight);
        self.bigView.frame = CGRectMake(0, kNavHeight, kScreenSize.width, kScreenSize.height-kNavHeight);
    }
     self.navigationController.navigationBar.hidden = NO;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"新建管理信息";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
   
    self.picView.layer.cornerRadius = 5.f;
    self.picView.layer.borderWidth = 1.f;
    self.picView.layer.borderColor = KLineColor.CGColor;
    self.fuJianView.layer.cornerRadius = 5.f;
    self.fuJianView.layer.borderWidth = 1.f;
    self.fuJianView.layer.borderColor = KLineColor.CGColor;
    
}
- (void)Alert:(NSString *)AlertStr{
    
    [LYMessageToast toastWithText:AlertStr backgroundColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] fontColor:[UIColor whiteColor] duration:2.f inView:[[UIApplication sharedApplication].windows lastObject]];
    
}

/**
 点击事件

 @param sender
 301 选择学生
 302上传图片
 303 上传附件
 */
- (IBAction)buttonClick:(UIButton *)sender {
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if (sender.tag == 301) {
        StudentsVC *student = [storyboard instantiateViewControllerWithIdentifier:@"StudentsVC"];
        student.delegate = self;
        [self.navigationController pushViewController:student animated:YES];
    }else if (sender.tag == 304) {
        TypeVC *typeVC = [storyboard instantiateViewControllerWithIdentifier:@"TypeVC"];
        typeVC.delegate = self;
        [self.navigationController pushViewController:typeVC animated:YES];
    }else if (sender.tag == 302) {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选取", nil];
        [sheet showInView:self.view];
    }else if (sender.tag == 303) {
        [self presentDocumentPicker];
    }
    
}

- (IBAction)backClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)postStudent:(NSDictionary *)studentDict withclassId:(NSString *)classId {
    self.studentsFile.text = [studentDict valueForKey:@"sname"];
    studentIdStr = classId;
}
- (void)postType:(NSString *)typeStr {
    self.typeFile.text = typeStr;
    if ([typeStr isEqualToString:@"奖惩记录"]) {
        myTypeStr = @"1";
    }else if ([typeStr isEqualToString:@"在校表现"]) {
        myTypeStr = @"0";
    }else if ([typeStr isEqualToString:@"活动记录"]) {
        myTypeStr = @"2";
    }
}
- (void)textViewDidChange:(UITextView *)textView {
    if (!textView.text.length) {
        self.placLab.alpha = 1;
    }else {
        self.placLab.alpha = 0;
    }
}
- (void) dismissKeyBoard {
    [self.detailTextView resignFirstResponder];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![self.detailTextView isExclusiveTouch]) {
        [self.detailTextView resignFirstResponder];
    }
}

//这个函数的最后一个参数text代表你每次输入的的那个字，所以：
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [self.detailTextView resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}

//上传图片

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0://拍照
        {
            //            [self takePhoto];
            [self takepic];
        }
            break;
        case 1://从相册选取
        {[self LocalPic];
            //            [self LocalPhoto];
            
        }
            break;
        default:
            break;
    }
}

/**
 *  从相册选择
 */
-(void)LocalPic{
    //    [self hiddenAllJumpView];
    if (_images.count <9) {
        
        
        NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];//Camera所支持的Media格式都有哪些,共有两个分别是@"public.image",@"public.movie"
        
        
        ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
        
        elcPicker.maximumImagesCount = 9-_images.count; //Set the maximum number of images to select to 100
        elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
        elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
        elcPicker.onOrder = YES; //For multiple image selection, display and return order of selected images
        elcPicker.mediaTypes =[NSArray arrayWithObject:availableMedia[0]];//Supports image and movie types
        elcPicker.imagePickerDelegate = self;
        
        [self presentViewController:elcPicker animated:YES completion:nil];
    }else {
        [self Alert:@"您最多只能上传9张图片"];
    }
    
}
/**
 *  拍照
 */
-(void)takepic{
    //    [self hiddenAllJumpView];
    if (_images.count <9) {
        
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        //判断是否有相机
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            //设置拍照后的图片可被编辑
            picker.allowsEditing = YES;
            //资源类型为照相机
            picker.sourceType = sourceType;
            [self presentViewController:picker animated:YES completion:nil];
        }else {
            [BGControl creatAlertWithString:@"该设备无摄像头" controller:self autoHiddenTime:0];
        }
    }else {
        [self Alert:@"您最多只能上传9张图片"];
    }
}


#pragma mark - 保存图片
- (void)displayPickerForGroup:(ALAssetsGroup *)group
{
    ELCAssetTablePicker *tablePicker = [[ELCAssetTablePicker alloc] initWithStyle:UITableViewStylePlain];
    tablePicker.singleSelection = YES;
    tablePicker.immediateReturn = YES;
    
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initWithRootViewController:tablePicker];
    elcPicker.maximumImagesCount = 1;
    elcPicker.imagePickerDelegate = self;
    elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
    elcPicker.onOrder = NO; //For single image selection, do not display and return order of selected images
    tablePicker.parent = elcPicker;
    
    // Move me
    tablePicker.assetGroup = group;
    [tablePicker.assetGroup setAssetsFilter:[ALAssetsFilter allAssets]];
    
    [self presentViewController:elcPicker animated:YES completion:nil];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    } else {
        return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
    }
}

#pragma mark ELCImagePickerControllerDelegate Methods

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
//    for (UIView *v in [self.bigScrollView subviews]) {
//        [v removeFromSuperview];
//    }
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i< info.count;i++) {
        NSDictionary *dict = info[i];
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                if (_images.count <9) {
                    //                    CGFloat newWiDTH = 300;
                    //                    CGFloat newHeight = 300;
                    //                    if (image.size.width<350) {
                    //                        newWiDTH = image.size.width;
                    //                    }
                    //                    if (image.size.height <500) {
                    //                        newHeight = image.size.height;
                    //                    }
                    
                    //                    UIImage *newImg =[self fitSmallImage:image needwidth:newWiDTH needheight:newHeight];
                    [_images addObject:image];
                    [arr addObject:image];
                }else {
                    [self Alert:@"您最多只能上传9张图片"];
                }
                
            } else {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        }
        
    }
    //    [_imageview removeFromSuperview];
    //    [_imgButton removeFromSuperview];
    //    [uploadImagesArr removeAllObjects];
    NSMutableArray *arrOne = [NSMutableArray arrayWithArray:_images];
    for (int i = 0; i<arrOne.count; i++) {
        
        [self uploadPicturewithInsdex:i withArr:arrOne];
        
    }
    
    
}
/**
 *将图片路径提交后台
 */
-(void)uploadPicturewithInsdex:(NSInteger )index withArr:(NSMutableArray *)arry{
    [self show];
  
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:arry];
    [_images removeAllObjects];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"chuan.png"];
    // 获取沙盒目录
    NSData *imageData = UIImageJPEGRepresentation(arr[index], 0.5);
    NSString *str=fullPath;
    [imageData writeToFile:fullPath atomically:NO];
    [[AFClient shareInstance] postFile:str  progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        
        if ([[responseBody valueForKey:@"code"] integerValue] == 0) {
            [addImgArr addObject:[[responseBody valueForKey:@"data"]valueForKey:@"img"]];
//            [addImgArr addObject:<#(nonnull id)#>]
           
//            for (UIView *v in [self.bigScrollView subviews]) {
//                [v removeFromSuperview];
//            }
//            [self creatImgScr];
            
        }else {
//            NSString *str = [responseBody valueForKey:@"errors"][0];
            //           [_images removeObjectAtIndex:index];
           [self Alert:responseBody[@"msg"]];
            
        }
        [self dismiss];
    } failure:^(NSError *error) {
        [self Alert:@"上传附件失败"];
//        [self creatImgScr];
        //       [arr removeObjectAtIndex:index];
        [self dismiss];
    }];
    
}



- (IBAction)addClick:(UIButton *)sender {
    NSString *jsonString = [[NSUserDefaults standardUserDefaults]valueForKey:@"loginData"];
    NSDictionary *userInfoDict = [[BGControl dictionaryWithJsonString:jsonString] valueForKey:@"userInfo"];
    NSString *teacherId = [userInfoDict valueForKey:@"id"];
    if ([BGControl isNULLOfString:studentIdStr]) {
        [self Alert:@"请选择学生"];
        return;
    }else if ([BGControl isNULLOfString:self.titleTextFile.text]) {
        [self Alert:@"请输入标题"];
        return;
    }else if ([BGControl isNULLOfString:self.detailTextView.text]) {
        [self Alert:@"请输入内容"];
        return;
    }else if ([BGControl isNULLOfString:myTypeStr]) {
        [self Alert:@"请选择类型"];
        return;
    }
    NSDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:teacherId forKey:@"teacherId"];
    [dict setValue:studentIdStr forKey:@"studentId"];
    [dict setValue:self.detailTextView.text forKey:@"content"];
    [dict setValue:self.titleTextFile.text forKey:@"title"];
    [dict setValue:myTypeStr forKey:@"type"];
    imgStr = [addImgArr componentsJoinedByString:@";"];
    txtStr = [addtxtArr componentsJoinedByString:@";"];
    if (![BGControl isNULLOfString:imgStr]) {
        [dict setValue:imgStr forKey:@"img"];
    }
    if (![BGControl isNULLOfString:txtStr]) {
        [dict setValue:txtStr forKey:@"txt"];
    }
   
    
    [self show];
    [[AFClient shareInstance] createBackWithDict:dict progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([[responseBody valueForKey:@"code"] integerValue] == 0) {
            [self Alert:@"新建成功"];
            
        }else{
            [self Alert:responseBody[@"msg"]];
        }
         [self dismiss];
    } failure:^(NSError *error) {
        [self dismiss];
    }];
}
- (void)presentDocumentPicker {
    NSArray *documentTypes = @[@"public.content", @"public.text", @"public.source-code ", @"public.image", @"public.audiovisual-content", @"com.adobe.pdf", @"com.apple.keynote.key", @"com.microsoft.word.doc", @"com.microsoft.excel.xls", @"com.microsoft.powerpoint.ppt"];
    
    UIDocumentPickerViewController *documentPickerViewController = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:documentTypes
                                                                                                                          inMode:UIDocumentPickerModeOpen];
    documentPickerViewController.delegate = self;
    [self presentViewController:documentPickerViewController animated:YES completion:nil];
}
#pragma mark - UIDocumentPickerDelegate

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    
    NSArray *array = [[url absoluteString] componentsSeparatedByString:@"/"];
    NSString *fileName = [array lastObject];
    fileName = [fileName stringByRemovingPercentEncoding];
    
    if ([iCloudManager iCloudEnable]) {
        [iCloudManager downloadWithDocumentURL:url callBack:^(id obj) {
            NSData *data = obj;
            
            //写入沙盒Documents
            NSString *path = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@",fileName]];
            [self show];
            [[AFClient shareInstance] postOneFileNameone:data withFileName:fileName progressBlock:^(NSProgress *progress) {
                
            } success:^(id responseBody) {
                
                if ([[responseBody valueForKey:@"code"] integerValue] == 0) {
                    NSString *txt = [[responseBody valueForKey:@"data"] valueForKey:@"img"];
                    NSString *txtName = [[responseBody valueForKey:@"data"] valueForKey:@"tname"];
                    NSString *txtStr = [NSString stringWithFormat:@"%@%@%@",txt,@"◆",txtName];
                    [addtxtArr addObject:txtStr];
                }else {
                  
                    [self Alert:responseBody[@"msg"]];
                    NSLog(@"%@",responseBody[@"msg"]);
                }
                [self dismiss];
            } failure:^(NSError *error) {
                [self Alert:@"上传附件失败"];
                [self dismiss];
            }];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
