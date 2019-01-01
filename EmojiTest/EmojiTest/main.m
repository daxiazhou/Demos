//
//  main.m
//  EmojiTest
//
//  Created by ZDX on 2018/12/20.
//  Copyright © 2018 ZDX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+DetectEmoji.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *emoji = @"😀";
        const unichar hs = [emoji characterAtIndex:0];
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (emoji.length > 1) {
                const unichar ls = [emoji characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                NSLog(@"====> %x", uc);
            }
        }
        
        NSData *data = [emoji dataUsingEncoding:NSUTF32LittleEndianStringEncoding allowLossyConversion:YES];
        uint32_t code = *((uint32_t *)data.bytes);
        NSLog(@"========> %x", code);
    }
    return 0;
}
