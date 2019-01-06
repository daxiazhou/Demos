//
//  ZDXCutoutLabel.m
//  NSStringPathDemo
//
//  Created by ZDX on 2019/1/5.
//  Copyright © 2019 none. All rights reserved.
//

#import "ZDXCutoutLabel.h"
#import "UIBezierPath+TextPath.h"

CGRect RectCenteredInRect(CGRect rect, CGRect mainRect)
{
    CGFloat dx = CGRectGetMidX(mainRect)-CGRectGetMidX(rect);
    CGFloat dy = CGRectGetMidY(mainRect)-CGRectGetMidY(rect);
    return CGRectOffset(rect, dx, dy);
}

@interface ZDXCutoutLabel ()

@end

@implementation ZDXCutoutLabel

- (void)updateWithText:(NSString *)text font:(UIFont *)font
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
    UIBezierPath *textPath = [UIBezierPath singleLinePathWithText:text font:font];
    
    CGRect textRect = CGPathGetPathBoundingBox(textPath.CGPath);
    CGRect centerRect = RectCenteredInRect(textRect, self.bounds);
    CGAffineTransform tansform = CGAffineTransformMakeTranslation(centerRect.origin.x - textRect.origin.x, centerRect.origin.y - textRect.origin.y);
    [textPath applyTransform:tansform];
    [path appendPath:textPath];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = [path CGPath];
    self.layer.mask = pathLayer;
}

@end
