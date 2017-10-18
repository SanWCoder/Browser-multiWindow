//
//  SWMultiWindowCell.m
//  BrowserMultiWindow
//
//  Created by SanW on 2017/10/17.
//  Copyright © 2017年 ONONTeam. All rights reserved.
//

#import "SWMultiWindowCell.h"

@implementation SWMultiWindowCell
{
    /// 标题
    UILabel *_titleLab;
    /// 删除按钮
    UIButton *_deleteBtn;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

/**
 * 创建子控件
 */
- (void)createSubViews{
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
}
@end
