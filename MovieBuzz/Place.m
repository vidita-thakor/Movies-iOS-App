//
//  Place.m
//  LocationPOI
//
//  Created by Abhishek Desai on 10/28/13.
//  Copyright (c) 2013 Abhishek Desai. All rights reserved.
//

#import "Place.h"

@implementation Place
@synthesize name;
@synthesize description;
@synthesize latitude;
@synthesize longitude;

- (void) dealloc
{
	[name release];
	[description release];
	[super dealloc];
}

@end
