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
        [self createSubView];
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}
- (void)createSubView{
    NSArray *image = @[@"top",@"down",@"more",@"windows",@"homePage"];
    CGFloat width = self.frame.size.width / image.count;
    for (int i = 0; i < image.count ; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:image[i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i + 1;
        btn.frame = CGRectMake(width * i, 0, width, self.frame.size.height);
        [self addSubview:btn];
    }
}
- (void)btnClick:(UIButton *)sender{
    if (_OprateBlock) {
        _OprateBlock(sender);
    }
}
@end
