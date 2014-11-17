//
//  MovieManagerDelegate.h
//  jsontableviewdemo
//
//  Created by vidita on 10/27/13.
//  Copyright (c) 2013 vidita. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MovieManagerDelegate <NSObject>
- (void)didReceiveMovies:(NSArray *)groups;
- (void)fetchingMoviesFailedWithError:(NSError *)error;

- (void)didReceiveTheatres:(NSArray *)groups;
- (void)fetchingTheatresFailedWithError:(NSError *)error;

/*****************************New Addition********************/
- (void)didReceiveTheatresShowTime:(NSArray *)groups;
- (void)fetchingTheatresShowTimeFailedWithError:(NSError *)error;

- (void)didReceiveMoviesShowTime:(NSArray *)groups;
- (void)fetchingMoviesShowTimeFailedWithError:(NSError *)error;
/*****************************New Addition********************/

@end
