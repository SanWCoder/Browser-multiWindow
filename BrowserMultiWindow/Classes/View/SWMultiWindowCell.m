//
//  SWMultiWindowCell.m
//  BrowserMultiWindow
//
//  Created by SanW on 2017/10/17.
//  Copyright © 2017年 ONONTeam. All rights reserved.
//

#import "SWMultiWindowCell.h"
#import <SDAutoLayout.h>
@implementation SWMultiWindowCell
{
    /// 标题
    UIButton *_titleBtn;
    /// 删除按钮
    UIButton *_deleteBtn;
    /// 分割线
    UIView *_lineView;
    /// 背景图
    UIImageView *_imageView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

/**
 * 创建子控件
 */
- (void)createSubViews{
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    
    _titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _titleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = [UIColor grayColor];
    
    _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"baidu"]];
    [self sd_addSubviews:@[_titleBtn,_deleteBtn,_lineView,_imageView]];
}
- (void)setMultiWindow:(SWMultiWindowModel *)multiWindow{
    _multiWindow = multiWindow;
    // 赋值
    [self addData];
    // 布局
    [self addLayout];
}
// 赋值
- (void)addData{
    [_titleBtn setTitle:@"首页" forState:UIControlStateNormal];
    _imageView.image = self.multiWindow.image;
}
// 布局
- (void)addLayout{
    _titleBtn.sd_layout
    .topSpaceToView(self, 0)
    .leftSpaceToView(self, 0)
    .widthIs(60)
    .heightIs(40);
    
    _deleteBtn.sd_layout
    .topSpaceToView(self, 0)
    .rightSpaceToView(self, 0)
    .widthIs(60)
    .heightIs(40);
    _lineView.sd_layout
    .leftSpaceToView(self, 0)
    .rightSpaceToView(self, 0)
    .topSpaceToView(_titleBtn, 0)
    .heightIs(1);
    
    _imageView.sd_layout
    .topSpaceToView(_lineView, 0)
    .rightSpaceToView(self, 0)
    .leftSpaceToView(self, 0)
    .bottomSpaceToView(self, 0);
    
    self.layer.cornerRadius = 6;
    self.layer.masksToBounds = YES;
}
@end
