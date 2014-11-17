//
//  DetailTheatreViewController.m
//  MovieBuzz
//
//  Created by Abhishek Desai on 12/7/13.
//  Copyright (c) 2013 IOS Frenzy. All rights reserved.
//

#import "DetailTheatreViewController.h"
#import "TheatreShowTimeViewController.h"

@interface DetailTheatreViewController ()
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation DetailTheatreViewController
@synthesize details, tableView, mapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,320,130)style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        
        [self.view addSubview:tableView];
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
    self.title = @"Theatre Detail";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [tableView release];
    [details release];
    [mapView release];
    [super dealloc];
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    static NSString *s = @"ann";
    
    MKAnnotationView *pin = [self.mapView dequeueReusableAnnotationViewWithIdentifier:s];
    if (!pin) {
        pin = [[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:s] autorelease];
        pin.canShowCallout = YES;
        pin.calloutOffset = CGPointMake(0, 0);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [button addTarget:self
                   action:@selector(viewMovieDetails) forControlEvents:UIControlEventTouchUpInside];
        pin.rightCalloutAccessoryView = button;
        
    }
    return pin;
}

/* Animating droping pins */
/*
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {

    MKAnnotationView *annotationView;
    
	for (annotationView in views) {
		if (annotationView.annotation == self.mapView.userLocation) {
			//[self locateMe];
        }
		
		CGRect endFrame = annotationView.frame;
		annotationView.frame = CGRectMake(annotationView.frame.origin.x, annotationView.frame.origin.y - 200.0, annotationView.frame.size.width, annotationView.frame.size.height);
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.1];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[annotationView setFrame:endFrame];
		[UIView commitAnimations];
	}
}*/

#pragma mark - CLLocationManager Delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *lastLocation = [locations lastObject];
	CLLocationAccuracy accuracy = [lastLocation horizontalAccuracy];
    //CLLocationDegrees latitude = [lastLocation coordinate].latitude;
	//CLLocationDegrees longitude = [lastLocation coordinate].longitude;
    
	if(accuracy < 100.0) {
		MKCoordinateSpan span = MKCoordinateSpanMake(0.20, 0.20);
        
		MKCoordinateRegion region = MKCoordinateRegionMake([lastLocation coordinate], span);
		
		[mapView setRegion:region animated:YES];
        CLLocationCoordinate2D myCoordinate;
        myCoordinate.latitude  = [[details valueForKey:@"latitude"] doubleValue];
        myCoordinate.longitude = [[details valueForKey:@"longitude"] doubleValue];
        PlaceAnnotation*  annotObj =[[[PlaceAnnotation alloc]initWithCoordinate:myCoordinate] autorelease];
        annotObj.title = [details valueForKey:@"name"];
        annotObj.subtitle = [NSString stringWithFormat:@"%@, %@, %@",[details valueForKey:@"street"],[details valueForKey:@"city"], [details valueForKey:@"state"]];
        
        [mapView addAnnotation:annotObj];
        
		[manager stopUpdatingLocation];
        [self performSelector:@selector(discardLocationManager) onThread:[NSThread currentThread] withObject:nil waitUntilDone:NO];
                
	}
    
}

- (void) discardLocationManager
{
    _locationManager.delegate = nil;
    [_locationManager release];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 25;
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell)
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    
    switch (indexPath.row) {
		case 0:
			cell.textLabel.text = [details valueForKey:@"name"];
			break;
		case 1:
			cell.textLabel.text = [NSString stringWithFormat:@"%@, %@, %@",[details valueForKey:@"street"],[details valueForKey:@"city"], [details valueForKey:@"state"]];
			break;
		case 2:
			cell.textLabel.text = [details valueForKey:@"telephone"];
            break;
        case 3:
			cell.textLabel.text = [NSString stringWithFormat:@"%.2f miles",[[details valueForKey:@"distance"] doubleValue]];
            break;
		default:
			break;
	}
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

-(void)viewMovieDetails{
    TheatreShowTimeViewController *showTimeController = [[[TheatreShowTimeViewController alloc] initWithNibName:@"TheatreShowTimeViewController" bundle:nil] autorelease];
    showTimeController.theatreId = [[details valueForKey:@"theatreId"] intValue];
    showTimeController.theatreName = [details valueForKey:@"name"];
    [self.navigationController pushViewController:showTimeController animated:YES];
    
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
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}


@end
