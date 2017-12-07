//
//  SWMultiWindowViewModel.m
//  BrowserMultiWindow
//
//  Created by SanW on 2017/12/7.
//  Copyright © 2017年 ONONTeam. All rights reserved.
//

#import "SWMultiWindowViewModel.h"
#import "SWNavigationController.h"
#import "PTHtmlViewController.h"
#import "SWRootViewController.h"
@implementation SWMultiWindowViewModel
/**
 * 重置navigationSubView 如果已经返回到root时再次点击清空以往打开过得VC，避免无限次累加返回后退
 @param viewController <#viewController description#>
 */
+ (void)resetNavigationSubController:(UIViewController *)viewController{
    /// 如果已经返回到root时再次点击清空以往打开过得VC，避免无限次累加返回后退
    SWNavigationController *nav = (SWNavigationController *)(viewController.navigationController);
    if (nav.currentVisibleIndex == 1) {
        NSMutableArray *mainArr = [[NSMutableArray alloc]initWithArray:@[nav.openedViewControllers.firstObject]];
        [nav.openedViewControllers removeAllObjects];
        nav.openedViewControllers = mainArr;
        nav.viewControllers = mainArr;
    }
}
/**
 * 添加保存新打开的控制器
 @param viewController 新控制器
 */
+ (void)addNewViewControllerToNavigationController:(UIViewController *)viewController{
    
    SWNavigationController *nav = (SWNavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    if (nav.currentVisibleIndex == 1 && [viewController isKindOfClass:[PTHtmlViewController class]]) {
        NSMutableArray *mainArr = [[NSMutableArray alloc]initWithArray:@[nav.openedViewControllers.firstObject]];
        [nav.openedViewControllers removeAllObjects];
        nav.openedViewControllers = mainArr;
    }
    if ([viewController isKindOfClass:[SWRootViewController class]] && nav.openedViewControllers.count) {
        viewController = nav.openedViewControllers.firstObject;
    }
    [nav.openedViewControllers addObject:viewController];
    nav.currentVisibleIndex ++;
    NSLog(@"main openVCs == %@,currentVisibleIndex == %ld",nav.openedViewControllers,(long)nav.currentVisibleIndex);
}

/**
 * 调整首页在显示栈中的位置
 @param viewController <#viewController description#>
 */
+ (void)updateNavigationViewControllers:(UIViewController *)viewController{
    SWNavigationController *nav = (SWNavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    NSMutableArray *subArr = [NSMutableArray arrayWithArray:nav.viewControllers];
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    for (UIViewController *subVc in subArr) {
        if ([subVc isKindOfClass:[SWRootViewController class]]) {
            [temp addObject:subVc];
        }
    }
    [subArr removeObjectsInArray:temp];
    [subArr addObject:nav.openedViewControllers.firstObject];
    nav.viewControllers = subArr;
}
/**
 * 返回操作
 @param viewController <#viewController description#>
 @return <#return value description#>
 */
+ (UIViewController *)popToViewController:(UIViewController *)viewController{
    SWNavigationController *nav = (SWNavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    if (nav.currentVisibleIndex - 2 < 0 ||!nav.openedViewControllers.count) {
        return nil;
    }
    NSUInteger index = nav.currentVisibleIndex - 2;
    UIViewController *vc = [nav.openedViewControllers objectAtIndex:index];
    if (!vc) {
        return nil;
    }
    /// 如果当前vc为首页vc，且Push栈中不存在则添加到前一个位置
    if (([vc isKindOfClass:[PTHtmlViewController class]]||[vc isKindOfClass:[SWRootViewController class]]) && ![nav.viewControllers containsObject:vc]){
        NSMutableArray *arr = [NSMutableArray arrayWithArray:nav.viewControllers];
        NSUInteger index = ((arr.count > 0) ? (arr.count - 1) : 0);
        [arr insertObject:vc atIndex:index];
        nav.viewControllers = arr;
    }
    nav.currentVisibleIndex --;
    return vc;
}
/**
 * 前进操作
 @param viewController <#viewController description#>
 @return <#return value description#>
 */
+ (UIViewController *)pushToViewController:(UIViewController *)viewController{
    SWNavigationController *nav = (SWNavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    NSUInteger index = nav.currentVisibleIndex;
    if (nav.currentVisibleIndex == nav.openedViewControllers.count) {
        return nil;
    }
    UIViewController *vc = [nav.openedViewControllers objectAtIndex:index];
    if (!vc) {
        return nil;
    }
    /// 如果当前栈里已存在则先移除，重新赋值
    if ([nav.viewControllers containsObject:vc]) {
        NSMutableArray *arr = [NSMutableArray arrayWithArray:nav.viewControllers];
        [arr removeObject:vc];
        nav.viewControllers = arr;
    }
    nav.currentVisibleIndex ++;
    return vc;
}
@end
