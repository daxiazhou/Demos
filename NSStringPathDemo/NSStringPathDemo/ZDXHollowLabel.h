//
//  ZDXHollowLabel.h
//  NSStringPathDemo
//
//  Created by 周舟 on 2019/1/22.
//  Copyright © 2019 none. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZDXHollowLabel : UIView

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) CGFloat cornerRadius;

@end

NS_ASSUME_NONNULL_END
