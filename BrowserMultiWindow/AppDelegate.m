//
//  AppDelegate.m
//  BrowserMultiWindow
//
//  Created by SanW on 2017/10/12.
//  Copyright © 2017年 ONONTeam. All rights reserved.
//

#import "AppDelegate.h"
#import "SWRootViewController.h"
#import "SWWindow.h"
@interface AppDelegate ()
/// 如果需要创建新窗口，新window须做为当前控制器的属性或者成员变量时才能显示 且为strong强引用
@property (strong, nonatomic) SWWindow *firstWindow;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[SWNavigationController alloc]initWithRootViewController:[[SWRootViewController alloc]init]];
    [self.window resignKeyWindow];
    self.window.hidden = YES;
    self.window.rootViewController = nil;
    
    self.firstWindow = [[SWWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.firstWindow.windowLevel = UIWindowLevelNormal;
    self.firstWindow.rootViewController = [[SWNavigationController alloc]initWithRootViewController:[[SWRootViewController alloc] init]];
    [self.firstWindow makeKeyAndVisible];
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
