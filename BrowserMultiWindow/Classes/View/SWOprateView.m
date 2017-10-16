//
//  SWOprateView.m
//  BrowserMultiWindow
//
//  Created by SanW on 2017/10/12.
//  Copyright © 2017年 ONONTeam. All rights reserved.
//

#import "SWOprateView.h"

@implementation SWOprateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}
- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self createSubView];
}
- (void)createSubView{
    for (int i = 0; i < self.dataArray.count ; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:self.dataArray[i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i + 1;
        [self addSubview:btn];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width / self.subviews.count;
    
    for (int i = 0; i < self.subviews.count ; i ++) {
      self.subviews[i].frame = CGRectMake(width * i, 0, width, self.frame.size.height);
    }
}
- (void)btnClick:(UIButton *)sender{
    if (_OprateBlock) {
        _OprateBlock(sender);
    }
}
@end
