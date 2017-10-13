//
//  SWRootViewController.m
//  BrowserMultiWindow
//
//  Created by SanW on 2017/10/12.
//  Copyright © 2017年 ONONTeam. All rights reserved.
//

#import "SWRootViewController.h"
#import "SWOprateView.h"
#import "AppDelegate.h"
#import "SWConfig.h"
#import "PTHtmlViewController.h"
@interface SWRootViewController ()<UIGestureRecognizerDelegate,UIWebViewDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak) UIWebView *webView;
/**
 *  tableView
 */
@property (nonatomic,weak) UITableView *tableView;
/**
 * 数据源
 */
@property (nonatomic,strong) NSMutableArray *homeData;
@end

@implementation SWRootViewController
/**
 *  懒加载数据源
 *
 *  @return <#return value description#>
 */
- (NSMutableArray *)homeData
{
    if (!_homeData) {
        _homeData = [[NSMutableArray alloc]init];
        for (int i = 0; i < 20; i ++) {
            [_homeData addObject:@"测试数据"];
        }
    }
    return _homeData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"BrowserMultiWindow";
    self.view.backgroundColor = [UIColor darkGrayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    /// 添加子视图
    [self addSubViews];
}
/**
 * 添加子控件
 */
- (void)addSubViews{
    NSArray *image = @[@"home",@"news",@"shop",@"read",@"application"];
    CGFloat width = KWidth / image.count;
    CGFloat height = 50;
    for (int i = 0; i < image.count ; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:image[i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i + 1;
        btn.backgroundColor = [UIColor whiteColor];
        btn.frame = CGRectMake(width * i,kNavHeight, width, height * 2);
        [self.view addSubview:btn];
    }
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavHeight + height * 2, KWidth, KHeight - (kNavHeight + height * 2) - kNomalHeight) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
//    tableView.backgroundColor = kBacColor;
    [self.view addSubview:tableView];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    
    SWOprateView *oprateView = [[SWOprateView alloc]initWithFrame:CGRectMake(0, KHeight - kNomalHeight, KWidth, kNomalHeight)];
    oprateView.OprateBlock = ^(UIButton *sender) {
        kWeakSelf(weakSelf)
        [weakSelf oprateClick:sender];
    };
    [self.view addSubview:oprateView];
}
/**
 * 按钮的点击方法
 @param sender <#sender description#>
 */
- (void)btnClick:(UIButton *)sender{
    
}
/**
 * 点击手势操作方法
 */
- (void)tagGes{
//    self.webView.frame = CGRectMake(0, kNavHeight, self.view.frame.size.width, self.view.frame.size.height - kNavHeight - kNomalHeight);
//    self.webView.userInteractionEnabled = YES;
}

/**
 * 按钮的操作
 @param sender <#sender description#>
 */
- (void)oprateClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
        {
            AppDelegate *deleg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [UIApplication sharedApplication].keyWindow.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[SWRootViewController alloc]init]];
            [deleg.multiWindows addObject:[[UINavigationController alloc]initWithRootViewController:[[SWRootViewController alloc]init]]];
            NSLog(@"=== %@",deleg.multiWindows);
        }
            break;
        case 5:
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
        default:
            break;
    }
}
// 允许多个手势并发
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.homeData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return  0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.homeData[indexPath.row];
    return cell;
}
@end
