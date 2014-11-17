//
//  HomeViewController.m
//  MovieBuzz
//
//  Created by Abhishek Desai on 10/11/13.
//  Copyright (c) 2013 IOS Frenzy. All rights reserved.
//

#import "HomeViewController.h"
#import "Movies.h"
#import "MovieManager.h"
#import "MovieCommunicator.h"
#import "CustomCell.h"
#import "SearchViewController.h"
#import "MBProgressHUD.h"
#import "MovieDetailViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface HomeViewController ()<CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;

@end

@implementation HomeViewController

@synthesize scrollView, pageControl, myTableView,_movies,_manager;

/*
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
*/

- (void)didReceiveMovies:(NSArray *)movies
{
    self._movies = movies;
    //  NSLog(@"movieslist%@",)
    [self.myTableView reloadData];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Home";
        self.tabBarItem.tag = 0;
        self.tabBarItem.image = [UIImage imageNamed:@"House"];
 /*       NSString* theURL = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=%@&q=%@","35ttsdwkn6d3q2wpeavdkqyp", "Batman"];
        NSError* err = nil;
        
        NSURLResponse* response = nil;
        
        NSMutableURLRequest* request = [[[NSMutableURLRequest alloc] init] autorelease];
        
        NSURL*URL = [NSURL URLWithString:theURL];
        
        [request setURL:URL];
        
        [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        
        [request setTimeoutInterval:30];
        
        NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
  */
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _locationManager = [[CLLocationManager alloc] init];
	[_locationManager setDelegate:self];
	[_locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
	[_locationManager startUpdatingLocation];
    pageControlBeingUsed = YES;
	//NSArray *colors = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor], nil];
	for (int i = 0; i < 3; i++) {
		CGRect frame;
		frame.origin.x = self.scrollView.frame.size.width * i;
		frame.origin.y = 0;
		frame.size = self.scrollView.frame.size;
		
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x - 100, 0,self.scrollView.frame.size.width,self.scrollView.frame.size.height)];
        
        image.image = [UIImage imageNamed:[NSString stringWithFormat:
                                           @"image_%d.jpg", i+1]];
        
        UIImageView *image_1 = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x, 0,self.scrollView.frame.size.width,self.scrollView.frame.size.height)];
        
        image_1.image = [UIImage imageNamed:[NSString stringWithFormat:
                                             @"image1_%d.jpg", i+1]];
        
        UIImageView *image_2 = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x + 100, 0,self.scrollView.frame.size.width,self.scrollView.frame.size.height)];
        
        image_2.image = [UIImage imageNamed:[NSString stringWithFormat:
                                             @"image2_%d.jpg", i+1]];
        
        image.contentMode = UIViewContentModeScaleAspectFit;
        image_1.contentMode = UIViewContentModeScaleAspectFit;
        image_2.contentMode = UIViewContentModeScaleAspectFit;
        image.tag = i+1;
        image_1.tag = i+1;
        image_2.tag = i+1;
        image.userInteractionEnabled = YES;
        image_1.userInteractionEnabled = YES;
        image_2.userInteractionEnabled = YES;
        
        [self.scrollView addSubview:image];
        [self.scrollView addSubview:image_1];
        [self.scrollView addSubview:image_2];
        [image release];
        [image_1 release];
        [image_2 release];
        [self.view addSubview:self.scrollView];
        
        
	}
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 3, self.scrollView.frame.size.height);
	
	//self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * colors.count, self.scrollView.frame.size.height);
	
	self.pageControl.currentPage = 0;

    
    _manager = [[MovieManager alloc] init];
    _manager.communicator = [[[MovieCommunicator alloc] init] autorelease];
    _manager.communicator.delegate = _manager;
    _manager.delegate = (id)self;
    [myTableView reloadData];

    
     //[self startFetchingMovies:1];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    // Show progress
    /*
     MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
     hud.mode = MBProgressHUDModeIndeterminate;
     hud.labelText = @"Searching...";
     [hud show:YES];*/
    
    CLLocation *lastLocation = [locations lastObject];
    CLLocationDegrees latitude = [lastLocation coordinate].latitude;
	CLLocationDegrees longitude = [lastLocation coordinate].longitude;
    
    [self startFetchingMovies:latitude AndLongitude:longitude];
    
    [manager stopUpdatingLocation];
    [self performSelector:@selector(discardLocationManager) onThread:[NSThread currentThread] withObject:nil waitUntilDone:NO];
    //[hud hide:YES];
    
}

