//
//  Theatre.m
//  TheaterList
//
//  Created by Abhishek Desai on 11/23/13.
//  Copyright (c) 2013 Abhishek Desai. All rights reserved.
//

#import "Theatre.h"

@implementation Theatre
@synthesize theatreId, name, location, distance, address, street, telephone, geoCode, longitude,latitude, state,city;

+(NSArray *)theatresFromJSON:(NSData *)objectNotation error:(NSError **)error
{
    
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    /*if (localError != nil) {
        *error = localError;
        return nil;
    }*/
    
    NSMutableArray *_listarr = [[[NSMutableArray alloc] init] autorelease];
    
    //NSArray *results = [parsedObject valueForKey:@"movies"];
    //NSLog(@"Count %d", results.count);
    
   // _listarr= [[[NSMutableArray alloc] init] autorelease];
    for(NSDictionary *theaterList in parsedObject)
    {
         Theatre *theatre = [[[Theatre alloc] init] autorelease];
        for(NSString *key in theaterList)
        {
            
            if([theatre respondsToSelector:NSSelectorFromString(key)])
            {
                if([[theaterList valueForKey:key] isKindOfClass:[NSDictionary class]])
                {
                    for(NSString *subkey in [theaterList valueForKey:key])
                    {
                        //NSLog(@"subkey name %@", subkey);
                        //NSLog(@"subkey value %@", [[theaterList valueForKey:key] valueForKey:subkey]);
                        
                        if([subkey isEqualToString:@"telephone"])
                        {
                            [theatre setValue:[[theaterList valueForKey:key] valueForKey:subkey] forKey:subkey];
                        }
                        
                        if([subkey isEqualToString:@"distance"])
                        {
                            [theatre setValue:[[theaterList valueForKey:key] valueForKey:subkey] forKey:subkey];
                        }
                        
                        if([[[theaterList valueForKey:key] valueForKey:subkey] isKindOfClass:[NSDictionary class]])
                        {
                            
                            for(NSString *subsubkey in [[theaterList valueForKey:key] valueForKey:subkey])
                            {
                                //NSLog(@"subkey name %@", subsubkey);
                                //NSLog(@"subkey value %@", [[[theaterList valueForKey:key] valueForKey:subkey] valueForKey:subsubkey]);
                                if([subsubkey isEqualToString:@"street"])
                                {
                                    [theatre setValue:[[[theaterList valueForKey:key] valueForKey:subkey] valueForKey:subsubkey] forKey:subsubkey];
                                }
                                if([subsubkey isEqualToString:@"longitude"])
                                {
                                    [theatre setValue:[[[theaterList valueForKey:key] valueForKey:subkey] valueForKey:subsubkey] forKey:subsubkey];
                                }
                                if([subsubkey isEqualToString:@"latitude"])
                                {
                                    [theatre setValue:[[[theaterList valueForKey:key] valueForKey:subkey] valueForKey:subsubkey] forKey:subsubkey];
                                }
                                if([subsubkey isEqualToString:@"state"])
                                {
                                    [theatre setValue:[[[theaterList valueForKey:key] valueForKey:subkey] valueForKey:subsubkey] forKey:subsubkey];
                                }
                                if([subsubkey isEqualToString:@"city"])
                                {
                                    [theatre setValue:[[[theaterList valueForKey:key] valueForKey:subkey] valueForKey:subsubkey] forKey:subsubkey];
                                }
                                //[self setValue:[[[theaterList valueForKey:key] valueForKey:subkey] valueForKey:subsubkey] forKey:subsubkey];
                                
                            }
                        }
                    }
                }
                [theatre setValue:[theaterList valueForKey:key] forKey:key];
            }
        }
        [_listarr addObject:theatre];
    }
    //NSLog(@"array %@", _listarr);
    
    return _listarr;
    
}

-(void) dealloc{
    [theatreId release];
    [name release];
    [location release];
    [distance release];
    [address release];
    [street release];
    [telephone release];
    [geoCode release];
    [longitude release];
    [latitude release];
    [state release];
    [city release];
    [super dealloc];
}

@end
