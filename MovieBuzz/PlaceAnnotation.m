//
//  PlaceAnnotation.m
//  LocationPOI
//
//  Created by Abhishek Desai on 10/28/13.
//  Copyright (c) 2013 Abhishek Desai. All rights reserved.
//

#import "PlaceAnnotation.h"


@implementation PlaceAnnotation

@synthesize coordinate=_cooordinate;
@synthesize title=_title;
@synthesize subtitle=_subtitle;
@synthesize theatreId;

+ (id)annotationWithCoordinate:(CLLocationCoordinate2D)coord {
    return [[[[self class] alloc] initWithCoordinate:coord] autorelease];
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)coord {
    if ( self = [super init] ) {
        self.coordinate = coord;
    }
    return self;
}
- (void) dealloc
{
    [super dealloc];
    [_title release];
    [_subtitle release];
}

@end
