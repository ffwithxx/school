//
//  BGControl.h
//  MyControl
//
//  Created by chenghong_mac on 15/7/30.
//  Copyright (c) 2015年 Bogo. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "UIImageView+WebCache.h"
#import <UIKit/UIKit.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
//#import "Reachability.h"

//#define kScreen              [UIScreen mainScreen].bounds.size

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kSystemNo            [[[UIDevice currentDevice] systemVersion] floatValue]
#define kAppVersion          [[NSBundle mainBundle]infoDictionary][@"CFBundleShortVersionString"]
#define kDeviceName          [[UIDevice currentDevice]name]//手机名
#define kIP                  [HHUtility deviceIPAdress]

//获取 version 版本号
#define kSoftwareVersion [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]


@interface BGControl : NSObject
/**
 *  1.创建 Label
 *
 *  @param frame           label 的frame
 *  @param text            显示的内容
 *  @param font            字体大小
 *  @param numberOfLine    显示的行数  0 -> 全部显示
 *  @param isLayer         是否允许切割
 *  @param cornerRadius    边角弧度
 *  @param backgroundColor 背景色
 *
 *  @return  设置好的 label
 */
+ (UILabel *)creatLabelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font numberOfLine:(NSInteger)numberOfLine isLayer:(BOOL)isLayer cornerRadius:(CGFloat)cornerRadius backgroundColor:(UIColor *)backgroundColor;

/**
 *  2.创建 Button
 *
 *  @param frame             位置
 *  @param target            按钮目标
 *  @param sel               添加选择器
 *  @param tag               设置 tag 值
 *  @param image             设置 button 的图片 若没有,写 nil
 *  @param isBackgroundImage 判断该图片是否是 button 的背景图
 *  @param title             button 的 title 若没有,写 nil
 *  @param isLayer           是否允许切割
 *  @param cornerRadius      设置边角弧度
 *
 *  @return 设置好的 button
 */
+ (UIButton *)creatButtonWithFrame:(CGRect)frame target:(id)target sel:(SEL)sel tag:(NSInteger)tag image:(NSString *)image isBackgroundImage:(BOOL)isBackgroundImage title:(NSString *)title isLayer:(BOOL)isLayer cornerRadius:(CGFloat)cornerRadius;

/**
 *  3.创建 ImageView
 *
 *  @param frame        位置
 *  @param image        设置图片
 *  @param isWebImage   判断图片是否是来自网络的图片
 *  @param holdOnImage  设置 holder 图片
 *  @param isLayer      是否允许切割
 *  @param cornerRadius 设置边角弧度
 *
 *  @return 设置好的 imageView
 */
+ (UIImageView *)creatImageViewWithFrame:(CGRect)frame image:(NSString *)image isWebImage:(BOOL)isWebImage holdOnImage:(NSString *)holdOnImage isLayer:(BOOL)isLayer cornerRadius:(CGFloat)cornerRadius;

/**
 *  4.创建 TextField
 *
 *  @param frame       位置
 *  @param placeHolder
 *  @param borderStyle 边框的类型
 UITextBorderStyleNone,
 UITextBorderStyleLine,
 UITextBorderStyleBezel,
 UITextBorderStyleRoundedRect
 
 *  @param delegate    代理
 *  @param tag         设置 tag 值
 *
 *  @return 设置好的 TextField
 */
+ (UITextField *)creatTextFieldWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder borderStyle:(UITextBorderStyle )borderStyle delegate:(id<UITextFieldDelegate>)delegate tag:(NSInteger)tag;

//5.创建 TextView
/*
 1、设置文本属性：text；
 2、设置文字对齐方式属性：textAlignment；
 3、设置文字颜色属性：textColor；
 4、设置文字字体属性：font；
 5、设置编辑使能属性：editable；
 6、设置背景颜色属性：backgroundColor；
 7、圆角边框：layer.cornerRadius、layer.borderWidth。
 */
