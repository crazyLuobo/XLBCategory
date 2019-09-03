//
//  NSString+Extension.m
//  HouseKeeperManager
//
//  Created by rango on 16/8/10.
//  Copyright © 2016年 Rango. All rights reserved.
//

#import "NSString+Extension.h"
#import "WHExpressionHelper.h"
#import "WHExpressionModel.h"
@implementation NSString (Extension)


//返回字符串所占用的尺寸.
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (NSAttributedString *)toDynamicMssageStringWithFont:(UIFont *)font textColor:(UIColor *)textColor {

    //1、创建一个可变的属性字符串
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self];

    attributeString.yy_font = font;
    attributeString.yy_color = textColor;
    attributeString.yy_lineSpacing = DynamicLineSpacing;
    //    attributeString.yy_kern = [NSNumber numberWithFloat:1.2];
    attributeString.yy_alignment = NSTextAlignmentLeft;
    attributeString.yy_lineBreakMode = NSLineBreakByWordWrapping;

    // 高亮状态的背景
    YYTextBorder *highlightBorder = [YYTextBorder new];
    highlightBorder.insets = UIEdgeInsetsMake(-2, 0, -2, 0);
    highlightBorder.fillColor = [UIColor blackColor];

    /*================================手机号===================================*/

    //所有话题
    NSArray * phoneNumers = [[Utilities regexPhone] matchesInString:self options:0 range:NSMakeRange(0, self.length)];


    for (NSTextCheckingResult *at  in phoneNumers) {

        if (at.range.location == NSNotFound && at.range.length <= 1)
        {
            continue;
        }

        if ([attributeString yy_attribute:YYTextHighlightAttributeName atIndex:at.range.location] == nil)
        {
            [attributeString yy_setColor:UIColorFromRGB(0x458def) range:at.range];

            // 高亮状态
            YYTextHighlight *highlight = [YYTextHighlight new];

            [highlight setBackgroundBorder:highlightBorder];
            // 数据信息，用于稍后用户点击
            highlight.userInfo = @{@"linkValue" : [attributeString.string substringWithRange:NSMakeRange(at.range.location, at.range.length)],@"linkType":@"LinkTypePhoneNumber"};
            [attributeString yy_setTextHighlight:highlight range:at.range];
        }

    }

    /*================================url===================================*/

    //所有话题
    NSArray * urls = [[Utilities regesUrl] matchesInString:self options:0 range:NSMakeRange(0, self.length)];

    for (NSTextCheckingResult *at  in urls) {

        if (at.range.location == NSNotFound && at.range.length <= 1)
        {
            continue;
        }

        if ([attributeString yy_attribute:YYTextHighlightAttributeName atIndex:at.range.location] == nil)
        {
            [attributeString yy_setColor:WHBGColorDarkBlue range:at.range];

            // 高亮状态
            YYTextHighlight *highlight = [YYTextHighlight new];

            [highlight setBackgroundBorder:highlightBorder];
            // 数据信息，用于稍后用户点击
            highlight.userInfo = @{@"linkValue" : [attributeString.string substringWithRange:NSMakeRange(at.range.location, at.range.length)],@"linkType":@"LinkTypeURL"};
            [attributeString yy_setTextHighlight:highlight range:at.range];
        }
    }

    //2、通过正则表达式来匹配字符串
    NSString *regex_emoji = @"\\[[a-zA-Z0-9\\/\\u4e00-\\u9fa5]+\\]"; //匹配表情

    NSError *error = nil;
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:regex_emoji options:NSRegularExpressionCaseInsensitive error:&error];
    if (!re) {
        NSLog(@"[NSString toMessageString]: %@", [error localizedDescription]);
        return attributeString;
    }

    NSArray *resultArray = [re matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    //3、获取所有的表情以及位置
    //用来存放字典，字典中存储的是图片和图片对应的位置
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:resultArray.count];
    //根据匹配范围来用图片进行相应的替换
    for(NSTextCheckingResult *match in resultArray) {
        //获取数组元素中得到range
        NSRange matchRange = [match range];
        //获取原字符串中对应的值
        NSString *subStr = [self substringWithRange:matchRange];

        WHExpressionGroupModel *group = [WHExpressionHelper shareInstance].defaultFaceGroup;

        NSMutableArray * faces = [NSMutableArray arrayWithArray:group.data];

        for (WHExpressionModel *emoji in faces) {

            if ([emoji.name isEqualToString:subStr]) {

                UIImage *image = [UIImage imageNamed:emoji.name];

                UIImageView *imageView = [[UIImageView alloc]initWithImage:image];

                NSMutableAttributedString *attachText  = [NSMutableAttributedString yy_attachmentStringWithContent:imageView contentMode:UIViewContentModeScaleAspectFill attachmentSize:CGSizeMake(20, 20) alignToFont:font alignment:YYTextVerticalAlignmentCenter];


                //把图片和图片对应的位置存入字典中
                NSMutableDictionary *imageDic = [NSMutableDictionary dictionaryWithCapacity:2];
                [imageDic setObject:attachText forKey:@"image"];
                [imageDic setObject:[NSValue valueWithRange:matchRange] forKey:@"range"];
                //把字典存入数组中
                [imageArray addObject:imageDic];
            }
        }
    }

    //4、从后往前替换，否则会引起位置问题
    for (int i = (int)imageArray.count -1; i >= 0; i--) {
        NSRange range;
        [imageArray[i][@"range"] getValue:&range];
        //进行替换
        [attributeString replaceCharactersInRange:range withAttributedString:imageArray[i][@"image"]];
    }
    return attributeString;



}

