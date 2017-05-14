//
//  CustomAnnotationView.h
//  Intafy
//
//  Created by Tasol on 3/18/14.
//  Copyright (c) 2014 tasol. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CustomAnnotationView : NSObject<MKAnnotation>
{
    NSString *strTitle;
    NSString *userId;
    NSString *strSubTitle;
    UIImage *imgProfile;
    CLLocationCoordinate2D coord;
    NSDictionary *post;
    int tag;
}

-(id)init:(NSString*)title subTitle:(NSString*)subTitle coordinate:(CLLocationCoordinate2D)coordinate image:(UIImage*)image userId:(NSString*)userId post:(NSDictionary*)post;
-(NSDictionary*)getPost;
-(NSString*)getTitle;
-(NSString*)getStatus;
-(UIImage*)getImage;
-(NSString*)getUserId;
-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;
- (CAAnimation *)pinBounceAnimation_;
@property(nonatomic,assign)int tag;
@end