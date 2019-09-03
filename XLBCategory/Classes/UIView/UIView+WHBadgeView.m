//
//  UIView+WHBadgeView.m
//  BoardingHouse
//
//  Created by rango on 2018/4/3.
//  Copyright © 2018年 Rango. All rights reserved.
//

#import "UIView+WHBadgeView.h"

#import <objc/runtime.h>
//#import <objc/message.h>
@implementation WHCircleView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextAddEllipseInRect(context, CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect)));

    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.829 green:0.194 blue:0.257 alpha:1.000].CGColor);

    CGContextFillPath(context);
}

@end

static NSString const * XHBadgeViewKey = @"XHBadgeViewKey";
static NSString const * XHBadgeViewFrameKey = @"XHBadgeViewFrameKey";
static NSString const * XHCircleBadgeViewKey = @"XHCircleBadgeViewKey";

@implementation UIView (WHBadgeView)

- (void)setBadgeViewFrame:(CGRect)badgeViewFrame {
    objc_setAssociatedObject(self, &XHBadgeViewFrameKey, NSStringFromCGRect(badgeViewFrame), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (CGRect)badgeViewFrame {
    return CGRectFromString(objc_getAssociatedObject(self, &XHBadgeViewFrameKey));
}

- (LKBadgeView *)badgeView {

    LKBadgeView *badgeView = objc_getAssociatedObject(self, &XHBadgeViewKey);
    if (badgeView)
        return badgeView;

    badgeView = [[LKBadgeView alloc] initWithFrame:self.badgeViewFrame];
    [self addSubview:badgeView];

    self.badgeView = badgeView;

    return badgeView;
}

- (void)setBadgeView:(LKBadgeView *)badgeView {
    objc_setAssociatedObject(self, &XHBadgeViewKey, badgeView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (WHCircleView *)setupCircleBadge {
    self.opaque = NO;
    self.clipsToBounds = NO;
    WHCircleView *circleView = objc_getAssociatedObject(self, &XHCircleBadgeViewKey);
    if (circleView)
        return circleView;

    if (!circleView) {
        circleView = [[WHCircleView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds), 0, 8, 8)];
        [self addSubview:circleView];
        objc_setAssociatedObject(self, &XHCircleBadgeViewKey, circleView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return circleView;
}
@end
