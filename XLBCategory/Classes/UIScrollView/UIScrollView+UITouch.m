//
//  UIScrollView+UITouch.m
//  BoardingHouse
//
//  Created by GuangdongQi on 2018/6/30.
//  Copyright © 2018年 Rango. All rights reserved.
//

#import "UIScrollView+UITouch.h"

@implementation UIScrollView (UITouch)


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [[self nextResponder] touchesBegan:touches withEvent:event];
    
    [super touchesBegan:touches withEvent:event];
    
}



-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [[self nextResponder] touchesMoved:touches withEvent:event];
    
    [super touchesMoved:touches withEvent:event];
    
}



-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [[self nextResponder] touchesEnded:touches withEvent:event];
    
    [super touchesEnded:touches withEvent:event];
    
}

@end
