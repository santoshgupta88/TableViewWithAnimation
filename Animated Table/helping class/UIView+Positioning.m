//
//  UIView+Positioning.m
//  Animated Table
//
//  Created by Santosh Gupta on 18/06/13.
//

#import "UIView+Positioning.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (Positioning)

- (void) setOrigin:(float)x :(float)y
{
    self.layer.anchorPoint = CGPointMake(x, y);
}

- (void) resetOriginToTopLeft
{
    [self setOrigin:0 :0];
    [self setCenter:CGPointMake(0, 0)];
}

- (void) resetOriginToTopRight
{
    [self setOrigin:0 :0];
    [self setCenter:CGPointMake(0, 0)];
}

@end
