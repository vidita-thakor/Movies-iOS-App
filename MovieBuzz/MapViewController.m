//
//  MapViewController.m
//  MovieBuzz
//
//  Created by Abhishek Desai on 10/11/13.
//  Copyright (c) 2013 IOS Frenzy. All rights reserved.
//

#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "Theatre.h"
#import "MovieManager.h"
#import "MovieCommunicator.h"
//#import "MBProgressHUD.h"
#import "Place.h"
#import "PlaceAnnotation.h"
#import "ShowTimeViewController.h"
#import "TheatreShowTimeViewController.h"



@interface MapViewController () <CLLocationManagerDelegate, MKMapViewDelegate, MKAnnotation>

@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property(nonatomic,retain) NSArray* _theatres;
@property(nonatomic,retain) MovieManager* _manager;

@property (nonatomic, strong) NSMutableArray *locations;

@end


@implementation MapViewController
@synthesize _manager,_theatres,showTimeView,mapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Map";
        self.tabBarItem.tag = 3;
        self.tabBarItem.image = [UIImage imageNamed:@"Globe"];
        
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
    // Do any additional setup after loading the view from its nib.
    
    _manager = [[MovieManager alloc] init];
    _manager.communicator = [[[MovieCommunicator alloc] init] autorelease];
    _manager.communicator.delegate = _manager;
    _manager.delegate = (id)self;

    // _locations = [[NSMutableArray alloc] init];
}

- (void)startFetchingTheatresWithLatitude:(float)lat AndLongtitude:(float)lng
{
    [_manager fetchTheatresWithLatitude:lat AndWithLongitude:lng];
}

- (void)didReceiveTheatres:(NSArray *)theatres
{
    self._theatres = theatres;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{

    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    static NSString *s = @"ann";
    
    MKAnnotationView *pin = [self.mapView dequeueReusableAnnotationViewWithIdentifier:s];
    if (!pin) {
        pin = [[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:s] autorelease];
        pin.canShowCallout = YES;
        //pin.image = [UIImage imageNamed:@"pin.png"];
        
        pin.calloutOffset = CGPointMake(0, 0);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
       /* [button addTarget:self
                   action:@selector(viewDetails:) forControlEvents:UIControlEventTouchUpInside];*/
        pin.rightCalloutAccessoryView = button;
        
    }
    return pin;
}

/* Animating droping pins */
/*
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    MKAnnotationView *annotationView;
    
	for (annotationView in views) {
		if (annotationView.annotation == mapView.userLocation) {
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
    
    // Show progress
    /*
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Searching...";
    [hud show:YES];*/
    
    
    CLLocation *lastLocation = [locations lastObject];
	CLLocationAccuracy accuracy = [lastLocation horizontalAccuracy];
    CLLocationDegrees latitude = [lastLocation coordinate].latitude;
	CLLocationDegrees longitude = [lastLocation coordinate].longitude;
    
    
    [self startFetchingTheatresWithLatitude:latitude AndLongtitude:longitude];
    
	
	if(accuracy < 100.0) {
		MKCoordinateSpan span = MKCoordinateSpanMake(0.20, 0.20);
        
		MKCoordinateRegion region = MKCoordinateRegionMake([lastLocation coordinate], span);
		
		[mapView setRegion:region animated:YES];
        int i=0;
        //PlaceAnnotation *myAnnotation = [[PlaceAnnotation alloc] init];
        
        NSMutableArray *places=[[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *results in self._theatres)
        {
            
            Theatre *theatre = _theatres[i];
            //NSLog(@"Theater Coordinate %@", theatre.latitude);
            CLLocationCoordinate2D myCoordinate;
            myCoordinate.latitude  = [theatre.latitude floatValue];
            myCoordinate.longitude = [theatre.longitude floatValue];
            PlaceAnnotation*  annotObj =[[[PlaceAnnotation alloc]initWithCoordinate:myCoordinate] autorelease];
            annotObj.title = theatre.name;
            annotObj.subtitle = [NSString stringWithFormat:@"%@, %@, %@",theatre.street,theatre.city, theatre.state];
            annotObj.theatreId = [theatre.theatreId intValue];
            
            [places addObject:annotObj];
            [mapView addAnnotation:annotObj];
            
            i++;
        }
        [places release];
		[manager stopUpdatingLocation];
        [self performSelector:@selector(discardLocationManager) onThread:[NSThread currentThread] withObject:nil waitUntilDone:NO];
        //[hud hide:YES];
        
	}
    
}

- (void) discardLocationManager
{
    _locationManager.delegate = nil;
    [_locationManager release];
    
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view
calloutAccessoryControlTapped:(UIControl *)control
{
    PlaceAnnotation *annView = view.annotation;
    TheatreShowTimeViewController *showTimeController = [[[TheatreShowTimeViewController alloc] initWithNibName:@"TheatreShowTimeViewController" bundle:nil] autorelease];
    showTimeController.theatreId = annView.theatreId;
    showTimeController.theatreName = annView.title;
    [self.navigationController pushViewController:showTimeController animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc
{
    
    mapView = nil;
    [mapView release];
    [_locations release];
    [_manager release];
    [_theatres release];
    [super dealloc];
}

@end
