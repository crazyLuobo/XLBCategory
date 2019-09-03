//
//  UIImage+Color.m
//  HouseKeeperManager
//
//  Created by rango on 16/8/1.
//  Copyright © 2016年 Rango. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)
+ (UIImage *)imageWithColor:(UIColor *)color {

    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}


+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)renderingimage:(UIImage *)image soonImageWithColor:(UIColor *)color
{
    //把图片的颜色都去掉
    UIImage *renderingImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //重新绘制图片颜色
    UIGraphicsBeginImageContextWithOptions(renderingImage.size, NO, 0.0f);
    
    [color setFill];
    
    CGRect bounds = CGRectMake(0, 0, renderingImage.size.width, renderingImage.size.height);
    
    UIRectFill(bounds);
    
    [renderingImage drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return tintedImage;
    
    
}





@end
