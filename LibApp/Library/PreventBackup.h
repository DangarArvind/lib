//
//  PreventBackup.h
//  EOESApplicateion
//
//  Created by tasol on 2/22/14.
//  Copyright (c) 2014 tailored. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PreventBackup : NSObject
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;
@end
