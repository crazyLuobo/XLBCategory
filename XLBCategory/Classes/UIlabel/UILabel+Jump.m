//
//  UILabel+Jump.m
//  GuGuInvestment
//
//  Created by rango on 2017/5/3.
//  Copyright © 2017年 Rango. All rights reserved.
//

#import "UILabel+Jump.h"

@implementation UILabel (Jump)

- (void)jumpDuration:(CFTimeInterval)duration {

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation.byValue = @-10;
    animation.duration = duration;
    [self.layer addAnimation:animation forKey:nil];

}

@end
