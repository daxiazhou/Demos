//
//  ZDXHollowLabel.m
//  NSStringPathDemo
//
//  Created by 周舟 on 2019/1/22.
//  Copyright © 2019 none. All rights reserved.
//

#import "ZDXHollowLabel.h"

@implementation ZDXHollowLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 圆角
    if (self.cornerRadius) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.cornerRadius];
        [path addClip];
        CGContextAddPath(context, path.CGPath);
    }
    
    CGContextSaveGState(context);
    if (self.fillColor) {
        [self.fillColor setFill];
        UIRectFill(rect);
    }
    
    CGContextSetBlendMode(context, kCGBlendModeDestinationOut);
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.font = self.font;
    label.text = self.text;
    label.textAlignment = self.textAlignment;
    label.backgroundColor = [UIColor clearColor];
    [label.layer drawInContext:context];
    CGContextRestoreGState(context);
    
    UIColor *textColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    [textColor setFill];
    UIRectFillUsingBlendMode(rect, kCGBlendModeDestinationOver);
}

- (void)setText:(NSString *)text
{
    if (_text != text) {
        _text = text;
        [self setNeedsDisplay];
    }
}

- (void)setFont:(UIFont *)font
{
    if (_font != font) {
        _font = font;
        [self setNeedsDisplay];
    }
}

- (void)setFillColor:(UIColor *)fillColor
{
    if (_fillColor != fillColor) {
        _fillColor = fillColor;
        [self setNeedsDisplay];
    }
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    if (_cornerRadius != cornerRadius) {
        _cornerRadius = cornerRadius;
        [self setNeedsDisplay];
    }
}

@end
