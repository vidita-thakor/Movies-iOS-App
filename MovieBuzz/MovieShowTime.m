//
//  MovieShowTime.m
//  MovieBuzz
//
//  Created by Harmony Public Schools on 12/11/13.
//  Copyright (c) 2013 IOS Frenzy. All rights reserved.
//

#import "MovieShowTime.h"

@implementation MovieShowTime
@synthesize tmsId, rootId, title, preferredImage, uri, showtimes, dateTime, telephone,name;
+(NSArray *)moviesShowTimeFromJSON:(NSData *)objectNotation error:(NSError **)error
{
    
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    NSMutableArray *listarr = [[[NSMutableArray alloc] init] autorelease];
    
    
    for(NSDictionary *movieShowTimeList in parsedObject)
    {
        
        
        MovieShowTime *movieShowTime = [[[MovieShowTime alloc] init] autorelease];
        
        for(NSString *key in movieShowTimeList)
        {
            NSLog(@"Key name %@", key);
            // NSLog(@"subkey value %@", [theaterShowTimeList valueForKey:key]);
            
            if([movieShowTime respondsToSelector:NSSelectorFromString(key)])
            {
                if([[movieShowTimeList valueForKey:key] isKindOfClass:[NSDictionary class]])
                {
                    for(NSString *subkey in [movieShowTimeList valueForKey:key])
                    {
                        //NSLog(@"subkey name %@", subkey);
                        //NSLog(@"subkey value %@", [[theaterShowTimeList valueForKey:key] valueForKey:subkey]);
                        
                        if([subkey isEqualToString:@"uri"])
                        {
                            [movieShowTime setValue:[[movieShowTimeList valueForKey:key] valueForKey:subkey] forKey:subkey];
                        }
                        
                        if([[[movieShowTimeList valueForKey:key] valueForKey:subkey] isKindOfClass:[NSDictionary class]])
                        {
                            
                            for(NSString *subsubkey in [[movieShowTimeList valueForKey:key] valueForKey:subkey])
                            {
                                
                                
                            }
                        }
                    }
                }
                [movieShowTime setValue:[movieShowTimeList valueForKey:key] forKey:key];
            }
        }
        [listarr addObject:movieShowTime];
    }

    return listarr;
    
}

-(void)dealloc{
    [tmsId release];
    [title release];
    [preferredImage release];
    [uri release];
    [showtimes release];
    [dateTime release];
    [telephone release];
    [name release];
    [super dealloc];
}


@end
