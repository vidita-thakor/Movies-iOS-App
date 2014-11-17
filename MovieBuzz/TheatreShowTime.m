//
//  TheatreShowTime.m
//  MovieBuzz
//
//  Created by Abhishek Desai on 12/8/13.
//  Copyright (c) 2013 IOS Frenzy. All rights reserved.
//

#import "TheatreShowTime.h"

@implementation TheatreShowTime

@synthesize tmsId, rootId, title, preferredImage, uri, showtimes, dateTime, telephone;
+(NSArray *)theatresShowTimeFromJSON:(NSData *)objectNotation error:(NSError **)error
{
    
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    NSMutableArray *_listarr = [[[NSMutableArray alloc] init] autorelease];
    

    for(NSDictionary *theaterShowTimeList in parsedObject)
    {
        TheatreShowTime *theatreShowTime = [[[TheatreShowTime alloc] init] autorelease];
        for(NSString *key in theaterShowTimeList)
        {
           // NSLog(@"subkey name %@", key);
           // NSLog(@"subkey value %@", [theaterShowTimeList valueForKey:key]);
            
            if([theatreShowTime respondsToSelector:NSSelectorFromString(key)])
            {
                if([[theaterShowTimeList valueForKey:key] isKindOfClass:[NSDictionary class]])
                {
                    for(NSString *subkey in [theaterShowTimeList valueForKey:key])
                    {
                        //NSLog(@"subkey name %@", subkey);
                        //NSLog(@"subkey value %@", [[theaterShowTimeList valueForKey:key] valueForKey:subkey]);
                        
                        if([subkey isEqualToString:@"uri"])
                        {
                            [theatreShowTime setValue:[[theaterShowTimeList valueForKey:key] valueForKey:subkey] forKey:subkey];
                        }
                        
                        if([[[theaterShowTimeList valueForKey:key] valueForKey:subkey] isKindOfClass:[NSDictionary class]])
                        {
                            
                            for(NSString *subsubkey in [[theaterShowTimeList valueForKey:key] valueForKey:subkey])
                            {
                                //NSLog(@"subkey name %@", subsubkey);
                                //NSLog(@"subkey value %@", [[[theaterShowTimeList valueForKey:key] valueForKey:subkey] valueForKey:subsubkey]);
                                /*if([subsubkey isEqualToString:@"street"])
                                {
                                    [theatre setValue:[[[theaterList valueForKey:key] valueForKey:subkey] valueForKey:subsubkey] forKey:subsubkey];
                                }*/
                                
                            }
                        }
                    }
                }
                [theatreShowTime setValue:[theaterShowTimeList valueForKey:key] forKey:key];
            }
        }
        [_listarr addObject:theatreShowTime];
    }
    //NSLog(@"array %@", _listarr);
    
    return _listarr;
    
}

-(void)dealloc{
    [title release];
    [preferredImage release];
    [uri release];
    [showtimes release];
    [dateTime release];
    [telephone release];
    [super dealloc];
}

@end
