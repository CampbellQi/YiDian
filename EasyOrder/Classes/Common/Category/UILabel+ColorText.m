//
//  UILabel+ColorText.m
//  testColorString
//
//  Created by fengwanqi on 16/3/25.
//  Copyright © 2016年 fengwanqi. All rights reserved.
//

#import "UILabel+ColorText.h"

@implementation UILabel (ColorText)
- (void)setColor:(UIColor *)color withString:(NSString *)aString {
    NSMutableAttributedString *sourceStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange range = NSMakeRange([[self text] rangeOfString:aString].location, aString.length);
    if (range.location != NSNotFound) {
        [sourceStr addAttribute:NSForegroundColorAttributeName value:color range:range];
        self.attributedText = sourceStr;
    }
}
@end
