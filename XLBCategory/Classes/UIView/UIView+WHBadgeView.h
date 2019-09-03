//
//  UIView+WHBadgeView.h
//  BoardingHouse
//
//  Created by rango on 2018/4/3.
//  Copyright © 2018年 Rango. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LKBadgeView.h"

@interface WHCircleView : UIView

@end


@interface UIView (WHBadgeView)

@property (nonatomic, assign) CGRect badgeViewFrame;
@property (nonatomic, strong, readonly) LKBadgeView *badgeView;

- (WHCircleView *)setupCircleBadge;

@end
