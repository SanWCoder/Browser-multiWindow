//
//  SWMultiWindowCell.h
//  BrowserMultiWindow
//
//  Created by SanW on 2017/10/17.
//  Copyright © 2017年 ONONTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWMultiWindowModel.h"
@interface SWMultiWindowCell : UICollectionViewCell
/** 数据源 **/
@property (nonatomic,strong) SWMultiWindowModel *multiWindow;
/**
 * 点击回调
 */
@property (nonatomic,copy)void(^MultiWindowBlcok)(UIButton *sender,SWMultiWindowModel *multiWindow);
/**
 * 快速创建cell
 @param collectionView <#collectionView description#>
 @param indexPath <#indexPath description#>
 @return <#return value description#>
 */
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;
@end
