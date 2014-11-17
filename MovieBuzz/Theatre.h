//
//  Theatre.h
//  TheaterList
//
//  Created by Abhishek Desai on 11/23/13.
//  Copyright (c) 2013 Abhishek Desai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Theatre : NSObject
@property (strong, nonatomic) NSString *theatreId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *distance;

@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *street;
@property (strong, nonatomic) NSString *telephone;

@property (strong, nonatomic) NSString *geoCode;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *city;



+(NSArray *)theatresFromJSON:(NSData *)objectNotation error:(NSError **)error;

@end
