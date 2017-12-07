//
//  SWNavigationController.h
//  BrowserMultiWindow
//
//  Created by SanW on 2017/10/27.
//  Copyright © 2017年 ONONTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWNavigationController : UINavigationController
/// 打开过的控制器集合
@property (nonatomic,strong) NSMutableArray *openedViewControllers;
/// 当前可见的控制器的位置
@property (nonatomic,assign) NSInteger currentVisibleIndex;
@end