+ (UITextView *)creatTextViewWithFrame:(CGRect)frame text:(NSString *)text textAlignment:(NSTextAlignment)textAlignment textColor:(UIColor *)textColor font:(UIFont *)font isEditable:(BOOL)isEditable backgroundColor:(UIColor *)backgroundColor isLayer:(BOOL)isLayer cornerRadius:(CGFloat)cornerRadius delegate:(id<UITextViewDelegate>)delegate;

/**
 *  6.创建滚动视图，广告
 *
 *  @param frame            滚动视图的 frame
 *  @param dataArr          将要展示的图片数组
 *  @param delegate         滚动视图的代理
 *  @param time             滚动的时间 间隔
 *  @param target           滚动视图的目标  self
 *  @param btnSel           点击事件对应的 选择器
 *  @param timerSel         计时器对应的选择器
 *  @param userInfo         一般为 nil
 *  @param repeats          是否重复 好像作用不大
 *  @param isLocalImage     图片是否是本地图片
 *  @param placeHolderImage 若不是本地图片 加入 placeHolder 图片
 *
 *  @return 设置好的 scrollView
 */
+ (UIScrollView *)creatScrollViewWithFrame:(CGRect)frame dataArr:(NSArray*)dataArr delegate:(id<UIScrollViewDelegate>)delegate time:(NSTimeInterval)time target:(id)target btnSel:(SEL)btnSel timerSel:(SEL)timerSel userInfo:(id)userInfo repeats:(BOOL)repeats isLocalImage:(BOOL)isLocalImage placeHolderImage:(NSString *)placeHolderImage;

/**
 *  7.创建 view
 *
 *  @param frame           要创建view的frame
 *  @param backgroundColor 要创建view的背景色
 *  @param isLayer         要创建的view是否需要裁减
 *  @param cornerRadius    弧度
 *
 *  @return 创建完成的view
 */
+ (UIView *)creatViewWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor isLayer:(BOOL)isLayer cornerRadius:(CGFloat)cornerRadius;

/**
 *  8.将二进制数据转化为标准的字典类型
 *
 *  @param data data形式的数据
 *
 *  @return 将data形式的数据转换成字典类型
 */
+ (NSDictionary *)getJsonData:(id)data;

/**
 *  9.警告框   ---> iOS 9.0 之后UIAlertView 取消使用  现使用 UIAlertController
 *
 *  @param string     要显示的名字
 *  @param controller 当前的controller (self)
 *
 *  @return 警告框
 */
+ (UIAlertController *)creatAlertWithString:(NSString *)string controller:(id)controller autoHiddenTime:(double)autoHiddenTime;

/**
 *  10.MD5加密
 *
 *  @param password 密钥
 *
 *  @return 加密完成的字符串
 */
+ (NSString *)MD5SecretCode:(NSString *)password;

/**
 *  11.过滤调html中的‘<...>’等标签 但是无法过滤像"&..."这样的标签
 *
 *  @param html 将要过滤的html以字符串的形式传入该方法
 *
 *  @return 过滤空格之后的html形式的字符串
 */
+ (NSString *)getStringWithHTML:(NSString *)html;

/**
 *  12.展示富文本
 *
 *  @param html 将html内容以字符串的形式传入该方法
 *
 *  @return 以富文本形式展示出来
 */
+ (NSAttributedString *)showViewWithHtml:(NSString *)html;

/**
 *  13.根据富文本的宽度计算高度
 *
 *  @param attributedString 传入富文本
 *  @param width            将要展示的宽度
 *
 *  @return 合适的高度
 */
+ (CGFloat)getFrameFromAttributedString:(NSAttributedString *)attributedString width:(CGFloat)width;

/**
 *  14.为富文本设置统一的颜色
 *
 *  @param html  将html内容以字符串的形式传入该方法
 *  @param color 内容字体将要改变的文字
 *
 *  @return 富文本形式
 */
+ (NSAttributedString *)setAttributedColorWithHtml:(NSString *)html color:(UIColor *)color;

/**
 *  15.设置按钮边框颜色
 *
 *  @param R
 *  @param G
 *  @param B
 *
 *  @return 边框颜色
 */
