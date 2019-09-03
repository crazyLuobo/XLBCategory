//
//  UIView+Corner.h
//  BoardingHouse
//
//  Created by rango on 2018/6/23.
//  Copyright © 2018年 Rango. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Corner)

/**
 * setCornerRadius   给view设置圆角
 * @param value      圆角大小
 * @param rectCorner 圆角位置
 **/
- (void)setCornerRadius:(CGFloat)value addRectCorners:(UIRectCorner)rectCorner;

@end