- (NSAttributedString *)toDynamicMssageString {

    //1、创建一个可变的属性字符串
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self];


    attributeString.yy_font = Font(DynamicFontSize);
    attributeString.yy_color = WHColorBlack;
    attributeString.yy_lineSpacing = DynamicLineSpacing;
//    attributeString.yy_kern = [NSNumber numberWithFloat:1.2];
    attributeString.yy_alignment = NSTextAlignmentLeft;
    attributeString.yy_lineBreakMode = NSLineBreakByWordWrapping;

    /*================================话 题===================================*/
    // 高亮状态的背景
    YYTextBorder *highlightBorder = [YYTextBorder new];
    highlightBorder.insets = UIEdgeInsetsMake(-2, 0, -2, 0);
    highlightBorder.fillColor = [UIColor blackColor];

    //所有话题
   NSArray * topics = [[Utilities regexTopic] matchesInString:self options:0 range:NSMakeRange(0, self.length)];

    for (NSTextCheckingResult *at  in topics) {

        if (at.range.location == NSNotFound && at.range.length <= 1)
        {
            continue;
        }

        if ([attributeString yy_attribute:YYTextHighlightAttributeName atIndex:at.range.location] == nil)
        {

          NSMutableAttributedString *topicAttristring   =  [[attributeString attributedSubstringFromRange:at.range]mutableCopy];

            //1.话题背景
            topicAttristring.yy_color = UIColorFromRGB(0xff6f30);
            topicAttristring.yy_font = Font(DynamicFontSize);

            YYTextBorder *border = [YYTextBorder new];
//            border.cornerRadius = 50;
//            border.insets = UIEdgeInsetsMake(-2, -5, -1, -5);
            border.fillColor = UIColorFromRGB(0xffefe7);
            topicAttristring.yy_textBackgroundBorder = border;
            [attributeString deleteCharactersInRange:at.range];

            [attributeString insertAttributedString:topicAttristring atIndex:at.range.location];

            //2.点击高亮状态
            YYTextHighlight *highlight = [YYTextHighlight new];

            [highlight setBackgroundBorder:highlightBorder];
            // 数据信息，用于稍后用户点击
            highlight.userInfo = @{@"linkValue" : [attributeString.string substringWithRange:NSMakeRange(at.range.location, at.range.length)],@"linkType":@"LinkTypeTopic"};
            [attributeString yy_setTextHighlight:highlight range:at.range];
        }

    }
    /*================================手机号===================================*/

    //所有话题
    NSArray * phoneNumers = [[Utilities regexPhone] matchesInString:self options:0 range:NSMakeRange(0, self.length)];


    for (NSTextCheckingResult *at  in phoneNumers) {

        if (at.range.location == NSNotFound && at.range.length <= 1)
        {
            continue;
        }

        if ([attributeString yy_attribute:YYTextHighlightAttributeName atIndex:at.range.location] == nil)
        {
            [attributeString yy_setColor:UIColorFromRGB(0x458def) range:at.range];

            // 高亮状态
            YYTextHighlight *highlight = [YYTextHighlight new];

            [highlight setBackgroundBorder:highlightBorder];
            // 数据信息，用于稍后用户点击
            highlight.userInfo = @{@"linkValue" : [attributeString.string substringWithRange:NSMakeRange(at.range.location, at.range.length)],@"linkType":@"LinkTypePhoneNumber"};
            [attributeString yy_setTextHighlight:highlight range:at.range];
        }

    }

    /*================================url===================================*/

    //所有话题
    NSArray * urls = [[Utilities regesUrl] matchesInString:self options:0 range:NSMakeRange(0, self.length)];

    for (NSTextCheckingResult *at  in urls) {

        if (at.range.location == NSNotFound && at.range.length <= 1)
        {
            continue;
        }

        if ([attributeString yy_attribute:YYTextHighlightAttributeName atIndex:at.range.location] == nil)
        {
            [attributeString yy_setColor:WHBGColorDarkBlue range:at.range];

            // 高亮状态
            YYTextHighlight *highlight = [YYTextHighlight new];

            [highlight setBackgroundBorder:highlightBorder];
            // 数据信息，用于稍后用户点击
            highlight.userInfo = @{@"linkValue" : [attributeString.string substringWithRange:NSMakeRange(at.range.location, at.range.length)],@"linkType":@"LinkTypeURL"};
            [attributeString yy_setTextHighlight:highlight range:at.range];
        }
    }

    //2、通过正则表达式来匹配字符串
    NSString *regex_emoji = @"\\[[a-zA-Z0-9\\/\\u4e00-\\u9fa5]+\\]"; //匹配表情

    NSError *error = nil;
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:regex_emoji options:NSRegularExpressionCaseInsensitive error:&error];
    if (!re) {
        NSLog(@"[NSString toMessageString]: %@", [error localizedDescription]);
        return attributeString;
    }

    NSArray *resultArray = [re matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    //3、获取所有的表情以及位置
    //用来存放字典，字典中存储的是图片和图片对应的位置
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:resultArray.count];
    //根据匹配范围来用图片进行相应的替换
    for(NSTextCheckingResult *match in resultArray) {
        //获取数组元素中得到range
        NSRange matchRange = [match range];
        //获取原字符串中对应的值
        NSString *subStr = [self substringWithRange:matchRange];

        WHExpressionGroupModel *group = [WHExpressionHelper shareInstance].defaultFaceGroup;

        NSMutableArray * faces = [NSMutableArray arrayWithArray:group.data];

        for (WHExpressionModel *emoji in faces) {

            if ([emoji.name isEqualToString:subStr]) {

                UIImage *image = [UIImage imageNamed:emoji.name];

                UIImageView *imageView = [[UIImageView alloc]initWithImage:image];

                NSMutableAttributedString *attachText  = [NSMutableAttributedString yy_attachmentStringWithContent:imageView contentMode:UIViewContentModeScaleAspectFill attachmentSize:CGSizeMake(20, 20) alignToFont:Font(DynamicFontSize) alignment:YYTextVerticalAlignmentCenter];


                //把图片和图片对应的位置存入字典中
                NSMutableDictionary *imageDic = [NSMutableDictionary dictionaryWithCapacity:2];
                [imageDic setObject:attachText forKey:@"image"];
                [imageDic setObject:[NSValue valueWithRange:matchRange] forKey:@"range"];
                //把字典存入数组中
                [imageArray addObject:imageDic];
            }
        }
    }

    //4、从后往前替换，否则会引起位置问题
    for (int i = (int)imageArray.count -1; i >= 0; i--) {
        NSRange range;
        [imageArray[i][@"range"] getValue:&range];
        //进行替换
        [attributeString replaceCharactersInRange:range withAttributedString:imageArray[i][@"image"]];
    }
    return attributeString;

}

