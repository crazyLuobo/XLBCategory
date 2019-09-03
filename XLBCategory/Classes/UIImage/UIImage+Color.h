//
//  UIImage+Color.h
//  HouseKeeperManager
//
//  Created by rango on 16/8/1.
//  Copyright © 2016年 Rango. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

/**
 *  @brief 根据颜色生成纯色图片
 *
 *  @param color 颜色
 *
 *  @return 纯色图片
 */
+(UIImage *)imageWithColor:(UIColor *)color;


+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;


/**
 @param image 原始图片
 @param color 将要改变的颜色
 @return 返回改变颜色的图片
 */
+ (UIImage *)renderingimage:(UIImage *)image soonImageWithColor:(UIColor *)color;

@end
