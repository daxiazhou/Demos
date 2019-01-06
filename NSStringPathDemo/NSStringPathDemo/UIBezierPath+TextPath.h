//
//  UIBezierPath+TextPath.h
//  NSStringPathDemo
//
//  Created by ZDX on 2019/1/5.
//  Copyright © 2019 none. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBezierPath (TextPath)

+ (UIBezierPath *)singleLinePathWithText:(NSString *)text font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
