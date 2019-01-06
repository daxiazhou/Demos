//
//  ZDXBasicTextView.m
//  NSStringPathDemo
//
//  Created by ZDX on 2019/1/6.
//  Copyright © 2019 none. All rights reserved.
//

#import "ZDXBasicTextView.h"
#import <CoreText/CoreText.h>

@implementation ZDXBasicTextView

- (void)drawRect:(CGRect)rect
{
    // 1. 获取 context
    CGContextRef context = UIGraphicsGetCurrentContext();

    // 2. 翻转坐标系
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);

    // 3. CTFramesetterRef
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self.attrString);

    // 4. 创建绘制区域
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    
    // 5. 创建 CTFrame
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, self.attrString.length), path, NULL);

    
    // 6. 绘制
    //CTFrameDraw(frame, context);
    
    // 逐行绘制
    CFArrayRef Lines = CTFrameGetLines(frame);
    CFIndex lineCount = CFArrayGetCount(Lines);
    CGPoint origins[lineCount];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins);
    for (CFIndex i = 0 ; i < lineCount; i ++) {
        CTLineRef line = CFArrayGetValueAtIndex(Lines, i);
        
        CGPoint lineOrigin = origins[i];
        CGContextSetTextPosition(context, lineOrigin.x, lineOrigin.y);

        CGRect lineBounds = CTLineGetImageBounds((CTLineRef)line, context);
        NSLog(@"lineBounds = %@",NSStringFromCGRect(lineBounds));
        
        CGContextSetLineWidth(context, 1.0);
        CGContextAddRect(context, lineBounds);
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGContextStrokeRect(context, lineBounds);
        CTLineDraw(line, context);
    }
    
    CFRelease(frame);
    CFRelease(path);
    CFRelease(frameSetter);
}

- (void)setAttrString:(NSAttributedString *)attrString
{
    if (_attrString != attrString) {
        _attrString = attrString;
        [self setNeedsDisplay];
    }
}

@end
