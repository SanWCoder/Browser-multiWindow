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
#import "SWOprateView.h"
#import "AppDelegate.h"
#import "SWMultiWindowsController.h"
#import "SWRootViewController.h"

@interface PTHtmlViewController ()<UIWebViewDelegate,WKNavigationDelegate,WKUIDelegate>



@property (nonatomic,strong) SWRootViewController *rootVC;

// 提示试图
@property (nonatomic,weak) PTRemindView *remidView;
/// 操作视图
@property (nonatomic,weak) SWOprateView *oprateView;
@end

@implementation PTHtmlViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    /// 更新按钮状态
    [self.oprateView subViewStatus:self sender:nil];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight  - kNomalHeight)];
//        _webView.delegate = self;
//        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        // iOS 11以后，设置不自动偏移使用（self.automaticallyAdjustsScrollViewInsets = NO;）
        if (@available(iOS 11.0, *)) {
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
    }
    return _webView;
}
- (PTRemindView *)remidView
{
    kWeakSelf(weakSelf);
    if (!_remidView) {
        PTRemindView *remidView = [[PTRemindView alloc]initWithFrame:CGRectMake(0,0, KWidth, KHeight)];
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
    self.rootVC = [[SWRootViewController alloc]init];
    [((SWNavigationController *)self.navigationController).openedViewControllers addObject:self];
    // iOS 11以后，设置不自动偏移使用（scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever）
    if (@available(*,iOS 11.0)) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
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
    
    SWOprateView *oprateView = [[SWOprateView alloc]initWithFrame:CGRectMake(0, KHeight - kNomalHeight, KWidth, kNomalHeight)];
    self.oprateView = oprateView;
    oprateView.dataArray = @[@"top",@"down",@"more",@"windows",@"homePage"];
    oprateView.OprateBlock = ^(UIButton *sender) {
        kWeakSelf(weakSelf)
        [weakSelf oprateClick:sender];
    };
    [self.view addSubview:oprateView];
}
/**
 * 按钮的操作
 @param sender <#sender description#>
 */
- (void)oprateClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1:{
            self.webView.canGoBack ? [self.webView goBack] : [self.navigationController popViewControllerAnimated:YES];
            /// 更新按钮状态
            [self.oprateView subViewStatus:self sender:nil];
        }

            break;
        case 2:
            if (self.webView.canGoForward) {
                [self.webView goForward];
            }else{
                NSUInteger index = [self.navigationController.viewControllers indexOfObject:self];
                if (index < ((SWNavigationController *)self.navigationController).openedViewControllers.count - 1) {
                    [self.navigationController pushViewController:((SWNavigationController *)self.navigationController).openedViewControllers[index + 1] animated:YES];
                }
                /// 更新按钮状态
                [self.oprateView subViewStatus:self sender:nil];
            }
            break;
        case 3:
            
            break;
        case 4:
        {
            SWMultiWindowsController *vc = [[SWMultiWindowsController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {
            [self.navigationController pushViewController:[[SWRootViewController alloc]init] animated:YES];
        }
            break;
        default:
            break;
    }
}
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    /// 更新按钮状态
    [self.oprateView subViewStatus:self sender:nil];
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    self.webTitle = webView.title;
//   self.webTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{

    
}
/**
 * 点击手势操作方法
 */
- (void)tagGes{
    // self.webView.frame = CGRectMake(0, kNavHeight, self.view.frame.size.width, self.view.frame.size.height - kNavHeight - kNomalHeight);
    // self.webView.userInteractionEnabled = YES;
}
// 允许多个手势并发
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
