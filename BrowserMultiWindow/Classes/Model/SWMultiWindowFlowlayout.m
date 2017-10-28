//
//  SWMultiWindowFlowlayout.m
//  BrowserMultiWindow
//
//  Created by SanW on 2017/10/19.
//  Copyright © 2017年 ONONTeam. All rights reserved.
//

#import "SWMultiWindowFlowlayout.h"
#import "SWConfig.h"
@implementation SWMultiWindowFlowlayout{
    NSMutableArray *_attibutes;
}
- (void)prepareLayout{
    [super prepareLayout];
    _attibutes = [[NSMutableArray alloc]init];
    CGFloat margin = 150;
    CGFloat height = KHeight - margin;
    for (NSUInteger i = 0; i < self.multiWindowCount; i ++) {
        UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        CGFloat width = KWidth * (1 - 0.03 * (self.multiWindowCount - i + 1));
        att.frame = CGRectMake((KWidth - width) / 2.0, margin * i, width, height);
        [_attibutes addObject:att];
    }
}
- (CGSize)collectionViewContentSize
{
    return CGSizeMake(KWidth - 20, KHeight - 150 + 150 * (self.multiWindowCount - 1));
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{

    return _attibutes;
}
@end