- (void)startFetchingMovies:(float)lat AndLongitude:(float)lng
{
    //[_manager fetchMovies:];
    [_manager fetchMovies:lat AndWithLongitude:lng];
}
- (void) discardLocationManager
{
    _locationManager.delegate = nil;
    [_locationManager release];
    
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.scrollView = nil;
	self.pageControl = nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
	if (!pageControlBeingUsed) {
		// Switch the indicator when more than 50% of the previous/next page is visible
		CGFloat pageWidth = self.scrollView.frame.size.width;
		int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
		self.pageControl.currentPage = page;
	}
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	pageControlBeingUsed = NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
	[scrollView release];
	[pageControl release];
    [myTableView release];
    //[_scrollView release];
    //[_pageControl release];
    [super dealloc];
}

- (IBAction)changePage:(id)sender {
    // Update the scroll view to the appropriate page
	CGRect frame;
	frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
	frame.origin.y = 0;
	frame.size = self.scrollView.frame.size;
	[self.scrollView scrollRectToVisible:frame animated:YES];
	
	// Keep track of when scrolls happen in response to the page control
	// value changing. If we don't do this, a noticeable "flashing" occurs
	// as the the scroll delegate will temporarily switch back the page
	// number.
	pageControlBeingUsed = YES;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _movies.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"I am in Cell for row at index path");
    static NSString *CellIdentifier = @"customCell";
    // [tableView registerNib:[UINib nibWithNibName:@"DetailCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
    CustomCell* cell = [[tableView dequeueReusableCellWithIdentifier:CellIdentifier] retain];
    if (cell == nil) {
        //  CustomCell* cell = [[[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        NSArray *nibObjects=[[[[NSBundle mainBundle] loadNibNamed:@"DetailCell" owner:nil options:nil] retain] autorelease];
        for(id currentObject in nibObjects)
        {
            if([currentObject isKindOfClass:[CustomCell class]])
            {
               // UIView *v1=(CustomCell *)currentObject;
                cell=(CustomCell *)currentObject;
            }
        }
    }
    //[cell.textLabel.text:@"test"];
    // Configure the cell...
    //NSLog(@"indexpath row - %d",indexPath.row);
    Movies *movie = _movies[indexPath.row];
    
    //NSLog(@"movie - %@",movie);
    
    // Movies *movie = _movies[indexPath.row];

    cell.titleLabel.text=movie.title;
    cell.ratingLabel.text=[movie.topCast componentsJoinedByString:@","];
    //NSMutableArray *tempArray = [NSMutableArray array];
    
        NSArray *array = [movie.runTime componentsSeparatedByString:@"PT"];
    NSArray *tempArray = [[array objectAtIndex:1] componentsSeparatedByString:@"H"];
        
    NSString *timeStr = [tempArray componentsJoinedByString:@"hr. "];
    NSString *displayTime=[timeStr stringByReplacingOccurrencesOfString:@"M" withString:@"min"];
     cell.durationLabel.text=displayTime;
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(void) {
        
        NSString *url = [NSString stringWithFormat:@"http://developer.tmsimg.com/%@?api_key=5dmhgfxxzv2y43kwhuzv8ap8",movie.uri];
        NSURL * imageUrl=[NSURL URLWithString:url];
        NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
        cell.poster.image=[UIImage imageWithData:imageData];
        
        dispatch_sync(dispatch_get_main_queue(), ^(void) {
            // UIImageView* imageView = (UIImageView*)[cell viewWithTag:100];
            cell.poster.image=[UIImage imageWithData:imageData];

        });
    });
    
    
    /*
    UIImage *newImage;
    CGSize newSize = cell.poster.frame.size;
    NSURL * imageUrl=[NSURL URLWithString:movie.thumbnail];
    NSData * imageData=[NSData dataWithContentsOfURL:imageUrl];
    cell.poster.image=[UIImage imageWithData:imageData];
    newImage = [cell.poster.image imageScaledToFitSize:newSize];
    //cell.poster.image= [UIImageView imageWithData:imageData];
    */
    //NSLog(@"Movietitle%@",movie.title);
    return cell;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0)
    {
        return @"In Theatres";
    }else if (section == 1) {
        return @"Top Rated";
    }else if (section == 2){
        return @"Box Office";
    }else {
        return @"In theatres";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    MovieDetailViewController *movieDetailView = [[[MovieDetailViewController alloc] initWithNibName:@"MovieDetailViewController" bundle:nil] autorelease];
    movieDetailView.moviedetail = _movies[indexPath.row];
    [self.navigationController pushViewController:movieDetailView animated:YES];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    MovieDetailViewController *movieDetailView = [[[MovieDetailViewController alloc] initWithNibName:@"MovieDetailViewController" bundle:nil] autorelease];
    movieDetailView.moviedetail = _movies[indexPath.row];
    [self.navigationController pushViewController:movieDetailView animated:YES];

}


@end
