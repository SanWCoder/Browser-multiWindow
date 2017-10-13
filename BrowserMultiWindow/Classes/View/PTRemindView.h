//
//  PTRemindView.h
//  PourOutAllTheWay
//
//  Created by SanW on 2016/11/29.
//  Copyright © 2016年 ONON. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTRemindView : UIView

/**
 *  提示信息 @[remindImage,remindText]
 */
@property (nonatomic,strong) NSArray *remindData;

@property (nonatomic,copy)void (^RefreshBlock)(PTRemindView *remindView);
@end
