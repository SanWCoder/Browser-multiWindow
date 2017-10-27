//
//  SWMultiWindowsController.m
//  BrowserMultiWindow
//
//  Created by SanW on 2017/10/13.
//  Copyright © 2017年 ONONTeam. All rights reserved.
//

#import "SWMultiWindowsController.h"
#import "SWConfig.h"
#import "SWOprateView.h"
#import "SWRootViewController.h"
#import "SWMultiWindowCell.h"
#import "SWMultiWindowFlowlayout.h"
#import "SWNavigationController.h"
#import "PTHtmlViewController.h"
@interface SWMultiWindowsController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
/// 数据源
@property (nonatomic,strong) NSMutableArray *baseProductsData;
/// collectView
@property (nonatomic,weak) UICollectionView *collectView;
/// 如果需要创建新窗口，新window须做为当前控制器的属性或者成员变量时才能显示 且为strong强引用
@property (strong, nonatomic) UIWindow *window;

@end

@implementation SWMultiWindowsController
{
    SWMultiWindowFlowlayout *_flowOut;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (UIImage *)convertViewToImage:(UIView *)view
{
UIGraphicsBeginImageContextWithOptions(CGSizeMake(view.bounds.size.width, view.bounds.size.height - kNavHeight),YES,[UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (NSMutableArray *)baseProductsData
{
    if (!_baseProductsData) {
        _baseProductsData = [[NSMutableArray alloc]init];
        for (UIWindow *windwow in [UIApplication sharedApplication].windows) {
            if (windwow && !windwow.isHidden && windwow.class == [UIWindow class]) {
                UINavigationController *nav = (UINavigationController *)windwow.rootViewController;
                NSLog(@"加载---window === %@,isKey == %d,nav == %@,visibale == %@,top == %@",windwow,windwow.isKeyWindow,nav,nav.visibleViewController,nav.topViewController);
                UIViewController *vc = windwow.isKeyWindow ? nav.viewControllers[nav.viewControllers.count - 2] : nav.visibleViewController ? nav.visibleViewController :nav.topViewController;
                NSString *title = @"首页";
                NSString *icon = @"net";
                if ([vc isKindOfClass:[SWRootViewController class]]) {
                    title = @"首页";
                }
                else if([vc isKindOfClass:[PTHtmlViewController class]]){
                    title = ((PTHtmlViewController *)vc).webTitle;
                    icon = [[((PTHtmlViewController *)vc).webView.request.URL.absoluteString componentsSeparatedByString:@"com"].firstObject stringByAppendingString:@"com/favicon.ico"];
                }
                SWMultiWindowModel *multiWindow = [[SWMultiWindowModel alloc]initWithImage:[self convertViewToImage:windwow] title:title icon:icon window:windwow];
                [_baseProductsData addObject:multiWindow];
            }
        }
    }
    return _baseProductsData;
}
- (UICollectionView *)collectView{
    if (!_collectView) {
        _flowOut = [[SWMultiWindowFlowlayout alloc]init];
        _flowOut.multiWindowCount = self.baseProductsData.count;
        UICollectionView *collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KWidth, KHeight - kNomalHeight) collectionViewLayout:_flowOut];
        collectView.alwaysBounceVertical = YES;
        _collectView = collectView;
        // 注册cell
        [collectView registerClass:[SWMultiWindowCell class] forCellWithReuseIdentifier:NSStringFromClass([SWMultiWindowCell class])];
        collectView.delegate = self;
        collectView.dataSource = self;
        [self.view addSubview:collectView];
    }
    return _collectView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectView.backgroundColor = [UIColor grayColor];
    self.view.backgroundColor = [UIColor grayColor];
    SWOprateView *oprateView = [[SWOprateView alloc]initWithFrame:CGRectMake(0, KHeight - kNomalHeight, KWidth, kNomalHeight)];
    oprateView.dataArray = @[@"add",@"return"];
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
        case 1:
        {
            [self.navigationController popViewControllerAnimated:YES];
            // 创建新window
            [self createWindow];
        }
            break;
        case 2:
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        default:
            break;
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"numberOfItemsInSection == %@",self.baseProductsData);
    return self.baseProductsData.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"sizeForItemAtIndexPath == %@",self.baseProductsData);
    return CGSizeMake(KWidth - 20, KHeight - 150);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForItemAtIndexPath == %@",self.baseProductsData);
    SWMultiWindowCell *cell = [SWMultiWindowCell cellWithCollectionView:collectionView indexPath:indexPath];
    cell.multiWindow = _baseProductsData[indexPath.item];
    NSLog(@"indexPath == %@",indexPath);
    cell.MultiWindowBlcok = ^(UIButton *sender, SWMultiWindowModel *multiWindow) {
        /// 当删除的为最后一个window时先创建新window再删除
        if (_baseProductsData.count < 2) {
            [self createWindow];
        }
        [multiWindow.window resignKeyWindow];
        ((SWNavigationController *)(multiWindow.window.rootViewController)).openedViewControllers = nil;
        ((SWNavigationController *)(multiWindow.window.rootViewController)).viewControllers = [[NSArray alloc]init];

        multiWindow.window.rootViewController = nil;
        [multiWindow.window removeFromSuperview];
        multiWindow.window.hidden = YES;
        multiWindow.window = nil;
        
        [_baseProductsData removeObject:multiWindow];
        __weak typeof(self)weakSelf = self;
        [weakSelf.collectView performBatchUpdates:^{
            [weakSelf.collectView deleteItemsAtIndexPaths:@[indexPath]];
            _flowOut.multiWindowCount = _baseProductsData.count;
            collectionView.collectionViewLayout = _flowOut;
            
        } completion:^(BOOL finished) {
            [weakSelf.collectView reloadData];
        }];
    };
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"现有---window === %@,nav == %@",[UIApplication sharedApplication].keyWindow,[[UIApplication sharedApplication].keyWindow rootViewController]);
    [[UIApplication sharedApplication].keyWindow resignKeyWindow];
    
    SWMultiWindowModel *multiWindow = _baseProductsData[indexPath.item];
    [multiWindow.window makeKeyAndVisible];
    NSLog(@"点击---window === %@,nav == %@",multiWindow.window,[multiWindow.window rootViewController]);
    NSLog(@"点击后---window === %@,nav == %@",[UIApplication sharedApplication].keyWindow,[[UIApplication sharedApplication].keyWindow rootViewController]);
}
- (void)dealloc{
    NSLog(@"SWRootViewController被销毁");
}
/**
 * 创建新window
 */
- (void)createWindow{
    if (self.window) {
        [self.window removeFromSuperview];
    }
    [[UIApplication sharedApplication].keyWindow resignKeyWindow];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor redColor];
    self.window.windowLevel = UIWindowLevelStatusBar;
    self.window.rootViewController = [[SWNavigationController alloc]initWithRootViewController:[[SWRootViewController alloc]init]];
    [self.window makeKeyAndVisible];
}
@end
