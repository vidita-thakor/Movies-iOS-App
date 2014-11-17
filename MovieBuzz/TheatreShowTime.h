//
//  TheatreShowTime.h
//  MovieBuzz
//
//  Created by Abhishek Desai on 12/8/13.
//  Copyright (c) 2013 IOS Frenzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TheatreShowTime : NSObject

@property (assign, nonatomic) int tmsId;
@property (assign, nonatomic) int rootId;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *preferredImage;
@property (strong, nonatomic) NSString *uri;

@property (strong, nonatomic) NSArray *showtimes;
@property (strong, nonatomic) NSString *dateTime;
@property (strong, nonatomic) NSString *telephone;


+(NSArray *)theatresShowTimeFromJSON:(NSData *)objectNotation error:(NSError **)error;

@end
