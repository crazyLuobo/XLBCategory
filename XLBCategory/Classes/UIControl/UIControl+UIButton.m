//
//  UIControl+UIButton.m
//  HouseKeeperManager
//
//  Created by rango on 2017/1/10.
//  Copyright © 2017年 Rango. All rights reserved.
//

#import "UIControl+UIButton.h"

#import <objc/runtime.h>

static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";

static const char *UIcontrol_ignoreEvent = "UIcontrol_ignoreEvent";

@implementation UIControl (UIButton)

- (NSTimeInterval)hyn_acceptEventInterval {

    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];

}

- (void)setHyn_acceptEventInterval:(NSTimeInterval)hyn_acceptEventInterval {

    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(hyn_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (BOOL)hyn_ignoreEvent {

    return [objc_getAssociatedObject(self, UIcontrol_ignoreEvent) boolValue];

}

- (void)setHyn_ignoreEvent:(BOOL)hyn_ignoreEvent {

    objc_setAssociatedObject(self, UIcontrol_ignoreEvent, @(hyn_ignoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

+ (void)load {

    Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));

    Method b = class_getInstanceMethod(self, @selector(__hyn_sendAction:to:forEvent:));

    method_exchangeImplementations(a, b);

}

- (void)__hyn_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {

    if (self.hyn_ignoreEvent) return;

    if (self.hyn_acceptEventInterval > 0) {

        self.hyn_ignoreEvent = YES;

        [self performSelector:@selector(setHyn_ignoreEvent:) withObject:@(NO) afterDelay:self.hyn_acceptEventInterval];
        
    }
    
    [self __hyn_sendAction:action to:target forEvent:event];
    
}



@end
