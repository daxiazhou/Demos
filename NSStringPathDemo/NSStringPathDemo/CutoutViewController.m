//
//  CutoutViewController.m
//  NSStringPathDemo
//
//  Created by ZDX on 2019/1/5.
//  Copyright © 2019 none. All rights reserved.
//

#import "CutoutViewController.h"
#import "ZDXCutoutLabel.h"
#import <ImageIO/ImageIO.h>
#import "ZDXHollowLabel.h"

@interface CutoutViewController ()

@property (nonatomic, strong) UIImageView *backView;
@property (nonatomic, strong) UIView *grayView;

@property (nonatomic, strong) ZDXCutoutLabel *label;

@end

@implementation CutoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    self.backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 300)];
    [self.view addSubview:self.backView];
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"timg" withExtension:@"gif"];
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef) fileUrl, NULL);
    size_t frameCout = CGImageSourceGetCount(gifSource);
    NSMutableArray *frames = [[NSMutableArray alloc] init];
    for (size_t i = 0; i < frameCout; i++) {
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
        UIImage *imageName = [UIImage imageWithCGImage:imageRef];
        [frames addObject:imageName];
        CGImageRelease(imageRef);
    }
    self.backView.animationImages = frames;
    self.backView.animationDuration = 0.1;
    [self.backView startAnimating];
    
    self.grayView = [[UIView alloc] initWithFrame:self.backView.bounds];
    self.grayView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    [self.backView addSubview:self.grayView];
    
    self.label = [[ZDXCutoutLabel alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 300)];
//    [self.view addSubview:self.label];
    self.label.backgroundColor = [UIColor whiteColor];
    [self.label updateWithText:@"这是镂空文字"
                          font:[UIFont boldSystemFontOfSize:60]];
    
    
    ZDXHollowLabel *label = [[ZDXHollowLabel alloc] init];
    label.text = @"镂空字体";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:50];
    label.frame = CGRectMake(0, 100, self.view.bounds.size.width, 100);
    label.fillColor = [UIColor whiteColor];
    
    [self.view addSubview:label];
}


@end