+ (CGColorRef)getButttonBurderColorWithR:(NSInteger)R G:(NSInteger)G B:(NSInteger)B;

/**
 *  16.将格式化字符串转化为URL
 *
 *  @param string1 拼接字符串1
 *  @param string2 拼接字符串2
 *
 *  @return 拼接完的字符串并转为URL类型
 */
+ (NSURL *)getURLWithFormat:(NSString *)string1 string2:(NSString *)string2;

/**
 *  17.获取设备IP地址
 *
 *  @return 获取设备IP地址
 */
+ (NSString *)deviceIPAdress;

/**
 *  18.把时间戳转化为时间字符串
 *
 *  @param timerStr 时间字符串 或是 时间戳
 *  @param isMinute 是否 显示为 几分钟前
 *
 *  @return 显示时间字符串
 */
+ (NSString *)getTimeStringFromNumberTimer:(NSString *)timerStr isMinuteLater:(BOOL)isMinute;

/**
 *  19.根据字符串内容的多少  在固定宽度 下计算出实际的行高
 *
 *  @param text      内容
 *  @param textWidth 宽度
 *  @param size      字体大小
 *
 *  @return 高度
 */
+ (CGFloat)textHeightFromTextString:(NSString *)text width:(CGFloat)textWidth fontSize:(CGFloat)size;

/**
 *  20.获取本地文件信息   例如 json
 *
 *  @param fileName 本地文件的文件名
 *  @param type     文件后缀名 -> 例如:json
 *
 *  @return 解析完成后的数组
 */
+ (NSMutableArray *)getCityDataFileName:(NSString *)fileName type:(NSString *)type;

/**
 *  21.汉语根据拼音排序
 *
 *  @param stringsToSort 存有 汉字 的数组
 *
 *  @return 排好顺序的数组
 */
+ (NSMutableArray *)chineseSequence:(NSMutableArray *)stringsToSort;

/**
 *  22.获取iOS 版本号
 *
 *  @return iOS 系统版本号
 */
+ (NSString *)getCurrentIOS;

/**
 *  23.创建 BarButtonItem
 *
 *  @param target 目标 (self)
 *  @param sel    选择器
 *  @param tag    tag值
 *  @param name   图片的名字
 *
 *  @return nav -> buttonItem
 */
+ (UIBarButtonItem *)creatBarButtomTarget:(id)target sel:(SEL)sel tag:(NSInteger)tag image:(NSString *)name;

/**
 *  24.创建 BarButtonItemSpace
 *
 *  @param sel    选择器
 *  @param target 目标 (self)
 *  @param width  buttonItem 中间的 空间
 *
 *  @return nav -> buttonItem 中间的空间
 */
+ (UIBarButtonItem *)creatBarButtomOfSpaceSel:(SEL)sel target:(id)target width:(NSInteger)width;

/**
 *  25.正则判断手机号
 *
 *  @param str 要判断的手机号
 *
 *  @return 满足条件 返回 YES
 */
+ (BOOL)checkTel:(NSString *)str;

/**
 *  26.返回今天星期几
 *
 *  @return 显示今天星期几
 */
+ (NSInteger)weekDay;

/**
 *  27.返回今天几号
 *
 *  @return 返回今天几号
 */
+ (NSArray *)seeDay;

/**
 *  28.返回今天左右几号
 *
 *  @param dayNum 周围的几天  昨天 -> -1, 今天 -> 0, 明天 -> 1
 *
 *  @return 返回今天左右几号
 */
+ (NSArray *)seeDayAroundToday:(NSInteger)dayNum;

/**
 *  29.字典转Data
 *
 *  @param dict 传入字典
 *
 *  @return 将字典形式 转变为 data形式
 */
+(NSData*)returnDataWithDictionary:(NSDictionary*)dict;

/**
 *  30.获取设备型号
 *
 *  @return 获取设备型号 --> 如:iPhone6
 */
+ (NSString*)deviceVersion;

