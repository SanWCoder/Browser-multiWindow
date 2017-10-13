//
//  SWMultiWindowsController.m
//  BrowserMultiWindow
//
//  Created by SanW on 2017/10/13.
//  Copyright © 2017年 ONONTeam. All rights reserved.
//

#import "SWMultiWindowsController.h"
#import "SWConfig.h"
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
    }
    return _baseProductsData;
}
- (UICollectionView *)collectView{
    if (!_collectView) {
        UICollectionViewFlowLayout *flowOut = [[UICollectionViewFlowLayout alloc]init];
        UICollectionView *collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KWidth, KHeight - kNavHeight - 20) collectionViewLayout:flowOut];
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
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.baseProductsData.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return self.baseProductsData.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80, 140);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

@end
