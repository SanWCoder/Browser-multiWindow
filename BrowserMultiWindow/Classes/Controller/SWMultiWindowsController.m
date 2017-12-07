//
//  SWMultiWindowsController.m
//  Navigation
//
//  Created by SanW on 2017/10/12.
//  Copyright © 2017年 ONONTeam. All rights reserved.
//

#import "SWMultiWindowsController.h"
#import "SWMultiWindowModel.h"
#import "SWMultiWindowFlowlayout.h"
#import "SWMultiWindowCell.h"
#import "SWOprateView.h"
#import "SWConfig.h"
#import "SWWindow.h"
#import "SWRootViewController.h"
#import "SWNavigationController.h"
#import "PTHtmlViewController.h"

#define kMultiBgColor [UIColor colorWithRed:10.0 / 255.0 green:54.0 / 255.0 blue:69.0 / 255.0 alpha:1]
@interface SWMultiWindowsController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,SWMultiWindowFlowlayoutDelegate,UIGestureRecognizerDelegate>
/// 数据源
@property (nonatomic,strong) NSMutableArray *baseProductsData;
/// collectView
@property (nonatomic,weak) UICollectionView *collectView;
/// 如果需要创建新窗口，新window须做为当前控制器的属性或者成员变量时才能显示 且为strong强引用
@property (strong, nonatomic)  SWWindow *window;

@property(nonatomic, strong) SWMultiWindowFlowlayout *cardLayout;
@end

@implementation SWMultiWindowsController
- (NSMutableArray *)baseProductsData{
    if (!_baseProductsData) {
        _baseProductsData = [[NSMutableArray alloc]init];
        for (UIWindow *window in [UIApplication sharedApplication].windows) {
            if (window && !window.isHidden && (window.class == [SWWindow class])) {
                [self addWindow:window];
            }
        }
    }
    return _baseProductsData;
}
- (UICollectionView *)collectView{
    if (!_collectView) {
        UICollectionView *collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KWidth, KHeight - kNomalHeight) collectionViewLayout:self.cardLayout];
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
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.cardLayout = [[SWMultiWindowFlowlayout alloc]initWithOffsetY:150];
    self.cardLayout.delegate = self;
    self.collectView.backgroundColor = kMultiBgColor;
    self.view.backgroundColor = kMultiBgColor;
    SWOprateView *oprateView = [[SWOprateView alloc]initWithFrame:CGRectMake(0, KHeight - kNomalHeight, KWidth, kNomalHeight)];
    oprateView.dataArray = @[@"window_add",@"window_back"];
    oprateView.OprateBlock = ^(UIButton *sender) {
        [self oprateClick:sender];
    };
    oprateView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:oprateView];
    /// 大于10个
    oprateView.subviews.firstObject.hidden = self.baseProductsData.count >= 10;
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
    return self.baseProductsData.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(KWidth - 20, KHeight - 150);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    kWeakSelf(weakSelf)
    SWMultiWindowCell *cell = [SWMultiWindowCell cellWithCollectionView:collectionView indexPath:indexPath];
    cell.multiWindow = _baseProductsData[indexPath.item];
//    cell.ReloadItemBlcok = ^(NGMultiWindowModel *multiWindow) {
//        [weakSelf.collectView reloadItemsAtIndexPaths:@[indexPath]];
//    };
    cell.MultiWindowBlcok = ^(UIButton *sender, SWMultiWindowModel *multiWindow) {
        /// 当删除的为最后一个window时切换rootViewController
        if (_baseProductsData.count < 2) {
            [UIApplication sharedApplication].keyWindow. rootViewController = [[SWNavigationController alloc]initWithRootViewController:[[SWRootViewController alloc]init]];
            return;
        }
        // 删除window
        [weakSelf deleteWindow:multiWindow.window];
        [_baseProductsData removeObject:multiWindow];
        [weakSelf.collectView performBatchUpdates:^{
            [weakSelf.collectView deleteItemsAtIndexPaths:@[indexPath]];
            collectionView.collectionViewLayout = weakSelf.cardLayout;
        } completion:^(BOOL finished) {
            [weakSelf.collectView reloadData];
        }];
    };
    return cell;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint translatedPoint = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:gestureRecognizer.view];
        if (fabs(translatedPoint.x) > fabs(translatedPoint.y)) {
            return YES;
        }
    }
    return NO;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SWMultiWindowModel *multiWindow = _baseProductsData[indexPath.item];
    NSLog(@"现有---window === %@,nav == %@,isKeyWindow == %d",[UIApplication sharedApplication].keyWindow,[[UIApplication sharedApplication].keyWindow rootViewController],[UIApplication sharedApplication].keyWindow.isKeyWindow);
    [self.navigationController popViewControllerAnimated:NO];
    if (multiWindow.window.isKeyWindow) {
        return;
    }
    [[UIApplication sharedApplication].keyWindow resignKeyWindow];
    NSLog(@"点击前---window === %@,nav == %@,isKeyWindow == %d",multiWindow.window,[multiWindow.window rootViewController],multiWindow.window.isKeyWindow);
    [multiWindow.window makeKeyAndVisible];
    NSLog(@"点击后---window === %@,nav == %@,isKeyWindow == %d",[UIApplication sharedApplication].keyWindow,[[UIApplication sharedApplication].keyWindow rootViewController],[UIApplication sharedApplication].keyWindow.isKeyWindow);
}
- (void)dealloc{
    NSLog(@"SWRootViewController被销毁");
}
/**
 * 创建新window
 */
