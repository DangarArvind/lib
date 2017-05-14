//
//  UILabel+Boldify.m
//  AMS
//
//  Created by Dipen on 12/11/16.
//  Copyright © 2016 Dipen. All rights reserved.
//

#import "UILabel+Boldify.h"

#import "UILabel+Boldify.h"





@implementation UILabel (Boldify)
- (void)boldRange:(NSRange)range {
    if (![self respondsToSelector:@selector(setAttributedText:)]) {
        return;
    }
    NSMutableAttributedString *attributedText;
    if (!self.attributedText) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    }
    
    [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:self.font.pointSize]} range:range];
    self.attributedText = attributedText;
}

- (void)boldSubstring:(NSString*)substring {
    if(!substring) return;
    NSRange range = [self.text rangeOfString:substring];
    [self boldRange:range];
}
@end
