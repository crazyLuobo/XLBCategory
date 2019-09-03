//
//  UILabel+Size.m
//  BoardingHouse
//
//  Created by GuangdongQi on 2018/1/22.
//  Copyright © 2018年 Rango. All rights reserved.
//

#import "UILabel+Size.h"

@implementation UILabel (Size)


- (CGSize)labelSizeWithConstrainedToSize:(CGSize)size
{
    return [self.text sizeWithFont:self.font
                 constrainedToSize:size
                     lineBreakMode:NSLineBreakByWordWrapping];
}

- (CGRect)boundsNeedWidth:(CGFloat)needWidth lineSpacing:(CGFloat)lineSpacing;
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self.text];

    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];

    style.lineSpacing = lineSpacing;

    [attributeString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, self.text.length)];

    [attributeString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, self.text.length)];

    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;

    CGRect rect = [attributeString boundingRectWithSize:CGSizeMake(needWidth, CGFLOAT_MAX) options:options context:nil];

    if ((rect.size.height - self.font.lineHeight) <= style.lineSpacing) {

        if ([self isHaveChineseInString:self.text]) {  //如果包含中文
            rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height-style.lineSpacing);

        }

    }

    return rect;

}

- (BOOL)isHaveChineseInString:(NSString *)string
{
    for(NSInteger i = 0; i < [string length]; i++){
        int a = [string characterAtIndex:i];
        if (a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

@end
