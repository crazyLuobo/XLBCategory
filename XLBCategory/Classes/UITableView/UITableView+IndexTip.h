//
//  UITableView+IndexTip.h
//  BoardingHouse
//
//  Created by rango on 2018/4/13.
//  Copyright © 2018年 Rango. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (IndexTip)

//显示索引字符悬浮提示;在点击或滑动索引时，在UITableView中间显示一个Label显示当前的索引字符
-(void)addIndexSectionTip;
@end
