//
//  SWOprateView.h
//  BrowserMultiWindow
//
//  Created by SanW on 2017/10/12.
//  Copyright © 2017年 ONONTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWOprateView : UIView

@property (nonatomic,copy) void(^OprateBlock)(UIButton *sender);
/// 创建数据
@property (nonatomic,strong) NSArray *dataArray;
/**
 * 更新按钮状态
 @param viewController <#viewController description#>
 */
- (void)subViewStatus:(UIViewController *)viewController sender:(UIButton *)sedner;
@end
