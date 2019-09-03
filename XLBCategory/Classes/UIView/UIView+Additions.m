//
//  UIView+Additions.m
//  WeSchool
//
//  Created by rango on 15/5/21.
//  Copyright (c) 2015年 YY. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)
- (UIViewController*)viewController{
    
    //下一个响应者
    UIResponder *next = [self nextResponder];
    
    do {
        
        if ([next isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController*)next;
            
        }
        
        next = [next nextResponder];
        
        
    } while (next != nil);
    
    return nil;
}

@end
