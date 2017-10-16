//
//  SWMultiWindowsController.m
//  BrowserMultiWindow
//
//  Created by SanW on 2017/10/13.
//  Copyright © 2017年 ONONTeam. All rights reserved.
//

#import "SWMultiWindowsController.h"
#import "SWConfig.h"
#import "AppDelegate.h"
#import "SWOprateView.h"
#import "SWRootViewController.h"
@interface SWMultiWindowsController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
/// 数据源
@property (nonatomic,strong) NSMutableArray *baseProductsData;
/// collectView
@property (nonatomic,weak) UICollectionView *collectView;
@end

@implementation SWMultiWindowsController
- (NSMutableArray *)baseProductsData
{
    if (!_baseProductsData) {
        _baseProductsData = [[NSMutableArray alloc]init];
        for (int i = 0; i < 20; i ++) {
            [_baseProductsData addObject:[NSString stringWithFormat:@"测试数据--%d",i]];
        }
    }
    return _baseProductsData;
}
- (UICollectionView *)collectView{
    if (!_collectView) {
        UICollectionViewFlowLayout *flowOut = [[UICollectionViewFlowLayout alloc]init];
        UICollectionView *collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KWidth, KHeight - kNomalHeight) collectionViewLayout:flowOut];
        collectView.alwaysBounceVertical = YES;
        _collectView = collectView;
        // 注册cell
        [collectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        collectView.delegate = self;
        collectView.dataSource = self;
        [self.view addSubview:collectView];
    }
    return _collectView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectView.backgroundColor = [UIColor whiteColor];
    SWOprateView *oprateView = [[SWOprateView alloc]initWithFrame:CGRectMake(0, KHeight - kNomalHeight, KWidth, kNomalHeight)];
    oprateView.dataArray = @[@"return",@"return"];
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
            [UIApplication sharedApplication].keyWindow.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[SWRootViewController alloc]init]];
            break;
        case 2:
        {

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
    return CGSizeMake(self.view.frame.size.width - 20, 140);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *lab = [[UILabel alloc]init];
    
    int R = (arc4random() % 256) ;
    int G = (arc4random() % 256) ;
    int B = (arc4random() % 256) ;
    lab.backgroundColor = [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:1];
    lab.text = _baseProductsData[indexPath.item];
    lab.frame = CGRectMake(0, 0, self.view.frame.size.width - 20, 140);
    [cell.contentView addSubview:lab];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *deleg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [UIApplication sharedApplication].keyWindow.rootViewController = deleg.multiWindows.firstObject;
}
@end