- (NSAttributedString *)toMessageString;
{
    //1、创建一个可变的属性字符串
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self];

    [attributeString addAttributes:[Utilities paraStyleofLabelFont:Font(ChatFontSize)] range:NSMakeRange(0, self.length)];


    //2、通过正则表达式来匹配字符串
    NSString *regex_emoji = @"\\[[a-zA-Z0-9\\/\\u4e00-\\u9fa5]+\\]"; //匹配表情

    NSError *error = nil;
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:regex_emoji options:NSRegularExpressionCaseInsensitive error:&error];
    if (!re) {
        NSLog(@"[NSString toMessageString]: %@", [error localizedDescription]);
        return attributeString;
    }

    NSArray *resultArray = [re matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    //3、获取所有的表情以及位置
    //用来存放字典，字典中存储的是图片和图片对应的位置
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:resultArray.count];
    //根据匹配范围来用图片进行相应的替换
    for(NSTextCheckingResult *match in resultArray) {
        //获取数组元素中得到range
        NSRange range = [match range];
        //获取原字符串中对应的值
        NSString *subStr = [self substringWithRange:range];


        WHExpressionGroupModel *group = [WHExpressionHelper shareInstance].defaultFaceGroup;

        WHExpressionModel *lieExpressionModel = [WHExpressionModel new];
        lieExpressionModel.name = @"[谎话]";

        NSMutableArray * faces = [NSMutableArray arrayWithArray:group.data];
        [faces addObject:lieExpressionModel];

        for (WHExpressionModel *emoji in faces) {

            if ([emoji.name isEqualToString:subStr]) {
                //face[i][@"png"]就是我们要加载的图片
                //新建文字附件来存放我们的图片,iOS7才新加的对象
                NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
                //给附件添加图片
                textAttachment.image = [UIImage imageNamed:emoji.name];
                //调整一下图片的位置,如果你的图片偏上或者偏下，调整一下bounds的y值即可

                if ([emoji.name isEqualToString:@"[谎话]"]) {

                     textAttachment.bounds = CGRectMake(0, -4, 34, 23.5);

                } else {

                     textAttachment.bounds = CGRectMake(0, -4, 20, 20);

                }

                //把附件转换成可变字符串，用于替换掉源字符串中的表情文字
                NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
                //把图片和图片对应的位置存入字典中
                NSMutableDictionary *imageDic = [NSMutableDictionary dictionaryWithCapacity:2];
                [imageDic setObject:imageStr forKey:@"image"];
                [imageDic setObject:[NSValue valueWithRange:range] forKey:@"range"];
                //把字典存入数组中
                [imageArray addObject:imageDic];
            }
        }
    }

    //4、从后往前替换，否则会引起位置问题
    for (int i = (int)imageArray.count -1; i >= 0; i--) {
        NSRange range;
        [imageArray[i][@"range"] getValue:&range];
        //进行替换
        [attributeString replaceCharactersInRange:range withAttributedString:imageArray[i][@"image"]];
    }





    return attributeString;
}


