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

@end
