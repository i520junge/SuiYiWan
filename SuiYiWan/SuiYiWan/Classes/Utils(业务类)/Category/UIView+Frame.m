//
//  UIView+Frame.m
//  SuiYiWan
//
//  Created by 刘军 on 16/10/16.
//  Copyright © 2016年 JunGe. All rights reserved.
//


#import "UIView+Frame.h"


@implementation UIView (Frame)

- (CGFloat)JG_x
{
    return self.frame.origin.x;
}

- (void)setJG_x:(CGFloat)JG_x
{
    CGRect frame = self.frame;
    frame.origin.x = JG_x;
    self.frame = frame;
}

- (CGFloat)JG_y
{
    return self.frame.origin.y;
}
- (void)setJG_y:(CGFloat)JG_y
{
    CGRect frame = self.frame;
    frame.origin.y = JG_y;
    self.frame = frame;
}

- (CGFloat)JG_width
{
    return self.frame.size.width;
    
}

- (void)setJG_width:(CGFloat)JG_width
{
    CGRect frame = self.frame;
    frame.size.width = JG_width;
    self.frame = frame;
}
- (CGFloat)JG_height
{
    return self.frame.size.height;
}

- (void)setJG_height:(CGFloat)JG_height
{
    CGRect frame = self.frame;
    frame.size.height = JG_height;
    self.frame = frame;
}

- (CGFloat)JG_centerX
{
    return self.center.x;
}
- (void)setJG_centerX:(CGFloat)JG_centerX
{
    CGPoint center = self.center;
    center.x = JG_centerX;
    self.center = center;
}

- (CGFloat)JG_centerY
{
    return self.center.y;
}

- (void)setJG_centerY:(CGFloat)JG_centerY
{
    CGPoint center = self.center;
    center.y = JG_centerY;
    self.center = center;
}
@end
