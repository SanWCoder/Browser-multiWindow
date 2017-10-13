//
//  PTRemindView.m
//  PourOutAllTheWay
//
//  Created by SanW on 2016/11/29.
//  Copyright © 2016年 ONON. All rights reserved.
//

#import "PTRemindView.h"
#import "SDAutoLayout.h"
@interface PTRemindView ()
/**
 *  提示图片
 */
@property (nonatomic,weak) UIImageView *remindImage;
/**
 *  提示信息
 */
@property (nonatomic,weak) UILabel *remindLab;
/**
 *  刷新
 */
@property (nonatomic,weak) UIButton *refreshBtn;
@end

@implementation PTRemindView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 创建子控件
        [self createSubView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)setRemindData:(NSArray *)remindData
{
    _remindData = remindData;
    // 赋值
    [self addData];
    // 给子控件设置大小
    [self addLayout];
}
/**
 *  创建子控件
 */
- (void)createSubView{
    UIImageView *remindImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    self.remindImage = remindImage;
    [self addSubview:remindImage];
    
    UILabel *remindLab = [[UILabel alloc]init];
    remindLab.font = [UIFont systemFontOfSize:17];
    remindLab.textColor = [UIColor blackColor];
    self.remindLab = remindLab;
    [self addSubview:remindLab];
    
    UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [refreshBtn setTitle:@"刷新试试" forState:UIControlStateNormal];
    [refreshBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [refreshBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [refreshBtn addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
    refreshBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    self.refreshBtn = refreshBtn;
    [self addSubview:refreshBtn];
}
/**
 *  赋值
 */
- (void)addData{
    self.remindImage.image = [UIImage imageNamed:self.remindData[0]];
    self.remindLab.text = self.remindData[1];
    if (self.remindData.count>3) {
        [self.refreshBtn setTitle:self.remindData[3] forState:UIControlStateNormal];
    }
}
/**
 *  给子控件布局
 */
- (void)addLayout{
    CGFloat topH = 100 ;
    CGFloat margin = 40 ;
    CGFloat imageW = 246.0 / 2 ;
    CGFloat imageH = imageW * 208.0 / 246.0;
    CGFloat btnH = 34 ;
    
    self.remindImage.sd_layout
    .centerXEqualToView(self)
    .topSpaceToView(self,topH)
    .widthIs(imageW)
    .heightIs(imageH);
    
    self.remindLab.sd_layout
    .topSpaceToView(self.remindImage,margin)
    .leftSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .heightIs(40);
    if (self.remindData.count < 3) {
        self.refreshBtn.sd_resetNewLayout.heightIs(0).widthIs(0);
    }
    else {
        NSNumber *isNotNet = self.remindData[2];
        if (!isNotNet) {
            self.refreshBtn.sd_resetNewLayout.heightIs(0).widthIs(0);
        }
        else
        {
            if ([isNotNet isEqualToNumber:@0]) {
                self.refreshBtn.sd_resetNewLayout
                .topSpaceToView(self.remindLab,margin/2)
                .centerXEqualToView(self)
                .heightIs(btnH)
                .widthIs(topH + 30);
            }
            else
            {
                self.refreshBtn.sd_resetNewLayout.heightIs(0).widthIs(0);
            }
        }
    }
    self.refreshBtn.layer.borderWidth = 1;
    self.refreshBtn.layer.borderColor = [UIColor redColor].CGColor;
    self.refreshBtn.layer.cornerRadius = 6;
    self.refreshBtn.layer.masksToBounds = YES;
}
- (void)refresh:(UIButton *)sender{
    if (_RefreshBlock) {
        _RefreshBlock(self);
    }
}
@end
