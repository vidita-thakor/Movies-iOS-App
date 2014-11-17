//
//  TestViewController.m
//  MovieBuzz
//
//  Created by Mac User 1 on 12/11/13.
//  Copyright (c) 2013 IOS Frenzy. All rights reserved.
//

#import "TheatreListViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "Theatre.h"
#import "MovieManager.h"
#import "MovieCommunicator.h"
//#import "MBProgressHUD.h"
#import "DetailTheatreViewController.h"

@interface TheatreListViewController () <CLLocationManagerDelegate>
@property (nonatomic, retain) CLLocationManager *locationManager;
@property(nonatomic,retain) NSArray* _theatres;
@property(nonatomic,retain) MovieManager* _manager;
@end

@implementation TheatreListViewController
@synthesize _theatres, _manager, filteredTheatreList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Theatre List";
        self.tabBarItem.tag = 1;
        self.tabBarItem.image = [UIImage imageNamed:@"Theatre"];
    }
    return self;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}


- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF.name contains[c] %@",
                                    searchText];
    self.filteredTheatreList = [self._theatres filteredArrayUsingPredicate:resultPredicate];
   
}

-(void) dealloc{
    [super dealloc];
    [_theatres release];
    [_manager release];
    [filteredTheatreList release];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _locationManager = [[CLLocationManager alloc] init];
	[_locationManager setDelegate:self];
	[_locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
	[_locationManager startUpdatingLocation];
    // Do any additional setup after loading the view from its nib.
    
    _manager = [[MovieManager alloc] init];
    _manager.communicator = [[[MovieCommunicator alloc] init] autorelease];
    _manager.communicator.delegate = _manager;
    _manager.delegate = (id)self;
    [self.tableView reloadData];
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}


#pragma mark - CLLocationManager Delegate

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
    
    [self startFetchingTheatresWithLatitude:latitude AndLongtitude:longitude];
    
    [manager stopUpdatingLocation];
    [self performSelector:@selector(discardLocationManager) onThread:[NSThread currentThread] withObject:nil waitUntilDone:NO];
    //[hud hide:YES];
    
}

- (void) discardLocationManager
{
    _locationManager.delegate = nil;
    [_locationManager release];
    
}

- (void)startFetchingTheatresWithLatitude:(float)lat AndLongtitude:(float)lng
{
    [_manager fetchTheatresWithLatitude:lat AndWithLongitude:lng];
}

- (void)didReceiveTheatres:(NSArray *)theatres
{
    self._theatres = theatres;
    [self.tableView reloadData];
}

/*
 -(void) stopUpdatingLocation{
 NSLog(@"Stop Updating Location");
 _locationManager = nil;
 [_locationManager release];
 }*/

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
    //return _theatres.count;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [filteredTheatreList count];
        
    } else {
        return [_theatres count];
        
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = NSLocalizedString(@"within 10 miles", @"within 10 miles");
            break;
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    
    Theatre *theatre; //= _theatres[indexPath.row];
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        theatre= [filteredTheatreList objectAtIndex:indexPath.row];
    }
    else{
        theatre= [_theatres objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = theatre.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@, %@",theatre.street, theatre.city, theatre.state];
    
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
/*
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
 DetailTheatreViewController *theatreDetailView = [[[DetailTheatreViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
 theatreDetailView.details = _theatres[indexPath.row];
 [self.navigationController pushViewController:theatreDetailView animated:YES];
 }*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    DetailTheatreViewController *theatreDetailView = [[[DetailTheatreViewController alloc] initWithNibName:@"DetailTheatreViewController" bundle:nil] autorelease];
    theatreDetailView.details = _theatres[indexPath.row];
    [self.navigationController pushViewController:theatreDetailView animated:YES];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    DetailTheatreViewController *theatreDetailView = [[[DetailTheatreViewController alloc] initWithNibName:@"DetailTheatreViewController" bundle:nil] autorelease];
    theatreDetailView.details = _theatres[indexPath.row];
    [self.navigationController pushViewController:theatreDetailView animated:YES];
}


@end
