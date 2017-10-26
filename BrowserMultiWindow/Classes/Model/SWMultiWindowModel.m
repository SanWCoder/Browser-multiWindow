//
//  SWMultiWindowModel.m
//  BrowserMultiWindow
//
//  Created by SanW on 2017/10/18.
//  Copyright © 2017年 ONONTeam. All rights reserved.
//

#import "SWMultiWindowModel.h"

@implementation SWMultiWindowModel
- (instancetype)initWithImage:(UIImage *)image window:(UIWindow *)window{
    SWMultiWindowModel *multiWindow = [[SWMultiWindowModel alloc]init];
    multiWindow.image = image;
    multiWindow.window = window;
    return multiWindow;
}
@end
