//
//  UIButton+Type.h
//  HouseKeeperManager
//
//  Created by rango on 16/8/1.
//  Copyright © 2016年 Rango. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Type)


+(id)zz_buttonWithCustomTarget:(id)target action:(SEL)sel;

+(id)zz_buttonWithSystemTarget:(id)target action:(SEL)sel;
@end
