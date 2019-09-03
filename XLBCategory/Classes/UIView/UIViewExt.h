


#import <UIKit/UIKit.h>

CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (ViewFrameGeometry)
@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat wr_height;
@property CGFloat wr_width;

@property CGFloat wr_top;
@property CGFloat wr_left;

@property CGFloat wr_bottom;
@property CGFloat wr_right;

@property CGFloat wr_centerX;
@property CGFloat wr_centerY;


- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;
@end
