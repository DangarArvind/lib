//
//  WebImageOperations.m
//  EOESApplicateion
//
//  Created by tailored on 11/22/13.
//  Copyright (c) 2013 tailored. All rights reserved.
//

#import "WebImageOperations.h"

@implementation WebImageOperations
+ (void)processImageDataWithURLString:(NSString *)urlString andBlock:(void (^)(NSData *imageData))processImage
{
//    NSLog(@"URL Out %@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
//    NSLog(@"URL Out1 %@",url);
    
//    dispatch_queue_t callerQueue = ;
    dispatch_queue_t downloadQueue = dispatch_queue_create("com.myapp.processsmagequeue", NULL);
    dispatch_async(downloadQueue, ^{
//            NSLog(@"URL IN1 %@",url);
        NSData * imageData = [NSData dataWithContentsOfURL:url];
        
        dispatch_async(dispatch_get_main_queue(), ^{
//                            NSLog(@"webimageIN1");
            processImage(imageData);
//                            NSLog(@"webimageIN1");
        });
    });
  //  dispatch_release(downloadQueue);
}
@end