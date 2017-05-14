//
//  NSUtil.m
//  Intafy
//
//  Created by tasol on 2/11/14.
//  Copyright (c) 2014 tasol. All rights reserved.
//

#import "NSUtil.h"
#import "WebImageOperations.h"
#import "PreventBackup.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSUtil
+(NSString*)getJsonStringFromDictionary:(NSDictionary*)dictionary{
    NSString *jsonString=@"";
    @try {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        
        if (!jsonData) {
            NSLog(@"JsonError: %@", error);
        } else {
            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }

    }
    @catch (NSException *exception) {
        NSLog(@"exception: %@", exception);
    }
    @finally {
        
    }
    return jsonString;
}
+(NSArray*)shortDirectoryArray:(NSArray*)arrayToShort ByKey:(NSString*)key{
    @try {
        return [[arrayToShort sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            NSString *first = [((NSDictionary*)a) valueForKey:key];
            NSString *second = [((NSDictionary*)b) valueForKey:key];
            return [first compare:second];
        }] mutableCopy];
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}

+(NSString *)storeImageInLocal:(UIImage *)image
{
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *strImageName = [NSString stringWithFormat:@"%f.jpg",[[NSDate date] timeIntervalSince1970]];
    NSData *imgData = UIImageJPEGRepresentation(image, 1.0);
    NSString *imgPath = [NSString stringWithFormat:@"%@/%@",docDir,strImageName];
    [imgData writeToFile:imgPath atomically:YES];
    
    return  strImageName;
}

