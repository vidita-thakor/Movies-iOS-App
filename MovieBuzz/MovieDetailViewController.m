//
//  MovieDetailViewController.m
//  MovieBuzz
//
//  Created by Abhishek Desai on 10/11/13.
//  Copyright (c) 2013 IOS Frenzy. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "MovieShowTimeViewController.h"

@interface MovieDetailViewController ()
@property (nonatomic, retain) NSArray *dataList;
@end

@implementation MovieDetailViewController
@synthesize moviedetail, poster, topcast, duration, description, rated, genre, runningTime, movieTitle,moviePlayer, dataList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Movie Detail";
        self.tabBarItem.tag = 1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSString *url = [NSString stringWithFormat:@"http://developer.tmsimg.com/%@?api_key=5dmhgfxxzv2y43kwhuzv8ap8",moviedetail.uri];
    NSURL * imageUrl=[NSURL URLWithString:url];
    NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
    self.poster.image=[UIImage imageWithData:imageData];
    self.movieTitle.text=moviedetail.title;
    self.topcast.text=[moviedetail.topCast componentsJoinedByString:@","];
    self.description.text=moviedetail.shortDescription;
    self.genre.text=[moviedetail.genres componentsJoinedByString:@","];
    
    //self.duration=moviedetail.runTime
    
    NSArray *array = [moviedetail.runTime componentsSeparatedByString:@"PT"];
    NSArray *tempArray = [[array objectAtIndex:1] componentsSeparatedByString:@"H"];
    
    NSString *timeStr = [tempArray componentsJoinedByString:@"hr. "];
    NSString *displayTime=[timeStr stringByReplacingOccurrencesOfString:@"M" withString:@"min"];
    self.duration.text=displayTime;
    self.runningTime.text=displayTime;
   // self.rated.text=moviedetail.code;
    

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [poster release];
    [topcast release];
    [duration release];
    [description release];
    [rated release];
    [genre release];
    [runningTime release];
    [movieTitle release];
    [super dealloc];
}
- (IBAction)playTrailer:(id)sender {
    
    NSString *url = [NSString stringWithFormat:@"%@%d%@", @"http://data.tmsapi.com/v1/screenplayTrailers?rootids=",moviedetail.rootId, @"&bitrateids=461&api_key=5dmhgfxxzv2y43kwhuzv8ap8"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *jasonParsingError = nil;
    
    NSArray *jasonArray = [NSJSONSerialization JSONObjectWithData: response options: NSJSONReadingMutableContainers error: &jasonParsingError];
    
    if([jasonArray count]>0)
    {
        dataList=jasonArray;
    }
    
    
    NSDictionary* moviestrailerlist= [dataList valueForKey:@"response"];
    NSDictionary* moviestrailer= [moviestrailerlist valueForKey:@"trailers"];
    id val = nil;
    NSArray *values = [moviestrailer valueForKey:@"Url"];
    
    if ([values count] != 0)
        val = [values objectAtIndex:0];
    
    NSURL* movieclipurl = [NSURL URLWithString:val];
    
    moviePlayer =  [[MPMoviePlayerController alloc]
                    initWithContentURL:movieclipurl];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:moviePlayer];
    
    moviePlayer.controlStyle = MPMovieControlStyleDefault;
    moviePlayer.shouldAutoplay = YES;
    [self.view addSubview:moviePlayer.view];
    [moviePlayer setFullscreen:YES animated:YES];
    
}


- (IBAction)showTimes:(id)sender {
    
    MovieShowTimeViewController *movieShowTimeViewController = [[[MovieShowTimeViewController alloc] initWithNibName:@"MovieShowTimeViewController" bundle:nil] autorelease];
    
    movieShowTimeViewController.moviesShowTime = moviedetail.showtimes;
    
    [self.navigationController pushViewController:movieShowTimeViewController animated:YES];
}


- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    MPMoviePlayerController *player = [notification object];
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:player];
    
    if ([player
         respondsToSelector:@selector(setFullscreen:animated:)])
    {
        [player.view removeFromSuperview];
    }
    [player stop];
    [player release];
}


@end
