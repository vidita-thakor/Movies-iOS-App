//
//  MovieListViewController.m
//  MovieBuzz
//
//  Created by Harmony Public Schools on 12/11/13.
//  Copyright (c) 2013 IOS Frenzy. All rights reserved.
//


#import "MovieListViewController.h"
#import "AppDelegate.h"
#import "MovieDetailViewController.h"
#import "CustomCell.h"
#import "Movies.h"
@interface MovieListViewController ()

@end

@implementation MovieListViewController

@synthesize movieList,locationManager,filteredMovieList,searchBar;
- (void)dealloc {
    [searchBar release];
    [movieList release];
    [filteredMovieList release];
    [locationManager release];
   // [searchBar release];

    [super dealloc];
}
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}
/*
 -(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
 // Tells the table data source to reload when scope bar selection changes
 [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
 // Return YES to cause the search result table view to be reloaded.
 return YES;
 }
 */
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    //NSLog(@"%@",searchText);
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF.title contains[c] %@",
                                    searchText];
    // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    //NSLog(@"1-)%d",[self.filteredMovieList count] );
    
    self.filteredMovieList = [movieList filteredArrayUsingPredicate:resultPredicate];
    //NSLog(@"2-)%d",[filteredMovieList count] );
}
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)loadMovieList
{
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd"];
    //NSLog(@"%@",[DateFormatter stringFromDate:[NSDate date]]);
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if(appDelegate.searchByCurrentLocation==YES)
    {
        [self startStandardUpdates];
        
        CLLocation *location = [self.locationManager location];
        CLLocationCoordinate2D coordinate = [location coordinate];
        appDelegate.latitude=coordinate.latitude;
        appDelegate.longitude=coordinate.longitude;
        
        NSString *url = [NSString stringWithFormat:@"%@%@%@%f%@%f%@", @"http://data.tmsapi.com/v1/movies/showings?startDate=",[DateFormatter stringFromDate:[NSDate date]],@"&lat=",coordinate.latitude, @"&lng=",coordinate.longitude,@"&radius=10&units=mi&api_key=5dmhgfxxzv2y43kwhuzv8ap8"];
        [self stopStandardUpdates];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        
        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        self.Rawdata=response;
        NSError *jasonParsingError = nil;
        
        NSArray *jasonArray = [NSJSONSerialization JSONObjectWithData: response options: NSJSONReadingMutableContainers error: &jasonParsingError];
        
        if([jasonArray count]>0)
        {
            self.movieList=jasonArray;
        }
        
    }
    else
    {
        
        
        
        
        NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@", @"http://data.tmsapi.com/v1/movies/showings?startDate=",[DateFormatter stringFromDate:[NSDate date]],@"&zip=",appDelegate.zipCode, @"&api_key=5dmhgfxxzv2y43kwhuzv8ap8"];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        
        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
         self.Rawdata=response;
        NSError *jasonParsingError = nil;
        
        NSArray *jasonArray = [NSJSONSerialization JSONObjectWithData: response options: NSJSONReadingMutableContainers error: &jasonParsingError];
        
        if([jasonArray count]>0)
        {
            self.movieList=jasonArray;
        }
        
    }
    [self.tableView reloadData];
    [DateFormatter release];
}
- (void)stopStandardUpdates
{
    [locationManager stopUpdatingLocation];
    NSLog(@"GPS Location is stopped...");
    
}
- (void)startStandardUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    NSLog(@"GPS Location is initialising...");
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    // Set a movement threshold for new events.
    locationManager.distanceFilter = kCLDistanceFilterNone; //
    [locationManager startUpdatingLocation];
    NSLog(@"GPS Location is initialised...");
}
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        // If the event is recent, do something with it.
        //NSLog(@"latitude %+.6f, longitude %+.6f\n",
        //      location.coordinate.latitude,
         //     location.coordinate.longitude);
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 80;
    
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadMovieList];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //return [movieList count];
    //NSLog(@"Filtered %d",[filteredMovieList count]);
    //NSLog(@"Regular %d",[movieList count]);
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [filteredMovieList count];
        
    } else {
        return [movieList count];
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{// custom cell code by Vidita Thakor
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
    // Custom cell code by Vidita Thakor end
    // Configure the cell...
    
    //NSLog(@"Regular %d",[movieList count]);
    
    //NSLog(@"Index %d",indexPath.row);
    
    //NSLog(@"Filtered %d",[filteredMovieList count]);
    NSDictionary* movies;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        movies= [filteredMovieList objectAtIndex:indexPath.row];
        
        
    }
    else{
        movies= [movieList objectAtIndex:indexPath.row];
        
        
    }
    
    NSString* topCast=[[movies objectForKey:@"topCast"] componentsJoinedByString:@","];
    cell.titleLabel.text=[NSString stringWithFormat:@"%@",[movies objectForKey:@"title"]];
    cell.ratingLabel.text=topCast;
    //NSMutableArray *tempArray = [NSMutableArray array];
    
    NSArray *array = [[NSString stringWithFormat:@"%@",[movies objectForKey:@"runTime"]] componentsSeparatedByString:@"PT"];
    NSArray *tempArray = [[array objectAtIndex:1] componentsSeparatedByString:@"H"];
    
    NSString *timeStr = [tempArray componentsJoinedByString:@"hr. "];
    NSString *displayTime=[timeStr stringByReplacingOccurrencesOfString:@"M" withString:@"min"];
    cell.durationLabel.text=displayTime;
    NSDictionary* preferredImg=[movies objectForKey:@"preferredImage"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(void) {
        
        NSString *url = [NSString stringWithFormat:@"http://developer.tmsimg.com/%@?api_key=5dmhgfxxzv2y43kwhuzv8ap8",[preferredImg objectForKey:@"uri"]];
        NSURL * imageUrl=[NSURL URLWithString:url];
        NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
        cell.poster.image=[UIImage imageWithData:imageData];
        
        dispatch_sync(dispatch_get_main_queue(), ^(void) {
            // UIImageView* imageView = (UIImageView*)[cell viewWithTag:100];
            cell.poster.image=[UIImage imageWithData:imageData];
            
        });
    });
    /*
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[movies objectForKey:@"title"]];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
    cell.textLabel.numberOfLines = 1;
    [cell.textLabel adjustsFontSizeToFitWidth];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[movies objectForKey:@"longDescription"]];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.numberOfLines = 5;
    */
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieDetailViewController *movieDetailViewController = [[[MovieDetailViewController alloc] initWithNibName:@"MovieDetailViewController" bundle:[NSBundle mainBundle]] autorelease];
    //passing movie object to the moviedetail by Vidita Thakor
   
    NSError *error = nil;
    NSArray *moviesl = [Movies moviesFromJSON:self.Rawdata error:&error];
    movieDetailViewController.moviedetail=moviesl[indexPath.row];
     // passing movie object to the moviedetail by Vidita Thakor
    [self.navigationController pushViewController:movieDetailViewController animated:YES];
    
}

@end
