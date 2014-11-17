//
//  MovieManager.h
//  jsontableviewdemo
//
//  Created by vidita on 10/27/13.
//  Copyright (c) 2013 vidita. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "MovieManagerDelegate.h"
#import "MovieCommunicatorDelegate.h"


@class MovieCommunicator;

@interface MovieManager : NSObject<MovieCommunicatorDelegate>
@property (strong, nonatomic) MovieCommunicator *communicator;
@property (strong, nonatomic) id<MovieManagerDelegate> delegate;

- (void)fetchMovies:(float)lat AndWithLongitude:(float)lng;
- (void)fetchTheatresWithLatitude:(float)lat AndWithLongitude:(float)lng;

/*********************New Addition***************************************/
- (void)fetchTheatresShowTime:(int)theatreId;
- (void)fetchMoviesShowTime:(NSString*)tmsId AndLatitude:(float)lat AndLongitude:(float)lng;
/*********************New Addition***************************************/

@end