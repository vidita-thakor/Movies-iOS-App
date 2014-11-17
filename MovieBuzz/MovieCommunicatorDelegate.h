//
//  MovieCommunicatorDelegate.h
//  jsontableviewdemo
//
//  Created by vidita on 10/27/13.
//  Copyright (c) 2013 vidita. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MovieCommunicatorDelegate <NSObject>
- (void)receivedMoviesJSON:(NSData *)objectNotation;
- (void)fetchingMoviesFailedWithError:(NSError *)error;


- (void)receivedTheatresJSON:(NSData *)objectNotation;
- (void)fetchingTheatresFailedWithError:(NSError *)error;

/******************************New Addition**************************/
- (void)receivedTheatresShowTimeJSON:(NSData *)objectNotation;
- (void)fetchingTheatresShowTimeFailedWithError:(NSError *)error;

- (void)receivedMoviesShowTimeJSON:(NSData *)objectNotation;
- (void)fetchingMoviesShowTimeFailedWithError:(NSError *)error;
/******************************New Addition*************************/
@end
