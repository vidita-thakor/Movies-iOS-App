//
//  MovieManager.m
//  jsontableviewdemo
//
//  Created by vidita on 10/27/13.
//  Copyright (c) 2013 vidita. All rights reserved.
//

#import "MovieManager.h"
#import "Movies.h"
#import "Theatre.h"
#import "MovieShowTime.h"
#import "TheatreShowTime.h"
#import "MovieCommunicator.h"
#import "MovieManagerDelegate.h"
@implementation MovieManager

- (void)fetchMovies:(float)lat AndWithLongitude:(float)lng
{
    [self.communicator searchMovies:lat AndWithLongitude:lng];
}
- (void)fetchTheatresWithLatitude:(float)lat AndWithLongitude:(float)lng
{
    [self.communicator searchTheatresWithLatitude:lat AndLongitude:lng];
}
- (void)fetchTheatresShowTime:(int)theatreId
{
    [self.communicator searchTheatresShowTime:theatreId];
}
- (void)fetchMoviesShowTime:(NSString*)tmsId AndLatitude:(float)lat AndLongitude:(float)lng;
{
    [self.communicator searchMoviesShowTime:tmsId AndLatitude:lat AndLongitude:lng];
}
#pragma mark - MeetupCommunicatorDelegate

- (void)receivedMoviesJSON:(NSData *)objectNotation
{
    NSError *error = nil;
    NSArray *movies = [Movies moviesFromJSON:objectNotation error:&error];
    
    if (error != nil) {
        [self.delegate fetchingMoviesFailedWithError:error];
        
    } else {
        [self.delegate didReceiveMovies:movies];
    }
}

- (void)fetchingMoviesFailedWithError:(NSError *)error
{
    [self.delegate fetchingMoviesFailedWithError:error];
}


- (void)receivedTheatresJSON:(NSData *)objectNotation
{
    
    NSError *error = nil;
    NSArray *theatres = [Theatre theatresFromJSON:objectNotation error:&error];
    
    if (error != nil) {
        [self.delegate fetchingTheatresFailedWithError:error];
        
    } else {
        [self.delegate didReceiveTheatres:theatres];
    }
}

- (void)fetchingTheatresFailedWithError:(NSError *)error
{
    [self.delegate fetchingTheatresFailedWithError:error];
}

/************************New Addition*****************************************/
- (void)receivedTheatresShowTimeJSON:(NSData *)objectNotation
{
    
    NSError *error = nil;
    NSArray *theatres = [TheatreShowTime theatresShowTimeFromJSON:objectNotation error:&error];
    
    if (error != nil) {
        [self.delegate fetchingTheatresShowTimeFailedWithError:error];
        
    } else {
        [self.delegate didReceiveTheatresShowTime:theatres];
    }
}

- (void)fetchingTheatresShowTimeFailedWithError:(NSError *)error
{
    [self.delegate fetchingTheatresShowTimeFailedWithError:error];
}
- (void)receivedMoviesShowTimeJSON:(NSData *)objectNotation
{
    
    NSError *error = nil;
    NSArray *movies = [MovieShowTime moviesShowTimeFromJSON:objectNotation error:&error];
    
    if (error != nil) {
        [self.delegate fetchingMoviesShowTimeFailedWithError:error];
        
    } else {
        [self.delegate didReceiveMoviesShowTime:movies];
    }
}

- (void)fetchingMoviesShowTimeFailedWithError:(NSError *)error
{
    [self.delegate fetchingMoviesShowTimeFailedWithError:error];
}

/***********************New Addition*******************************************/

@end