/**
 *  31.读取钥匙串中存取的值
 *
 *  @param key 取出数据的 key
 *
 *  @return 从钥匙串取出的数据
 */
+ (NSString *)readKeyChain:(NSString *)key;

/**
 *  32.将信息写入钥匙串
 *
 *  @param uuid value
 *  @param key  key
 */
+ (void)writeKeyChain:(NSString *)uuid key:(NSString *)key;

/**
 *  33.plist 存储地址
 *
 *  @param fileName 要存入文件的名字
 *
 *  @return 拼接成的存储路径
 */
+ (NSString*)filePath:(NSString*)fileName;

/**
 *  34.存储方法
 *
 *  @param dic   将要放入数据的字典
 *  @param key   key
 *  @param value value
 *
 *  @return 判断过 空 的字典
 */
+ (NSMutableDictionary *)saveUserInfoInDictionary:(NSMutableDictionary *)dic key:(NSString *)key value:(NSString *)value;
+ (NSMutableDictionary *)saveUserInfoIn:(NSMutableDictionary *)dic key:(NSString *)key value:(NSDictionary *)value;

/**
 *  35.判断是否为空
 *
 *  @param string 要判断是否为空的字符串
 *
 *  @return 空 -> YES
 */
+ (BOOL)isNULLOfString:(NSString *)string;
+ (NSString *)textIsNull:(NSString *)string;

/**
 *  36.将时间字符串转变为时间戳
 *
 *  @param timeStr 传入时间字符串
 *
 *  @return 时间戳
 */
+ (NSString *)getTimeStempByString:(NSString *)timeStr;

/**
 *  37.将两张图片合二为一,一般用于二维码上添加图片
 *
 *  @param image1 要添加在二维码上的图片
 *  @param image2 二维码
 *
 *  @return 合成之后的image
 */
+ (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2;

/**
 *  38.根据内容返回label的宽度
 *
 *  @param text     内容
 *  @param fontSize 字体大小
 *  @param maxSize  最大宽度
 *
 *  @return label的宽度
 */
+ (CGSize)labelAutoCalculateRectWith:(NSString*)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize;
#pragma mark ---判断网络状态
+ (NSString *)isConnectionAvailable;
+ (NSString *)getYear ;
/**
 *  浏览大图
 *
 *  @param avatarImageView 要显示的图片
 */
+(void)showImage:(UIImageView*)avatarImageView;

//时间戳转字符串
+(NSString *)zhuantimeStr:(NSInteger)inter;
#pragma  mark -- 把时间转为几小时几分钟前
+ (NSString *) compareCurrentTime:(NSString *)str;
+ (NSString *)updateTimeForRow:(NSInteger)ter ;
//时间戳转为几小时前
+(NSString *)zhuanjixiaoshiqianStr:(NSString* )inter;
+(UILabel *)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font;
+ (CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width;
+ (NSString *)notRounding:(NSDecimalNumber *)price afterPoint:(NSInteger)position;

//nsdate 转字符串
+ (NSString *)changeNsdate:(NSDate *)dateTime;
//转为yy-mm-dd
+(NSString *) dateToDateString:(NSDate *)date;
// 转为yy-mm-dd hh:mm
+(NSString *) dateToDateStringTwo:(NSDate *)date;
//1.时间格式的字符串转date
+(NSDate *)stringToDate:(NSString *)str;
//计算已月为时间差
+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(NSInteger)month;
//以星期为的时间差
+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withWeek:(NSInteger)week;
//2. JSON字符串转化为字典

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
// 字典转json字符串方法

+(NSString *)convertToJsonData:(NSDictionary *)dict;
+ (NSString *)dateWithString:(NSString *)str;
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(UIColor *)fromHexColorStr toColor:(UIColor *)toHexColorStr;
+(CGFloat)heightForRow:(NSString *)aString font:(UIFont *)font labelSize:(CGSize)labelSize;
//时间戳转字符串时间
+(NSString *)timeStampForDateStringWith:(NSString *)timeStampStr;
@end

