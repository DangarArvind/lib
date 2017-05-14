//
//  WebImageOperations.h
//  EOESApplicateion
//
//  Created by tailored on 11/22/13.
//  Copyright (c) 2013 tailored. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebImageOperations : NSObject
+ (void)processImageDataWithURLString:(NSString *)urlString andBlock:(void (^)(NSData *imageData))processImage;
@end
