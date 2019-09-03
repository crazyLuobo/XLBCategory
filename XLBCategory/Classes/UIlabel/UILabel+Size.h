//
//  UILabel+Size.h
//  BoardingHouse
//
//  Created by GuangdongQi on 2018/1/22.
//  Copyright © 2018年 Rango. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Size)

- (CGSize)labelSizeWithConstrainedToSize:(CGSize)size;

- (CGRect)boundsNeedWidth:(CGFloat)needWidth lineSpacing:(CGFloat)lineSpacing;


@end
