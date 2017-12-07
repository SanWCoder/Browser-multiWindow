//
//  SWMultiWindowCell.m
//  BrowserMultiWindow
//
//  Created by SanW on 2017/10/17.
//  Copyright © 2017年 ONONTeam. All rights reserved.
//

#import "SWMultiWindowCell.h"
#import <SDAutoLayout.h>
#import "UIButton+WebCache.h"
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

/**
 * 快速创建cell
 @param collectionView <#collectionView description#>
 @param indexPath <#indexPath description#>
 @return <#return value description#>
 */
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath{
    SWMultiWindowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
    return cell;
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
    [_deleteBtn setImage:[UIImage imageNamed:@"window_delete"] forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
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
    [_titleBtn setTitle:self.multiWindow.title.length ? self.multiWindow.title : @"首页" forState:UIControlStateNormal];
    [_titleBtn sd_setImageWithURL:[NSURL URLWithString:self.multiWindow.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"net"]];
    _titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _imageView.image = self.multiWindow.image;
}
// 布局
- (void)addLayout{
    _deleteBtn.sd_layout
    .topSpaceToView(self, 0)
    .rightSpaceToView(self, 0)
    .widthIs(60)
    .heightIs(40);
    
    _titleBtn.sd_layout
    .topSpaceToView(self, 0)
    .leftSpaceToView(self, 0)
    .rightSpaceToView(_deleteBtn, 30)
    .heightIs(40);
    _titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    _titleBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);

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
- (void)handleSwipeFrom:(UIPanGestureRecognizer *)recognizer{
//    CGPoint translation = [recognizer translationInView:self];
//    [recognizer setCancelsTouchesInView:translation.y != 0 ? YES : NO];
//    CGPoint velocity = [recognizer velocityInView:self];
//    NSLog(@"translation == %@,velocity == %@",NSStringFromCGPoint(translation),NSStringFromCGPoint(velocity));
//    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
//                                  recognizer.view.center.y);
//    [recognizer setTranslation:CGPointZero inView:self];
//    if (fabs(velocity.x) > 4000 && self.MultiWindowBlcok) {
//        self.MultiWindowBlcok(nil, self.multiWindow);
//    }
}
- (void)btnClick:(UIButton *)sender{
    if (self.MultiWindowBlcok) {
        self.MultiWindowBlcok(sender, self.multiWindow);
    }
}
@end
