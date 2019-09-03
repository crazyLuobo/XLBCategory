//
//  UIImage+size.h
//  BoardingHouse
//
//  Created by rango on 2018/3/26.
//  Copyright © 2018年 Rango. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (size)

///指定高度按比例缩放
-(UIImage *) imageCompressForHeight:(UIImage *)sourceImage targetHeight:(CGFloat)defineHeight;
///指定宽度按比例缩放
-(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

@end