- (CGSize)catchSpecifyStringWithAndHeight {

    NSRange  startRange = [self rangeOfString:@"?"];

   NSString * catchString = [self substringFromIndex:startRange.location+1];

   NSArray *catchs  =  [catchString componentsSeparatedByString:@"&"];

   NSString *firstWidth = catchs.firstObject;
   NSString *lastHeight = catchs.lastObject;


    NSString *width  = [firstWidth componentsSeparatedByString:@"="].lastObject;
    NSString *height = [lastHeight componentsSeparatedByString:@"="].lastObject;

    return  CGSizeMake(width.floatValue, height.floatValue);

}

- (NSInteger)getStringLenthOfBytes
{
    NSInteger length = 0;
    for (int i = 0; i<[self length]; i++) {
        //截取字符串中的每一个字符
        NSString *s = [self substringWithRange:NSMakeRange(i, 1)];
        if ([self validateChineseChar:s]) {
            
            NSLog(@" s 打印信息:%@",s);
            
            length +=2;
        }else{
            length +=1;
        }
        
        NSLog(@" 打印信息:%@  %ld",s,(long)length);
    }
    return length;
}

- (NSString *)subBytesOfstringToIndex:(NSInteger)index
{
    NSInteger length = 0;
    
    NSInteger chineseNum = 0;
    NSInteger zifuNum = 0;
    
    for (int i = 0; i<[self length]; i++) {
        //截取字符串中的每一个字符
        NSString *s = [self substringWithRange:NSMakeRange(i, 1)];
        if ([self validateChineseChar:s])
        {
            if (length + 2 > index)
            {
                return [self substringToIndex:chineseNum + zifuNum];
            }
            
            length +=2;
            
            chineseNum +=1;
        }
        else
        {
            if (length +1 >index)
            {
                return [self substringToIndex:chineseNum + zifuNum];
            }
            length+=1;
            
            zifuNum +=1;
        }
    }
    return [self substringToIndex:index];
}

