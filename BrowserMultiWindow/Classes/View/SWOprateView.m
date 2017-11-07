//
//  SWOprateView.m
//  BrowserMultiWindow
//
//  Created by SanW on 2017/10/12.
//  Copyright © 2017年 ONONTeam. All rights reserved.
//

#import "SWOprateView.h"
#import "SWNavigationController.h"
#import "PTHtmlViewController.h"
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
/**
 * 更新按钮状态
 @param viewController <#viewController description#>
 */
- (void)subViewStatus:(UIViewController *)viewController sender:(UIButton *)sedner{
    if(self.dataArray.count < 3){
        return;
    }
    NSUInteger index = [viewController.navigationController.viewControllers indexOfObject:viewController];
    NSLog(@"class == %@,NGWebViewControllerView == %@,eque == %d",viewController.class,[PTHtmlViewController class],[viewController isKindOfClass:[PTHtmlViewController class]]);
    for (UIButton *subView in self.subviews) {
        if ((index == 0 && subView.tag == 1)) {
            ([viewController isKindOfClass:[PTHtmlViewController class]] && ((PTHtmlViewController *)viewController).webView.canGoBack) ?[subView setEnabled:YES] : [subView setEnabled:NO];
        }
        else if((index == ((SWNavigationController *)viewController.navigationController).openedViewControllers.count - 1) && subView.tag == 2){
            ([viewController isKindOfClass:[PTHtmlViewController class]] && ((PTHtmlViewController *)viewController).webView.canGoForward) ? [subView setEnabled:YES] : [subView setEnabled:NO];
        }
        else{
            [subView setEnabled:YES];
        }
    }
}
@end
