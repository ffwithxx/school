//
//  AppDelegate.m
//  Teacher
//
//  Created by 冯丽 on 2017/12/18.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftViewController.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "MainPageViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UIViewController alloc]init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tiaoLogin) name: @"tLogin" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tiaoMain) name: @"Main" object: nil];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *logVC =[storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:logVC];
    self.window.rootViewController = loginNav;
    
    
    
    return YES;
    
    
}
#pragma mark --- 跳转到主页面
- (void)tiaoMain {
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    MainViewController *mainVC = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
//    self.mainNavigationController = [[UINavigationController alloc] initWithRootViewController:mainVC];
//    LeftViewController *leftVC = [storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
//    self.LeftSlideVC = [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:self.mainNavigationController];
//    self.window.rootViewController = self.LeftSlideVC;
    NSDictionary *option = @{UIPageViewControllerOptionSpineLocationKey:@(UIPageViewControllerSpineLocationMin)};
    MainPageViewController *mainPageController = [[MainPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:option];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mainPageController];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    self.mainNavigationController = [[UINavigationController alloc] initWithRootViewController:mainPageController];
    LeftViewController *leftVC = [storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
    self.LeftSlideVC = [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:self.mainNavigationController];
    self.window.rootViewController = self.LeftSlideVC;
}
#pragma  mark --- 调到登录页面
-(void)tiaoLogin {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *logVC =[storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:logVC];
    self.window.rootViewController = loginNav;
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    NSLog(@"url  %@",[url absoluteString]);
    
    if ([[url absoluteString] containsString:@"file"]) {
        NSArray *array = [[url absoluteString] componentsSeparatedByString:@"/"];
        NSString *fileName = [array lastObject];
        fileName = [fileName stringByRemovingPercentEncoding];
        
        NSString *path = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/Inbox/%@",fileName]];
        
        NSData *data = [NSData dataWithContentsOfFile:path];
    }
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
