//
//  BasicViewController.m
//  NSStringPathDemo
//
//  Created by ZDX on 2019/1/6.
//  Copyright © 2019 none. All rights reserved.
//

#import "BasicViewController.h"
#import "ZDXBasicTextView.h"

@interface BasicViewController ()

@property (nonatomic, strong) ZDXBasicTextView *textView;

@end

@implementation BasicViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.textView = [[ZDXBasicTextView alloc] initWithFrame:CGRectMake(10, 150, 300, 300)];
    self.textView.backgroundColor = [UIColor whiteColor];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"UIBezierPath继承自NSObject，位于UIKit框架中，是Core Graphics框架中与路径相关的功能的封装。在iOS3.2及更高版本中，可以使用UIBezierPath创建基于向量的路径、绘制路径的轮廓、填充路径包围的空间等。\n 其中路径可以定义简单的形状，如矩形，椭圆或弧形，也可以定义复合多边形，包含直线和曲线段的混合。"];
    [attrString addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:17 weight:UIFontWeightMedium]
                       range:NSMakeRange(0, attrString.length)];
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:[UIColor blueColor]
                       range:NSMakeRange(0, attrString.length)];
    
    self.textView.attrString = attrString;
    [self.view addSubview:self.textView];
    
    
}

@end
