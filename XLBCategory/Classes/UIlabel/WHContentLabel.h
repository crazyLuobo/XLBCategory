//
//  WHContentLabel.h
//  BoardingHouse
//
//  Created by GuangdongQi on 2018/3/13.
//  Copyright © 2018年 Rango. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WHVerticalAlignmentTop = 0, //default
    WHVerticalAlignmentMiddle,
    WHVerticalAlignmentBottom,

} VerticalAlignment;

@interface WHContentLabel : UILabel {

@private
    VerticalAlignment _verticalAlignment;
}

@property (nonatomic) VerticalAlignment verticalAlignment;

@end
