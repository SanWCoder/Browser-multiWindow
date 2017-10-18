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
    self.image = image;
    self.window = window;
    return self;
}
@end
