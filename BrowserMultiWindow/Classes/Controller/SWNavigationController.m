//
//  SWNavigationController.m
//  BrowserMultiWindow
//
//  Created by SanW on 2017/10/27.
//  Copyright © 2017年 ONONTeam. All rights reserved.
//

#import "SWNavigationController.h"

@interface SWNavigationController ()

@end

@implementation SWNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.openedViewControllers = [[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