- (NSAttributedString *)toHisDynamicString {
    
    //1、创建一个可变的属性字符串
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self];
    
    
    attributeString.yy_font = Font(15);
    attributeString.yy_color = WHColorBlack;
    attributeString.yy_lineSpacing = DynamicLineSpacing;
    //    attributeString.yy_kern = [NSNumber numberWithFloat:1.2];
    attributeString.yy_alignment = NSTextAlignmentLeft;
    attributeString.yy_lineBreakMode = NSLineBreakByWordWrapping;
    
    
    //    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    //    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    //    paraStyle.alignment = NSTextAlignmentLeft;
    //    paraStyle.lineSpacing = DynamicLineSpacing; //设置行间距
    //
    //    [attributeString setAttributes:@{NSFontAttributeName :Font(CommentFontSize),NSForegroundColorAttributeName:WHColorBlack,NSKernAttributeName:@1.2f,NSParagraphStyleAttributeName:paraStyle} range:NSMakeRange(0, self.length)];
    //
    
    /*================================话 题===================================*/
    // 高亮状态的背景
    YYTextBorder *highlightBorder = [YYTextBorder new];
    highlightBorder.insets = UIEdgeInsetsMake(-2, 0, -2, 0);
    highlightBorder.fillColor = [UIColor blackColor];
    
    //所有话题
    NSArray * topics = [[Utilities regexTopic] matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    for (NSTextCheckingResult *at  in topics) {
        
        if (at.range.location == NSNotFound && at.range.length <= 1)
        {
            continue;
        }
        
        if ([attributeString yy_attribute:YYTextHighlightAttributeName atIndex:at.range.location] == nil)
        {
            
            NSMutableAttributedString *topicAttristring   =  [[attributeString attributedSubstringFromRange:at.range]mutableCopy];
            
            //1.话题背景
            topicAttristring.yy_color = UIColorFromRGB(0xff6f30);
            topicAttristring.yy_font = Font(15);
            
            YYTextBorder *border = [YYTextBorder new];
            //            border.cornerRadius = 50;
            //            border.insets = UIEdgeInsetsMake(-2, -5, -1, -5);
            border.fillColor = UIColorFromRGB(0xffefe7);
            topicAttristring.yy_textBackgroundBorder = border;
            [attributeString deleteCharactersInRange:at.range];
            
            [attributeString insertAttributedString:topicAttristring atIndex:at.range.location];
            
            //2.点击高亮状态
            YYTextHighlight *highlight = [YYTextHighlight new];
            
            [highlight setBackgroundBorder:highlightBorder];
            // 数据信息，用于稍后用户点击
            highlight.userInfo = @{@"linkValue" : [attributeString.string substringWithRange:NSMakeRange(at.range.location, at.range.length)],@"linkType":@"LinkTypeTopic"};
            [attributeString yy_setTextHighlight:highlight range:at.range];
        }
        
    }
    /*================================手机号===================================*/
    
    //所有话题
    NSArray * phoneNumers = [[Utilities regexPhone] matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    
    for (NSTextCheckingResult *at  in phoneNumers) {
        
        if (at.range.location == NSNotFound && at.range.length <= 1)
        {
            continue;
        }
        
        if ([attributeString yy_attribute:YYTextHighlightAttributeName atIndex:at.range.location] == nil)
        {
            [attributeString yy_setColor:UIColorFromRGB(0x458def) range:at.range];
            
            // 高亮状态
            YYTextHighlight *highlight = [YYTextHighlight new];
            
            [highlight setBackgroundBorder:highlightBorder];
            // 数据信息，用于稍后用户点击
            highlight.userInfo = @{@"linkValue" : [attributeString.string substringWithRange:NSMakeRange(at.range.location, at.range.length)],@"linkType":@"LinkTypePhoneNumber"};
            [attributeString yy_setTextHighlight:highlight range:at.range];
        }
        
    }
    
    /*================================url===================================*/
    
    //所有话题
    NSArray * urls = [[Utilities regesUrl] matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    for (NSTextCheckingResult *at  in urls) {
        
        if (at.range.location == NSNotFound && at.range.length <= 1)
        {
            continue;
        }
        
        if ([attributeString yy_attribute:YYTextHighlightAttributeName atIndex:at.range.location] == nil)
        {
            [attributeString yy_setColor:WHBGColorDarkBlue range:at.range];
            
            // 高亮状态
            YYTextHighlight *highlight = [YYTextHighlight new];
            
            [highlight setBackgroundBorder:highlightBorder];
            // 数据信息，用于稍后用户点击
            highlight.userInfo = @{@"linkValue" : [attributeString.string substringWithRange:NSMakeRange(at.range.location, at.range.length)],@"linkType":@"LinkTypeURL"};
            [attributeString yy_setTextHighlight:highlight range:at.range];
        }
    }
    
    //2、通过正则表达式来匹配字符串
    NSString *regex_emoji = @"\\[[a-zA-Z0-9\\/\\u4e00-\\u9fa5]+\\]"; //匹配表情
    
    NSError *error = nil;
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:regex_emoji options:NSRegularExpressionCaseInsensitive error:&error];
    if (!re) {
        NSLog(@"[NSString toMessageString]: %@", [error localizedDescription]);
        return attributeString;
    }
    
    NSArray *resultArray = [re matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    //3、获取所有的表情以及位置
    //用来存放字典，字典中存储的是图片和图片对应的位置
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:resultArray.count];
    //根据匹配范围来用图片进行相应的替换
    for(NSTextCheckingResult *match in resultArray) {
        //获取数组元素中得到range
        NSRange range = [match range];
        //获取原字符串中对应的值
        NSString *subStr = [self substringWithRange:range];
        
        WHExpressionGroupModel *group = [WHExpressionHelper shareInstance].defaultFaceGroup;
        
        NSMutableArray * faces = [NSMutableArray arrayWithArray:group.data];
        
        for (WHExpressionModel *emoji in faces) {
            
            if ([emoji.name isEqualToString:subStr]) {
                
                UIImage *image = [UIImage imageNamed:emoji.name];
                
                UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
                
                
                NSMutableAttributedString *attachText  = [NSMutableAttributedString yy_attachmentStringWithContent:imageView contentMode:UIViewContentModeScaleAspectFill attachmentSize:CGSizeMake(20, 20) alignToFont:Font(15) alignment:YYTextVerticalAlignmentCenter];

                //把图片和图片对应的位置存入字典中
                NSMutableDictionary *imageDic = [NSMutableDictionary dictionaryWithCapacity:2];
                [imageDic setObject:attachText forKey:@"image"];
                [imageDic setObject:[NSValue valueWithRange:range] forKey:@"range"];
                //把字典存入数组中
                [imageArray addObject:imageDic];
            }
        }
    }
    
    //4、从后往前替换，否则会引起位置问题
    for (int i = (int)imageArray.count -1; i >= 0; i--) {
        NSRange range;
        [imageArray[i][@"range"] getValue:&range];
        //进行替换
        [attributeString replaceCharactersInRange:range withAttributedString:imageArray[i][@"image"]];
    }
    return attributeString;
    
}


//检测中文或者中文符号
- (BOOL)validateChineseChar:(NSString *)string
{
    NSString *nameRegEx = @"[\\u0391-\\uFFE5]";
    if (![string isMatchesRegularExp:nameRegEx]) {
        return NO;
    }
    return YES;
}

//检测中文
- (BOOL)validateChinese:(NSString*)string
{
    NSString *nameRegEx = @"[\u4e00-\u9fa5]";
    if (![string isMatchesRegularExp:nameRegEx]) {
        return NO;
    }
    return YES;
}

- (BOOL)isMatchesRegularExp:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

@end
