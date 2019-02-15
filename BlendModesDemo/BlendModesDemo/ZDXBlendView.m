//
//  ZDXBlendView.m
//  BlendModesDemo
//
//  Created by 周舟 on 2019/2/14.
//  Copyright © 2019 none. All rights reserved.
//

#import "ZDXBlendView.h"

@implementation ZDXBlendView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 1.0;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIImage *destinationImg = [UIImage imageNamed:@"destination.png"];
    [destinationImg drawInRect:rect blendMode:kCGBlendModeNormal alpha:1.f];

    UIImage *sourceImg = [UIImage imageNamed:@"source.png"];
    [sourceImg drawInRect:rect blendMode:kCGBlendModeSourceOut alpha:1.f];
//    CGContextDrawImage(context, rect, sourceImg);

//    CGContextDrawImage(context, rect, destinationImg);
    
}

@end
