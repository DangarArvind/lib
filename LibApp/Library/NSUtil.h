//
//  NSUtil.h
//  Intafy
//
//  Created by tasol on 2/11/14.
//  Copyright (c) 2014 tasol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
@interface NSUtil : NSObject

+(NSString*)getJsonStringFromDictionary:(NSDictionary*)dictionary;
+(void)getImageForView:(UIView*)imageView fromURL:(NSString *)imgUrl alterText:(NSString*)alterText;
+(void)getImageForView1:(UIView*)imageView fromURL:(NSString *)imgUrl alterText:(NSString*)alterText;
+(void)getImageForViewWithCatch:(UIView*)imageView fromURL:(NSString *)imgUrl alterText:(NSString*)alterText catch:(NSCache *)catchImage;
+(UIImage*)getImageFromURL:(NSString *)imgUrl;
+(NSArray*)shortDirectoryArray:(NSArray*)arrayToShort ByKey:(NSString*)key;
+(NSString*)convertDate:(NSString*)dateToConver;
+(void)applyCircleAsBorder:(UIButton*)view;
+(NSString*)convertDate:(NSString*)dateToConver dateFormate:(NSString*)dateFormate dateFormateToConvert:(NSString*)dateFormateToConvert;
+(NSString*)getDataFromURL:(NSString *)imgUrl;
+ (UIImage *) cropImage:(UIImage *)originalImage;
+(void)cropImage:(UIImage *)originalImage forView:(UIImageView *)imageView;
+(UIImage*)cropImageFromMiddle:(UIImage *)originalImage;
+(void)cropImageFromMiddleVertically:(UIImage *)originalImage forView:(UIImageView *)imageView;
+(NSString*)convertDateTimeStamp:(NSString*)timestamp DateFormat:(NSString*)dateFormat;
+(long)getUTCTimeStamp;
+(NSData*)getImageDataFromURL:(NSString *)imgUrl;
+(UIImage *)scaleAndRotateImage :(UIImage*)image;
+(UIColor*)colorWithHexString:(NSString*)hex;
+(UIImage*)getYouTubeImageFromURL:(NSString *)imgUrl andID:(NSString*)youtubeID;
+(UIImage *)generateThumbImage : (NSURL *)filepath;
+(void)getImageForView2:(UIView*)imageView fromURL:(NSString *)imgUrl alterText:(NSString*)alterText;
+(void)getImageForView:(UIView*)imageView fromURL:(NSString *)imgUrl forTableCell:(UITableViewCell*)cell;
+(void)cropImage1:(UIImage *)originalImage forView:(UIImageView *)imageView;
+ (UIImage *)fixrotation:(UIImage *)image;
+(NSString *)storeImageInLocal:(UIImage *)image;
+(CATransition *)pushViewFromLeft:(UIView*)newView;
+(CATransition *)pushViewFromTop:(UIView*)newView;
+(CATransition *)pushViewFromright:(UIView*)newView;
+(CATransition *)pushViewFromBottom:(UIView*)newView;


+(CATransition *)pushViewFromLeft;
+(CATransition *)pushViewFromright;
+(CATransition *)pushViewFromTop;
+(CATransition *)pushViewFromBottom;

+(CGSize)getHeightForWidth:(CGSize)imgSize;
+(CGSize)getImageSizeFromURL:(NSString *)imgUrl;
+(UITextField *) addPaddingOnTextField :(UITextField *)txtField;

+(BOOL)validateEmail:(NSString *) email;
+(BOOL)MobileNumberValidate:(NSString*)number;
+ (BOOL) validateUrl: (NSString *) candidate;

+(id)convertJsonStringToAnyObject:(NSString*)jsonString;
@end

@interface NSDictionary (JSONKitSerializing)
- (NSString *)JSONString;
- (BOOL)containsKey: (NSString *)key;

@end
@interface NSArray (JSONKitSerializing)
- (NSString *)JSONString;


@end
@interface NSString (MD5)
- (NSString *)MD5String;

@end
