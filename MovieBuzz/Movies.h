//
//  Movies.h
//  jsontableviewdemo
//
//  Created by vidita on 10/27/13.
//  Copyright (c) 2013 vidita. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movies : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSArray *topCast;
@property (strong, nonatomic) NSString *preferredImage;
@property (strong, nonatomic) NSString *uri;

@property (strong, nonatomic) NSString *runTime;
@property (strong, nonatomic) NSArray *ratings;
@property (strong, nonatomic) NSString *body;
@property (strong, nonatomic) NSString *code;


@property (strong, nonatomic) NSArray *genres;
@property (strong, nonatomic) NSString *shortDescription;
@property (strong, nonatomic) NSString *releaseYear;
@property (assign, nonatomic) int rootId;
@property (strong, nonatomic) NSString *tmsId;
@property (strong, nonatomic) NSArray *showtimes;
+(NSArray *)moviesFromJSON:(NSData *)objectNotation error:(NSError **)error;

@end
