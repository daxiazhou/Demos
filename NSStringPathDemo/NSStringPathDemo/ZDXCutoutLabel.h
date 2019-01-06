//
//  ZDXCutoutLabel.h
//  NSStringPathDemo
//
//  Created by ZDX on 2019/1/5.
//  Copyright © 2019 none. All rights reserved.
//

#import <UIKit/UIKit.h>

CGRect RectCenteredInRect(CGRect rect, CGRect mainRect);


NS_ASSUME_NONNULL_BEGIN

@interface ZDXCutoutLabel : UIView

- (void)updateWithText:(NSString *)text font:(UIFont *)font;


@end

NS_ASSUME_NONNULL_END
