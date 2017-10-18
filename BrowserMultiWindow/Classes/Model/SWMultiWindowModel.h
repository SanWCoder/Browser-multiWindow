//
//  SWMultiWindowModel.h
//  BrowserMultiWindow
//
//  Created by SanW on 2017/10/18.
//  Copyright © 2017年 ONONTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SWMultiWindowModel : NSObject
/** 标题 **/
@property (nonatomic,copy) NSString *title;
/** 图片 **/
@property (nonatomic,strong) UIImage *image;
/** 窗口 **/
@property (nonatomic,strong) UIWindow *window;

- (instancetype)initWithImage:(UIImage *)image window:(UIWindow *)window;
@end
