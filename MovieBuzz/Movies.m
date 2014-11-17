//
//  Movies.m
//  jsontableviewdemo
//
//  Created by vidita on 10/27/13.
//  Copyright (c) 2013 vidita. All rights reserved.
//

#import "Movies.h"

@implementation Movies
//@synthesize title, runtime, posters, mpaa_rating, release_date, thumbnail, profile, detailed, original;
@synthesize title,topCast,preferredImage,uri,runTime,ratings,body,code,rootId,genres,shortDescription,releaseYear,tmsId,showtimes;
+(NSArray *)moviesFromJSON:(NSData *)objectNotation error:(NSError **)error
{
    
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    /*if (localError != nil) {
        *error = localError;
        return nil;
    }*/
    
    NSMutableArray *movies = [[[NSMutableArray alloc] init] autorelease];
    
    NSArray *results = [parsedObject valueForKey:@"movies"];
    NSLog(@"Countjhgg %lu", (unsigned long)results.count);
    
    for (NSDictionary *groupDic in parsedObject) {
        Movies *movie = [[[Movies alloc] init] autorelease];
        
        for (NSString *key in groupDic) {
            //NSLog(@"KEy- @%",key);
           
            if ([movie respondsToSelector:NSSelectorFromString(key)]) {
              //NSLog(@"keys-%@ type- %@",key,[[groupDic valueForKey:key] class]);

            if([[groupDic valueForKey:key] isKindOfClass:[NSDictionary class]])
            {
                for(NSString *subkey in [groupDic valueForKey:key])
                {
                    //if(
                    
                    if ([movie respondsToSelector:NSSelectorFromString(subkey)]) {
                       
                    [movie setValue:[[groupDic valueForKey:key] valueForKey:subkey]  forKey:subkey];
                    }
                }
            }
                /*
                if([[groupDic valueForKey:key] isKindOfClass:[NSArray class]])
                {
                    for(NSString *subkey in [groupDic valueForKey:key])
                    {
                        //if(
                        
                        if ([movie respondsToSelector:NSSelectorFromString(subkey)]) {
                            
                            [movie setValue:[[groupDic valueForKey:key] valueForKey:subkey]  forKey:subkey];
                        }
                    }
                }*/
                [movie setValue:[groupDic valueForKey:key] forKey:key];
            }
        }
        
        [movies addObject:movie];
    }
    
    return movies;

}

-(void)dealloc{
    [title release];
    [topCast release];
    [preferredImage release];
    [uri release];
    [runTime release];
    [ratings release];
    [body release];
    [code release];
    [genres release];
    [releaseYear release];
    [shortDescription release];
    [tmsId release];
    [showtimes release];
    [super dealloc];
}
@end
