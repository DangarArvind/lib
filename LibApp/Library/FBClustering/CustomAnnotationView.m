//
//  CustomAnnotationView.m
//  Intafy
//
//  Created by Tasol on 3/18/14.
//  Copyright (c) 2014 tasol. All rights reserved.
//

#import "CustomAnnotationView.h"

#define kHeight 36
#define kWidth 36
#define kBorder 0


@implementation CustomAnnotationView
@synthesize tag;

-(id)init:(NSString*)title subTitle:(NSString*)subTitle coordinate:(CLLocationCoordinate2D)coordinate image:(UIImage*)image userId:(NSString *)userID post:(NSDictionary*)post1;
{
    strTitle=title;
    strSubTitle=subTitle;
    coord=coordinate;
    imgProfile=image;
    userId=userID;
    post =post1;
    return self;
}
-(NSString*)getUserId
{
    return userId;
}
- (CLLocationCoordinate2D)coordinate;
{
    return coord;
}

- (NSString *)title
{
    return strSubTitle;
}

// optional
-(NSString*)subtitle
{
    return strSubTitle;
}
-(NSString*)getStatus
{
    return strSubTitle;
}
-(NSString *)getTitle
{
    return strTitle;
}
-(UIImage *)getImage
{
    return imgProfile;
}
-(NSDictionary *)getPost{
    return post;
}
-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    coord=newCoordinate;
}
#pragma mark Core Animation class methods

- (CAAnimation *)pinBounceAnimation_ {
    
    CAKeyframeAnimation *pinBounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:(id)[UIImage imageNamed:@"PinDown1.png"].CGImage];
    [values addObject:(id)[UIImage imageNamed:@"PinDown2.png"].CGImage];
    [values addObject:(id)[UIImage imageNamed:@"PinDown3.png"].CGImage];
    
    [pinBounceAnimation setValues:values];
    pinBounceAnimation.duration = 0.1;
    
    return pinBounceAnimation;
}
//-(MKAnnotationView*)annotation:(MKAnnotationView*)view
//{
//   
//    CGSize  calloutSize = CGSizeMake(200.0, 80.0);
//    UIView *calloutView = [[UIView alloc] initWithFrame:CGRectMake(view.frame.origin.x-50, view.frame.origin.y-calloutSize.height, calloutSize.width, calloutSize.height)];
//    
//    calloutView.backgroundColor = [UIColor clearColor];
//    
//    UIImageView *imgView=[[UIImageView alloc] initWithImage:[self getImage]];
//    imgView.frame=CGRectMake(5, 5, 60, 60);
//    [calloutView addSubview:imgView];
//    
//    UILabel *name=[[UILabel alloc]init];
//    name.text=[self getTitle];
//    name.frame=CGRectMake(70, 0, 150, 30);
//    [calloutView addSubview:name];
//    
//    UILabel *status=[[UILabel alloc]init];
//    status.text=[self getStatus];
//    status.frame=CGRectMake(30, 20, 150, 60);
//    [calloutView addSubview:status];
//    MKAnnotationView *annotationview=[[MKAnnotationView alloc]init];
//    [annotationview addSubview:calloutView];
//    
//    return annotationview;
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
