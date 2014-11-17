//
//  MovieCommunicator.m
//  jsontableviewdemo
//
//  Created by vidita on 10/27/13.
//  Copyright (c) 2013 vidita. All rights reserved.
//

#import "MovieCommunicator.h"
#import "MovieCommunicatorDelegate.h"

#define API_KEY @"5dmhgfxxzv2y43kwhuzv8ap8"
#define THEATRE_API_KEY @"5dmhgfxxzv2y43kwhuzv8ap8"
#define PAGE_COUNT 20

@implementation MovieCommunicator

//@synthesize  id;

- (void)searchMovies:(float)lat AndWithLongitude:(float)lng
{

    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *urlAsString = [NSString stringWithFormat:@"http://data.tmsapi.com/v1/movies/showings?startDate=%@&lat=%f&lng=%f&api_key=%@",[DateFormatter stringFromDate:[NSDate date]],lat, lng,API_KEY];
    NSURL *url = [[[NSURL alloc] initWithString:urlAsString] autorelease];
   // NSLog(@"%@", urlAsString);
  // NSURLResponse* response = nil;
    NSURLResponse* response = nil;
    NSError* error = nil;
	
    NSMutableURLRequest* request = [[[NSMutableURLRequest alloc] init] autorelease];
	
	//NSURL* URL = [NSURL URLWithString:movieURL];
	[request setURL:url];
	[request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
	[request setTimeoutInterval:30];
	
   // [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	
        //NSLog(@"data received%@",data);
        if (error) {
            [self.delegate fetchingMoviesFailedWithError:error];
        } else {
            [self.delegate receivedMoviesJSON:data];
        }
   // }];
    [DateFormatter release];
}

- (void)searchTheatresWithLatitude:(float)lat AndLongitude:(float)lng
{
    NSString *urlAsString = [NSString stringWithFormat:@"http://data.tmsapi.com/v1/theatres?lat=%f&lng=%f&radius=10&api_key=%@",lat, lng,THEATRE_API_KEY];
    //NSLog(@"URl %@", urlAsString);
    NSURL *url = [[[NSURL alloc] initWithString:urlAsString] autorelease];
    NSURLResponse* response = nil;
    NSError* error = nil;
	
    NSMutableURLRequest* request = [[[NSMutableURLRequest alloc] init] autorelease];
	
	[request setURL:url];
	[request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
	[request setTimeoutInterval:30];
	
    // [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	
    if (error) {
        [self.delegate fetchingTheatresFailedWithError:error];
    } else {
        [self.delegate receivedTheatresJSON:data];
    }
    
}

/***************************************New Addition*******************************************/
- (void)searchTheatresShowTime:(int)theatreId
{
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *urlAsString = [NSString stringWithFormat:@"http://data.tmsapi.com/v1/theatres/%d/showings?startDate=%@&api_key=%@",theatreId,[DateFormatter stringFromDate:[NSDate date]],THEATRE_API_KEY];
   
    //NSLog(@"URl %@", urlAsString);
    NSURL *url = [[[NSURL alloc] initWithString:urlAsString] autorelease];
    NSURLResponse* response = nil;
    NSError* error = nil;
	
    NSMutableURLRequest* request = [[[NSMutableURLRequest alloc] init] autorelease];
	
	[request setURL:url];
	[request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
	[request setTimeoutInterval:30];
	
    // [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	
    if (error) {
        [self.delegate fetchingTheatresShowTimeFailedWithError:error];
    } else {
        [self.delegate receivedTheatresShowTimeJSON:data];
    }
    [DateFormatter release];
}

- (void)searchMoviesShowTime:(NSString *)tmsId AndLatitude:(float)lat AndLongitude:(float)lng
{
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *urlAsString = [NSString stringWithFormat:@"http://data.tmsapi.com/v1/movies/%@/showings?startDate=%@&lat=%f&lng=%f&radius=10&api_key=%@",tmsId,[DateFormatter stringFromDate:[NSDate date]],lat, lng,THEATRE_API_KEY];
    
    NSLog(@"URl %@", urlAsString);
    
    NSURL *url = [[[NSURL alloc] initWithString:urlAsString] autorelease];
    NSURLResponse* response = nil;
    NSError* error = nil;
	
    NSMutableURLRequest* request = [[[NSMutableURLRequest alloc] init] autorelease];
	
	[request setURL:url];
	[request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
	[request setTimeoutInterval:30];

    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	
    if (error) {
        [self.delegate fetchingMoviesShowTimeFailedWithError:error];
    } else {
        [self.delegate receivedMoviesShowTimeJSON:data];
    }
    [DateFormatter release];
}
/***************************************New Addition*******************************************/



@end
