//
//  AppDelegate.m
//  SuiYiWan
//
//  Created by 刘军 on 16/10/15.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "AppDelegate.h"
#import "JGAdVC.h"
#import <SDImageCache.h>
//#import "JGStatusWindow.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //创建window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds] ;
    
    //设置根控制器
//    JGTabBarController *tabBarC = [[JGTabBarController alloc] init] ;
    JGAdVC *adVC = [[JGAdVC alloc] init] ;
    self.window.rootViewController = adVC ;
    
    //设置为主窗口并显示
    [self.window makeKeyAndVisible] ;
    
    //创建一个状态栏窗口到应用程序，可点击让tableView回到顶部
//    [JGStatusWindow show] ;
    
    [UIApplication sharedApplication].statusBarHidden = NO ;
    return YES;
}
//发生内存警告时调用
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    //1、清除缓存
    [[SDImageCache sharedImageCache] clearMemory] ;
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