+(void)getImageForView:(UIView*)imageView fromURL:(NSString *)imgUrl alterText:(NSString*)alterText{
    @try {
        
        // Get an image from the URL below
        // Let's save the file into Document folder.
        // You can also change this to your desktop for testing. (e.g. /Users/kiichi/Desktop/)
        // NSString *deskTopDir = @"/Users/kiichi/Desktop";
        
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        // If you go to the folder below, you will find those pictures
//        NSLog(@"CHECK URL%@",imgUrl);
        
        
//        NSLog(@"saving jpeg");
        if(!imgUrl ||imgUrl.length==0)
        {
            
            return;
        }
        
        // ImgUrl = [ImgUrl stringByReplacingOccurrencesOfString:@" " withString:@""];
        imgUrl = [imgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSArray *arratemp = [imgUrl componentsSeparatedByString:@"/"];
        NSString *imgPath = [NSString stringWithFormat:@"%@/%@",docDir,[arratemp lastObject]];
        NSURL *pathURL= [NSURL fileURLWithPath:imgPath];
        [PreventBackup addSkipBackupAttributeToItemAtURL:pathURL];
        NSFileManager *filemgr = [NSFileManager defaultManager];
        BOOL isFileExist = [filemgr fileExistsAtPath:imgPath];
        if(!isFileExist)
        {
            //    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:ImgUrl]]];
            __block UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            indicatorView.frame=CGRectMake((imageView.frame.size.width-37)/2, (imageView.frame.size.height-37)/2, 37, 37);
            indicatorView.color = [UIColor colorWithRed:90.0/255.0 green:200.0/255.0 blue:175.0/255.0 alpha:1];
            [indicatorView startAnimating];
            [imageView addSubview:indicatorView];
            
            indicatorView.translatesAutoresizingMaskIntoConstraints=NO;
            
            [imageView addConstraint:[NSLayoutConstraint constraintWithItem:indicatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
            [imageView addConstraint:[NSLayoutConstraint constraintWithItem:indicatorView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
            
            [WebImageOperations processImageDataWithURLString:imgUrl andBlock:^(NSData *imageData)
            {
//                NSLog(@"webimage1");
                [imageData writeToFile:imgPath atomically:YES];
                [indicatorView removeFromSuperview];
                
                if([imageView isKindOfClass:[UIImageView class]])
                {
                    UIImage *image = [UIImage imageWithData:imageData];
                    ((UIImageView*)imageView).image = image;
                    [((UIImageView*)imageView) setImage:image];
                }
                else if([imageView isKindOfClass:[UIButton class]])
                {
                    [((UIButton*)imageView) setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
                }
            }];
            
        }
        else
        {
            if([imageView isKindOfClass:[UIImageView class]])
            {
                UIImage *image =[UIImage imageWithContentsOfFile:imgPath];
                ((UIImageView*)imageView).image = image;
                [((UIImageView*)imageView) setImage:image];
            }else if([imageView isKindOfClass:[UIButton class]])
            {
                [((UIButton*)imageView) setImage:[UIImage imageWithContentsOfFile:imgPath] forState:UIControlStateNormal];
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Exception :%@",exception);
    }
    @finally {
        
    }
}

+(void)getImageForView1:(UIView*)imageView fromURL:(NSString *)imgUrl alterText:(NSString*)alterText{
    @try {
        
        // Get an image from the URL below
        // Let's save the file into Document folder.
        // You can also change this to your desktop for testing. (e.g. /Users/kiichi/Desktop/)
        // NSString *deskTopDir = @"/Users/kiichi/Desktop";
        
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        // If you go to the folder below, you will find those pictures
//        NSLog(@"CHECK URL%@",imgUrl);
        
        
//        NSLog(@"saving jpeg");
        if(!imgUrl ||imgUrl.length==0)
        {
            
            return;
        }
        
        // ImgUrl = [ImgUrl stringByReplacingOccurrencesOfString:@" " withString:@""];
        imgUrl = [imgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSArray *arratemp = [imgUrl componentsSeparatedByString:@"/"];
        NSString *imgPath = [NSString stringWithFormat:@"%@/%@",docDir,[arratemp lastObject]];
        NSURL *pathURL= [NSURL fileURLWithPath:imgPath];
        [PreventBackup addSkipBackupAttributeToItemAtURL:pathURL];
        NSFileManager *filemgr = [NSFileManager defaultManager];
        BOOL isFileExist = [filemgr fileExistsAtPath:imgPath];
        if(!isFileExist)
        {
            //    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:ImgUrl]]];
            __block UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            
            indicatorView.frame=CGRectMake((imageView.frame.size.width-37)/2, (imageView.frame.size.height-37)/2, 37, 37);
            
            indicatorView.color = [UIColor colorWithRed:90.0/255.0 green:200.0/255.0 blue:175.0/255.0 alpha:1];
            [indicatorView startAnimating];
            [imageView addSubview:indicatorView];
            
            indicatorView.translatesAutoresizingMaskIntoConstraints=NO;

            [imageView addConstraint:[NSLayoutConstraint constraintWithItem:indicatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
            [imageView addConstraint:[NSLayoutConstraint constraintWithItem:indicatorView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
            
            [WebImageOperations processImageDataWithURLString:imgUrl andBlock:^(NSData *imageData) {
//                NSLog(@"webimage1");
                [imageData writeToFile:imgPath atomically:YES];
                [indicatorView removeFromSuperview];
                if([imageView isKindOfClass:[UIImageView class]])
                {
                    UIImage *image;
                    @try
                    {
                        image = [UIImage imageWithData:imageData];
                    }
                    @catch (NSException *exception) {
                    }
                    @finally
                    {
                    }
                    if (!image) {
                        image = [UIImage imageNamed:@"user-Male.png"];
                        
                    }
                    
//                    ((UIImageView*)imageView).image = image;
//                    [((UIImageView*)imageView) setImage:image];
                    [NSUtil cropImage:image forView:((UIImageView*)imageView)];
                }
                else if([imageView isKindOfClass:[UIButton class]]){
                    [((UIButton*)imageView) setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
                }
//                NSLog(@"webimage2");
            }];
            
        }else{
//            NSLog(@"webimage3");
            if([imageView isKindOfClass:[UIImageView class]]){
                UIImage *image =[UIImage imageWithContentsOfFile:imgPath];
//                ((UIImageView*)imageView).image = image;
//                [((UIImageView*)imageView) setImage:image];
                [NSUtil cropImage:image forView:((UIImageView*)imageView)];
            }
            else if([imageView isKindOfClass:[UIButton class]]){
                [((UIButton*)imageView) setImage:[UIImage imageWithContentsOfFile:imgPath] forState:UIControlStateNormal];
            }
//            NSLog(@"webimage5");
            
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Exception :%@",exception);
    }
    @finally {
        
    }
}

+(void)getImageForViewWithCatch:(UIView*)imageView fromURL:(NSString *)imgUrl alterText:(NSString*)alterText catch:(NSCache *)catchImage
{
    @try {
        
        // Get an image from the URL below
        // Let's save the file into Document folder.
        // You can also change this to your desktop for testing. (e.g. /Users/kiichi/Desktop/)
        // NSString *deskTopDir = @"/Users/kiichi/Desktop";
        
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        // If you go to the folder below, you will find those pictures
        //        NSLog(@"CHECK URL%@",imgUrl);
        
        
        //        NSLog(@"saving jpeg");
        if(!imgUrl ||imgUrl.length==0)
        {
            
            return;
        }
        
        // ImgUrl = [ImgUrl stringByReplacingOccurrencesOfString:@" " withString:@""];
        imgUrl = [imgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSArray *arratemp = [imgUrl componentsSeparatedByString:@"/"];
        NSString *imgPath = [NSString stringWithFormat:@"%@/%@",docDir,[arratemp lastObject]];
        NSURL *pathURL= [NSURL fileURLWithPath:imgPath];
        [PreventBackup addSkipBackupAttributeToItemAtURL:pathURL];
        NSFileManager *filemgr = [NSFileManager defaultManager];
        BOOL isFileExist = [filemgr fileExistsAtPath:imgPath];
        if(!isFileExist)
        {
            //    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:ImgUrl]]];
            __block UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            
            indicatorView.frame=CGRectMake((imageView.frame.size.width-37)/2, (imageView.frame.size.height-37)/2, 37, 37);
            
            indicatorView.color = [UIColor colorWithRed:90.0/255.0 green:200.0/255.0 blue:175.0/255.0 alpha:1];
            [indicatorView startAnimating];
            [imageView addSubview:indicatorView];
            
            indicatorView.translatesAutoresizingMaskIntoConstraints=NO;
            
            [imageView addConstraint:[NSLayoutConstraint constraintWithItem:indicatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
            [imageView addConstraint:[NSLayoutConstraint constraintWithItem:indicatorView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
            
            [WebImageOperations processImageDataWithURLString:imgUrl andBlock:^(NSData *imageData) {
                //                NSLog(@"webimage1");
                [imageData writeToFile:imgPath atomically:YES];
                [indicatorView removeFromSuperview];
                if([imageView isKindOfClass:[UIImageView class]]){
                    
                    UIImage *image;
                    @try {
                        
                        if (catchImage == nil)
                        {
                            image = [UIImage imageWithData:imageData];
                        }
                        else
                        {
                            image = [catchImage objectForKey:[arratemp lastObject]];
                            if (image == nil)
                            {
                                image = [UIImage imageWithData:imageData];
                                [catchImage setObject:image forKey:[arratemp lastObject]];
                            }
                        }
                    }
                    @catch (NSException *exception) {
                    }
                    @finally {
                    }
                    //                    if (!image) {
                    //                        image = [UIImage imageNamed:@"user-Male.png"];
                    //
                    //                    }
                    
                    //                    ((UIImageView*)imageView).image = image;
                    //                    [((UIImageView*)imageView) setImage:image];
                    [NSUtil cropImage:image forView:((UIImageView*)imageView)];
                }
                //                else if([imageView isKindOfClass:[UIButton class]]){
                //                    [((UIButton*)imageView) setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
                //                }
                //                NSLog(@"webimage2");
            }];
            
        }else{
            //            NSLog(@"webimage3");
            if([imageView isKindOfClass:[UIImageView class]])
            {
                UIImage *image;
                
                if (catchImage == nil)
                {
                    image =[UIImage imageWithContentsOfFile:imgPath];
                }
                else
                {
                    image = [catchImage objectForKey:[arratemp lastObject]];
                    
                    if (image == nil)
                    {
                        image =[UIImage imageWithContentsOfFile:imgPath];
                        [catchImage setObject:image forKey:[arratemp lastObject]];
                    }
                }
                
                //                ((UIImageView*)imageView).image = image;
                //                [((UIImageView*)imageView) setImage:image];
                [NSUtil cropImage:image forView:((UIImageView*)imageView)];
            }
            //            else if([imageView isKindOfClass:[UIButton class]]){
            //                [((UIButton*)imageView) setImage:[UIImage imageWithContentsOfFile:imgPath] forState:UIControlStateNormal];
            //                
            //            }
            //            NSLog(@"webimage5");
            
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Exception :%@",exception);
    }
    @finally {
        
    }
}

+(void)getImageForView:(UIView*)imageView fromURL:(NSString *)imgUrl forTableCell:(UITableViewCell*)cell{
    @try {
        
        // Get an image from the URL below
        // Let's save the file into Document folder.
        // You can also change this to your desktop for testing. (e.g. /Users/kiichi/Desktop/)
        // NSString *deskTopDir = @"/Users/kiichi/Desktop";
        
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        // If you go to the folder below, you will find those pictures
        //        NSLog(@"CHECK URL%@",imgUrl);
        
        
        //        NSLog(@"saving jpeg");
        if(!imgUrl ||imgUrl.length==0)
        {
            
            return;
        }
        
        // ImgUrl = [ImgUrl stringByReplacingOccurrencesOfString:@" " withString:@""];
        imgUrl = [imgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSArray *arratemp = [imgUrl componentsSeparatedByString:@"/"];
        NSString *imgPath = [NSString stringWithFormat:@"%@/%@",docDir,[arratemp lastObject]];
        NSURL *pathURL= [NSURL fileURLWithPath:imgPath];
        [PreventBackup addSkipBackupAttributeToItemAtURL:pathURL];
        NSFileManager *filemgr = [NSFileManager defaultManager];
        BOOL isFileExist = [filemgr fileExistsAtPath:imgPath];
        if(!isFileExist)
        {
            //    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:ImgUrl]]];
            __block UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            indicatorView.frame=CGRectMake((imageView.frame.size.width-37)/2, (imageView.frame.size.height-37)/2, 37, 37);
            indicatorView.color = [UIColor colorWithRed:90.0/255.0 green:200.0/255.0 blue:175.0/255.0 alpha:1];
            [indicatorView startAnimating];
            [imageView addSubview:indicatorView];
            [WebImageOperations processImageDataWithURLString:imgUrl andBlock:^(NSData *imageData) {
                //                NSLog(@"webimage1");
                [imageData writeToFile:imgPath atomically:YES];
                [indicatorView removeFromSuperview];
                if([imageView isKindOfClass:[UIImageView class]]){
                    UIImage *image = [UIImage imageWithData:imageData];
                    //                    ((UIImageView*)imageView).image = image;
                    //                    [((UIImageView*)imageView) setImage:image];
                    UIView *parentForCell = [[[imageView superview] superview] superview];
//                    NSLog(@"parentForCell :- %@",[parentForCell class]);
//                    NSLog(@"good JOB :- %@",[parentForCell class]);
                    if ([parentForCell isKindOfClass:[UITableView class]]) {
                        [((UITableView*)parentForCell) reloadData];
                    }
                    [((UIImageView*)imageView) setImage:image];
//                    [NSUtil cropImage:image forView:((UIImageView*)imageView)];
                }
                //                else if([imageView isKindOfClass:[UIButton class]]){
                //                    [((UIButton*)imageView) setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
                //                }
                //                NSLog(@"webimage2");
            }];
            
        }else{
            //            NSLog(@"webimage3");
            if([imageView isKindOfClass:[UIImageView class]]){
                UIImage *image =[UIImage imageWithContentsOfFile:imgPath];
                //                ((UIImageView*)imageView).image = image;
                //                [((UIImageView*)imageView) setImage:image];
                [((UIImageView*)imageView) setImage:image];
//                [NSUtil cropImage:image forView:((UIImageView*)imageView)];
            }
            //            else if([imageView isKindOfClass:[UIButton class]]){
            //                [((UIButton*)imageView) setImage:[UIImage imageWithContentsOfFile:imgPath] forState:UIControlStateNormal];
            //
            //            }
            //            NSLog(@"webimage5");
            
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Exception :%@",exception);
    }
    @finally {
        
    }
}


+(CGSize)getHeightForWidth:(CGSize)imgSize{
    @try {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        
        float scalRatio = screenSize.width/imgSize.width;
        imgSize.height = imgSize.height*scalRatio;
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
    return imgSize;
}
+(void)getImageForView2:(UIView*)imageView fromURL:(NSString *)imgUrl alterText:(NSString*)alterText{
    @try {
        
        // Get an image from the URL below
        // Let's save the file into Document folder.
        // You can also change this to your desktop for testing. (e.g. /Users/kiichi/Desktop/)
        // NSString *deskTopDir = @"/Users/kiichi/Desktop";
        
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        // If you go to the folder below, you will find those pictures
        //        NSLog(@"CHECK URL%@",imgUrl);
        
        
        //        NSLog(@"saving jpeg");
        if(!imgUrl ||imgUrl.length==0)
        {
            
            return;
        }
        
        // ImgUrl = [ImgUrl stringByReplacingOccurrencesOfString:@" " withString:@""];
        imgUrl = [imgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSArray *arratemp = [imgUrl componentsSeparatedByString:@"/"];
        NSString *imgPath = [NSString stringWithFormat:@"%@/%@",docDir,[arratemp lastObject]];
        NSURL *pathURL= [NSURL fileURLWithPath:imgPath];
        [PreventBackup addSkipBackupAttributeToItemAtURL:pathURL];
        NSFileManager *filemgr = [NSFileManager defaultManager];
        BOOL isFileExist = [filemgr fileExistsAtPath:imgPath];
        if(!isFileExist)
        {
            //    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:ImgUrl]]];
            __block UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            indicatorView.frame=CGRectMake((imageView.frame.size.width-37)/2, (imageView.frame.size.height-37)/2, 37, 37);
            indicatorView.color = [UIColor colorWithRed:90.0/255.0 green:200.0/255.0 blue:175.0/255.0 alpha:1];
            [indicatorView startAnimating];
            [imageView addSubview:indicatorView];
            [WebImageOperations processImageDataWithURLString:imgUrl andBlock:^(NSData *imageData) {
//                NSLog(@"webimage1");
                [imageData writeToFile:imgPath atomically:YES];
                [indicatorView removeFromSuperview];
                if([imageView isKindOfClass:[UIImageView class]]){
                    UIImage *image = [UIImage imageWithData:imageData];
                    //                    ((UIImageView*)imageView).image = image;
                    //                    [((UIImageView*)imageView) setImage:image];
                     ((UIImageView*)imageView).image=[NSUtil cropImageFromMiddle:image];
                }
                //                else if([imageView isKindOfClass:[UIButton class]]){
                //                    [((UIButton*)imageView) setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
                //                }
//                NSLog(@"webimage2");
            }];
            
        }else{
//            NSLog(@"webimage3");
            if([imageView isKindOfClass:[UIImageView class]]){
                UIImage *image =[UIImage imageWithContentsOfFile:imgPath];
                //                ((UIImageView*)imageView).image = image;
                //                [((UIImageView*)imageView) setImage:image];
               ((UIImageView*)imageView).image=[NSUtil cropImageFromMiddle:image];
            }
            //            else if([imageView isKindOfClass:[UIButton class]]){
            //                [((UIButton*)imageView) setImage:[UIImage imageWithContentsOfFile:imgPath] forState:UIControlStateNormal];
            //
            //            }
//            NSLog(@"webimage5");
            
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Exception :%@",exception);
    }
    @finally {
        
    }
}

+(UIImage*)getImageFromURL:(NSString *)imgUrl
{
    @try {
        
        // Get an image from the URL below
        // Let's save the file into Document folder.
        // You can also change this to your desktop for testing. (e.g. /Users/kiichi/Desktop/)
        // NSString *deskTopDir = @"/Users/kiichi/Desktop";
        
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        // If you go to the folder below, you will find those pictures
//        NSLog(@"%@",docDir);
        
        
//        NSLog(@"saving jpeg");
//
        imgUrl = [imgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSArray *arratemp = [imgUrl componentsSeparatedByString:@"/"];
        NSString *imgPath = [NSString stringWithFormat:@"%@/%@",docDir,[arratemp lastObject]];
        NSURL *pathURL= [NSURL fileURLWithPath:imgPath];
        [PreventBackup addSkipBackupAttributeToItemAtURL:pathURL];
        NSFileManager *filemgr = [NSFileManager defaultManager];
        BOOL isFileExist = [filemgr fileExistsAtPath:imgPath];
        if(!isFileExist)
        {
           NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
            [imgData writeToFile:imgPath atomically:YES];
            
            return [UIImage imageWithData:imgData];
        }
        else
        {
         
            return [UIImage imageWithContentsOfFile:imgPath];
            
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Exception :%@",exception);
    }
    @finally {
        
    }
}

+(CGSize)getImageSizeFromURL:(NSString *)imgUrl
{
    @try {
        
        // Get an image from the URL below
        // Let's save the file into Document folder.
        // You can also change this to your desktop for testing. (e.g. /Users/kiichi/Desktop/)
        // NSString *deskTopDir = @"/Users/kiichi/Desktop";
        
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        // If you go to the folder below, you will find those pictures
        //        NSLog(@"%@",docDir);
        //        NSLog(@"saving jpeg");
        //
        imgUrl = [imgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSArray *arratemp = [imgUrl componentsSeparatedByString:@"/"];
        NSString *imgPath = [NSString stringWithFormat:@"%@/%@",docDir,[arratemp lastObject]];
        NSURL *pathURL= [NSURL fileURLWithPath:imgPath];
        [PreventBackup addSkipBackupAttributeToItemAtURL:pathURL];
        NSFileManager *filemgr = [NSFileManager defaultManager];
        BOOL isFileExist = [filemgr fileExistsAtPath:imgPath];
        if(isFileExist)
        {
            CGSize imgSize = [self getHeightForWidth:[UIImage imageWithContentsOfFile:imgPath].size];
            return imgSize;
        }
        else
        {
            return CGSizeMake([UIScreen mainScreen].bounds.size.width, 86);
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Exception :%@",exception);
    }
    @finally {
        
    }
}

+(NSString*)getDataFromURL:(NSString *)imgUrl
{
    @try {
        
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        // If you go to the folder below, you will find those pictures
//        NSLog(@"%@",docDir);
        
        
//        NSLog(@"saving jpeg");
        imgUrl = [imgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSArray *arratemp = [imgUrl componentsSeparatedByString:@"/"];
        NSString *imgPath = [NSString stringWithFormat:@"%@/%@",docDir,[arratemp lastObject]];
        NSURL *pathURL= [NSURL fileURLWithPath:imgPath];
        [PreventBackup addSkipBackupAttributeToItemAtURL:pathURL];
       
        
        NSFileManager *filemgr = [NSFileManager defaultManager];
        BOOL isFileExist = [filemgr fileExistsAtPath:imgPath];
        if(!isFileExist)
        {
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
            [data writeToFile:imgPath atomically:YES];
//            NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
//            [imgData writeToFile:imgPath atomically:YES];
            
//            return data;
        }
//        else
//        {
//            
//            return [NSData dataWithContentsOfFile:imgPath];
//            
//        }
        return imgPath;
            
 
    }
    @catch (NSException *exception) {
        NSLog(@"Exception :%@",exception);
    }
    @finally {
        
    }
}

+(NSString*)convertDate:(NSString*)dateToConver{
    NSString *dateString = @"";
    @try {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [dateFormat dateFromString:dateToConver];
        
        // Convert date object to desired output format
        [dateFormat setDateFormat:@"dd-MMM-yyyy"];
        dateString = [dateFormat stringFromDate:date];
        return dateString;
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }

    
}
+(NSString*)convertDate:(NSString*)dateToConver dateFormate:(NSString*)dateFormate dateFormateToConvert:(NSString*)dateFormateToConvert{
    @try {
        
//        NSString* format = @"yyyy-MM-dd  HH:mm";
        
        // Set up an NSDateFormatter for UTC time zone
        
        NSDateFormatter* formatterUtc = [[NSDateFormatter alloc] init];
        [formatterUtc setDateFormat:dateFormate];
        
        NSDate* utcDate = [formatterUtc dateFromString:dateToConver];
        
        NSTimeZone *currentTimeZone = [NSTimeZone localTimeZone];
        NSTimeZone *utcTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
        
        NSInteger currentGMTOffset = [currentTimeZone secondsFromGMTForDate:utcDate];
        NSInteger gmtOffset = [utcTimeZone secondsFromGMTForDate:utcDate];
        NSTimeInterval gmtInterval = currentGMTOffset - gmtOffset;
        
        NSDate *destinationDate = [[NSDate alloc] initWithTimeInterval:gmtInterval sinceDate:utcDate];
        
        NSDateFormatter *dateFormatters = [[NSDateFormatter alloc] init];
        [dateFormatters setDateFormat:dateFormateToConvert];
        [dateFormatters setTimeZone:[NSTimeZone systemTimeZone]];
        NSString *dateStr = [dateFormatters stringFromDate: destinationDate];
//        NSLog(@"Converted Date : %@", dateStr);
        return dateStr;
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }    
}

+(NSString*)convertDateTimeStamp:(NSString*)timestamp DateFormat:(NSString*)dateFormat
{
    @try
    {
        double unixTime=[timestamp doubleValue];
        NSTimeInterval _interval=unixTime;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
        [_formatter setLocale:[NSLocale currentLocale]];
        [_formatter setDateFormat:dateFormat];
        NSString *_date=[_formatter stringFromDate:date];
        return _date;
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}


+(void)applyCircleAsBorder:(UIButton*)view{
    @try {
        view.layer.borderWidth=1;
//        view.layer.borderColor=[ApplicationConfiguration sharedInstance].buttonBorderColor.CGColor;
        view.layer.cornerRadius=view.frame.size.width/2.0;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@",exception);
    }
    @finally {
        
    }
}

+ (UIImage *)fixrotation:(UIImage *)image{
    
    
    if (image.imageOrientation == UIImageOrientationUp)
        return image;
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (image.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
    
}

+(UIImage*)cropImageFromMiddle:(UIImage *)originalImage{
    @try {
        if (originalImage.size.width==originalImage.size.height) {
            return originalImage;
        }
        originalImage = [self fixrotation:originalImage];
        float size=0;
        float y = 0;
        float x=0;
        if (originalImage.size.width<originalImage.size.height) {
            size =originalImage.size.width;
            y=(originalImage.size.height-originalImage.size.width)/2;
        }else{
            size =originalImage.size.height;
            x=(originalImage.size.width-originalImage.size.height)/2;
            
        }
        
        CGRect clippedRect  = CGRectMake(x, y, size, size);
        
        CGImageRef imageRef = CGImageCreateWithImageInRect([originalImage CGImage], clippedRect);
        UIImage *newImage   = [UIImage imageWithCGImage:imageRef];
        // scale:1.0 orientation:originalImage.imageOrientation
        CGImageRelease(imageRef);
        
        //        newImage = [[UIImage alloc] initWithCGImage:newImage.CGImage scale:0.0f orientation:UIImageOrientationLeftMirrored];
        
        return newImage;
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    return nil;
}

+(void)cropImageFromMiddleVertically:(UIImage *)originalImage forView:(UIImageView *)imageView{
    @try {
        if (originalImage.size.width==originalImage.size.height ||(originalImage.size.width==imageView.frame.size.width&&originalImage.size.height==imageView.frame.size.height)) {
            imageView.image=originalImage;
            return;
        }
        originalImage = [self fixrotation:originalImage];
        float y = 0;
        float x=(originalImage.size.width -(imageView.frame.size.width*2))/2;
//        if (originalImage.size.width<originalImage.size.height) {
//            size =originalImage.size.width;
//            y=(originalImage.size.height-originalImage.size.width)/2;
//        }else{
//            size =originalImage.size.height;
//            x=(originalImage.size.width-originalImage.size.height)/2;
//            
//        }
        
        CGRect clippedRect  = CGRectMake(x, y, (imageView.frame.size.width*2), (imageView.frame.size.height*2));
        
        CGImageRef imageRef = CGImageCreateWithImageInRect([originalImage CGImage], clippedRect);
        UIImage *newImage   = [UIImage imageWithCGImage:imageRef];
        // scale:1.0 orientation:originalImage.imageOrientation
        CGImageRelease(imageRef);
        
        //        newImage = [[UIImage alloc] initWithCGImage:newImage.CGImage scale:0.0f orientation:UIImageOrientationLeftMirrored];
        imageView.image = newImage;

    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }

}


+ (UIImage *) cropImage:(UIImage *)originalImage
{
    NSLog(@"original image orientation:%ld",(long)originalImage.imageOrientation);
    
    //calculate scale factor to go between cropframe and original image
//    flsoat SF = originalImage.size.width / cropSize.width;
    
    //find the centre x,y coordinates of image
//    float centreX = originalImage.size.width / 2;
//    float centreY = originalImage.size.height / 2;
//    
//    //calculate crop parameters
//    float cropX = centreX - ((cropSize.width / 2) * SF);
//    float cropY = centreY - ((cropSize.height / 2) * SF);
    
    CGRect cropRect = CGRectMake(0, 0, originalImage.size.width , originalImage.size.height);
    
    CGAffineTransform rectTransform;
    switch (originalImage.imageOrientation)
    {
        case UIImageOrientationLeft:
            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(M_PI_2), 0, -originalImage.size.height);
            break;
        case UIImageOrientationRight:
            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(-M_PI_2), -originalImage.size.width, 0);
            break;
        case UIImageOrientationDown:
            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(-M_PI), -originalImage.size.width, -originalImage.size.height);
            break;
        default:
            rectTransform = CGAffineTransformIdentity;
    };
    rectTransform = CGAffineTransformScale(rectTransform, originalImage.scale, originalImage.scale);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectApplyAffineTransform(cropRect, rectTransform));
    UIImage *result = [UIImage imageWithCGImage:imageRef scale:originalImage.scale orientation:originalImage.imageOrientation];
    CGImageRelease(imageRef);
    //return result;
    
    //Now want to scale down cropped image!
    //want to multiply frames by 2 to get retina resolution
    CGRect scaledImgRect =  CGRectMake(0, 0, originalImage.size.width , originalImage.size.height);
    
    UIGraphicsBeginImageContextWithOptions(scaledImgRect.size, NO, [UIScreen mainScreen].scale);
    
    [result drawInRect:scaledImgRect];
    
    UIImage *scaledNewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledNewImage;
    
}
+(long)getUTCTimeStamp{
    @try {
        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        NSDate *currentDate = [[NSDate alloc] init];
        NSDateFormatter *dFormat = [[NSDateFormatter alloc] init];
        [dFormat setTimeZone:timeZone];
        [dFormat setDateFormat:@"dd.MM.yyyy HH:mm:ss"];
        NSString *theDate = [dFormat stringFromDate:currentDate];
//        dFormat = [[NSDateFormatter alloc] init];
//        [dFormat setDateFormat:@"dd.MM.yyyy HH:mm:ss"];
        NSDate *date = [dFormat dateFromString:theDate];
        long timestamp = [date timeIntervalSince1970];
        NSLog(@"currentUTC :- %ld",timestamp);

         return timestamp;

        
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
    return 0;
}

+(UIImage *)scaleAndRotateImage :(UIImage*)image
{
    int kMaxResolution = 320; // Or whatever
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 1.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft)
    {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}


+(UIImage*)getYouTubeImageFromURL:(NSString *)imgUrl andID:(NSString*)youtubeID
{
    @try {
        
        // Get an image from the URL below
        // Let's save the file into Document folder.
        // You can also change this to your desktop for testing. (e.g. /Users/kiichi/Desktop/)
        // NSString *deskTopDir = @"/Users/kiichi/Desktop";
        
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        // If you go to the folder below, you will find those pictures
        //        NSLog(@"%@",docDir);
        
        
        //        NSLog(@"saving jpeg");
        //
        imgUrl = [imgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSArray *arratemp = [imgUrl componentsSeparatedByString:@"/"];
        NSString *imgPath = [NSString stringWithFormat:@"%@/%@%@",docDir,youtubeID,[arratemp lastObject]];
        NSURL *pathURL= [NSURL fileURLWithPath:imgPath];
        [PreventBackup addSkipBackupAttributeToItemAtURL:pathURL];
        NSFileManager *filemgr = [NSFileManager defaultManager];
        BOOL isFileExist = [filemgr fileExistsAtPath:imgPath];
        if(!isFileExist)
        {
            NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
            [imgData writeToFile:imgPath atomically:YES];
            
            return [UIImage imageWithData:imgData];
        }
        else
        {
            return [UIImage imageWithContentsOfFile:imgPath];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Exception :%@",exception);
    }
    @finally {
        
    }
}
+(void)cropImage:(UIImage *)originalImage forView:(UIImageView *)imageView{
    @try {
        if (originalImage.size.width==originalImage.size.height ||(originalImage.size.width==imageView.frame.size.width&&originalImage.size.height==imageView.frame.size.height)) {
            imageView.image=originalImage;
           // imageView.contentMode = UIViewContentModeScaleAspectFit;
            return;
        }
        
        if(imageView.frame.size.width/imageView.frame.size.height == originalImage.size.width/originalImage.size.height){
            imageView.image=originalImage;
           // imageView.contentMode = UIViewContentModeScaleAspectFit;
            return;
        }
        
        originalImage = [self fixrotation:originalImage];
        float y = 0;
        float x=(originalImage.size.width -(imageView.frame.size.width*2))/2;
        CGSize size = originalImage.size;
        
        if (imageView.frame.size.width<originalImage.size.width && imageView.frame.size.height<originalImage.size.height) {
            
            if (originalImage.size.width<originalImage.size.height) {
                size = CGSizeMake(originalImage.size.width, imageView.frame.size.height*(originalImage.size.width/imageView.frame.size.width));
                if (size.height>originalImage.size.height) {
                   size = CGSizeMake(imageView.frame.size.width*(originalImage.size.height/imageView.frame.size.height), originalImage.size.height);
                }
                x=0;
                y=(originalImage.size.height -size.height)/2;
                
            }else{
                size = CGSizeMake(imageView.frame.size.width*(originalImage.size.height/imageView.frame.size.height), originalImage.size.height);
                
                if (size.width>originalImage.size.width) {
                    size = CGSizeMake(originalImage.size.width, imageView.frame.size.height*(originalImage.size.width/imageView.frame.size.width));
                }
                x=(originalImage.size.width -size.width)/2;
                y=0;
                
            }
        }else{
            imageView.image=originalImage;
            //imageView.contentMode = UIViewContentModeScaleAspectFit;
            return;
        }
        
        CGRect clippedRect  = CGRectMake(x, y, size.width, size.height);
        
        CGImageRef imageRef = CGImageCreateWithImageInRect([originalImage CGImage], clippedRect);
        UIImage *newImage   = [UIImage imageWithCGImage:imageRef];
        // scale:1.0 orientation:originalImage.imageOrientation
        CGImageRelease(imageRef);
        
        //        newImage = [[UIImage alloc] initWithCGImage:newImage.CGImage scale:0.0f orientation:UIImageOrientationLeftMirrored];
        imageView.image = newImage;
        //imageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

+(void)cropImage1:(UIImage *)originalImage forView:(UIImageView *)imageView{
    @try {
        if (originalImage.size.width==originalImage.size.height ||(originalImage.size.width==imageView.frame.size.width&&originalImage.size.height==imageView.frame.size.height)) {
            imageView.image=originalImage;
            return;
        }
        
        if(imageView.frame.size.width/imageView.frame.size.height == originalImage.size.width/originalImage.size.height){
            imageView.image=originalImage;
            return;
        }
        
        originalImage = [self fixrotation:originalImage];
        float y = 0;
        float x=(originalImage.size.width -(imageView.frame.size.width*2))/2;
        CGSize size = originalImage.size;
        
        if (imageView.frame.size.width<originalImage.size.width || imageView.frame.size.height<originalImage.size.height) {
            
            if (originalImage.size.width<originalImage.size.height) {
                size = CGSizeMake(originalImage.size.width, imageView.frame.size.height*(originalImage.size.width/imageView.frame.size.width));
                if (size.height>originalImage.size.height) {
                    size = CGSizeMake(imageView.frame.size.width*(originalImage.size.height/imageView.frame.size.height), originalImage.size.height);
                }
                x=0;
                y=(originalImage.size.height -size.height)/2;
                
            }else{
                size = CGSizeMake(imageView.frame.size.width*(originalImage.size.height/imageView.frame.size.height), originalImage.size.height);
                
                if (size.width>originalImage.size.width) {
                    size = CGSizeMake(originalImage.size.width, imageView.frame.size.height*(originalImage.size.width/imageView.frame.size.width));
                }
                x=(originalImage.size.width -size.width)/2;
                y=0;
                
            }
        }else{
            imageView.image=originalImage;
            return;
        }
        
        CGRect clippedRect  = CGRectMake(x, y, size.width, size.height);
        
        CGImageRef imageRef = CGImageCreateWithImageInRect([originalImage CGImage], clippedRect);
        UIImage *newImage   = [UIImage imageWithCGImage:imageRef];
        // scale:1.0 orientation:originalImage.imageOrientation
        CGImageRelease(imageRef);
        
        //        newImage = [[UIImage alloc] initWithCGImage:newImage.CGImage scale:0.0f orientation:UIImageOrientationLeftMirrored];
        imageView.image = newImage;
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}


+(NSData*)getImageDataFromURL:(NSString *)imgUrl
{
    @try {
        
        // Get an image from the URL below
        // Let's save the file into Document folder.
        // You can also change this to your desktop for testing. (e.g. /Users/kiichi/Desktop/)
        // NSString *deskTopDir = @"/Users/kiichi/Desktop";
        
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        // If you go to the folder below, you will find those pictures
//        NSLog(@"%@",docDir);
        
        
//        NSLog(@"saving jpeg");
        //        if(!imgUrl ||imgUrl.length==0){
        //            //            UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
        //            //            label.textAlignment= NSTextAlignmentCenter;
        //            //            label.text=alterText;
        //            //            label.font=[ApplicationData sharedInstance].header9;
        //            //            label.textColor=[UIColor grayColor];
        //            //            label.numberOfLines=3;
        //            //            [imageView addSubview:label];
        //            //            imageView.hidden=YES;
        //            return;
        //        }
        
        // ImgUrl = [ImgUrl stringByReplacingOccurrencesOfString:@" " withString:@""];
        @try {
            imgUrl = [imgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        NSArray *arratemp = [imgUrl componentsSeparatedByString:@"/"];
        NSString *imgPath = [NSString stringWithFormat:@"%@/%@",docDir,[arratemp lastObject]];
        NSURL *pathURL= [NSURL fileURLWithPath:imgPath];
        [PreventBackup addSkipBackupAttributeToItemAtURL:pathURL];
        NSFileManager *filemgr = [NSFileManager defaultManager];
        BOOL isFileExist = [filemgr fileExistsAtPath:imgPath];
        if(!isFileExist)
        {
            //    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:ImgUrl]]];
            //            [WebImageOperations processImageDataWithURLString:imgUrl andBlock:^(NSData *imageData) {
            NSData *imageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
            [imageData writeToFile:imgPath atomically:YES];
            
            return imageData;
            //            }];
            
        }else{
            
            return [filemgr contentsAtPath:imgPath];
            
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Exception :%@",exception);
    }
    @finally {
        
    }
}

+(UIImage *)generateThumbImage : (NSURL *)filepath
{
    AVAsset *asset = [AVAsset assetWithURL:filepath];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
    CMTime time = [asset duration];
    time.value = 0;
    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
    UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);  // CGImageRef won't be released by ARC
    
    CGSize size = thumbnail.size;
    CGFloat ratio = 0;
    
    if((thumbnail.size.height > 960) || (thumbnail.size.width > 640))
    {
        if (size.width > size.height)
        {
            ratio = 640.0 / size.width;
        }
        else
        {
            ratio = 960.0 / size.height;
        }
        CGRect rect = CGRectMake(0.0, 0.0, ratio * size.width, ratio * size.height);
        
        UIGraphicsBeginImageContext(rect.size);
        [thumbnail drawInRect:rect];
        thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    }
    
//    UIImage *rotatedImage = [[UIImage alloc] initWithCGImage:thumbnail.CGImage scale:1.0f orientation:UIImageOrientationUpMirrored];
//    
//    UIImage *rotatedImage1 = [[UIImage alloc] initWithCGImage:rotatedImage.CGImage scale:1.0f orientation:UIImageOrientationRight];
    
    
    return thumbnail;
}


+(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

#pragma Padding------------------------------

+(UITextField *) addPaddingOnTextField :(UITextField *)txtField
{
    @try
    {
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, txtField.frame.size.height)];
        txtField.leftView = paddingView;
        txtField.leftViewMode = UITextFieldViewModeAlways;
    }
    @catch (NSException *exception)
    {
        NSLog(@"Exception:- %@",exception);
    }
    @finally
    {
    }
    return txtField;
}

#pragma mark Convert String To Dictionary
+(id)convertJsonStringToAnyObject:(NSString*)jsonString
{
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    return json;
}

#pragma mark validation

+(BOOL) validateEmail: (NSString *) email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isValid = [emailTest evaluateWithObject:email];
    return isValid;
}
+ (BOOL)MobileNumberValidate:(NSString*)number
{
    NSString *numberRegEx = @"[0-9]{10,20}";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegEx];
    if ([numberTest evaluateWithObject:number] == YES)
        return TRUE;
    else
        return FALSE;
}
+ (BOOL) validateUrl: (NSString *) candidate {
    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
       
    if ([urlTest evaluateWithObject:candidate] == YES)
        return TRUE;
    else
        return FALSE;
}

#pragma transition from Left---------------------
+(CATransition *)pushViewFromLeft
{
    @try
    {
        CATransition *transition = [CATransition animation];
        transition.duration = 0.40;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionMoveIn;
        transition.subtype= kCATransitionFromLeft;
        
        return transition;
    }
    @catch (NSException *exception)
    {
        NSLog(@"Exception:- %@",exception);
    }
    @finally
    {
    }
}

+(CATransition *)pushViewFromLeft:(UIView*)newView
{
    @try
    {
        CATransition *transition = [CATransition animation];
        transition.duration = 0.40;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionMoveIn;
        transition.subtype= kCATransitionFromLeft;
        
        [newView.layer addAnimation:transition forKey:nil];
        
        
        return transition;
    }
    @catch (NSException *exception)
    {
        NSLog(@"Exception:- %@",exception);
    }
    @finally
    {
    }
}

#pragma transition from RightView---------------------

+(CATransition *)pushViewFromright:(UIView*)newView
{
    @try
    {
        CATransition *transition = [CATransition animation];
        transition.duration = 0.40;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionMoveIn;
        transition.subtype= kCATransitionFromRight;
        
        [newView.layer addAnimation:transition forKey:nil];

        
        return transition;
    }
    @catch (NSException *exception)
    {
        NSLog(@"Exception:- %@",exception);
    }
    @finally
    {
    }
}

#pragma transition from Right---------------------

+(CATransition *)pushViewFromright
{
    @try
    {
        CATransition *transition = [CATransition animation];
        transition.duration = 0.40;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionMoveIn;
        transition.subtype= kCATransitionFromRight;
        
        return transition;
    }
    @catch (NSException *exception)
    {
        NSLog(@"Exception:- %@",exception);
    }
    @finally
    {
    }
}

#pragma transition from TopView---------------------

+(CATransition *)pushViewFromTop:(UIView *)newView
{
    @try
    {
        CATransition *transition = [CATransition animation];
        transition.duration = 1.0;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionMoveIn;
        transition.subtype= kCATransitionFromTop;
        
        [newView.layer addAnimation:transition forKey:nil];
        
        
        return transition;
    }
    @catch (NSException *exception)
    {
        NSLog(@"Exception:- %@",exception);
    }
    @finally
    {
    }
}
#pragma transition from Top---------------------


+(CATransition *)pushViewFromTop
{
    @try
    {
        CATransition *transition = [CATransition animation];
        transition.duration = 0.40;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionMoveIn;
        transition.subtype= kCATransitionFromBottom;
        
        return transition;
    }
    @catch (NSException *exception)
    {
        NSLog(@"Exception:- %@",exception);
    }
    @finally
    {
    }
}
#pragma transition from BottomView---------------------

+(CATransition *)pushViewFromBottom:(UIView*)newView
{
    @try
    {
        CATransition *transition = [CATransition animation];
        transition.duration = 0.40;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionMoveIn;
        transition.subtype= kCATransitionFromBottom;
        
         [newView.layer addAnimation:transition forKey:nil];
        
        return transition;
    }
    @catch (NSException *exception)
    {
        NSLog(@"Exception:- %@",exception);
    }
    @finally
    {
    }
}


#pragma transition from Bottom---------------------

+(CATransition *)pushViewFromBottom
{
    @try
    {
        CATransition *transition = [CATransition animation];
        transition.duration = 0.40;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionMoveIn;
        transition.subtype= kCATransitionFromTop;
        
        return transition;
    }
    @catch (NSException *exception)
    {
        NSLog(@"Exception:- %@",exception);
    }
    @finally
    {
    }
}


@end

@implementation NSDictionary (JSONKitSerializing)

- (NSString *)JSONString{

    NSString *jsonString=@"";
    @try {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                           options:0 // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        if (!jsonData)
        {
            NSLog(@"JsonError: %@", error);
        }
        else
        {
            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"exception: %@", exception);
    }
    @finally {
        
    }
    return jsonString;
}

- (BOOL)containsKey: (NSString *)key
{
    BOOL retVal = 0;
    NSArray *allKeys = [self allKeys];
    retVal = [allKeys containsObject:key];
    return retVal;
}

@end

@implementation NSArray(JSONKitSerializing)
- (NSString *)JSONString{
    
    NSString *jsonString=@"";
    @try {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                           options:0//NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        if (!jsonData) {
            NSLog(@"JsonError: %@", error);
        } else {
            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"exception: %@", exception);
    }
    @finally {
        
    }
    return jsonString;
}
@end

@implementation NSString (MD5)

- (NSString *)MD5String {
    const char *cstr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cstr, strlen(cstr), result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];  
}


@end