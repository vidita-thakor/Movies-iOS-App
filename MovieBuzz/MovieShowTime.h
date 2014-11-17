//
//  MovieShowTime.h
//  MovieBuzz
//
//  Created by Harmony Public Schools on 12/11/13.
//  Copyright (c) 2013 IOS Frenzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieShowTime : NSObject
@property (strong, nonatomic) NSString * tmsId;
@property (assign, nonatomic) int rootId;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *preferredImage;
@property (strong, nonatomic) NSString *uri;

@property (strong, nonatomic) NSArray *showtimes;
@property (strong, nonatomic) NSString *dateTime;
@property (strong, nonatomic) NSString *telephone;

@property (strong, nonatomic) NSString * name;

+(NSArray *)moviesShowTimeFromJSON:(NSData *)objectNotation error:(NSError **)error;


@end
