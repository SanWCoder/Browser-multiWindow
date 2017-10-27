//
//  PTHtmlViewController.h
//  PourOutAllTheWay
//
//  Created by SanW on 2016/12/20.
//  Copyright © 2016年 ONON. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTHtmlViewController : UIViewController
@property(nonatomic,strong)UIWebView * webView;
// 链接
@property(nonatomic,copy)NSString *str;
// 标题
@property(nonatomic,copy)NSString *webTitle;

@end
