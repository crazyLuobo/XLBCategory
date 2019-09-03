/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

#import "UIViewExt.h"

CGPoint CGRectGetCenter(CGRect rect)
{
    CGPoint pt;
    pt.x = CGRectGetMidX(rect);
    pt.y = CGRectGetMidY(rect);
    return pt;
}

CGRect CGRectMoveToCenter(CGRect rect, CGPoint center)
{
    CGRect newrect = CGRectZero;
    newrect.origin.x = center.x-CGRectGetMidX(rect);
    newrect.origin.y = center.y-CGRectGetMidY(rect);
    newrect.size = rect.size;
    return newrect;
}

@implementation UIView (ViewGeometry)

// Retrieve and set the origin
- (CGPoint) origin
{
	return self.frame.origin;
}

- (void) setOrigin: (CGPoint) aPoint
{
	CGRect newframe = self.frame;
	newframe.origin = aPoint;
	self.frame = newframe;
}


// Retrieve and set the size
- (CGSize) size
{
	return self.frame.size;
}

- (void) setSize: (CGSize) aSize
{
	CGRect newframe = self.frame;
	newframe.size = aSize;
	self.frame = newframe;
}

// Query other frame locations
- (CGPoint) bottomRight
{
	CGFloat x = self.frame.origin.x + self.frame.size.width;
	CGFloat y = self.frame.origin.y + self.frame.size.height;
	return CGPointMake(x, y);
}

- (CGPoint) bottomLeft
{
	CGFloat x = self.frame.origin.x;
	CGFloat y = self.frame.origin.y + self.frame.size.height;
	return CGPointMake(x, y);
}

- (CGPoint) topRight
{
	CGFloat x = self.frame.origin.x + self.frame.size.width;
	CGFloat y = self.frame.origin.y;
	return CGPointMake(x, y);
}

- (void)setWr_centerX:(CGFloat)wr_centerX {

    self.center = CGPointMake(wr_centerX, self.center.y);

}
- (CGFloat)wr_centerX {

      return self.center.y;

}

- (void)setWr_centerY:(CGFloat)wr_centerY {

     self.center = CGPointMake(self.center.x, wr_centerY);

}

- (CGFloat)wr_centerY {

  return self.center.y;

}
// Retrieve and set height, width, top, bottom, left, right
- (CGFloat) wr_height
{
	return self.frame.size.height;
}

- (void)setWr_height:(CGFloat)wr_height {
    CGRect newframe = self.frame;
    newframe.size.height = wr_height;
    self.frame = newframe;

}

- (CGFloat) wr_width
{
	return self.frame.size.width;
}

- (void)setWr_width:(CGFloat)wr_width {

    CGRect newframe = self.frame;
    newframe.size.width = wr_width;
    self.frame = newframe;

}


- (CGFloat)wr_top {
    return self.frame.origin.y;

}

- (void)setWr_top:(CGFloat)wr_top {
    CGRect newframe = self.frame;
    newframe.origin.y = wr_top;
    self.frame = newframe;

}
//- (void) setTop: (CGFloat) newtop
//{
//	CGRect newframe = self.frame;
//	newframe.origin.y = newtop;
//	self.frame = newframe;
//}


- (CGFloat) wr_left
{
	return self.frame.origin.x;
}

- (void)setWr_left:(CGFloat)wr_left {

    CGRect newframe = self.frame;
    newframe.origin.x = wr_left;
    self.frame = newframe;

}
//- (void) setLeft: (CGFloat) newleft
//{
//	CGRect newframe = self.frame;
//	newframe.origin.x = newleft;
//	self.frame = newframe;
//}

- (CGFloat) wr_bottom
{
	return self.frame.origin.y + self.frame.size.height;
}

- (void)setWr_bottom:(CGFloat)wr_bottom {

    CGRect newframe = self.frame;
    newframe.origin.y = wr_bottom - self.frame.size.height;
    self.frame = newframe;

}
//- (void) setBottom: (CGFloat) newbottom
//{
//	CGRect newframe = self.frame;
//	newframe.origin.y = newbottom - self.frame.size.height;
//	self.frame = newframe;
//}

- (CGFloat) wr_right
{
	return self.frame.origin.x + self.frame.size.width;
}

- (void)setWr_right:(CGFloat)wr_right {

    CGFloat delta = wr_right - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;


}
//- (void) setRight: (CGFloat) newright
//{
//	CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
//	CGRect newframe = self.frame;
//	newframe.origin.x += delta ;
//	self.frame = newframe;
//}

// Move via offset
- (void) moveBy: (CGPoint) delta
{
	CGPoint newcenter = self.center;
	newcenter.x += delta.x;
	newcenter.y += delta.y;
	self.center = newcenter;
}

// Scaling
- (void) scaleBy: (CGFloat) scaleFactor
{
	CGRect newframe = self.frame;
	newframe.size.width *= scaleFactor;
	newframe.size.height *= scaleFactor;
	self.frame = newframe;
}

// Ensure that both dimensions fit within the given size by scaling down
- (void) fitInSize: (CGSize) aSize
{
	CGFloat scale;
	CGRect newframe = self.frame;
	
	if (newframe.size.height && (newframe.size.height > aSize.height))
	{
		scale = aSize.height / newframe.size.height;
		newframe.size.width *= scale;
		newframe.size.height *= scale;
	}
	
	if (newframe.size.width && (newframe.size.width >= aSize.width))
	{
		scale = aSize.width / newframe.size.width;
		newframe.size.width *= scale;
		newframe.size.height *= scale;
	}
	
	self.frame = newframe;	
}
@end
