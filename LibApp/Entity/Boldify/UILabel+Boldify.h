//
//  UILabel+Boldify.h
//  AMS
//
//  Created by Dipen on 12/11/16.
//  Copyright © 2016 Dipen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Boldify)
- (void) boldSubstring: (NSString*) substring;
- (void) boldRange: (NSRange) range;
@end

