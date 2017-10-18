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
#import "SWMultiWindowsController.h"
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
{
    UIButton *_button;
    /// 如果需要创建新窗口，新window须做为当前控制器的属性或者成员变量时才能显示
    UIWindow *_window;
}
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
            [_homeData addObject:[NSString stringWithFormat:@"测试数据--%d",i]];
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
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavHeight + height * 2, KWidth, KHeight - (kNavHeight + height * 2) - kNomalHeight) style:UITableViewStylePlain]; // UITableViewStyleGrouped会在头上部添加空白大体30左右
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
//    tableView.backgroundColor = kBacColor;
    [self.view addSubview:tableView];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = NO;
    } else {
        // Fallback on earlier versions
    }
    tableView.showsVerticalScrollIndicator = NO;
    
    SWOprateView *oprateView = [[SWOprateView alloc]initWithFrame:CGRectMake(0, KHeight - kNomalHeight, KWidth, kNomalHeight)];
    
    oprateView.dataArray = @[@"top",@"down",@"more",@"windows",@"homePage"];
    oprateView.OprateBlock = ^(UIButton *sender) {
        kWeakSelf(weakSelf)
        [weakSelf oprateClick:sender];
    };
    [self.view addSubview:oprateView];
//    [self createSuspendButton];
}
- (void)createSuspendButton
{
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setTitle:@"悬浮按钮" forState:UIControlStateNormal];
    _button.frame = CGRectMake(0, 0, 80, 80);
    [_button addTarget:self action:@selector(closeWindow) forControlEvents:UIControlEventTouchUpInside];
    
    _window = [[UIWindow alloc]initWithFrame:CGRectMake(100, 200, 80, 80)];
    _window.windowLevel = UIWindowLevelAlert + 1;
    _window.backgroundColor = [UIColor redColor];
    _window.layer.cornerRadius = 40;
    _window.layer.masksToBounds = YES;
    [_window addSubview:_button];
    [_window makeKeyAndVisible];//关键语句,显示window
}
/**
 * 按钮的点击方法
 @param sender <#sender description#>
 */
- (void)btnClick:(UIButton *)sender{
    
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
            SWMultiWindowsController *vc = [[SWMultiWindowsController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
        default:
            break;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.homeData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.homeData[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PTHtmlViewController *html = [[PTHtmlViewController alloc]init];
   // html.str = @"http://www.hunliji.com/";
    html.str = @"https://www.baidu.com/";
    [self.navigationController pushViewController:html animated:YES];
}
@end
