//
//  MovieCommunicator.h
//  jsontableviewdemo
//
//  Created by vidita on 10/27/13.
//  Copyright (c) 2013 vidita. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "MovieCommunicatorDelegate.h"

@protocol MovieCommunicatorDelegate;

@interface MovieCommunicator : NSObject


@property (strong, nonatomic) id<MovieCommunicatorDelegate> delegate;


- (void)searchMovies:(float)lat AndWithLongitude:(float)lng;
- (void)searchTheatresWithLatitude:(float)lat AndLongitude:(float)lng;

/*************************New Addition*****************************/
- (void)searchTheatresShowTime:(int)theatreId;
- (void)searchMoviesShowTime:(NSString *)tmsId AndLatitude:(float)lat AndLongitude:(float)lng;
/*************************New Addition****************************/
@end
