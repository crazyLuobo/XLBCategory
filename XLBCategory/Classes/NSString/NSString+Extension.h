//
//  NSString+Extension.h
//  HouseKeeperManager
//
//  Created by rango on 16/8/10.
//  Copyright © 2016年 Rango. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSString (Extension)
/** 返回字符串所占用的尺寸 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

//聊天
- (NSAttributedString *)toMessageString;

//动态
- (NSAttributedString *)toDynamicMssageStringWithFont:(UIFont *)font textColor:(UIColor *)textColor;

//动态列表
- (NSAttributedString *)toHisDynamicString;

//获取url路径的宽高
- (CGSize)catchSpecifyStringWithAndHeight;

- (NSInteger)getStringLenthOfBytes;

- (NSString *)subBytesOfstringToIndex:(NSInteger)index;

@end
