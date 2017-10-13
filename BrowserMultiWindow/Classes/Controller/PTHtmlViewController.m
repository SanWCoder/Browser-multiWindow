//
//  PTHtmlViewController.m
//  PourOutAllTheWay
//
//  Created by SanW on 2016/12/20.
//  Copyright © 2016年 ONON. All rights reserved.
//

#import "PTHtmlViewController.h"
#import "PTRemindView.h"
#import "SWConfig.h"
@interface PTHtmlViewController ()<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView * webView;

// 提示试图
@property (nonatomic,weak) PTRemindView *remidView;
@end

@implementation PTHtmlViewController

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, kNavHeight, KWidth, KHeight - kNavHeight)];
        
        _webView.delegate = self;
        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
    }
    return _webView;
}
- (PTRemindView *)remidView
{
    kWeakSelf(weakSelf);
    if (!_remidView) {
        PTRemindView *remidView = [[PTRemindView alloc]initWithFrame:CGRectMake(0,kNavHeight, self.view.frame.size.width, self.view.frame.size.height - kNavHeight)];
        self.remidView = remidView;
        [self.view addSubview:remidView];
        
        remidView.hidden = YES;
        remidView.remindData = @[@"no_network",@"呀、好像没网了！",@0];
        remidView.RefreshBlock = ^(PTRemindView *remindView){
            // 请求数据
            NSURL *url = [NSURL URLWithString:self.str];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [weakSelf.webView loadRequest:request];
            remindView.hidden = YES;
        };
    }
    return _remidView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 1. URL 定位资源,需要资源的地址
    // NSString * str = @"http://static.16qs.com/app/pages/wailing-wall.html";
    NSString *urlStr = self.str;
    if (![self.str hasPrefix:@"http://"]) {
        urlStr = [NSString stringWithFormat:@"http://m.baidu.com/s?word=%@", self.str];
    }
    NSURL *url = [NSURL URLWithString:urlStr];
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 3. 发送请求给服务器
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.remidView.hidden = NO;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    if (_remidView) {
        _remidView.hidden = YES;
    }
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        PTHtmlViewController *html = [[PTHtmlViewController alloc]init];
        html.str = request.URL.absoluteString;
        [self.navigationController pushViewController:html animated:YES];
    }
    return YES;
}
/**
 * 点击手势操作方法
 */
- (void)tagGes{
    //    self.webView.frame = CGRectMake(0, kNavHeight, self.view.frame.size.width, self.view.frame.size.height - kNavHeight - kNomalHeight);
    //    self.webView.userInteractionEnabled = YES;
}
// 允许多个手势并发
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
