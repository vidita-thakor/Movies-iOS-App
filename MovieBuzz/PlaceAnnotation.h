//
//  PlaceAnnotation.h
//  LocationPOI
//
//  Created by Abhishek Desai on 10/28/13.
//  Copyright (c) 2013 Abhishek Desai. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>

@interface PlaceAnnotation : NSObject <MKAnnotation>

@property (nonatomic)CLLocationCoordinate2D coordinate;

@property (nonatomic, retain) NSString *title;

@property (nonatomic, retain) NSString *subtitle;

@property (nonatomic, assign) int theatreId;


+ (id)annotationWithCoordinate:(CLLocationCoordinate2D)coord;
- (id)initWithCoordinate:(CLLocationCoordinate2D)coord;


@end
