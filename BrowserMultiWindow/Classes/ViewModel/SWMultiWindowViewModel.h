//
//  SWMultiWindowViewModel.h
//  BrowserMultiWindow
//
//  Created by SanW on 2017/12/7.
//  Copyright © 2017年 ONONTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SWMultiWindowViewModel : NSObject
/**
 * 重置navigationSubView 如果已经返回到root时再次点击清空以往打开过得VC，避免无限次累加返回后退
 @param viewController <#viewController description#>
 */
+ (void)resetNavigationSubController:(UIViewController *)viewController;

/**
 * 添加保存新打开的控制器
 @param viewController 新控制器
 */
+ (void)addNewViewControllerToNavigationController:(UIViewController *)viewController;
/**
 * 调整首页在显示栈中的位置
 @param viewController <#viewController description#>
 */
+ (void)updateNavigationViewControllers:(UIViewController *)viewController;
/**
 * 返回操作
 @param viewController <#viewController description#>
 @return <#return value description#>
 */
+ (UIViewController *)popToViewController:(UIViewController *)viewController;
/**
 * 前进操作
 @param viewController <#viewController description#>
 @return <#return value description#>
 */
+ (UIViewController *)pushToViewController:(UIViewController *)viewController;
@end
