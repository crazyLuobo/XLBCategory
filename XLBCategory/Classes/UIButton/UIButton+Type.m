//
//  UIButton+Type.m
//  HouseKeeperManager
//
//  Created by rango on 16/8/1.
//  Copyright © 2016年 Rango. All rights reserved.
//

#import "UIButton+Type.h"

@implementation UIButton (Type)
+ (id)zz_buttonWithCustomTarget:(id)target action:(SEL)sel {

    id btn = [self buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    [btn setExclusiveTouch:YES];
    return btn;


}

+ (id)zz_buttonWithSystemTarget:(id)target action:(SEL)sel {

    id btn = [self buttonWithType:UIButtonTypeSystem];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    [btn setExclusiveTouch:YES];

    return btn;
}
@end