- (void)createWindow{
    if (self.window) {
        [self deleteWindow:self.window];
    }
    [[UIApplication sharedApplication].keyWindow resignKeyWindow];
    self.window = [[SWWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.windowLevel = UIWindowLevelNormal;
    self.window.rootViewController = [[SWNavigationController alloc]initWithRootViewController:[[SWRootViewController alloc]init]];
    self.window.hidden = NO;
    [self.window makeKeyAndVisible];
}

/**
 * 删除window
 @param window <#window description#>
 */
- (void)deleteWindow:(UIWindow *)window{
    [((SWNavigationController *)(window.rootViewController)).openedViewControllers removeAllObjects];
    ((SWNavigationController *)(window.rootViewController)).openedViewControllers = nil;
    ((SWNavigationController *)(window.rootViewController)).viewControllers = [[NSArray alloc]init];
    [window.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    window.rootViewController = nil;
    [window resignKeyWindow];
    [window removeFromSuperview];
    window.hidden = YES;
    window = nil;
}

/**
 * 给集合添加一个window
 @param window <#window description#>
 */
- (void)addWindow:(UIWindow *)window{
    SWNavigationController *nav = (SWNavigationController *)window.rootViewController;
    if ([nav.openedViewControllers.lastObject isKindOfClass:[SWMultiWindowsController class]]) {
        [nav.openedViewControllers removeLastObject];
    }
    UIViewController *vc = nav.viewControllers.lastObject;
    if ([vc isKindOfClass:[SWMultiWindowsController class]]) {
        vc = nav.viewControllers[nav.viewControllers.count - 2];
    }
    NSString *title = @"首页";
    NSString *icon = @"net";
    if ([vc isKindOfClass:[SWRootViewController class]]) {
        title = @"首页";
    }
    else if([vc isKindOfClass:[PTHtmlViewController class]]){
        title = ((PTHtmlViewController *)vc).webTitle;
        icon = [[((PTHtmlViewController *)vc).str componentsSeparatedByString:@"com"].firstObject stringByAppendingString:@"com/favicon.ico"];
    }
    SWMultiWindowModel *multiWindow = [[SWMultiWindowModel alloc]initWithImage:[self captureView:vc] title:title icon:icon window:window];
    [_baseProductsData addObject:multiWindow];
}
#pragma mark - 生成图片
- (UIImage*)captureView:(UIViewController *)viewController
{
    UIView *originView = viewController.view;
        CGRect frame = [viewController isKindOfClass:[PTHtmlViewController class]] ? CGRectMake(0, kNavHeight, originView.frame.size.width, originView.frame.size.height - kNomalHeight  - kNavHeight): CGRectMake(0, 0, originView.frame.size.width, originView.frame.size.height - kNomalHeight);
    UIGraphicsBeginImageContext(frame.size);
    UIImage *img;
    /// *WKWebView截屏只显示背景，因此和其他方式截屏区分开（UIWebVIew正常）
    UIGraphicsEndImageContext();
    if([viewController isKindOfClass:[PTHtmlViewController class]]){
        UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0.0);
        
        for(UIView *subview in originView.subviews)
        {
            /// 过滤掉底部视图
            if ([subview isKindOfClass:[WKWebView class]]) {
                [subview drawViewHierarchyInRect:CGRectMake(0, 0, subview.frame.size.width, subview.frame.size.height) afterScreenUpdates:YES];
            }
        }
        img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    else
    {
        UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0.0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [viewController.view.layer renderInContext:context];
        img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return img;
}
@end

