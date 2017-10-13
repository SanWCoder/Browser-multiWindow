//
//  SWConfig.h
//  BrowserMultiWindow
//
//  Created by SanW on 2017/10/13.
//  Copyright © 2017年 ONONTeam. All rights reserved.
//

#ifndef SWConfig_h
#define SWConfig_h

#define kNavHeight 64
#define kNomalHeight  44
// 弱指针
#define kWeakSelf(weakSelf) __weak __typeof(&*self)weakSelf = self;
// 屏幕尺寸
#define KWidth [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height
#endif /* SWConfig_h */
