//
//  SWMultiWindowFlowlayout.h
//  BrowserMultiWindow
//
//  Created by SanW on 2017/10/12.
//  Copyright © 2017年 ONONTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWConfig.h"

@protocol SWMultiWindowFlowlayoutDelegate <NSObject>

-(void)updateBlur:(CGFloat) blur ForRow:(NSInteger)row;

@end

@interface SWMultiWindowFlowlayout : UICollectionViewFlowLayout
@property(nonatomic, assign) CGFloat offsetY;
@property(nonatomic, assign) CGFloat contentSizeHeight;
@property(nonatomic, strong) NSMutableArray *blurList;
@property(nonatomic, weak)id <SWMultiWindowFlowlayoutDelegate> delegate;

-(instancetype)initWithOffsetY:(CGFloat)offsetY;

@end
