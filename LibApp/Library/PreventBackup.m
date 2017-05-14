//
//  PreventBackup.m
//  EOESApplicateion
//
//  Created by tasol on 2/22/14.
//  Copyright (c) 2014 tailored. All rights reserved.
//

#import "PreventBackup.h"

@implementation PreventBackup

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
//        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
//    NSLog(@"prevent backup method called without error");
    return success;
}

@end
